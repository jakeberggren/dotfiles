# Dotfiles

Important dotfiles stored in the same place.

## Requirements

### Git

Used for version control and to download this repo.

```
brew install git
```

### Stow

Stow is used to manage all dotfiles in one folder, and create symlinks in the correct locations

```
brew install stow
```

## Installation

Check out the dotfiles repo in the $HOME directory using git.

```
$ git clone git@github.com:jakeberggren/dotfiles.git
$ cd dotfiles
```

Then use GNU stow to create symlinks

```
$ stow .
```

For more information, refer to this [YouTube Video](https://www.youtube.com/watch?v=y6XCebnB9gs)
