Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE3A944
	for <iwd@lists.linux.dev>; Tue, 25 Apr 2023 21:46:57 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-5ef6ddd0498so62962586d6.3
        for <iwd@lists.linux.dev>; Tue, 25 Apr 2023 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682459216; x=1685051216;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bn00VqhZLMv98GzShcQX9KGA9gSq8dpBuXIVYicfWYU=;
        b=INvu22lS8r/K0qXV8okAD1mdM7c5cTSYbWa8q6VC9WYVxGPNn8SYFqmqN8gJMUuaV8
         pGpEog4ncH/dxmiiyNK/EUjtC/Qbxc4QYKb4bOTaqQ0dwNyPwSZPIH+rzr2lTzxBZ4X+
         c2WiCJVMhwiubYrFV+MKAO5XIBy016Opw0uVM3/rL5UDU6db9FoowTik6531ntHzOcMT
         fJx8G2NtPhpNbxwikAnnPs+h+GJc+JuK3tB5Qern33ZSllLFqpT+Br/Xe6zCao06PtGM
         RnohaxfaY3vi0WjoVqUsu1Jgi+v1dO6qKDgqXiPq/IlXVhUlzMewONOUMI12GWu7o7bM
         JxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682459216; x=1685051216;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn00VqhZLMv98GzShcQX9KGA9gSq8dpBuXIVYicfWYU=;
        b=Gweb1QoQ/J6AmTB4Da9DuA3pV/TGepBc95oTSLjaOQxWPqx/rqDIRwgBMJKdWXhAIH
         8yXNmp4VCEXp8HBphTgCOB8azZbZJhCs5awAaiYDSj6e+BhyoAPZV4MA3l9DYktFYPc8
         Qs0ZNQfwWl+AkQ+dslJRRcgIIGtFsH0HnfgPBa6icAVBoAOYGZ41LUHTd505Siynb3jG
         cjr31eziLEVBmG+HRQWQ/KXZ+7qnxjRZ+G0keMMcCJmCL4bxAIVQaGHE/olxF7nh3GwY
         d/YBjgQLr3miROx9sGMPjGxLASxPVZMnXeUDWRuvQmYn7nbrUwvPBTUt1M8nDEmJlx62
         IlBw==
X-Gm-Message-State: AAQBX9d4qyAAWfr2T6B7GXR2tsc/GilyZ3R16pTV4TOL5SzuzFH9vwaJ
	ik/N5kD2YWSCX/X9vDh95co=
X-Google-Smtp-Source: AKy350bZ275VYcQxYQ3/8JFIrknj7j8j3nC2pNQRfsNiQ6MYvvHKZ2vTgPZJRjBlmQOzcmHEvUZdDw==
X-Received: by 2002:a05:6214:e6b:b0:5f7:8b31:4548 with SMTP id jz11-20020a0562140e6b00b005f78b314548mr30270423qvb.4.1682459216132;
        Tue, 25 Apr 2023 14:46:56 -0700 (PDT)
Received: from [10.193.157.43] ([208.216.218.212])
        by smtp.gmail.com with ESMTPSA id z6-20020a0cda86000000b005ef53081921sm4379953qvj.42.2023.04.25.14.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 14:46:55 -0700 (PDT)
Message-ID: <b2be8a34-3624-b269-e253-6b76373807e0@gmail.com>
Date: Tue, 25 Apr 2023 14:46:54 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
To: Marcel Holtmann <marcel@holtmann.org>
Cc: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
 <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
 <914A101F-70E4-4FA0-80A9-CF3A28BE61D2@holtmann.org>
