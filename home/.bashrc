# .bashrc - subshells only read the .bashrc
# source the .profile to get general environment settings

[ -r ~/.profile ] && source ~/.profile

# For any subshell, include the subshell level in the prompt string
#PS1='($SHLVL) \h:\w \u\$ '
#PS1='($SHLVL) \u@\h: `basename \w`\$ '
PS1='($SHLVL) \u@\h: \w\$ '
MANPATH=$MANPATH:$HOME/share/man

# Provide supp
# function frameworkpython {
#     if [[ ! -z "$VIRTUAL_ENV" ]]; then
#         PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
#     else
#         /usr/local/bin/python "$@"
#     fi
# }

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

export PATH=/Users/vanessen1/.gem/ruby/2.0.0/bin:${PATH}

# added by travis gem
[ -f /Users/vanessen1/.travis/travis.sh ] && source /Users/vanessen1/.travis/travis.sh
