<?php
/**
 * YouTube without contacting Google before the visitor chooses to play.
 *
 * Two jobs, both used by the media design's templates through the
 * youtube_id and video_thumbnail operators:
 *
 *  - id(): accepts a stored video identifier (or a watch / youtu.be / embed
 *    URL an editor pasted) and returns the 11-character id, or '' when it is
 *    not one. Everything that ends up in a URL goes through it first.
 *
 *  - thumbnailUrl(): a copy of the video's preview image kept in the site's
 *    storage, as a site URL. The image is fetched from img.youtube.com once,
 *    by the server, and from then on every page links to the local copy, so
 *    a visitor's browser never asks YouTube for it. A video YouTube has no
 *    image for (deleted, private) gets the theme's neutral placeholder, and
 *    the failure is remembered for an hour before it is tried again.
 *
 * Safe under persistent workers (Velocity, FrankenPHP): nothing is cached in
 * memory except the per-request fetch budget, which resets itself.
 */
class sevenxThemesMediaYouTube
{
    /** The thumbnail sizes YouTube publishes for every video, smallest first. */
    public static $Sizes = array( 'default', 'mqdefault', 'hqdefault', 'sddefault', 'maxresdefault' );

    /** Seconds before a failed fetch is tried again. */
    const RETRY_AFTER = 3600;

    /** Seconds one fetch may take, and to connect. */
    const FETCH_TIMEOUT = 3;
    const CONNECT_TIMEOUT = 2;

    /**
     * Seconds of fetching one page render may spend in all. A list page with
     * twenty uncached videos would otherwise wait twenty times; past the budget
     * the remaining videos show the placeholder for this render only (nothing
     * is remembered) and get their image on the next one.
     */
    const REQUEST_BUDGET = 5.0;

    /** Largest image accepted, in bytes. */
    const MAX_BYTES = 1048576;

    protected static $BudgetKey = null;
    protected static $BudgetStarted = 0.0;
    protected static $BudgetSpent = 0.0;

    /**
     * @param mixed $value a stored identifier or a YouTube URL
     * @return string the 11-character video id, or ''
     */
    public static function id( $value )
    {
        $value = trim( (string)$value );
        if ( preg_match( '/^[A-Za-z0-9_-]{11}$/', $value ) )
            return $value;
        if ( preg_match( '#^https?://(?:www\.|m\.)?(?:youtube\.com/(?:watch\?(?:.*&)?v=|embed/|shorts/|live/)|youtube-nocookie\.com/embed/|youtu\.be/)([A-Za-z0-9_-]{11})(?:[?&\#/].*)?$#', $value, $m ) )
            return $m[1];
        return '';
    }

    /**
     * The site URL of the neutral placeholder shown when there is no thumbnail.
     */
    public static function placeholderUrl()
    {
        return '/' . eZExtension::baseDirectory() . '/sevenx_themes_media/design/media/images/video-placeholder.svg';
    }

