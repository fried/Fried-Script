##############################################################################
# Fried Script by Jason Fried <cshrc[at]jasonfried.info>    Standard Distro  #
# INFO avalible at http://jasonfried.info/friedscript/	   		     #
# Copyright (c) 2000-2010, Jason Fried.   Simplified BSD License             #
# License Statement: http://jasonfried.info/friedscript/license.html         #
##############################################################################
#!!!DO NOT MAKE CHANGES TO THIS FILE THEY WILL BE LOST AFTER A 'getupdate'!!!#
#        !!! Make ANY CHANGES YOU WISH TO KEEP IN '.cshrc.local' !!!	     #	

#Fried Script Version
set cshrcversion=2.2.9g

#This is for easy to change distro settings
set distloc='https://raw.github.com/fried/Fried-Script/master/'
set distfile='.cshrc'
set gettool='NONE' #Default

#set the permissions for new files
umask 022

#Clean up the Enviroment
unalias *
uncomplete *

#Emergency Path, Incase one doesnt exist.
if (! $?path) then
    set path = ( /bin /usr/bin )
endif

# Now with System Paths added in.
# I got the idea for this somewhere i forget. Super User Paths now first
set smartp=()
foreach dir ($path /sbin /usr/sbin /usr/local/sbin /bin /usr/bin /usr/local/bin /usr/games /usr/X11R6/bin /usr/pkg/bin /usr/pkg/games /usr/pkg/X11R6/bin /opt/local/bin /opt/local/sbin /sw/bin ~/ ~/bin ~/tools ./)
    if (-d $dir ) then
	set smartp=( $smartp $dir )
    endif
end
#Strip out dups
set path = `echo $smartp | awk 'a[$1]++==0{printf"%s ",$0}' RS=" "`
unset smartp
unset dir

