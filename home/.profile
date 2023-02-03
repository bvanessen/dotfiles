# .profile - login shells only read .profile by default

#source ~/.bve_env
#source ~/.uw_env

# Check to see if the -i (interactive) flag has been set
case $- in
  *i*)
     echo "Interactive shell"
     source ~/.bve_path
     ;;
#  *)
#    echo "Non-Interactive shell"
#   ;;
esac

#if ($?TERM) then
#  if(xterm =~ $TERM || xterm-color =~ $TERM) then
#    source ~/.settitle
#		setenv PATH ${PATH}:/Users/vanessen/bin
#		setenv MANPATH ${MANPATH}:/usr/local/man
#		setenv INFOPATH ${INFOPATH}:/usr/local/info
#	endif
#  if(xterm-color =~ $TERM) then
#    setenv DISPLAY localhost:0.0
#  endif
#endif

#setup terminals so it knows where the display is.
if [ -z "$DISPLAY" ]; then
  export DISPLAY=:0.0
fi

source ~/.alias


case $TERM in
xterm*)
        #Place the pathname into the Terminal's Title Bar
        export PROMPT_COMMAND='echo -n "]1;$PWD"'

        #setup the prompt
        #PS1='\u@\h: `basename \w`\$ '
        PS1='\u@\h: \w\$ '
        ;;
*)
        PS1='\u@\h\$ '
        ;;
esac

# Fink
#test -r /sw/bin/init.sh && . /sw/bin/init.sh

prepend_path PATH /Users/vanessen1/usr/bin
# Setup NVIDIA CUDA
#prepend_path PATH /usr/local/cuda/bin
#export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH

# Setup C++ Boost
#export BOOST_INSTALL=/Users/vanessen1/usr/boost_1_45_0
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BOOST_INSTALL/lib
#export DYLD_LIBRARY_PATH=$BOOST_INSTALL/lib:$DYLD_LIBRARY_PATH

##
# Support homebrew by moving /usr/local/bin in front of /usr/bin
#
prepend_path PATH /usr/local/bin

##
# Your previous /Users/vanessen1/.profile file was backed up as /Users/vanessen1/.profile.macports-saved_2011-10-24_at_13:02:45
##

# MacPorts Installer addition on 2011-10-24_at_13:02:45: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH

##
# Your previous /Users/vanessen1/.profile file was backed up as /Users/vanessen1/.profile.macports-saved_2013-08-05_at_17:21:40
##

# MacPorts Installer addition on 2013-08-05_at_17:21:40: adding an appropriate PATH variable for use with MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Enable node.js and npm to work
export NODE_TLS_REJECT_UNAUTHORIZED='0'
# Setup spack
export SPACK_ROOT=/Users/vanessen1/Research/spack.git
. $SPACK_ROOT/share/spack/setup-env.sh

export EDITOR='emacs -nw'
export PATH=~/bin:$PATH

export PATH=/Developer/NVIDIA/CUDA-9.1/bin${PATH:+:${PATH}}
export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-9.1/lib\
                         ${DYLD_LIBRARY_PATH:+:${DYLD_LIBRARY_PATH}}

# Add support for lmod and module commands via Brew
#source $(brew --prefix lmod)/init/$(basename $SHELL)

source ~/.alias
