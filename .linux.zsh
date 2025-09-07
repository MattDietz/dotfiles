[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$PATH:~/.local/bin:~/.local/appimages

# Turn on "experimental" hardware encoding and decoding and also make sure things know where the ICD is
export RADV_PERFTEST=video_encode,video_decode
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json

# Aliases for setting the charge limit because I couldn't remember what the tool was called
alias charge80="sudo ~/.local/bin/framework_tool --charge-limit 80"
alias charge100="sudo ~/.local/bin/framework_tool --charge-limit 100"

# Not sure I want to keep this
# zellij_tab_name_update() {
#     if [[ -n $ZELLIJ ]]; then
#         local current_dir=$PWD
#         if [[ $current_dir == $HOME ]]; then
#             current_dir="~"
#         else
#             current_dir=${current_dir##*/}
#         fi
#         command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
#     fi
# }
#
# zellij_tab_name_update
# chpwd_functions+=(zellij_tab_name_update)
