# EDITOR=vi; export EDITOR
alias maestro='cd /cygdrive/c/Maestro5/m5svntrunk/'
alias fitnesse='cd /cygdrive/c/Maestro5/m5svntrunk/ExternalTools/FitNesse/;./server.cmd&'
alias msbuild='/cygdrive/c/WINDOWS/Microsoft.NET/Framework/v2.0.50727/msbuild.exe'
alias mssql='net start MSSQL\$SQLEXPRESS'
alias vim='/cygdrive/c/opt/vim/vim72/gvim.exe'
alias restart_mysql='/cygdrive/c/MySQL/logs/restart.bat'
alias ls='ls  --color'
alias grep='grep --color=auto'

set -o vi

### Command completion for rake ###
cd () { 
    command cd "$@"; 
    if [ -f ./rakefile ]; then	
complete -W "$(rake -T | awk 'NR = 1 {print $2}')" rake
    fi	
}

# Load the profile if not loaded.
if [ -z "$RANPROFILE" ]; then
  PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
fi

