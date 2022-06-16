#!/bin/bash

#https://stackoverflow.com/a/52570455/5464101
function htmlEscape () {
    local s
    s=${1//&/&amp;}
    s=${s//</&lt;}
    s=${s//>/&gt;}
    s=${s//'"'/&quot;}
    printf -- %s "$s"
}

DIFF=$1
DEST=$TMPDIR/pd.html

echo "<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>pretty diff</title>
<style>
del, ins { display: block; text-decoration: none; position: relative; }
del { background-color: #fbb; }
ins { background-color: #d4fcbc; }
del::before, ins::before { position: absolute; left: .5rem; font-family: monospace; }
del::before { content: '−'; }
ins::before { content: '+'; }
p { margin: 0 1.8rem 0; font-family: courier; font-size: 1rem; white-space: pre; }
</style>
</head>
<body>" > $DEST

IFS='
'
for line in $DIFF; do
  LINE=$(htmlEscape $line)
  case $LINE in
    diff\ --git*) echo "<h3><p>$LINE</p></h3>" >> $DEST;;
    +++*) echo "<p>$LINE</p>" >> $DEST;;
    ---*) echo "<p>$LINE</p>" >> $DEST;;
    +*) echo "<ins><p>${LINE:1}</p></ins>" >> $DEST;;
    -*) echo "<del><p>${LINE:1}</p></del>" >> $DEST;;
    *) echo "<p>$LINE</p>" >> $DEST;;
  esac
done

echo "</body>
</html>" >> $DEST

#cat $DEST
open $DEST