    /**
     * @param string $value video id (or URL, see id())
     * @param string $size one of self::$Sizes, mqdefault by default
     * @return string a site URL: the local copy, or the placeholder
     */
    public static function thumbnailUrl( $value, $size = 'mqdefault' )
    {
        $id = self::id( $value );
        if ( !in_array( $size, self::$Sizes, true ) )
            $size = 'mqdefault';
        if ( $id === '' )
            return self::placeholderUrl();

        // Next to the Vimeo and Dailymotion copies: storage/images is the one
        // storage folder Apache and Velocity both serve as files.
        $dir = eZSys::storageDirectory() . '/images/_video-thumbnails';
        $base = $dir . '/youtube-' . $id . '-' . $size;
        if ( is_file( $base . '.jpg' ) )
            return '/' . $base . '.jpg';
        // The theme ships the demo videos' images, so a new installation shows
        // them at once, offline too
        $shipped = eZExtension::baseDirectory() . '/sevenx_themes_media/design/media/images/video-thumbnails/youtube-' . $id . '-' . $size . '.jpg';
        if ( is_file( $shipped ) )
            return '/' . $shipped;
        if ( is_file( $base . '.fail' ) && filemtime( $base . '.fail' ) > time() - self::RETRY_AFTER )
            return self::placeholderUrl();
        if ( !self::budgetLeft() )
            return self::placeholderUrl();

        $started = microtime( true );
        $image = self::fetch( 'https://img.youtube.com/vi/' . $id . '/' . $size . '.jpg' );
        self::$BudgetSpent += microtime( true ) - $started;

        if ( !is_dir( $dir ) )
        {
            eZDir::mkdir( $dir, false, true );
            self::giveToStorageOwner( $dir );
        }
        $info = $image !== false ? @getimagesizefromstring( $image ) : false;
        if ( !$info || $info[2] !== IMAGETYPE_JPEG )
        {
            @touch( $base . '.fail' );
            self::giveToStorageOwner( $base . '.fail' );
            eZDebug::writeNotice( "No YouTube thumbnail for video $id ($size), retrying after " . self::RETRY_AFTER . ' s', __METHOD__ );
            return self::placeholderUrl();
        }

        // Written whole under a temporary name, then renamed into place, so a
        // concurrent request never serves half an image.
        $file = $base . '.jpg';
        $tmp = $file . '.' . getmypid() . '.tmp';
        if ( @file_put_contents( $tmp, $image ) === false )
        {
            @unlink( $tmp );
            return self::placeholderUrl();
        }
        @chmod( $tmp, 0664 );
        self::giveToStorageOwner( $tmp );
        if ( !@rename( $tmp, $file ) )
        {
            @unlink( $tmp );
            return self::placeholderUrl();
        }
        if ( is_file( $base . '.fail' ) )
            @unlink( $base . '.fail' );
        return '/' . $file;
    }

    /**
     * One GET with short timeouts. Only a 200 with an image body counts.
     *
     * @return string|false
     */
    protected static function fetch( $url )
    {
        if ( !function_exists( 'curl_init' ) )
            return false;
        $ch = curl_init( $url );
        curl_setopt_array( $ch, array(
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_CONNECTTIMEOUT => self::CONNECT_TIMEOUT,
            CURLOPT_TIMEOUT => self::FETCH_TIMEOUT,
            CURLOPT_PROTOCOLS => CURLPROTO_HTTPS,
            CURLOPT_USERAGENT => 'Exponential video thumbnail',
            CURLOPT_NOSIGNAL => true,
        ) );
        $body = curl_exec( $ch );
        $code = (int)curl_getinfo( $ch, CURLINFO_RESPONSE_CODE );
        $type = (string)curl_getinfo( $ch, CURLINFO_CONTENT_TYPE );
        if ( PHP_VERSION_ID < 80000 )
            curl_close( $ch );
        unset( $ch );
        if ( !is_string( $body ) || $body === '' || $code !== 200 || stripos( $type, 'image/' ) !== 0 || strlen( $body ) > self::MAX_BYTES )
            return false;
        return $body;
    }

    /**
     * Whether this render may still spend time fetching. The budget belongs to
     * one request; a persistent worker serves many, so it starts over when the
     * request changes, and after 30 seconds in any case, in case the request
     * time is not refreshed between requests.
     */
    protected static function budgetLeft()
    {
        $key = isset( $_SERVER['REQUEST_TIME_FLOAT'] ) ? (string)$_SERVER['REQUEST_TIME_FLOAT'] : '';
        $now = microtime( true );
        if ( $key !== self::$BudgetKey || $now - self::$BudgetStarted > 30 )
        {
            self::$BudgetKey = $key;
            self::$BudgetStarted = $now;
            self::$BudgetSpent = 0.0;
        }
        return self::$BudgetSpent < self::REQUEST_BUDGET;
    }

    /**
     * Hands a file or folder created here to the owner of the storage folder
     * when this runs as root (Velocity, FrankenPHP, a root command line). The
     * site's PHP-FPM runs as that owner and has to be able to replace the
     * image or the failure marker later.
     */
    public static function giveToStorageOwner( $path )
    {
        if ( !function_exists( 'posix_geteuid' ) || posix_geteuid() !== 0 || !file_exists( $path ) )
            return;
        $storage = eZSys::storageDirectory();
        @chown( $path, fileowner( $storage ) );
        @chgrp( $path, filegroup( $storage ) );
        @chmod( $path, is_dir( $path ) ? 02775 : 0664 );
    }
}
