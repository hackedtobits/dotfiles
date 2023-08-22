# hackedtobits' dotfiles
My dotfiles as managed by rcm (https://thoughtbot.github.io/rcm/)

## Quick install to new machine
1. Clone the repo to the local machine
  ```
  git clone https://github.com/hackedtobits/dotfiles.git ~/.dotfiles
  ```
2. Run the 'rcup -g'-created install script
  ```
  sh .dotfiles/install.sh
  ```

## Adding files in ~/.dotfiles
  First, add the new file with rcm
  ```
  mkrc <filename>
  ```
  The specified file will be moved to the `~/.dotfiles` directory with the
  dot prefix removed. The original file will be deleted,
  then symlinked from `~/.dotfiles` back to its original location.

  Then, follow the instructions below, starting at #2.

## Updating files in ~/.dotfiles
1. Edit the file in question.
2. Propose addition to the repository
  ```
  git add <filename>
  ```
3. Commit these changes
  ```
  git commit -m "Commit message"
  ```
4. Send these changes to the remote repository
  ```
  git push origin master
  ```

## Get the newest version of the .dotfiles directory
```
git pull
```
