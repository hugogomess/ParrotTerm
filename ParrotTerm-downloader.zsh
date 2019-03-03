#!/bin/zsh

# ZSH theme downloader
# Usage:
#       ./ParrotTerm-downloader.zsh $ZSH_CUSTOM

# Check if $ZSH_CUSTOM exists

if [[ ! -d $1 ]];
then
    echo "You don't have a \$ZSH_CUSTOM variable"
    echo "Exiting..."
    exit
fi

# Exit if no .zshrc file
if [[ ! -f "$HOME/.zshrc" ]];
then
    echo "You don't have a .zshrc file"
    echo "Exiting..."
    exit
fi

# Check if $ZSH_CUSTOM is writable and download theme file if it is

if [[ ! -w $1 ]];
then
    echo "You don't have write permission to $1"
    # Ask to use sudo
    read -q "keyInpt?Use sudo? [y/N] "
    echo ""
else
    mkdir -p $1/themes
    curl -o "$1/themes/ParrotTerm.zsh-theme" "https://raw.githubusercontent.com/Eshaan7/ParrotTerm/master/ParrotTerm.zsh-theme"
fi

# Download theme using sudo or exit
if [[ $keyInpt == "y" || $keyInpt == "Y" ]];
then
    sudo mkdir -p $1/themes
    sudo curl -o "$1/themes/ParrotTerm.zsh-theme" "https://raw.githubusercontent.com/Eshaan7/ParrotTerm/master/ParrotTerm.zsh-theme"
else
    if (( ${+keyInpt} ));
    then
        echo "Exiting..."
        exit
    fi
fi

# Exit if the theme file didn't get downloaded
if [[ ! -f "$1/themes/ParrotTerm.zsh-theme" ]];
then
    echo "Something went wrong..."
    echo "Exiting..."
    exit
fi

# Make backup of .zshrc
zshrc_bak="$HOME/.zshrc_`date +%s`.bak"
cp $HOME/.zshrc $zshrc_bak
echo "Backup file $zshrc_bak created"

# Update .zshrc
sed -e "s/ZSH_THEME.*/ZSH_THEME=\"ParrotTerm\"/g" $zshrc_bak > $HOME/.zshrc
echo "$HOME/.zshrc updated"

exit

