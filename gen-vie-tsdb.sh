#!/usr/bin/sh


export LAB_ROOT=~/virgo
export TSDB_ROOT=${LAB_ROOT}/testsuites
export TARGET_TESTSUITE=${LAB_ROOT}/vie-tsdb/skeletons/vmt/item
export RAW_ITEM_FILE=vi-testsuite.txt.item

cd ${LAB_ROOT}

# CLEAN
if [ -f ${TSDB_ROOT}/${RAW_ITEM_FILE} ];
then
   rm ${TSDB_ROOT}/${RAW_ITEM_FILE}
fi
#if [ -d ${LAB_ROOT}/vie/ ];
#then
   # rm -rf ${LAB_ROOT}/vie/
#fi

# USE LASTEST LANGUAGE TEMPLATE
#cp ${LAB_ROOT}/matrix/vie.tar.gz ${LAB_ROOT}/
#tar -xf ${LAB_ROOT}/vie.tar.gz

# BUILD TEST SUITE
perl ${TSDB_ROOT}/make_item_silent.pl ${TSDB_ROOT}/vi-testsuite.txt
if [ -f ${TARGET_TESTSUITE} ];
then
   rm ${TARGET_TESTSUITE}
fi
cp -v ${TSDB_ROOT}/${RAW_ITEM_FILE} ${TARGET_TESTSUITE}

#Patch language rules
# FILES=`ls ${LAB_ROOT}/vie-patch/*.tdl`
# for f in $FILES;
# do
#   echo "Patching $f file..."
#   # take action on each file. $f store current file name
#   #cat $f
# done

# Override the default lexicon.tdl
#echo "Delete default lexicon file: ${LAB_ROOT}/vie/lexicon.tdl"
#rm ${LAB_ROOT}/vie/lexicon.tdl
#cp ${LAB_ROOT}/vie-patch/lexicon.tdl ${LAB_ROOT}/vie/lexicon.tdl

# Orverride the matrix.tdl file
#echo "Delete default matrix file: ${LAB_ROOT}/vie/matrix.tdl"
#rm ${LAB_ROOT}/vie/matrix.tdl
#cp ${LAB_ROOT}/vie-patch/matrix.tdl ${LAB_ROOT}/vie/matrix.tdl


#cat ${LAB_ROOT}/vie-patch/rules.tdl >> ${LAB_ROOT}/vie/rules.tdl
#cat ${LAB_ROOT}/vie-patch/vietnamese.tdl >> ${LAB_ROOT}/vie/vietnamese.tdl
#cat ${LAB_ROOT}/vie-patch/labels.tdl >> ${LAB_ROOT}/vie/labels.tdl
#cat ${LAB_ROOT}/vie-patch/lexicon-patch.tdl >> ${LAB_ROOT}/vie/lexicon.tdl
#cat ${LAB_ROOT}/vie-patch/lkb/globals.lsp >> ${LAB_ROOT}/vie/lkb/globals.lsp
