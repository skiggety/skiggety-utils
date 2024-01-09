######################## ( should be at the bottom of ~/.bashrc ) ################################## FROM_SKIGGETY_UTILS
# From                                                                                             # FROM_SKIGGETY_UTILS
# "$SKIGGETY_UTILS_DIR/installers/skiggety.bash.config/bashrc_section.bash",                       # FROM_SKIGGETY_UTILS
# this should be installed into the user's .bashrc file:                                           # FROM_SKIGGETY_UTILS
export SKIGGETY_UTILS_DIR="$HARDCODED_SKIGGETY_UTILS_DIR"                                          # FROM_SKIGGETY_UTILS
                                                                                                   # FROM_SKIGGETY_UTILS
# TODO^11: try to at least support nano or vscode:                                                 # FROM_SKIGGETY_UTILS
export EDITOR='vim' # Use any editor you want, it'll be pretty well supported if it's vim.         # FROM_SKIGGETY_UTILS
                                                                                                   # FROM_SKIGGETY_UTILS
source $SKIGGETY_UTILS_DIR/lib/include_in_bashrc.bash                                              # FROM_SKIGGETY_UTILS
                                                                                                   # FROM_SKIGGETY_UTILS
# Default debug setting.  Set it to "true" above this section in your ~/.bashrc to see debug       # FROM_SKIGGETY_UTILS
# messages:                                                                                        # FROM_SKIGGETY_UTILS
export SKIGGETY_DEBUG=${SKIGGETY_DEBUG:-false}                                                     # FROM_SKIGGETY_UTILS
export SKIGGETY_BLINKY_DEBUG=${SKIGGETY_DEBUG:-false} # help you see 'DEBUG'                       # FROM_SKIGGETY_UTILS
# export PATH="${PATH}:${SKIGGETY_UTILS_DIR}/bin/silliness" # very optional                        # FROM_SKIGGETY_UTILS
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"                                      # FROM_SKIGGETY_UTILS
