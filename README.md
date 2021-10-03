# TLA Mode
An Emacs major mode for editing TLA+ specifications.

**WARNING** Currently very hacky and dependent on multiple forks. PRs will be tracked here, and as they are integrated this will get easier to use.

## Installation

With `straight.el` and use-package integration
```elisp
(use-package tla-mode
  :straight (:repo "carlthuringer/tla-mode")
  :hook ((tla-mode . tree-sitter-mode)
         (tla-mode . tree-sitter-hl-mode)))
  
(use-package tree-sitter-langs
  :straight (:fork (:repo "carlthuringer/tree-sitter-langs" :branch "add-tlaplus")))
```

After cloning the repo, you have to then build the grammar binary for your system.
You need to install some `node` environment, such as `volta` and configure it for your system. You will also probably need to have an available `g++` compiler. As I said, this is very WIP.

```sh
cd ~/.config/emacs/straight/repos/tree-sitter-langs/
script/compile tlaplus
```

Unfortunately, with the upstream version of `tree-sitter-tlaplus`, I run into this error:
```
script/compile tlaplus
[tree-sitter-langs] Processing tlaplus
[tree-sitter-langs] Running (git submodule update --init --checkout -- repos/tlaplus) in /home/carl/.config/emacs/straight/repos/tree-sitter-langs/
Cloning into '/home/carl/.config/emacs/straight/repos/tree-sitter-langs/repos/tlaplus'...
Submodule path 'repos/tlaplus': checked out 'd7d8c73035028edeb07cd3d9a50bcc635a186877'

[tree-sitter-langs] Running (tree-sitter generate) in /home/carl/.config/emacs/straight/repos/tree-sitter-langs/repos/tlaplus/
No such file or directory (os error 2)
```

The error code being emitted here occurs because `tree-sitter-langs` sets `TREE_SITTER_DIR="/home/carl/.config/emacs/straight/build/tree-sitter-langs/"`. The `tree-sitter-cli` looks in this location for a `config.json`, which does not exist there.
For some reason, calling `tree-sitter generate` with this environment results in this error, but only on `>= v0.20` of `tree-sitter-cli`. 

For now, the workaround I have is to add the `config.json` to the `tree-sitter-langs` fork. 
