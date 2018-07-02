# hackedtobits' dotfiles
My dotfiles as managed by rcm.

## Quick install to new machine
1. Clone the repo to the local machine
  ```
  git clone git@github.com:hackedtobits/dotfiles.git ~/.dotfiles
  ```
1. Run the 'rcup -g'-created install script
  ```
  sh .dotfiles/install.sh
  ```

## Updating files in ~/.dotfiles
1. First, add the new file with rcm
  ```
  mkrc <filename>
  ```
  The specified file will be moved to the `~/.dotfiles` directory with the
  dot prefix removed. The original file will be deleted,
  then symlinked from `~/.dotfiles` back to its original location.
1. Propose addition to the repository
  ```
  git add <filename>
  ```
1. Actually commit these changes
  ```
  git commit -m "Commit message"
  ```
1. Send these changes to the remote repository
  ```
  git push origin master
  ```

## Get the newest version of the .dotfiles directory
```
git pull
```