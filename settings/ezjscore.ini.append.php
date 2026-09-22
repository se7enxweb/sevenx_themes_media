<?php /* #?ini charset="utf-8"?

[Packer]
# Put the sources' last modified time in the packed file's name.
#
# Without this the packed bundle is named after an md5 of the file list alone,
# so editing a stylesheet leaves the URL unchanged. The packer notices and
# rebuilds the file, but nobody asks for it again: static assets here are
# served with "cache-control: public, max-age=31536000", so a returning visitor
# and every proxy between us keep the old bundle for a year.
#
# With the time in the name, an edit produces a new URL, which is fetched, and
# the year-long lifetime becomes correct rather than dangerous.
#
# The cost is that superseded bundles stay on disk -- ezjscore ships no cleanup
# cronjob. They are a handful of files in var/<site>/cache/public/ and are
# removed with the rest of the cache.
AppendLastModifiedTime=enabled

*/ ?>
