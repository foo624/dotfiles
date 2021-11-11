function fish_prompt -d "Print prompt"
  if [ $status -eq 0 ]
    set status_face (set_color normal)'$ '
  else
    set status_face (set_color red)'$ '(set_color normal)
  end

  set -g fish_prompt_pwd_dir_length 0

  set -g __fish_git_prompt_showdirtystate 'yes'
  set -g __fish_git_prompt_showstashstate 'yes'
  set -g __fish_git_prompt_showuntrackedfiles 'yes'

  set prompt (set_color green)$USER'@'(hostname | cut -d . -f 1) (set_color yellow)(prompt_pwd)(set_color normal)

  echo ""
  echo $prompt (fish_git_prompt)
  echo $status_face
end

