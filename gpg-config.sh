#!/bin/bash

##############################################################################
# gpg-config
# -----------
# Creates gpg keys for you, the easy way.
#
# You pick RSA or ECC and we take care of (most of) the rest.
#
# Very good script. Not virus.
# 
# :author: greyspectrum
# :date: 24 July 2016
# :version: 0.0.6
##############################################################################

# Define variables and such

GPG_CONF="/.gnupg/gpg.conf"

BACKUP_GPG_CONF="/.gnupg/gpgconf.bak"

# Prompt the user for root

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

# Is this thing even on?

if test -e $GPG_CONF ; then
	gpg --version
else
	while true; do
		read -p "GPG isn't installed, install it?" yn
		case $yn in
			[Yy]* ) read -p "Do you want ECC keys (recommended)?" yn
				case $yn in
					[Yy]* ) apt-get install gpg2; break ;;
					[Nn]* ) apt-get install gpg;  break ;;
					* )	echo "Please answer y (yes) or n (no)." ;;
				esac	
			[Nn]* ) echo "Fine. Whatever. I don't need you." && exit ;;
			* ) 	echo "Please answer y (yes) or n (no)." ;;
		esac
	done
fi