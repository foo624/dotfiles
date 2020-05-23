function fco -d "Fuzzy-find and checkout a tag"
  set OLD_IFS IFS
  set IFS

  set branches (
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  set tags (git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  echo -e $branches"\n"$tags | fzf --no-hscroll --no-multi -n 2 --ansi | awk '{print $2}' | read -l result;

  git checkout "$result"

  set IFS OLD_IFS
end

