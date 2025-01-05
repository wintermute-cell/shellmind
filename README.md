# shellmind 🧠

A shell plugin that uses an llm to convert natural language or pseudo-code into
actual shell commands. It is not just an llm client, but integrates into the
shell for convenience and speed.

![demo gif](./.github/demo.gif)

- (For now limited to OpenAI, open an issue to request other providers.)
- (For now limited to Fish, open an issue to request other shells.)

## Requirements

- Fish shell
- curl
- jq
- An OpenAI API key

## Usage

1. Install `shellmind` and bind it to a key
2. Type a pseudo-code command in your shell
3. Press your assigned key to replace the pseudo-code with a real command

## Installation

First, make sure to set the environment variable `OPENAI_API_KEY` to a valid
OpenAI API key.

### Fish

1. Put the `shellmind.fish` file from this repo into `.config/fish/functions/`.
   You may edit that file for some optional configuration options.

2. Add a [keybind](https://fishshell.com/docs/current/cmds/bind.html) to `.config/fish/functions/fish_user_key_bindings.fish`:
    ```fish
    function fish_user_key_bindings
        # ...
        # Your other keybinds
        # ...

        # For Ctrl-X:
        bind \cx 'shellmind'

        # For Ctrl-X in insert mode when using Vi mode:
        bind -M insert \cx 'shellmind'
    end
    ```

### Bash

1. Put the `shellmind.bash` file from this repo into a directory of your choice.
   You may edit that file for some optional configuration options.

   ```bash
   source /path/to/shellmind.bash
   ```

2. Add a keybind to your `.bashrc`:
   ```bash
   # For Ctrl-G
   bind -x '"\C-g": shellmind'
   ```

### Zsh

1. Put the `shellmind.zsh` file from this repo into a directory of your choice.
   You may edit that file for some optional configuration options.

2. Source the file in your `.zshrc`:
    ```bash
    source /path/to/shellmind.zsh
    ```

3. Add a [keybind](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Key-Bindings) to your `.zshrc`:
    ```bash
    # For Ctrl-G:
    zle -N shellmind
    bindkey '^G' shellmind
    ```
