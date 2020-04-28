function fish_prompt --description 'Write out the prompt'
  #Save the return status of the previous command
  set stat $status

  #Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    #set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    set -g __fish_prompt_hostname "sf-mbp"
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __fish_color_user
    set -g __fish_color_user (set_color -o 00b)
  end

  if not set -q __fish_color_host
    set -g __fish_color_host (set_color -o b0b)
  end

  if not set -q __fish_color_punctuation
    set -g __fish_color_punctuation (set_color -o 777)
  end

  if not set -q __fish_color_vcs
    set -g __fish_color_vcs (set_color -o purple)
  end

  #Set the color for the status depending on the value
  set __fish_color_status (set_color -o green)
  if test $stat -gt 0
    set __fish_color_status (set_color -o red)
  end

  # Hack; fish_config only copies the fish_prompt function (see #736)
  if not set -q -g __fish_classic_git_functions_defined
    set -g __fish_classic_git_functions_defined

    function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
      if status --is-interactive
        commandline -f repaint ^/dev/null
      end
    end
  end


  switch $USER

  case root toor

    if not set -q __fish_prompt_cwd
      if set -q fish_color_cwd_root
        set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
      else
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end
    end

    printf '%s@%s %s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

  case '*'

    if not set -q __fish_prompt_cwd
      set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '\n%s%s%s@%s%s %s%s %s[%s%s%s]%s%s%s%s\f\r$%s ' "$__fish_color_user" $USER "$__fish_color_punctuation" "$__fish_color_host" $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_color_punctuation" "$__fish_color_status" "$stat" "$__fish_color_punctuation" "$__fish_prompt_normal" "$__fish_color_vcs" (__fish_vcs_prompt) "$__fish_color_punctuation" "$__fish_prompt_normal"

  end
end
