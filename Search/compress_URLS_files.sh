#!/bin/bash
cd /home/user/Desktop/download_warcs/
while read f;do xz -e $f & done < <(find . -name "*URLS" -amin +10 -size +200M)
