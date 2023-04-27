Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B83201
	for <iwd@lists.linux.dev>; Thu, 27 Apr 2023 14:28:24 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-94f0dd117dcso1279776866b.3
        for <iwd@lists.linux.dev>; Thu, 27 Apr 2023 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682605703; x=1685197703;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMoZzdS9l6dkhJcdB/feWzso3okmA1SIi04NfS7lrSY=;
        b=NoZC9AHTBXnLF/R9HW73nTunuDakFJink/FMyALVGKY/m1fs3AGG7P8ydnHD9JdBJL
         BNaWZhTu6STs1Ql7UfTd4RSZNkCeoH1Ih3oaWGVB8rT94u8aecaZhFULZiSAoiBpRhKh
         I0Ho+NeNGC9uNXbTcwuKK5Rws/BhejvaaNDtY56YSmoYMvqw3SbNmTEReWD9weZZcSUp
         FMItW0vYXPS8jmZH9PF7kQI+maV7ysntsRsYVXz4pFCxTtSJT+CPo7K7Sl/y4nSpx38g
         vY/Aq6BCfKyOqEhwO5CZ0nouAqQtW99WC81WFZB1fqS23hyHFDkW+ONcFdjx9yJuF1FA
         WFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605703; x=1685197703;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMoZzdS9l6dkhJcdB/feWzso3okmA1SIi04NfS7lrSY=;
        b=RMFQkMO7LSQdwDn+QusT0HyldYQRA8DHySzpmhnIaYFiZosQ6bKCTkpUcctCdU//fL
         ChD4zwxz5I0S0k8HpCDvIsPVMjOpTFuVmTu7aG/YZkClmEwUdfWaAep/H+JhrBAT5a02
         OSUX2otHxQK5BBag3yiTYzvqeqw6x7vrE81Y6mN5fAmgZgzbGrCOpu9KipetOOmD5fu5
         n7N+Ioe5IZLk+yEG/3wy7WSJajImkJjiX9iGrSXBHiwz0nDTYU3pkGa3rDhDJYg2BAIl
         Lf7gjhhEBx5xskcgjmMqm5Mr9HcGtx85EEc/A7c1kMo2/MscpwYBcnxbo77scED+KA2w
         PkmQ==
X-Gm-Message-State: AC+VfDx1MTZB30B0mZh+McmMyIlzJ1NZJg1sS6RWKCgUeCPxpTEXtuop
	dERaYXLXfj4nD8jreYDNJBdeOAEfcTs=
X-Google-Smtp-Source: ACHHUZ5ewgilphyXjSpINJ3rEm7Xez83ioMpuYTmDX5BItOLeqnTorqbZtajXPWlSAw2R1IL3cjrPg==
X-Received: by 2002:a17:907:934a:b0:94a:5306:3952 with SMTP id bv10-20020a170907934a00b0094a53063952mr2011446ejc.57.1682605702899;
        Thu, 27 Apr 2023 07:28:22 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x3-20020a170906710300b0094f2f0c9ed9sm9604761ejj.167.2023.04.27.07.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 07:28:22 -0700 (PDT)
Message-ID: <4fb2f58e-8a05-93fa-de19-d61d9b4320ed@gmail.com>
Date: Thu, 27 Apr 2023 07:28:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
Content-Language: en-US
To: daniel antoine <univac55@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>, iwd@lists.linux.dev
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
 <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
 <914A101F-70E4-4FA0-80A9-CF3A28BE61D2@holtmann.org>
 <b2be8a34-3624-b269-e253-6b76373807e0@gmail.com>
 <CA+iibzAW33xScrgXCqMebr1t5AmpPG6xntsv+8z4cUjc8ih4uQ@mail.gmail.com>
 <CA+iibzB2XA6xuQtMQRH3vcPiRtsb5bdDHRDQN5HNbvu2eQttJA@mail.gmail.com>
 <CA+iibzCNBhsS3sCkuN4cdvWmLDokaVMoVS6r8Q2mcKKx1+mm-g@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CA+iibzCNBhsS3sCkuN4cdvWmLDokaVMoVS6r8Q2mcKKx1+mm-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel/Marcel,

On 4/27/23 2:37 AM, daniel antoine wrote:
> Hi James Hi Marcel
> 
> I have updated libedit to 20221030-3.1 et the compilation off iwd is OK now
> may be you have to specify that the level of libedit must be
> 20221030-3.1 to build with libedit instead of readline
> 
> I am sorry for the convenience the problem was on my side I was not at
> the last level of libeditt

