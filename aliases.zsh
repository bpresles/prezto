# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Super user
alias _='sudo'

#alias g='grep -in'

# Show history
# the next one prevents us from using history with arguments since it has hardcoded 1
# which means the entire history. 
#alias history='fc -l 1'
alias history='fc -l '

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias ks=ls # often screw this up
# list only directories
alias lsd='ls -d *(/)'

alias afind='ack-grep -il'

#export TERM=xterm-color
export TERM=screen
# These options only work in GNU ls (gls) not in bsd
export LS_OPTIONS='-F --color'
alias l='ls -otrh'
alias lc='ls -F --color=none'
alias irb='irb --readline -r irb/completion --prompt inf_ruby'
alias ri='ri -f ansi -T'
alias helpruby19='open http://yardoc.org/docs/ruby-core/'
alias helpruby187='open http://ruby-doc.org/core-1.8.7/index.html'
alias helpbash='open ~/Documents/Technical/abs-guide4/HTML/index.html'

alias helpvimhtml='vim ~/vimHTML.html'
alias helpyard='open http://rubydoc.info/docs/yard/file/docs/GettingStarted.md'
alias totalrecall='cd ~/myblogs/totalrecall'
alias work='cd ~/work'
alias bin='cd ~/bin'
alias tmp='cd ~/tmp'
#alias locate='/sw/bin/locate'
alias vew='vim `ls -t | head -1`'
alias mmd='~/bin/multis.sh'
alias maillog='cat /var/log/mail.log'
alias systemlog='cat /var/log/system.log'
# have to keep doing this in screen !
alias PS1='PS1="\w: "'
alias gll='gem list --local'
alias k='ls -ltrh'
alias ks='ls'
alias ur='vim + -c "set paste" ~/UNIX.README'
#top
alias tu='top -o cpu' #cpu
alias tm='top -o vsize' #memory

#git
alias gb='git branch'
alias gba='git branch -a'
alias gcv='git commit -v'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gd='git diff'
alias gpl='git pull --rebase'
alias gp='git push'
alias ga='git add'
alias gaa='git add -A'
alias gst='git status'
#alias bp='vi ~/.bash_profile'
#alias zrc='vi ~/.zshrc'
alias zrc='vi ~/.zpreztorc ZS'
alias vrc='vi ~/.vimrc'
alias vimrc='vi ~/.vimrc'
alias helpsed='view ~/Documents/Technical/sed1line.txt'
alias ff="find . -type f -name "
alias vimneo='vim -u ~/vimrc-spf13'
alias vimspf='vim -u ~/vimrc-spf13'
# minsed, supposed to be faster cleaner
alias msed='sed'

# http://www.amirwatad.com/blog/archives/2009/01/30/enhanced-bash/
#Make sure all terminals save history
#shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#Increase history size
#export HISTSIZE=1000
#export HISTFILESIZE=1000
#Use GREP color features by default
export GREP_OPTIONS='--color=auto'
#if [ -f /opt/local/etc/bash_completion ]; then
   #. /opt/local/etc/bash_completion
#fi
alias bq='b q -CLO -CAN'
alias reddit='open  http://www.reddit.com/r/programming/'
alias hacker='open  http://news.ycombinator.com/'

## todo related
alias t='todo.sh -d ~/todo_rbc.cfg'
alias t='todorb'
#alias tb='t list +bugzy'
#alias tba='tb -J bugzy add'
#alias tbb='tb list +bugzy'
#alias tbr='tb list +r'

#alias trr='todo.sh -d ~/todo_rbc.cfg'
#alias tra='trr -J rbc add'

alias bu='bugzyrb'  # issues that will take longer
alias di='diary.sh'
alias tg='todoapp.sh -d ~/ ' # global todo general, like learnings
#alias ta='todoapp.sh '
# open last file ?
#alias lvim='vim -c "normal '\''0"'

alias notes='appenddiary.sh NOTES'
# so common modules can be placed here and called from anywhere witohout having to specify -I each time
export RUBYLIB=~/work/projects/rbcurse-core/lib
#[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
alias mdf='mdfind -name'
#source ~/bin/z.sh # http://github.com/rupa/z/blob/master/z.sh directory jumper
#    ruby lightning gem
alias lg=lightning   
#alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
#alias cvls='vlc -I rc'
# alias d does not work
#alias d=dooby
alias bl='b list --fields="1,2,4,9,10" --sort="9,9 -r" -CLO -CAN'
alias screen='screen -A'
alias bli='brew list'
# for a quick brew local search without pull requests, do bs
alias brs='brew search'
alias bri='brew install'
alias bru='brew update ; echo "-- outdated --" ; brew outdated'
alias bh='brew home'
# use 240px to download and put title in filename
alias ytdl='youtube-dl --title -f 5 '

# taskwarrior
alias ta='task'
# shell program that prints bugzy output instantly
alias bs='~/bin/b.sh'
# I tried this out since emacs was loading slowly, not that i use it, it was
# due to changes in Lion in /etc/hosts

alias -g G='| egrep'
alias -g FG='| fgrep'
alias -g L='| less'
alias -g WC='| wc -l'
alias -g H='| head'
alias -g HD='| head -24'
alias -g T='| tail'
alias -g TL='| tail -20'
alias -g RE='~/README'
alias -g AL='~/.zprezto/aliases.zsh'
alias -g ZS='~/.zshrc'
alias -g ZP='~/.zprezto/'
alias val='vim -o AL ZS'

# newest directory
alias -g ND='*(/om[1])'
# newest file
alias -g NF='*(.om[1])'
# replace ls in previous command with less
alias rr='r ls=less'
alias rl='r ls=l'
alias rv='r ls=vim'

alias rz='source ~/.zshrc && rehash'
trap "source ~/.zshrc && rehash" USR1
 # send pkill -usr1 zsh so all terminals source zshrc
alias le='less'

#alias bs='brew search'
alias bu='brew uses'
alias bd='brew deps'
alias bm='~/bin/bookmark'
# there is some command called w for seeing who is on system
alias w='which'
