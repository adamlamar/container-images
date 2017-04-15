#!/bin/sh

ZIM2INDEX=/srv/upload/zim2index/
SCRIPT=`readlink -f $0/../`
SCRIPT_DIR=`dirname "$SCRIPT"`
MWOFFLINER="$SCRIPT_DIR/mwoffliner.js"
MWMATRIXOFFLINER="$SCRIPT_DIR/mwmatrixoffliner.js --verbose --adminEmail=contact@kiwix.org --mwUrl=https://meta.wikimedia.org/ --cacheDirectory=/data/scratch/mwoffliner/cac/ --deflateTmpHtml --skipCacheCleaning"

# Wikipedia
$MWMATRIXOFFLINER --project=wiki --outputDirectory=$ZIM2INDEX/wikipedia/ --language="(ko|hu)" &&

# Wiktionary
$MWMATRIXOFFLINER --project=wiktionary --outputDirectory=$ZIM2INDEX/wiktionary/ --languageInverter --language="(fr)"
