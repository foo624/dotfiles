##################################################
# git

set git_dirty_color red
set git_not_dirty_color green

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color $git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $git_not_dirty_color)$branch(set_color normal)
  end
end

##################################################
# prompt

set fish_prompt_pwd_dir_length 0

function fish_prompt
  if [ $status -eq 0 ]
    set status_face (set_color normal)'$ '
  else
    set status_face (set_color red)'$ '(set_color normal)
  end

  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  set prompt (set_color green)$USER'@'(hostname | cut -d . -f 1) (set_color yellow)(prompt_pwd)(set_color normal)

  if test -n "$git_dir"
    echo ''
    echo $prompt [(parse_git_branch)]
    echo $status_face
  else
    echo ''
    echo $prompt
    echo $status_face
  end
end

