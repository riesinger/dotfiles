# Dotfiles

These are the dotfiles for all my machines.
Many scripts are heavily inspired by [Luke Smith](https://lukesmith.xyz).

I deploy my dotfiles on new machines using [PARIS](https://github.com/riesinger/paris), which will
install all needed programs on Arch based computers (Arch derivatives such as Manjaro should also
work).

## Workflow

I mostly use Arch (or Arch-based distros) on my machines, since I just cannot live without the AUR
anymore. On servers however, I mostly use Debian.

sway is my window manager of choice, paired with waybar as a status bar.
I use neovim to do 99% percent of my editing.

For most projects, I keep tmux sessions running.

## Installing

On clean installs, use [PARIS](https://github.com/riesinger/paris). Otherwise, run the
`link_dotfiles` script in the `scripts` directory.

