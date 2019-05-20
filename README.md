# Dotfiles

These are the dotfiles for all my machines. 
Many scripts are heavily inspired by [Luke Smith](https://lukesmith.xyz).

I deploy my dotfiles on new machines using [PARIS](https://github.com/riesinger/paris), which will
install all needed programs on Arch based computers (Arch derivatives such as Manjaro should also
work).

## Workflow

I only use Arch or Arch-based distros on my machines, since the AUR and rolling upgrades are
_awesome_.

i3 (i3-gaps) is my window manager of choice, paired with i3blocks as a status bar.
I use neovim to do 99% percent of my editing (Java development is done in IntelliJ IDEA with the
IdeaVim plugin).

For most projects, I keep tmux sessions running.

## Installing

On clean installs, use [PARIS](https://github.com/riesinger/paris). Otherwise, run the
`link_dotfiles` script in the `scripts` directory.

