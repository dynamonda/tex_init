#!/bin/bash

function usage() {
cat <<_EOT_
Usage:
  $0 [-h] projectname

Description:
  Create tex project

Options:
  -h: help message

_EOT_
return
}

function make_project(){
mkdir $1

TEXFILE="${1}/${1}.tex"
touch ${TEXFILE}

MAKEFILE="${1}/Makefile"
touch ${MAKEFILE}
echo "FILENAME = ${1}.tex" >>${MAKEFILE}
echo "" >>${MAKEFILE}
echo "all:" >>${MAKEFILE}
echo -e "\tlatexmk \$(FILENAME)" >>${MAKEFILE}
echo "" >>${MAKEFILE}
echo "clean:" >>${MAKEFILE}
echo -e "\trm -rf *.aux *.dvi *.fls *.log *.fdb_latexmk *.gz *.toc *.pdf" >>${MAKEFILE}
echo "" >>${MAKEFILE}
echo "pv:" >>${MAKEFILE}
echo -e "\tlatexmk -pv \$(FILENAME)" >>${MAKEFILE}

echo "\documentclass{jsarticle}"  >> ${TEXFILE}
echo "" >> ${TEXFILE}
echo "\title{タイトル}" >> ${TEXFILE}
echo "\author{作者名}" >> ${TEXFILE}
echo "\date{\today}" >> ${TEXFILE}
echo "" >> ${TEXFILE}
echo "\begin{document}" >> ${TEXFILE}
echo "" >> ${TEXFILE}
echo "\maketitle" >> ${TEXFILE}
echo "" >> ${TEXFILE}
echo "% 目次" >> ${TEXFILE}
echo "\tableofcontents" >> ${TEXFILE}
echo "" >> ${TEXFILE}
echo "\end{document}" >> ${TEXFILE}
}

while getopts h OPT
do
  case $OPT in
    h)  usage
      ;;
  esac
done

shift $((OPTIND - 1))

if [ $# -ne 1 ]; then
  echo "Not exist projectname"
else
  if [ -e $1 ]; then
    echo "Already exist $1"
  else
    make_project $1
  fi
fi