Content-Language: en-US
In-Reply-To: <914A101F-70E4-4FA0-80A9-CF3A28BE61D2@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 4/24/23 3:14 AM, Marcel Holtmann wrote:
> Hi James,
> 
>>>> I have tried to build iwd to the last commit "Allow building with
>>>> libedit instead readline". The Pkgfile seems to need the option
>>>> --enable-libedit to remove readline but it fails with
>>>>   CC       wired/dbus.o
>>>>   CCLD     ell/libell-internal.la
>>>>   CCLD     client/iwctl
>>>>   CCLD     src/iwd
>>>>   CCLD     wired/ead
>>>> /usr/bin/ld: client/command.o: in function `command_completion':
>>>> command.c:(.text+0x6cc): undefined reference to `rl_copy_text'
>>>> /usr/bin/ld: command.c:(.text+0x8b0): undefined reference to `rl_copy_text'
>>>> /usr/bin/ld: client/display.o: in function `save_input':
>>>> display.c:(.text+0x32): undefined reference to `rl_copy_text'
>>>> /usr/bin/ld: display.c:(.text+0x3a): undefined reference to `rl_save_prompt'
>>>> /usr/bin/ld: display.c:(.text+0x46): undefined reference to `rl_replace_line'
>>>> /usr/bin/ld: client/display.o: in function `display_text':
>>>> display.c:(.text+0x796): undefined reference to `rl_restore_prompt'
>>>> /usr/bin/ld: display.c:(.text+0x7a0): undefined reference to `rl_replace_line'
>>>> /usr/bin/ld: client/display.o: in function `display_completion_matches':
>>>> display.c:(.text+0x834): undefined reference to `rl_copy_text'
>>>> /usr/bin/ld: client/display.o: in function `timeout_callback':
>>>> display.c:(.text+0x9d0): undefined reference to `rl_restore_prompt'
>>>> /usr/bin/ld: display.c:(.text+0x9da): undefined reference to `rl_replace_line'
>>>> /usr/bin/ld: client/display.o: in function `display_table_footer':
>>>> display.c:(.text+0x11a6): undefined reference to `rl_restore_prompt'
>>>> /usr/bin/ld: display.c:(.text+0x11b1): undefined reference to `rl_replace_line'
>>>> /usr/bin/ld: client/display.o: in function `display_enable_cmd_prompt':
>>>> display.c:(.text+0x168e): undefined reference to `rl_save_prompt'
>>>> /usr/bin/ld: display.c:(.text+0x1698): undefined reference to
>>>> `rl_restore_prompt'
>>>> /usr/bin/ld: client/display.o: in function `display_agent_prompt':
>>>> display.c:(.text+0x177d): undefined reference to `rl_copy_text'
>>>> /usr/bin/ld: display.c:(.text+0x1797): undefined reference to `rl_replace_line'
>>>> /usr/bin/ld: display.c:(.text+0x17a5): undefined reference to
>>>> `rl_erase_empty_line'
>>>> /usr/bin/ld: client/display.o: in function `display_agent_prompt_release':
>>>> display.c:(.text+0x1889): undefined reference to `rl_copy_text'
>>>> /usr/bin/ld: display.c:(.text+0x18cd): undefined reference to
>>>> `rl_erase_empty_line'
>>>> /usr/bin/ld: display.c:(.text+0x18db): undefined reference to `rl_replace_line'
>>>> /usr/bin/ld: client/display.o: in function `display_init':
>>>> display.c:(.text+0x1a3e): undefined reference to `rl_erase_empty_line'
>>>> collect2: error: ld returned 1 exit status
>>>> make[1]: *** [Makefile:1895: client/iwctl] Error 1
>>>> make[1]: *** Waiting for unfinished jobs....
>>>> make: *** [Makefile:1595: all] Error 2
>>>> =======> ERROR: Building
>>>> '/usr/ports/perso/iwd/iwd1682174379x86_64.cards.tar.xz' failed.
>>>>
>>>> It looks like some readline commands are always taken in count
>>>>
>>>> I have my Pkgfile and the compilation log
>>> It does build for me just fine. What distro is this?
>>> What does pkg-config --cflags --libs libedit show?
>>
>> I'm seeing the same build problem, Ubuntu 20.04:
>>
>> $ pkg-config --cflags --libs libedit
>> -I/usr/include/editline -ledit
> 
> so Ubuntu seems to have libeditreadline-dev and maybe it has
> Its own pkg-config file for a library with the rl_ symbols.

I see that Debian package, but Ubuntu doesn't have it (or my Ubuntu 
distro doesn't). It does have libedit-dev which is what I installed. It 
appears the libedit package just doesn't include ALL the rl_* symbols 
that iwctl uses:

jprestwood@LOCLAP699:~/iwd$ objdump -TC 
/lib/x86_64-linux-gnu/libedit.so.2 | grep rl_ | cut -d' ' -f17
rl_getc_function
rl_pre_input_hook
rl_inhibit_completion
rl_readline_name
rl_redisplay
rl_deprep_terminal
rl_completer_quote_characters
rl_completer_word_break_characters
rl_filename_completion_desired
rl_prep_terminal
rl_free_line_state
rl_set_keymap
rl_newline
rl_resize_terminal
rl_callback_handler_remove
_rl_qsort_string_compare
rl_completion_word_break_hook
rl_instream
rl_basic_word_break_characters
rl_forced_update_display
rl_readline_version
rl_kill_text
rl_startup_hook
rl_set_screen_size
rl_point
rl_special_prefixes
rl_startup1_hook
rl_get_previous_history
rl_stuff_char
rl_completion_entry_function
rl_completion_display_matches_hook
rl_did_startup_hook
rl_generic_bind
rl_set_keyboard_input_timeout
rl_event_hook
rl_callback_handler_install
rl_parse_and_bind
rl_line_buffer
rl_linefunc
rl_variable_bind
rl_terminal_name
rl_deprep_term_function
rl_on_new_line
rl_done
rl_redisplay_function
rl_prep_term_function
rl_outstream
rl_end
rl_read_key
rl_catch_sigwinch
rl_catch_signals
rl_insert
rl_completion_append_character
rl_attempted_completion_over
rl_reset_after_signal
rl_completion_query_items
rl_reset_terminal
rl_library_version
rl_already_prompted
rl_bind_key
rl_completion_matches
rl_callback_read_char
rl_set_prompt
rl_get_screen_size
rl_cleanup_after_signal
rl_bind_key_in_map
rl_make_bare_keymap
rl_prompt
rl_read_init_file
rl_insert_text
rl_add_defun
_rl_print_completions_horizontally
rl_echo_signal_char
rl_display_match_list
rl_ignore_completion_duplicates
rl_filename_completion_function
rl_completion_type
rl_attempted_completion_function
rl_get_keymap
rl_initialize
_rl_abort_internal
rl_complete

Why this would be different on Fedora is beyond me, very weird.

Thanks,
James

> 
> Regards
> 
> Marcel
> 
