Vim�UnDo� }��+�o2�\6
(�'n�e"]�6.����H                                     [u��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             [u��     �                   �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             [u��    �                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                       %           V        [u��     �                   �               �              %   %# compinit optimization for oh-my-zsh   L# On slow systems, checking the cached .zcompdump file to see if it must be    Q# regenerated adds a noticable delay to zsh startup.  This little hack restricts    G# it to once a day.  It should be pasted into your own completion file.   #   ,# The globbing is a little complicated here:   ]# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.   m# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)   # - '.' matches "regular files"   T# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.       #autoload -U compaudit compinit   #: ${ZSH_DISABLE_COMPFIX:=true}   # ...   setopt extendedglob   +if [[ $ZSH_DISABLE_COMPFIX != true ]]; then   Q  # If completion insecurities exist, warn the user without enabling completions.   "  if ! compaudit &>/dev/null; then   J    # This function resides in the "lib/compfix.zsh" script sourced above.   "    handle_completion_insecurities   ;  # Else, enable and cache completions to the desired file.     else   2    if [[ -n "${ZSH_COMPDUMP}"(#qN.mh+24) ]]; then   #      compinit -d "${ZSH_COMPDUMP}"         compdump       else         compinit -C       fi     fi   else   0  if [[ -n "${ZSH_COMPDUMP}"(#qN.mh+24) ]]; then   $    compinit -i -d "${ZSH_COMPDUMP}"       compdump     else       compinit -C     fi   fi5�_�                             ����                                                                                                                                                                                                                                                                                                                                                  V        [u��    �                   �               5��