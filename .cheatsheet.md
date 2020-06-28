# Cheat Sheet

## vim-commentary

- `gcc`         : 一行コメント
- `[visual] gc` : visual選択した個所をコメント
- `gc[cmd]`     : vimの移動系コマンドで範囲をコメント

## vim-surround

- `ds[e]`       : 囲いを削除
- `cs[e][d]`    : 囲い[e]を[d]に変更
- `ys[mo][d]`   : モーションを使用して[d]で囲む (ex: ysiw")
- `S[d]`        : ヴィジュアルモードで[d]で囲む

## fzf

- `<Leader>tab` : Maps一覧の表示
- `[fzf]l`      : Show commit log.
- `[fzf]L`      : Show commit log for current buffer.
- `[fzf]p`      : Show git ls-files.
- `[fzf]P`      : Show git status.