### INTERACTIVE SHELL ONLY
if ($?prompt && $?term) then
    alias reload	source ~/.cshrc #Reloads this file

    #This is for easy to change distro settings
    set distloc='http://jasonfried.info/friedscript/'
    set distfile='cshrc.tar.gz'
    set arctool='tar -zxf'
    #gettool is declared with the OS crap

    #set the permissions for new files
    umask 022

    #Global directory paths
    set smartp=()
    foreach dir (~/ /usr/src/sys/i386 /usr/local/ /home /etc / /var/www)
	if (-d $dir ) then
	    set smartp=( $smartp $dir )
	endif
    end
    set cdpath = ( $smartp )
    unset smartp
    unset dir

    #Enviroment Var Block
    #Buck Up, if you dont like it use the .cshrc.local to redefine it
    if (-X vim) then
	setenv EDITOR vim
    else
	setenv EDITOR vi
    endif
    if (-X less) then
	setenv PAGER less
    else
	setenv PAGE more
    endif

    setenv BLOCKSIZE 1024

    #OS Identification
    set thisuname=`uname`

    #I dont even know if this is needed anymore most OS's are good about providing a term type now days
    #The only one i would see keeping is the transform xterm to xterm-color
    if ($?TERM) then
	if("$thisuname" == "SunOS") then
	    set term='sun'
	else if ("$TERM" == "xterm" && ("$thisuname" == "FreeBSD" || "$thisuname" == "Darwin" )) then
	    set term='xterm-color'
	endif
    endif

    #Iphone Identification
    if ("$thisuname" == "Darwin" && `uname -m` =~ "iPhone*") then
	set thisuname=iPhone
    endif

    #Shell Settings
    setenv CLICOLOR #No longer force, because i want pipe safe color
    
    #Old Versions of TCSH dont like the new color fields for ls
    if (`echo $tcsh | awk -F"." '{if( $1"."$2 >= "6.14") print "1"; else print "0";}'`) then
	setenv LS_COLORS 'no=00:fi=00:di=00;36:ln=00;35:pi=01;34:do=01;34:bd=01;33:cd=00;33:or=01;35:so=01;34:su=00;31:sg=01;31:tw=01;37:ow=00;33:st=01;37:ex=00;32:mi=01;35:'
    else
	setenv LS_COLORS 'no=00:fi=00:di=00;36:ln=00;35:pi=01;34:do=01;34:bd=01;33:cd=00;33:or=01;35:so=01;34:ex=00;32:mi=01;35:'
    endif
    setenv LSCOLORS gxfxExExcxDxdxbxBxhxdx #bsd & darwin
    set inputmode=insert
    unset correct
    unset autocorrect
    set symlinks=chase
    set visiblebell
    set echo_style=both
    set pushdsilent
    set pushdtohome
    set nobeep
    set listflags=a
    set listlinks
    set autoexpand
    set listjobs
    unset printexitvalue
    set addsuffix
    set ignoreeof=0
    set color
    set colorcat
    set histdup=erase
    set history=100
    set savehist=25
    set filec
    set fignore = ( .o )
    set rmstar
    set ampm
    set autolist
    unset noclobber
    set complete=enhance
    set recognize_only_executables #this only returns executable files for command completion, can be slow
    set nonomatch
    set watch = (0 any any)
    unset autologout
    set notify #asynch job completion notifications
    set matchbeep=never
    set mail = (5 /var/mail/$user)

    #Lets get the shell name so i can pick a prompt to set
    set shell=`basename $shell`
    if ($?version) then #csh doesnt use a $version var, so it must be tcsh
	set shell=tcsh
	#Its tcsh lets bind some keys this should fix any problems I hope
	bindkey -e #Select Emacs bindings
	bindkey "^W" backward-delete-word
	bindkey -k up history-search-backward
	bindkey -k down history-search-forward
	bindkey "\e[3~" delete-char
	bindkey "^H" backward-delete-char
	bindkey "^?" backward-delete-char
	bindkey "\177" backward-delete-char
	bindkey "^[[1~" beginning-of-line
	bindkey "^[[4~" end-of-line
	bindkey "^[[D" backward-char
	bindkey "^[[C" forward-char
	bindkey "^[[A" up-history
	bindkey "^[[B" down-history
	bindkey "^[[5~" vi-word-back
	bindkey "^[[6~" vi-word-fwd
	bindkey "^[[1~" beginning-of-line
	bindkey "^[[4~" end-of-line
	if ("$thisuname" == "Darwin") then
	    bindkey "^[[5~" history-search-backward
	    bindkey "^[[6~" history-search-forward
	    bindkey "^[[H" beginning-of-line
	    bindkey "^[[1~" beginning-of-line
	    bindkey "^[[F" end-of-line
	endif
    endif

    #Set the hostname for the script
    if ("$thisuname" == "SunOS") then
	set thisnode=`hostname | awk -F. '{print $1}'`
    else if ("$thisuname" == "iPhone") then
	set thisnode=`hostname`
    else
	set thisnode=`hostname -s`
    endif

    #Script messages and Prompt settings
    #Prompt is in the form [user@host]:/current/dir>
    echo "`date '+%a %h %d %r %Z %Y'`"
    echo "Interactive \e[0;1;34mLogin\e[0m, Fried Script $cshrcversion."
    if ("$shlvl" == "1") then #Only Post this info at first login
	echo "Terminal type set to \e[1;33m$TERM\e[0m on $tty."
	echo "Using \e[31m$shell\e[0m as shell with \e[31m$thisuname\e[0m instructions."
    else #Provide some usefull info
	echo "Fried Script - Current Shell Depth ${shlvl}"
    endif
    if (${?SUDO_USER}) then
	echo "You are currently in a \e[1;31mSUDO\e[0m shell from user \e[1;32m${SUDO_USER}\e[0m."
    endif
    set endchar=">"
    if ("$shell" == "csh") then
	if ("$user" == "root") then
	    set endchar="\e[0;1;33m>\e[0m"
	endif
	alias cd	'cd \!*;set prompt="\e[0;1;31m[\e[0;1;33m${user}\e[0;1;32m@\e[0;1;32m${thisnode}\e[31m]\e[33m:\e[34m$cwd\e[0m$endchar "'
	set prompt="\e[0;1;31m[\e[0;1;33m${user}\e[0;1;31m@\e[0;1;32m${thisnode}\e[31m]\e[33m:\e[34m$cwd\e[0m$endchar "
    else if ("$shell" == "tcsh") then
	if ("$uid" == "0") then
	    set endchar="%{\e[0;1;31m%}>%{\e[0m%}"
	endif
	set prompt="%{\e[0;1;34m%}[%{\e[0;1;31m%}%n%{\e[0;1;34m%}@%{\e[0;1;33m%}%m%{\e[34m%}]%{\e[31m%}:%{\e[32m%}%/%{\e[0m%}$endchar "
    endif


    #Xterm Title Bar Fun
    if ("$term" == "xterm-color" || "$term" == "xterm" ) then
	alias cwdcmd 'echo -n "\e]0;${USER}@${HOST} : ${PWD}        ::        Fried Script ${cshrcversion}\007"; if($?STY) echo -n "\ek${USER}@${thisnode}:${PWD}\e\"'
	cwdcmd
    endif

    #Settings and Alias depending on OS
    if ("$thisuname" == "Linux") then
	alias ls	ls-F --color=tty -hC
	set gettool='wget -q'
	set mail = (5 /var/spool/mail/$user)
    else if ("$thisuname" == "FreeBSD") then
	set gettool='fetch'
	#In freebsd 4.6 the LSCOLORS syntax changed this is hax0red method to deal with it
	if (`uname -r | awk -F"-" '{print $1}' | awk -F"." '{if( $1"."$2 >= "4.6") print "1"; else print "0";}'`) then
	    alias ls	ls-F -hCGoga #tcsh 6.10.0 and above have a realy cool ls-F
	else
	    setenv LSCOLORS 6x5x4x4x2x4x4x1x7x7x3x
	    alias ls	ls -FCGoga #tcsh 6.9.0 didnt support the ls-F with arguments
	endif
    else if ("$thisuname" == "Darwin") then
	alias ls	ls -GFCa
	set gettool='curl -O'
	alias killapp "ps axww | grep /\!*.app/ | grep -v grep | ped "s/[^0-9\n]+/:/g" | cut -d : -f1 | xargs kill -9"
	alias appkill killapp
    else if ("$thisuname" == "iPhone") then
	alias ls	ls -FCah
	set gettool='curl -O'
    else if ("$thisuname" == "SunOS") then
	alias ls	ls -CFa
	set gettool="NONE" #Solaris Doesnt have a file fetching program (That i can find)
	alias psgrep 'ps -AfP | grep \!*' #Sun has its own ps syntax
    else if ("$thisuname" == "AIX") then
	alias ls	ls -CFa
	set gettool="NONE" #Also I need a program that fetches stuff that can be operated via arguments
    endif

    #############
    #ALIAS BLOCK#
    #############
    if ( -X pico ) then
	alias pico	pico -web #removes word wrap
    endif

    if ( -X nano ) then
	alias nano	nano -w #remove word wrap
	alias pico	nano
    endif

    if ("$thisuname" == "FreeBSD") then
	alias lock	lock -np #This works in FreeBSD lock the terminal with pass
    else if ( -X vlock ) then
	alias lock	vlock
    endif

    #Case insensitive search
    alias grep	grep -i

    #SunOS sucks, you cant override -i options
    if ("$thisuname" != "SunOS") then
	alias rm	rm -i
	alias mv	mv -i
	alias cp	cp -i
	#comes in handy if your a BOFH (psgrep joeuser)
	alias psgrep	'ps auxww | grep \!*'
    endif

    #Less is better than more
    if ( -X less ) then
	alias more	less
    endif
    alias cls	clear
    #internic doesnt carry ip info in its whois database 
    alias whoip	whois -h whois.arin.net
    #Hey what script version am i running again?
    alias version	'echo "Fried Script $cshrcversion"'
    alias depth	'echo "You are currently at a shell depth of ${shlvl}"'

    #Need the time in various formats
    alias mildate	'\date'
    alias date	'date \!* "+%a %h %d %r %Z %Y"'
    #I use bc some much this saves time very sweet
    if ( -X bc ) then
	alias calc	'echo \!* | bc -l'
    endif
    alias fetchrfc '${gettool} ftp://ftp.isi.edu/in-notes/rfc\!^.txt'
    #Forward the ssh agent
    alias ssh	'ssh -A'
    alias sshkeys 'ssh-add -l'
    #Ive been using pushd and popd more and more when on foreign systems
    alias stack	dirs -l
    alias pop	popd
    alias push	pushd
    #ACL's well at least on freebsd this helps
    alias getacl	getfacl
    alias setacl	setfacl
    if ( -X perl ) then
	alias ped	'perl -i.bak -npe'
	#Check to see that perl returns 0 if this module being used
	if ({ (perl -e "use LWP::Simple" >& /dev/null)  }) then
	    alias phttpcat	'perl -MLWP::Simple -e "exit is_error getprint shift"'
	    alias pwget		'phttpcat \!* > `basename \!*`'
	    if ("$gettool" == "NONE") then
		set gettool = 'pwget' #Make of the new alias
	    endif
	endif
    endif
    if ( -X vim ) then
	alias vi	'vim -N'
    endif
    #This is so i can check php syntax for command line
    if ( -X php ) then
	alias phpcheck	'php -q -l \!* | sed "s/<[^>]*>//gi"'
    endif
    #Sudo
    if (-X sudo ) then
	alias become 	'sudo -s -H -u '
    endif
    #This is the update command
    if ("$gettool" != "NONE") then
	alias cshrcupdate	'pushd . && cd && mv -f .zshrc .zshrc.old && ${gettool} ${distloc}${distfile} && reload && popd'
    else
	alias cshrcupdate	'echo "Disabled, lacking a file fetch utility for your OS"'
    endif

    alias doupdate	'cshrcupdate'
    alias getupdate	'cshrcupdate'

    #Dont want people bothering you
    if ("$thisuname" != "iPhone") then
	mesg n
    endif

    #Load Custom Completion
    if ("$shell" == "tcsh" ) then
	complete -%*		'c/%/j/'
	complete cd		'p/1/d/'
	complete kill		'c/%/j/' 'c/-/`kill -l`/' 'p/1/`ps ax | awk \{print\ \$1\} | sed s@PID@%\\n-@i`/' 'p/2-/`ps ax | awk \{print\ \$1\} | sed s@PID@%@i`/'
	complete passwd		'n/*/u/'
	complete chfn		'n/*/u/'
	complete userdel	'n/*/u/'
	complete rmuser		'n/*/u/'
	complete acminfo	'n/*/u/'
	complete webfix		'n/*/u/'
	complete akill		'n/*/u/'
	complete su		'n/*/u/'
	complete become		'n/*/u/'
	complete finger		'n/*/u/'
	complete set		'c/*=/f/' 'p/1/s/=' 'n/=/f/'
	complete alias		'p/1/a/'
	complete unalias	'n/*/a/'
	complete printenv	'n/*/e/'
	complete unsetenv	'n/*/e/'
	complete setenv		'c/*=/f/' 'p/1/e/' 'n/=/f/'
	complete unset		'n/*/s/'
	#Push and Pop everyones friends
	complete pushd		'p/1/d/'
	complete popd		'p/1/d/'
	complete pop		'p/1/d/'
	complete push		'p/1/d/'
	complete {fg,bg,stop} 	'c/%/j/' 'p/1/(%)//'
	#Custom completion for man, based on man path and strip out no such file errors
	complete man \
	    n@1@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man1 |& sed s%\\.1.\*\$%% | grep -v "no such file"`'@ \
	    n@2@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man2 |& sed s%\\.2.\*\$%% | grep -v "no such file"`'@ \
	    n@3@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man3 |& sed s%\\.3.\*\$%% | grep -v "no such file"`'@ \
	    n@4@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man4 |& sed s%\\.4.\*\$%% | grep -v "no such file"`'@ \
	    n@5@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man5 |& sed s%\\.5.\*\$%% | grep -v "no such file"`'@ \
	    n@6@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man6 |& sed s%\\.6.\*\$%% | grep -v "no such file"`'@ \
	    n@7@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man7 |& sed s%\\.7.\*\$%% | grep -v "no such file"`'@ \
	    n@8@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man8 |& sed s%\\.8.\*\$%% | grep -v "no such file"`'@ \
	    n@9@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man9 |& sed s%\\.9.\*\$%% | grep -v "no such file"`'@ \
	    n@0@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/man0 |& sed s%\\.0.\*\$%% | grep -v "no such file"`'@ \
	    n@n@'`manpath | tr : "\n" | xargs -n1 -I ## \ls -1 ##/mann |& sed s%\\..\*\$%% | grep -v "no such file"`'@ \
	    n@*@'`manpath | tr : "\n" | awk \{print\ \$1\"/mann\"\;for\(i=0\;i\<=9\;i++\)\{print\ \$1\"/man\"i}} | xargs -n1 -I ## \ls -1 ## | & grep -v "no such file" | sed s%\\..\*\%% | sort | uniq`'@
	complete find	'n/-name/f/' 'n/-newer/f/' 'n/-{,n}cpio/f/' \
			'n/-exec/c/' 'n/-ok/c/' 'n/-user/u/' \
			'n/-group/g/' 'n/-fstype/(nfs 4.2)/' \
			'n/-type/(b c d f l p s)/' \
			'c/-/(name newer cpio ncpio exec ok user \
			 group fstype type atime ctime depth inum \
			 ls mtime nogroup nouser perm print prune \
			 size xdev iname)/' \
			'p/*/d/'

    endif
    
    unset oracle #Unset Oracle Toggle Switch
 
    #Load User Customized Settings if they have them
    if ( -f $home/.cshrc.local ) then
	source $home/.cshrc.local
    endif

    #For my Java Peeps
    if($?JAVA_HOME) then
	set path = ( $path $JAVA_HOME/bin )
    endif

    #If they try to load sqlplus
    #For my Oracle DBA's 
    if($?oracle) then
	if(! $?ORACLE_SID || ! $?ORACLE_HOME) then
	    if ( -f /usr/local/bin/coraenv ) then
		source /usr/local/bin/coraenv
	    else
		echo 'Warning: /usr/local/bin/coraenv does not exist.'
		echo 'add "setenv ORACLE_SID <SID>" to ~/.cshrc.local'
		echo 'add "setenv ORACLE_HOME <PATH>" to ~/.cshrc.local'
	    endif
        endif
	if($?ORACLE_HOME) then
	    set path = ( $ORACLE_HOME/bin $path )
	endif
    else #Setup a means to auto configure
	#If they try to load sqlplus
	alias sqlplus 'echo "#Enable Oracle Support\nset oracle" >> ~/.cshrc.local && echo "Attempting to Auto Configure Oracle Env!"; reload'
	alias oracle sqlplus
    endif

endif #End of Interactive Shell Configuration
