# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster_multiline's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=black
fi

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
AHEAD="↑"
BEHIND="↓"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment $PRIMARY_FG default " %(!.%{%F{yellow}%}.)$user@%m "
  fi
}

prompt_user() {
  local user=`whoami`
  
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment $PRIMARY_FG default " %(!.%{%F{yellow}%}.)$user "
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref git_status_full git_status

  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }

  git_status_summary() {
    awk '
    BEGIN {
      untracked=0;
      unstaged=0;
      staged=0;
    }
    {
      if (!after_first && $0 ~ /^##.+/) {
        print $0
        seen_header = 1
      } else if ($0 ~ /^\?\? .+/) {
        untracked += 1
      } else {
        if ($0 ~ /^.[^ ] .+/) {
          unstaged += 1
        }
        if ($0 ~ /^[^ ]. .+/) {
          staged += 1
        }
      }
      after_first = 1
    }
    END {
      if (!seen_header) {
        print
      }
      print untracked "\t" unstaged "\t" staged
    }'
  }
  
  ref="$vcs_info_msg_0_"

  local status_lines=$((git status --porcelain -b 2> /dev/null ||
                        git status --porcelain 2> /dev/null) | git_status_summary)

  local git_status=$(awk 'NR==1' <<< "$status_lines")
  local counts=$(awk 'NR==2' <<< "$status_lines")

  IFS=$'\t' read untracked_count unstaged_count staged_count <<< "$counts"

  if [[ -n "$ref" ]]; then
    if is_dirty; then
      ref="${ref} $PLUSMINUS"

      if [[ $untracked_count -gt 0 ]]; then
        color=red
        ref+=" ?:${untracked_count}"
      elif [[ $unstaged_count -gt 0 ]]; then
        color=yellow
	ref+=" U:${unstaged_count}"
      else
        color=cyan
	ref+=" S:${staged_count}"
      fi
    else
      color=green
      ref="${ref} "
    fi

    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    
    local ahead_re='.+ahead ([0-9]+).+'
    local behind_re='.+behind ([0-9]+).+'
    [[ $git_status =~ $ahead_re ]] && ref+=" ${AHEAD}$match[1]"
    [[ $git_status =~ $behind_re ]] && ref+=" ${BEHIND}$match[1]"
    
    prompt_segment $color $PRIMARY_FG
    print -Pn " $ref"
  fi
}

# Dir: current working directory
prompt_dir_shortened() {
  prompt_pwd=$(promptpwd)
  prompt_segment blue $PRIMARY_FG " $prompt_pwd "
}

prompt_dir() {
  prompt_segment blue $PRIMARY_FG ' %~ '
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG default " $symbols "
}

# Display current virtual environment
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    color=cyan
    prompt_segment $color $PRIMARY_FG
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

prompt_time() {
  print "%F{white}[%D{%H:%M:%S}]" 
}

## Main prompt
prompt_agnoster_multiline_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_git
  prompt_dir
  prompt_virtualenv
  prompt_status
  prompt_end
}

prompt_agnoster_multiline_right() {
  prompt_context
  prompt_time 
}

prompt_agnoster_multiline_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_agnoster_multiline_main) 
 ❯ '
  RPROMPT='$(prompt_agnoster_multiline_right)'
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
}

prompt_agnoster_multiline_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_agnoster_multiline_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_multiline_setup "$@"
