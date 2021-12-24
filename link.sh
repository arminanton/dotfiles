#!/bin/bash
############################
# link.sh
# This set up the files
############################

#################################
export WILLIAM_DEV="/Users/e126380/dev"

export WILLIAM_DOTFILES="$WILLIAM_DEV/dotfiles"

export ZSH="$WILLIAM_DEV/tools/oh-my-zsh"

export ZSH_CUSTOM="$WILLIAM_DEV/tools/oh-my-zsh_custom"
#################################

function link_configs() {
    dir=~/dev/dotfiles                     # dotfiles directory
    timenow=$(date +'%Y-%m-%d_%Hh-%Mm-%Ss-%p-%Z')   # backup folder
    olddir=$dir/backup_old/$timenow        # old dotfiles backup directory
    files="bash_profile zshrc p10k.zsh"             # list of files/folders to symlink in homedir
    devcache=~/dev/cache
    ##########

    # create dotfiles_old in homedir
    echo "Creating folder at: "
    echo "[$olddir]"
    echo "for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...done"

    # change to the dotfiles directory
    #echo "Changing to the $dir directory"
    #cd $dir/loader
    #echo "...done"

    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
    for file in $files; do
      if [ -e ~/.$file ]
      then
        cp ~/.$file $olddir/$file
      fi
      
      #echo "Creating symlink to $file in home directory."
      #ln -s $dir/$file ~/.$file
    done

    echo "Preparing cache folder..."
    cp -a ~/.cache/. $devcache/
    rm -rf ~/.cache
    ln -s $devcache ~/.cache

    echo "Preparing bash/zsh profile loader..."
    cp -a $dir/loader/. ~/

    cat <<< '

# william profile invoker
. ~/william_bash


' >> ~/.bash_profile

    #install oh-my-zsh
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    echo "Installing powerlevel10k..."
    cp -a $ZSH/custom/. $ZSH_CUSTOM/
    rm -rf $ZSH/custom

    #gh repo clone https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k --depth=1
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

    echo "Redoing the zshrc..."
    # prepare zsh profile loader
    rm -rf ~/.zshrc
    cat <<< '

# william profile invoker
. ~/william_zsh


' >> ~/.zshrc
    
    echo "Setting up p10k..."
    rm -rf ~/.p10k.zsh
    cat <<< '

# william p10k custom invoker
. "$WILLIAM_DOTFILES/home/p10k.zsh"


' >> ~/.p10k.zsh

    echo "Installing plugins..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    
    # Custom mc-sudo
    cp -a $dir/plugins/. $ZSH_CUSTOM/plugins/

    echo "!! Make sure to install Pygments later on (using pip) !!"
    echo "!! Currently using MC-SUDO, change when necessary !!"

    echo "Done! Re-load/open your terminal!"
}

link_configs