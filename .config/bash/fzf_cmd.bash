# fzf command for bash.

export FZF_DEFAULT_OPTS="--height 20% --layout=default"

fcd() {
  if [[ -z "$*" ]]; then
    cd "$(z | fzf -1 -0 --no-sort --tac +m | sed 's/^[0-9,.]* *//')" || exit
  else
    cd "$(z | fzf --query="$*" -1 -0 --no-sort --tac +m | sed 's/^[0-9,.]* *//')" || exit
  fi
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout "$(echo "$branch" | awk '{print $1}' | sed "s/.* //")"
}

# fbrc - checkout git branch (including remote branches)
fbrc() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout "$(awk '{print $2}' <<<"$target" )"
}
