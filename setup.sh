#!/usr/bin/sh

# Virgo root
# E.g. /home/user/virgo/
VIRGO_ROOT=`readlink -f ./`

# Logon root
# E.g. /home/user/logon/
LOGONROOT=`readlink -f ~/logon/`

echo "VIRGO ROOT: ${VIRGO_ROOT}"
echo "LOGON ROOT: ${LOGONROOT}"

ln -sfv ${VIRGO_ROOT}/vie/parse_vrg.sh   ${LOGONROOT}/parse_vrg.sh
ln -sfv ${VIRGO_ROOT}/vie                ${LOGONROOT}/ntu/virgo
ln -sfv ${VIRGO_ROOT}/vie-tsdb/home      ${LOGONROOT}/lingo/lkb/src/tsdb/home/vrg
ln -sfv ${VIRGO_ROOT}/vie-tsdb/skeletons ${LOGONROOT}/lingo/lkb/src/tsdb/vrg

# Config demophin
git submodule init
git submodule update

ln -sfv ${VIRGO_ROOT}/modules/demophin ${VIRGO_ROOT}/demophin
cp -vf ${VIRGO_ROOT}/modules/config/demophin.json ${VIRGO_ROOT}/demophin/

# Auto compile VIRGO
cd ${VIRGO_ROOT}/vie
./compile_vrg.sh

echo "Link virgo.dat to demophin"
ln -sfv ${VIRGO_ROOT}/vie/vrg.dat ${VIRGO_ROOT}/demophin/virgo.dat

echo "Run demophin to test VIRGO in browser (http://127.0.0.1:8080/)"
echo "cd demophin && python3 demophin.py"
