#!/usr/bin/env bash

cfg_folder=~/termappcfg

fcfg=tmux.conf
for fcfg in p10k.zsh tmux.conf zshrc; do
	echo -n ${fcfg} ...
	if [ -h ~/.${fcfg} ]; then
		echo is already linked
		continue
	fi
	if [ -f ~/.${fcfg} ]; then
		echo is a file, please verify, remove and rerun
		exit 1
	fi
	ln -s ${cfg_folder}/${fcfg} ~/.${fcfg} && echo linked ...
done
for ks in bin/*; do
	echo -n ${ks} ...
	if [ -h ~/${ks} ]; then
		echo is already linked
		continue
	fi
	if [ -f ~/${ks} ]; then
		echo is a file, please verify, remove and rerun
		exit 1
	fi
	ln -s ${cfg_folder}/${ks} ~/${ks} && echo linked ...
done
