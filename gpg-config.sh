#!/bin/bash

##############################################################################
# gpg-config
# -----------
# Creates gpg keys for you with sane defaults.
#  
# :author: greyspectrum
# :date: 3 November 2016
# :version: 0.1.0
##############################################################################

# Define variables 

GPG_CONF="/.gnupg/gpg.conf"

BACKUP_GPG_CONF="/.gnupg/gpgconf.bak"

# Prompt the user for root

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

# Test if GPG is installed.

if test -e $GPG_CONF ; then
	gpg --version
else
	while true; do
		read -p "GPG isn't installed, install it?" yn
		case $yn in
			[Yy]* ) read -p "Do you want ECC keys (recommended)?" yn
				case $yn in
					[Yy]* ) apt-get install gpg2
						
								    ; break ;;
					[Nn]* ) apt-get install gpg 
						gpg --gen-key
						echo "1" ^M
						echo "4096" ^M 
 						echo "1y" ^M
						echo "y" ^M
						read -p #pick up where you left off
								    ; break ;;
					* )	echo "Please answer y (yes) or n (no)." ;;
				esac	
			[Nn]* ) echo "WTF. Why are you running this script, then?" && exit ;;
			* ) 	echo "Please answer y (yes) or n (no)." ;;
		esac
	done
fi
