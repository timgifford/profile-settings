# Identify OS and Machine -----------------------------------------
export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
echo -e "OS: " `uname -smr`
echo -e "`bash --version`"
echo -ne "Server time is: "; date

# Path ------------------------------------------------------------
if [[ $OS == *darwin* ]] ; then
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH  # OS-X Specific, with MacPorts and MySQL installed
fi

if [[ $OS == *cygwin* ]] ; then
    alias ls='ls  --color'
    alias grep='grep --color=auto'    
fi

# EDITOR=vi; export EDITOR
export TMPDIR=$TMP
export VIMRUNTIME=~/vimfiles
set -o vi

### Command completion for rake ###
cd () { 
    command cd "$@"; 
    if [ -f ./rakefile ]; then	
complete -W "$(rake -T | awk 'NR = 1 {print $2}')" rake
    fi	
}

# push SSH public key to another box
push_ssh_cert() {
    local _host
    test -f ~/.ssh/id_rsa.pub || ssh-keygen -t rsa
    for _host in "$@";
    do
		echo $_host
        ssh $_host 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
    done
}
