function shellmind {
    # ===================
    # CONFIGURATION
    # [0.0 to 1.0], determines "creativity" of the model,
    # higher is more creative
    local TEMPERATURE=0.3

    # An addition to the base prompt, if desired
    local ADDITIONAL_PROMPT=""

    # The OpenAI model name. Options: https://platform.openai.com/docs/models
    local MODEL="gpt-4o-mini"
    # END CONFIGURATION
    # ===================

    local current_cmd="$BUFFER"
    if [[ -z "$current_cmd" ]]; then
        return
    fi

    echo -en "\033[2K\rThinking..."

    local openai_key="$OPENAI_API_KEY"
    if [[ -z "$openai_key" ]]; then
        echo "OpenAI API key not set. Please set the OPENAI_API_KEY environment variable." >&2
        return
    fi

    local base_prompt="You are a command line assistant. You have complete knowledge of linux command and cli tools. Your input is a pseudo code form of a command line job. Your output is the actual command line job, implemented and formatted as closely as makes sense to the pseudo code input. You might need to add additional flags or arguments, or even rewrite or implement some parts or all of it from scratch. Your number one priority is writing a command that achieves what the user INTENDS. Focus on small details and do not overlook anything. Only ever output the command, no explanation or additional information. Do not wrap the output in a markdown code block. The raw code is the only allowed response. If you are unsure of the correct command, output a message indicating that you are unable to process the input, giving a reason why."
    base_prompt="${base_prompt} You are writing a command for the zsh shell."

    if [[ -n "$ADDITIONAL_PROMPT" ]]; then
        base_prompt="${base_prompt}\n${ADDITIONAL_PROMPT}"
    fi

    local prompt="${base_prompt}\n\nInput: ${current_cmd}"

    # Escape the prompt for JSON
    local escaped_prompt=$(echo "$prompt" | jq -R -s '.')
    local json_data="{\"model\":\"$MODEL\",\"messages\":[{\"role\":\"user\",\"content\":$escaped_prompt}],\"temperature\":$TEMPERATURE}"

    local resp=$(curl -s "https://api.openai.com/v1/chat/completions" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "$json_data")

    local completion=$(echo "$resp" | jq -r '.choices[0].message.content')

    if [[ -z "$completion" ]]; then
        echo "An error occurred while processing the input. Please try again." >&2
        return
    fi

    # Replace the current command line buffer with the completion
    BUFFER="$completion"
    CURSOR=${#BUFFER}  # Move cursor to end
    zle redisplay
}
