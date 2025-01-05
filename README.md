# shellmind

A shell plugin that uses GPT to convert natural language or pseudo-code into
actual shell commands. It is not just a cli llm client, but integrates into the
shell for convenience and speed.

![demo gif](./.github/demo.gif)

- (For now limited to OpenAI, open an issue to request other providers.)
- (For now limited to Fish, open an issue to request other shells.)

## Requirements

- Fish shell
- curl
- jq
- An OpenAI API key

## Installation

First, make sure to set the environment variable `OPENAI_API_KEY` to a valid
OpenAI API key.

### Fish

1. Put the `shellmind.fish` file from this repo into `.config/fish/functions/`.
   Edit this file for some optional configuration options.

2. Add a [keybind](TODO) to `.config/fish/functions/fish_user_key_bindings.fish`:
    ```fish
    function fish_user_key_bindings
        # ...
        # Your other keybinds
        # ...

        # For Ctrl-X:
        bind \cx 'shellmind_replace'

        # For Ctrl-X in insert mode when using Vi mode:
        bind -M insert \cx 'shellmind_replace'
    end
    ```

### Bash: TODO
### Zsh: TODO
