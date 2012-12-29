#!/bin/bash

cd "$1"
for tsfile in *.ts; do
	mv ${tsfile} _${tsfile}
	naludump _${tsfile} ${tsfile} >> naludump.log 2>&1
	rm _${tsfile}
done
rm index
# vdr --genindex="$1" >> naludump.log 2>&1
svdrpsend MESG \"Finished stripping NALUs from recording '$1'\"
