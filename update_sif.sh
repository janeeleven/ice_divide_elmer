#!/bin/bash
xa=$1
a0=$2
DivPos=$3
file=$4
echo xa = ${xa} a0 = ${a0} DivPos = ${DivPos} >> log.txt
sed 's/^$xa = [^ ]*/$xa = '"${xa}"'/;s/^$a0 = [^ ]*/$a0 = '"${a0}"'/; s/^$DivPosition = [^ ]*/$DivPosition = '"${DivPos}"'/' "$file" > Case_${xa}_${a0}_${DivPos}.sif

