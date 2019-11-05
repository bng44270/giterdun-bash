#!/bin/bash

DUNDB="MAKEDBFILE"

sqlite_binary() {
	ls /usr/bin/sqlite* | head -n 1
}

printf "Content-type: text/html\n\n"

cat << HERE
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<!-- git web interface version 2.1.4, (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>, Christian Gierke -->
<!-- git core binaries version 2.1.4 -->
<head>
<meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8"/>
<meta name="generator" content="gitweb/2.1.4 git/2.1.4"/>
<meta name="robots" content="index, nofollow"/>
<title>Giterdun</title>
<link rel="stylesheet" type="text/css" href="/static/gitweb.css"/>
<link rel="shortcut icon" href="/static/git-favicon.png" type="image/png" />
</head>
<body>
<div class="page_header">
<a href="http://github.andydoestech.com/#giterdun" target="_blank"><img src="/static/giterdun-logo.png" width="100" alt="git" class="logo" height="27" /></a>git.andydoestech.com
</div>
<div class="projsearch">
<table class="project_list">
<tr>
<td style="text-align:left;">
<ul>
HERE

$(sqlite_binary) $DUNDB "SELECT reponame FROM repos" | while read line; do
echo "<li><a href=\"/$line\"><b><u>$line</u></b></a>"
done

cat << HERE
</ul>
</td>
</tr>
</table>
</div>
</body>
</html>
HERE

