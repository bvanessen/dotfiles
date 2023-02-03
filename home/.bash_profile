source ~/.profile

# BVE 8-11-2017 Need to figure out what is going on with .profile vs .bash_profile
export SPACK_ROOT=/Users/vanessen1/Research/spack.git
. $SPACK_ROOT/share/spack/setup-env.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/vanessen1/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/vanessen1/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/vanessen1/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/vanessen1/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export PATH="/usr/local/sbin:$PATH"
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