No problem, I ran into the same thing :) Marcel, is there a way to do a 
version check on libedit so configure can detect these unsupported versions?

> 
> Best regard
> 
> Daniel
> 
> Le mer. 26 avr. 2023 à 14:36, daniel antoine <univac55@gmail.com> a écrit :
>>
>> Hi gents
>>
>> I suppose that my problem is here
>> http://cvsweb.netbsd.org/bsdweb.cgi/src/lib/libedit/readline.c
>>
>> Revision 1.169 / (download) - annotate - [select for diffs], Tue Jan
>> 11 18:30:15 2022 UTC (15 months, 1 week ago) by christos
>> Branch: MAIN
>> Changes since 1.168: +70 -2 lines
>> Diff to previous 1.168 (colored)
>>
>> PR/56618: Walter Lozano: Improve libedit compatibility with readline by
>> implementing:
>>
>>      rl_copy_text, rl_erase_empty_line, rl_message, rl_on_new_line,
>>      rl_replace_line, rl_restore_prompt, rl_save_prompt
>>
>> ________________________________
>>
>> the patch is 20221101 after libedit 20210910-3.1
>> I have also a debian (bullseye) system with libedit 20191231-3.1
>> without libedit-dev
>>
>> I hope that if I have to compile on my LFS system it will not break it
>> ,it's a base package
>>
>> Best regards
>>
>> Danial
>>
>> Le mer. 26 avr. 2023 à 12:14, daniel antoine <univac55@gmail.com> a écrit :
>>>
>>> Hi James, Hi Marcel
>>>
>>> I got this in my chroot
>>> Chroot path: /mnt/hd
>>> ******************************
>>> root@grat-os1:/# cards search libedit
>>> (base) libedit 20210910-3.1 Command line editor library providing
>>> generic line editing, history, and tokenization functions.
>>> (base) libedit.devel 20210910-3.1 Command line editor library
>>> providing generic line editing, history, and tokenization functions.
>>> (base) libedit.man 20210910-3.1 Command line editor library providing
>>> generic line editing, history, and tokenization functions.
>>>
>>> root@grat-os1:/# find / -name libedit.so*
>>> /usr/lib/libedit.so
>>> /usr/lib/libedit.so.0
>>> /usr/lib/libedit.so.0.0.68
>>>
>>> root@grat-os1:/# objdump -TC /usr/lib/libedit.so | grep rl_ | cut -d' ' -f17
>>> rl_sort_completion_matches
>>> rl_completion_query_items
>>> rl_resize_terminal
>>> rl_parse_and_bind
>>> rl_deprep_terminal
>>> rl_basic_word_break_characters
>>> rl_pre_input_hook
>>> rl_set_keyboard_input_timeout
>>> rl_startup1_hook
>>> rl_completer_word_break_characters
>>> rl_initialize
>>> rl_directory_completion_hook
>>> rl_add_defun
>>> rl_readline_version
>>> rl_free_line_state
>>> rl_attempted_completion_over
>>> rl_basic_quote_characters
>>> _rl_echoing_p
>>> rl_prep_terminal
>>> rl_outstream
>>> rl_already_prompted
>>> rl_line_buffer
>>> rl_completion_word_break_hook
>>> rl_abort
>>> rl_redisplay
>>> _rl_abort_internal
>>> rl_echo_signal_char
>>> rl_display_match_list
>>> rl_ignore_completion_duplicates
>>> rl_on_new_line
>>> _rl_complete_mark_directories
>>> rl_instream
>>> rl_completion_matches
>>> rl_bind_key_in_map
>>> rl_generic_bind
>>> rl_deprep_term_function
>>> rl_filename_completion_desired
>>> rl_forced_update_display
>>> rl_completion_type
>>> rl_insert
>>> rl_inhibit_completion
>>> rl_reset_after_signal
>>> rl_set_screen_size
>>> _rl_qsort_string_compare
>>> rl_point
>>> rl_make_bare_keymap
>>> rl_newline
>>> rl_get_keymap
>>> rl_library_version
>>> rl_startup_hook
>>> _rl_completion_prefix_display_length
>>> rl_event_hook
>>> rl_callback_read_char
>>> rl_getc_function
>>> rl_display_prompt
>>> rl_crlf
>>> rl_set_keymap
>>> rl_ding
>>> rl_bind_key
>>> rl_completion_append_character
>>> rl_catch_sigwinch
>>> rl_insert_text
>>> rl_variable_bind
>>> rl_get_screen_size
>>> rl_read_init_file
>>> rl_redisplay_function
>>> rl_completer_quote_characters
>>> _rl_print_completions_horizontally
>>> _rl_erase_entire_line
>>> rl_readline_state
>>> rl_callback_handler_install
>>> rl_cleanup_after_signal
>>> rl_catch_signals
>>> rl_terminal_name
>>> rl_set_prompt
>>> rl_done
>>> rl_filename_completion_function
>>> rl_readline_name
>>> rl_completion_entry_function
>>> rl_complete
>>> rl_special_prefixes
>>> rl_linefunc
>>> rl_set_keymap_name
>>> rl_get_previous_history
>>> rl_attempted_completion_function
>>> rl_kill_text
>>> rl_read_key
>>> rl_reset_terminal
>>> rl_stuff_char
>>> rl_completion_display_matches_hook
>>> rl_end
>>> rl_prep_term_function
>>> rl_callback_handler_remove
>>> rl_completion_suppress_append
>>> rl_prompt
>>> root@grat-os1:/#
>>>
>>> Is my version of libedit too old --> 20221030-3.1 ?
>>>
>>> Best regards
>>>
>>> Daniel
>>>
>>> Le mar. 25 avr. 2023 à 23:46, James Prestwood <prestwoj@gmail.com> a écrit :
>>>>
>>>> Hi Marcel,
>>>>
>>>> On 4/24/23 3:14 AM, Marcel Holtmann wrote:
>>>>> Hi James,
>>>>>
>>>>>>>> I have tried to build iwd to the last commit "Allow building with
>>>>>>>> libedit instead readline". The Pkgfile seems to need the option
>>>>>>>> --enable-libedit to remove readline but it fails with
>>>>>>>>    CC       wired/dbus.o
>>>>>>>>    CCLD     ell/libell-internal.la
>>>>>>>>    CCLD     client/iwctl
>>>>>>>>    CCLD     src/iwd
>>>>>>>>    CCLD     wired/ead
>>>>>>>> /usr/bin/ld: client/command.o: in function `command_completion':
>>>>>>>> command.c:(.text+0x6cc): undefined reference to `rl_copy_text'
>>>>>>>> /usr/bin/ld: command.c:(.text+0x8b0): undefined reference to `rl_copy_text'
>>>>>>>> /usr/bin/ld: client/display.o: in function `save_input':
>>>>>>>> display.c:(.text+0x32): undefined reference to `rl_copy_text'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x3a): undefined reference to `rl_save_prompt'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x46): undefined reference to `rl_replace_line'
>>>>>>>> /usr/bin/ld: client/display.o: in function `display_text':
>>>>>>>> display.c:(.text+0x796): undefined reference to `rl_restore_prompt'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x7a0): undefined reference to `rl_replace_line'
>>>>>>>> /usr/bin/ld: client/display.o: in function `display_completion_matches':
>>>>>>>> display.c:(.text+0x834): undefined reference to `rl_copy_text'
>>>>>>>> /usr/bin/ld: client/display.o: in function `timeout_callback':
>>>>>>>> display.c:(.text+0x9d0): undefined reference to `rl_restore_prompt'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x9da): undefined reference to `rl_replace_line'
>>>>>>>> /usr/bin/ld: client/display.o: in function `display_table_footer':
>>>>>>>> display.c:(.text+0x11a6): undefined reference to `rl_restore_prompt'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x11b1): undefined reference to `rl_replace_line'
>>>>>>>> /usr/bin/ld: client/display.o: in function `display_enable_cmd_prompt':
>>>>>>>> display.c:(.text+0x168e): undefined reference to `rl_save_prompt'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x1698): undefined reference to
>>>>>>>> `rl_restore_prompt'
>>>>>>>> /usr/bin/ld: client/display.o: in function `display_agent_prompt':
>>>>>>>> display.c:(.text+0x177d): undefined reference to `rl_copy_text'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x1797): undefined reference to `rl_replace_line'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x17a5): undefined reference to
>>>>>>>> `rl_erase_empty_line'
>>>>>>>> /usr/bin/ld: client/display.o: in function `display_agent_prompt_release':
>>>>>>>> display.c:(.text+0x1889): undefined reference to `rl_copy_text'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x18cd): undefined reference to
>>>>>>>> `rl_erase_empty_line'
>>>>>>>> /usr/bin/ld: display.c:(.text+0x18db): undefined reference to `rl_replace_line'
>>>>>>>> /usr/bin/ld: client/display.o: in function `display_init':
>>>>>>>> display.c:(.text+0x1a3e): undefined reference to `rl_erase_empty_line'
>>>>>>>> collect2: error: ld returned 1 exit status
>>>>>>>> make[1]: *** [Makefile:1895: client/iwctl] Error 1
>>>>>>>> make[1]: *** Waiting for unfinished jobs....
>>>>>>>> make: *** [Makefile:1595: all] Error 2
>>>>>>>> =======> ERROR: Building
>>>>>>>> '/usr/ports/perso/iwd/iwd1682174379x86_64.cards.tar.xz' failed.
>>>>>>>>
>>>>>>>> It looks like some readline commands are always taken in count
>>>>>>>>
>>>>>>>> I have my Pkgfile and the compilation log
>>>>>>> It does build for me just fine. What distro is this?
>>>>>>> What does pkg-config --cflags --libs libedit show?
>>>>>>
>>>>>> I'm seeing the same build problem, Ubuntu 20.04:
>>>>>>
>>>>>> $ pkg-config --cflags --libs libedit
>>>>>> -I/usr/include/editline -ledit
>>>>>
>>>>> so Ubuntu seems to have libeditreadline-dev and maybe it has
>>>>> Its own pkg-config file for a library with the rl_ symbols.
>>>>
>>>> I see that Debian package, but Ubuntu doesn't have it (or my Ubuntu
>>>> distro doesn't). It does have libedit-dev which is what I installed. It
>>>> appears the libedit package just doesn't include ALL the rl_* symbols
>>>> that iwctl uses:
>>>>
>>>> jprestwood@LOCLAP699:~/iwd$ objdump -TC
>>>> /lib/x86_64-linux-gnu/libedit.so.2 | grep rl_ | cut -d' ' -f17
>>>> rl_getc_function
>>>> rl_pre_input_hook
>>>> rl_inhibit_completion
>>>> rl_readline_name
>>>> rl_redisplay
>>>> rl_deprep_terminal
>>>> rl_completer_quote_characters
>>>> rl_completer_word_break_characters
>>>> rl_filename_completion_desired
>>>> rl_prep_terminal
>>>> rl_free_line_state
>>>> rl_set_keymap
>>>> rl_newline
>>>> rl_resize_terminal
>>>> rl_callback_handler_remove
>>>> _rl_qsort_string_compare
>>>> rl_completion_word_break_hook
>>>> rl_instream
>>>> rl_basic_word_break_characters
>>>> rl_forced_update_display
>>>> rl_readline_version
>>>> rl_kill_text
>>>> rl_startup_hook
>>>> rl_set_screen_size
>>>> rl_point
>>>> rl_special_prefixes
>>>> rl_startup1_hook
>>>> rl_get_previous_history
>>>> rl_stuff_char
>>>> rl_completion_entry_function
>>>> rl_completion_display_matches_hook
>>>> rl_did_startup_hook
>>>> rl_generic_bind
>>>> rl_set_keyboard_input_timeout
>>>> rl_event_hook
>>>> rl_callback_handler_install
>>>> rl_parse_and_bind
>>>> rl_line_buffer
>>>> rl_linefunc
>>>> rl_variable_bind
>>>> rl_terminal_name
>>>> rl_deprep_term_function
>>>> rl_on_new_line
>>>> rl_done
>>>> rl_redisplay_function
>>>> rl_prep_term_function
>>>> rl_outstream
>>>> rl_end
>>>> rl_read_key
>>>> rl_catch_sigwinch
>>>> rl_catch_signals
>>>> rl_insert
>>>> rl_completion_append_character
>>>> rl_attempted_completion_over
>>>> rl_reset_after_signal
>>>> rl_completion_query_items
>>>> rl_reset_terminal
>>>> rl_library_version
>>>> rl_already_prompted
>>>> rl_bind_key
>>>> rl_completion_matches
>>>> rl_callback_read_char
>>>> rl_set_prompt
>>>> rl_get_screen_size
>>>> rl_cleanup_after_signal
>>>> rl_bind_key_in_map
>>>> rl_make_bare_keymap
>>>> rl_prompt
>>>> rl_read_init_file
>>>> rl_insert_text
>>>> rl_add_defun
>>>> _rl_print_completions_horizontally
>>>> rl_echo_signal_char
>>>> rl_display_match_list
>>>> rl_ignore_completion_duplicates
>>>> rl_filename_completion_function
>>>> rl_completion_type
>>>> rl_attempted_completion_function
>>>> rl_get_keymap
>>>> rl_initialize
>>>> _rl_abort_internal
>>>> rl_complete
>>>>
>>>> Why this would be different on Fedora is beyond me, very weird.
>>>>
>>>> Thanks,
>>>> James
>>>>
>>>>>
>>>>> Regards
>>>>>
>>>>> Marcel
>>>>>
