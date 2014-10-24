#!/usr/bin/sh

# Virgo root
# E.g. /home/user/virgo/
# Don't forget the slash '/' at the end
VIRGO_ROOT='./'

# Logon root (don't forget the slash '/' at the end)
LOGONROOT='~/logon/'

ln -s ${VIRGO_ROOT}vie/parse_vrg.sh   ${LOGONROOT}parse_vrg.sh
ln -s ${VIRGO_ROOT}vie                ${LOGONROOT}ntu/virgo
ln -s ${VIRGO_ROOT}vie-tsdb/home      ${LOGONROOT}lingo/lkb/src/tsdb/home/vrg
ln -s ${VIRGO_ROOT}vie-tsdb/skeletons ${LOGONROOT}lingo/lkb/src/tsdb/vrg
