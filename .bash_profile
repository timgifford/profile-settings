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

# if [[ $OS == *mingw32* ]] ; then
    export PATH=/c/Maestro5/maestro/bin:$PATH
# fi

if [[ $OS == *cygwin* ]] ; then
	# Add paths
	export PATH=$PATH:/cygdrive/c/code/java/apache-maven-2.2.1/bin

	alias maestro='cd /cygdrive/c/Maestro5/maestro/'
	alias fitnesse='cd /cygdrive/c/Maestro5/m5svntrunk/ExternalTools/FitNesse/;./server.cmd&'
	alias msbuild='/cygdrive/c/WINDOWS/Microsoft.NET/Framework/v2.0.50727/msbuild.exe'
	alias mssql='net start MSSQL\$SQLEXPRESS'
    alias gvim='/cygdrive/c/opt/vim/vim72/gvim.bat'
    alias restart_mysql='/cygdrive/c/MySQL/logs/restart.bat'
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
