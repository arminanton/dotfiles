#!/bin/bash
############################
# unlink.sh
# This script undo changes
############################
# check if there are other users using it

function unlink_configs() {
    dtfiles=$WILLIAM_DOTFILES
    files="bash_profile zshrc p10k.zsh" 
    devcache=$WILLIAM_DEV/cache
    currentbkp=$dtfiles/backup_old/$(ls -t $dtfiles/backup_old | head -1)
    ##########

    # create dotfiles_old in homedir
    echo "Undoing changes..."
    rm -rf ~/william_bash
    rm -rf ~/william_zsh
    rm -rf ~/.cache
    cp -a $devcache/. ~/.cache/ #changed mv to cp as other users may use it
    rm -rf ~/.cache/p10k*
    rm -rf ~/dev/tools/oh-my-zs*

    #restoring old files from backup
    for file in $files; do
      if [ -e $currentbkp/$file ]
      then
        #remove the existing file if it exists
        if [ -e ~/.$file ]
        then
          rm -rf ~/.$file
        fi

        #restore old file
        cp $currentbkp/$file ~/.$file
      fi
    done

    echo "Done! Re-load/open your terminal!"
}

unlink_configs
