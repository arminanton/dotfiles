# mc-sudo

Easily prefix your current or previous commands with `mc-sudo` by pressing <kbd>esc</kbd> twice

To use it, add `mc-sudo` to the plugins array in your zshrc file:

```zsh
plugins=(... mc-sudo)
```

## Usage

### Current typed commands

Say you have typed a long command and forgot to add `mc-sudo` in front:

```console
$ apt-get install build-essential
```

By pressing the <kbd>esc</kbd> key twice, you will have the same command with `mc-sudo` prefixed without typing:

```console
$ mc-sudo apt-get install build-essential
```

### Previous executed commands

Say you want to delete a system file and denied:

```console
$ rm some-system-file.txt
-su: some-system-file.txt: Permission denied
$
```

By pressing the <kbd>esc</kbd> key twice, you will have the same command with `mc-sudo` prefixed without typing:

```console
$ rm some-system-file.txt
-su: some-system-file.txt: Permission denied
$ mc-sudo rm some-system-file.txt
Password:
$
```
