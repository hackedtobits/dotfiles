# bshayne 20091201

umask 022

# environment variables:

export LESS=-acIMMQ

if [ -f /gridware/sge/default/common/settings.sh ]; then
	. /gridware/sge/default/common/settings.sh
fi

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
alias qhogs='qstat -u '\'*\'' | grep -v qw | awk '\''{print $4}'\'' | sort | uniq -c | grep -v user'
alias qhogsSplit='qstat -u '\''*'\'' | awk '\''{print $4 " " $5}'\'' | sort | grep -P '\''[^\d\s]'\'' | uniq -c | grep -v user'
alias qhags='qstat -u '\'*\'' | awk '\''{print $4}'\'' | sort | uniq -c | grep -v user'

# functions:

function ll()		{ ls -lA | more; }
function lsd()		{ ls -lA | grep ^d; }
function fix()		{ printf "\n\017\n\033c\n"; }

function sync-to(){
	for i in "$@"; do
		scp -p ~/.bashrc ~/.bash_profile ~/.screenrc ~/.tmux.conf ${i}:
	done
}

function sync-from(){
	scp -p ${1}:.bashrc ${1}:.bash_profile ~
}

function password-to(){
	user="$1"; shift
	name="`awk -F: '$1=="'$user'" {print $5}' /etc/passwd`"
	for host in "$@"; do
		echo Syncing password for $user to $host. . .
		ssh $host cp -p /etc/shadow /etc/shadow.old
		(ssh $host cat /etc/shadow|awk -F: '$1!= "'$user'" {print}'
		 awk -F: '$1=="'$user'" {print}' /etc/shadow)|
		ssh $host "cat > /etc/shadow.new"
		ssh $host cp /etc/shadow.new /etc/shadow
		ssh $host rm /etc/shadow.new
	done
}

function account-to(){
	user="$1"; shift
	uid="`awk -F: '$1=="'$user'" {print $3}' /etc/passwd`"
	gid="`awk -F: '$1=="'$user'" {print $4}' /etc/passwd`"
        name="`awk -F: '$1=="'$user'" {print $5}' /etc/passwd`"
        for host in "$@"; do
		echo Syncing account $user to $host. . .
		groups=`grep $user /etc/group|awk -F: '{print $1}'|perl -le '@a=<>; chomp @a; print join ",",@a'`
		ssh $host "/usr/sbin/useradd -u $uid -g $g $gid -c '$name' -m $user"
		ssh $host "/usr/sbin/usermod -G '$groups' $user"
		password-to "$user" "$host"
	done
}

mail_line(){
	user="$1"; shift
	printf "$*\nend\n"|mail -s "$*" $user
}

mail_test(){
	for user in "$@"; do mail_line "$user" test: $user from `hostname`, time `date`; done
}

function account-del(){
	if [ "$#" -ne 2 ]; then
		echo Usage: account-del user machine >&2
		return 1;
	else
		user=$1
		host=$2
	fi

	if ! ssh $host grep ^${user}: /etc/passwd; then
		echo User $user has no account on $host >&2
	elif ssh $host grep $user /etc/aliases; then
		echo User $user is in an alias on $host >&2
	elif ssh $host crontab -l $user 2>/dev/null; then
		echo User $user has a cronjob on $host >&2
	elif ssh $host /usr/sbin/userdel $user; then
		echo User $user deleted from $host
	else
		echo Error deleting user $user from $host.
	fi
}

function find-bad-perms() {
	find "$@" -perm -002 ! -type l ! -type s ! \( -type d -perm -01000 \) -print
}

new-xterm-ssh () {
	dest=${1:?$0 needs at least one arg for destination}
	name=${2:-"$dest"}
	#rest="$*"
	title=$name
	alias $name="ssh -XY $dest $rest";
	alias x$name="back xterm -sb -sl 2000 -fn vga -name $title -n $title -title $title -e ssh -XY $dest $rest"
	alias o$name="TERM=vt100 back open -s -w -- ssh -XY $dest $rest"

	title=${name}-x
	alias $title="back xterm -sb -sl 2000 -fn vga -name $title -n $title -T $title -e ssh -XY $dest"
}

# Home Boxen
new-xterm-ssh bshayne@case.hackedtobits.com case
new-xterm-ssh bshayne@molly.hackedtobits.com molly
new-xterm-ssh shayne@router.hackedtobits.com router
new-xterm-ssh pi@scanner.scanbaltimore.com scanner

# Other Boxen
new-xterm-ssh bshayne@external.hltcoe.jhu.edu external
new-xterm-ssh bshayne@hpcc1.hltcoe.jhu.edu hpcc1
