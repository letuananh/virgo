#!/usr/bin/sh

echo "-------------------------------------------------------------------"
echo " Compile VIRGO using ACE"
echo "-------------------------------------------------------------------"
# Compile VIRGO using ACE
#ace -G vrg.dat -g ace/config.tdl
answer -G vrg.dat -g ace/config.tdl

#Test using ACE

echo "-------------------------------------------------------------------"
echo " Compile VIRGO using PET"
echo "-------------------------------------------------------------------"

# Compile VIRGO using PET
flop vietnamese-pet.tdl

# Test using PET
#cheap vietnamese-pet.grm
echo "-------------------------------------------------------------------"
echo "DONE - Virgo is ready to use"
echo "-------------------------------------------------------------------"
