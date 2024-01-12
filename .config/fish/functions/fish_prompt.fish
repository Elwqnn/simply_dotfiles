# function fish_prompt
#     set -l last_command_status $status

#     set -l symbol 'π'

#     set -l normal_color (set_color normal)
#     set -l branch_color (set_color yellow)
#     set -l meta_color (set_color red)
#     set -l symbol_color (set_color blue -o)
#     set -l error_color (set_color red -o)

#     if git_is_repo
#         echo -n -s $branch_color (git_branch_name) $normal_color
#         set -l git_meta ""
#         if test (command git ls-files --others --exclude-standard | wc -w 2> /dev/null) -gt 0
#             set git_meta "$git_meta?"
#         end
#         if test (command git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
#             set git_meta "$git_meta\$"
#         end
#         if git_is_touched
#             git_is_dirty && set git_meta "$git_meta⨯"
#             git_is_staged && set git_meta "$git_meta●"
#         end
#         set -l commit_count (command git rev-list --count --left-right (git remote)/(git_branch_name)"...HEAD" 2> /dev/null)
#         if test $commit_count
#             set -l behind (echo $commit_count | cut -f 1)
#             set -l ahead (echo $commit_count | cut -f 2)
#             if test $behind -gt 0
#                 set git_meta "$git_meta🠋"
#             end
#             if test $ahead -gt 0
#                 set git_meta "$git_meta🠉"
#             end
#         end
#         if test $git_meta
#             echo -n -s $meta_color " " $git_meta " " $normal_color
#         else
#             echo -n -s " "
#         end
#     end

#     if test $last_command_status -eq 0
#         echo -n -s $symbol_color $symbol " " $normal_color
#     else
#         echo -n -s $error_color $symbol " " $normal_color
#     end
# end

function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color blue)(prompt_pwd)' '

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'# '
    end
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    set_color normal
end
