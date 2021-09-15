#!/usr/bin/env bash
lang_file="$HOME/repos/dotfiles/tmux-cht-languages"
comm_file="$HOME/repos/dotfiles/tmux-cht-command"

# cat $lang_file
selected=`cat $lang_file $comm_file    | fzf`
read -p "Enter Query: " query

		if grep -qs "$selected" $lang_file; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
