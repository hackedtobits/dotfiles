# bshayne 20211114

umask 022

# environment variables:

export LESS=-acIMMQ

[ -z "$PATH"    ] && PATH=/usr/bin:/bin
[ -z "$MANPATH" ] && MANPATH=/usr/share/man

export PATH MANPATH

if ! echo $PATH |grep '^/usr/local/bin\:' >/dev/null 2>&1; then
	PATH=/usr/local/bin:$PATH
fi

export PATH

expand-path(){
	[ ! -d $1 ] && return 1;
	if ! echo $PATH |egrep "(:$1:|^$1:|:$1\$|^$1\$)" >/dev/null 2>&1; then
		PATH=$PATH:$1
	fi
}

expand-manpath(){
	[ ! -d $1 ] && return 1;
	if ! echo $MANPATH |egrep "(:$1:|^$1:|:$1\$|^$1\$)" >/dev/null 2>&1; 
			then
		MANPATH=$MANPATH:$1
	fi
}

expand-path /usr/bin
expand-path /usr/sbin
expand-path /usr/local/bin
expand-path /usr/local/sbin
expand-path /bin
expand-path /sbin
expand-path /usr/ccs/bin
expand-path /usr/ucb
expand-path /usr/proc/bin
expand-path /usr/X11R6/bin
expand-path $HOME/bin

expand-manpath /usr/man
expand-manpath /usr/share/man
expand-manpath /usr/openwin/man
expand-manpath /usr/X11R6/man
expand-manpath /usr/local/man
expand-manpath /usr/dt/man
expand-manpath /usr/fore/man
expand-manpath /opt/OV/man
expand-manpath /opt/CSCOpx/man
expand-manpath /opt/ipf/man

if type vim >/dev/null 2>&1; then
	alias vi=vim && export EDITOR=vim
else
	export EDITOR=vi
fi

if type less >/dev/null 2>&1; then
	export PAGER="less -si"
else
	export PAGER=more
fi

# shell variables:

if [ $USER = "root" ]; then
	export PS1="\u@\h:\[\e[31m\]\w \[\e[0m\]\t # "
else
        export PS1="\u@\h:\[\e[31m\]\w \[\e[0m\]\t \$ "
fi

export HISTTIMEFORMAT="%F %T - "

if [ ! -z "$WINDOWNAME" ]; then
	PR=`perl -e "print pack('A15', '${WINDOWNAME}:')"`
	echo -ne "\033]1;$WINDOWNAME\007"
	echo -ne "\033]2;$WINDOWNAME\007"
	unset WINDOWNAME # don't want to affect children
fi

unset ignoreeof
set -o notify; notify=1
set -o noclobber; noclobber=1
set -o vi

# Aliases

alias lo='exit'
alias ls='ls -hF'

# functions:

function ll()		{ ls -lA | more; }
function lsd()		{ ls -lA | grep ^d; }
function fix()		{ printf "\n\017\n\033c\n"; }

mail_line(){
	user="$1"; shift
	printf "$*\nend\n"|mail -s "$*" $user
}

mail_test(){
	for user in "$@"; do mail_line "$user" test: $user from `hostname`, time `date`; done
}

function find-bad-perms() {
	find "$@" -perm -002 ! -type l ! -type s ! \( -type d -perm -01000 \) -print
}
