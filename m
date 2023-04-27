Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E123BD
	for <iwd@lists.linux.dev>; Thu, 27 Apr 2023 09:37:29 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5144043d9d1so5990034a12.3
        for <iwd@lists.linux.dev>; Thu, 27 Apr 2023 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682588248; x=1685180248;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1HRWdcZ680Ds80K8BRyNbL/td4jKCrloMCpGrItNkQ=;
        b=qyMc/+xTfrguVQnbt697T9oZbj68nf4F7g9670+fL2g06k+gINEwZKMCbDb+/Mv7bz
         QoGwRVBg8aMzY5+6pKXU8hwXdf1D0ViKUZSBo+kci2w9wDrX3aFvjOTOCZf4ENGMBlmb
         vH5GW8P77f4UDVTGOKdPR67e0BEgYAeYja0CYjjAmfFAlY6JuA9SeD28KeV6vIuGzLYh
         tziMu3DA484a2S0bY2EOKORv/tmClmuHKbtazW7gaPrkH9ekG6io/NKLdq6gJmYVKhYI
         68rKZ4pgIQTKvtjRLaBipejpKg92iD+9EWprkN/KyKVr4DOGnrN7RPbBn/B/cW8xaw2o
         55aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682588248; x=1685180248;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1HRWdcZ680Ds80K8BRyNbL/td4jKCrloMCpGrItNkQ=;
        b=Wpwh7bEc5MFRjBjsJaPddkm9xezmtk02543cu04XR7lftLUbvPvUo3L3hjfSGZPTav
         RHmjdERJGKZO4wGJEGQ1uzXf1MwlykbtuYMT0StMsdEdl67pU6FQrVTiaMB7cgl91j/8
         v19aEcAg76lEwxNz0+IvOr1LW8kRI2bc+XMDuzPUCAvBWcZc8p4GqMXF+N7UMnyTZjeT
         StOoCGCkSZJsbw9MgQDBok1CN0XYLbk5Up6MRhShwMZOOBpu/RfIcfmxLYAHK+7kuF/h
         lJ+n8nST1OXvmzmIEde63CBn6DEoraXlOMrl5HVWSlMGWMdpXASo77IWr5bD9ZQU/grq
         bqmA==
X-Gm-Message-State: AC+VfDzoPxIC1PS3HnF42fTBzEzSEw6+3iQ7U8ya3Ib2C0/MGSEEDiHb
	uvbxsK1JqHcbNGAOmdLtM3a35tlg9vSvDrjCHbY=
X-Google-Smtp-Source: ACHHUZ58k6cg1k45BtZI6t0O9eM+bDYBUY9kkpj+flmXuT+7lpeLnrhhz5sgorqqxNybDSe3WKUscgatMlcpvMIaQpY=
X-Received: by 2002:a17:90b:38d0:b0:246:b06c:adc8 with SMTP id
 nn16-20020a17090b38d000b00246b06cadc8mr1284476pjb.9.1682588248105; Thu, 27
 Apr 2023 02:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org> <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
 <914A101F-70E4-4FA0-80A9-CF3A28BE61D2@holtmann.org> <b2be8a34-3624-b269-e253-6b76373807e0@gmail.com>
 <CA+iibzAW33xScrgXCqMebr1t5AmpPG6xntsv+8z4cUjc8ih4uQ@mail.gmail.com> <CA+iibzB2XA6xuQtMQRH3vcPiRtsb5bdDHRDQN5HNbvu2eQttJA@mail.gmail.com>
In-Reply-To: <CA+iibzB2XA6xuQtMQRH3vcPiRtsb5bdDHRDQN5HNbvu2eQttJA@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Thu, 27 Apr 2023 11:37:16 +0200
Message-ID: <CA+iibzCNBhsS3sCkuN4cdvWmLDokaVMoVS6r8Q2mcKKx1+mm-g@mail.gmail.com>
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
To: James Prestwood <prestwoj@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James Hi Marcel

I have updated libedit to 20221030-3.1 et the compilation off iwd is OK now
may be you have to specify that the level of libedit must be
20221030-3.1 to build with libedit instead of readline

I am sorry for the convenience the problem was on my side I was not at
the last level of libeditt

Best regard

Daniel

Le mer. 26 avr. 2023 =C3=A0 14:36, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
>
> Hi gents
>
> I suppose that my problem is here
> http://cvsweb.netbsd.org/bsdweb.cgi/src/lib/libedit/readline.c
>
> Revision 1.169 / (download) - annotate - [select for diffs], Tue Jan
> 11 18:30:15 2022 UTC (15 months, 1 week ago) by christos
> Branch: MAIN
> Changes since 1.168: +70 -2 lines
> Diff to previous 1.168 (colored)
>
> PR/56618: Walter Lozano: Improve libedit compatibility with readline by
> implementing:
>
>     rl_copy_text, rl_erase_empty_line, rl_message, rl_on_new_line,
>     rl_replace_line, rl_restore_prompt, rl_save_prompt
>
> ________________________________
>
> the patch is 20221101 after libedit 20210910-3.1
> I have also a debian (bullseye) system with libedit 20191231-3.1
> without libedit-dev
>
> I hope that if I have to compile on my LFS system it will not break it
> ,it's a base package
>
> Best regards
>
> Danial
>
> Le mer. 26 avr. 2023 =C3=A0 12:14, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
> >
> > Hi James, Hi Marcel
> >
> > I got this in my chroot
> > Chroot path: /mnt/hd
> > ******************************
> > root@grat-os1:/# cards search libedit
> > (base) libedit 20210910-3.1 Command line editor library providing
> > generic line editing, history, and tokenization functions.
> > (base) libedit.devel 20210910-3.1 Command line editor library
> > providing generic line editing, history, and tokenization functions.
> > (base) libedit.man 20210910-3.1 Command line editor library providing
> > generic line editing, history, and tokenization functions.
> >
> > root@grat-os1:/# find / -name libedit.so*
> > /usr/lib/libedit.so
> > /usr/lib/libedit.so.0
> > /usr/lib/libedit.so.0.0.68
> >
> > root@grat-os1:/# objdump -TC /usr/lib/libedit.so | grep rl_ | cut -d' '=
 -f17
> > rl_sort_completion_matches
> > rl_completion_query_items
> > rl_resize_terminal
> > rl_parse_and_bind
> > rl_deprep_terminal
> > rl_basic_word_break_characters
> > rl_pre_input_hook
> > rl_set_keyboard_input_timeout
> > rl_startup1_hook
> > rl_completer_word_break_characters
> > rl_initialize
> > rl_directory_completion_hook
> > rl_add_defun
> > rl_readline_version
> > rl_free_line_state
> > rl_attempted_completion_over
> > rl_basic_quote_characters
> > _rl_echoing_p
> > rl_prep_terminal
> > rl_outstream
> > rl_already_prompted
> > rl_line_buffer
> > rl_completion_word_break_hook
> > rl_abort
> > rl_redisplay
> > _rl_abort_internal
> > rl_echo_signal_char
> > rl_display_match_list
> > rl_ignore_completion_duplicates
> > rl_on_new_line
> > _rl_complete_mark_directories
> > rl_instream
> > rl_completion_matches
> > rl_bind_key_in_map
> > rl_generic_bind
> > rl_deprep_term_function
> > rl_filename_completion_desired
> > rl_forced_update_display
> > rl_completion_type
> > rl_insert
> > rl_inhibit_completion
> > rl_reset_after_signal
> > rl_set_screen_size
> > _rl_qsort_string_compare
> > rl_point
> > rl_make_bare_keymap
> > rl_newline
> > rl_get_keymap
> > rl_library_version
> > rl_startup_hook
> > _rl_completion_prefix_display_length
> > rl_event_hook
> > rl_callback_read_char
> > rl_getc_function
> > rl_display_prompt
> > rl_crlf
> > rl_set_keymap
> > rl_ding
> > rl_bind_key
> > rl_completion_append_character
> > rl_catch_sigwinch
> > rl_insert_text
> > rl_variable_bind
> > rl_get_screen_size
> > rl_read_init_file
> > rl_redisplay_function
> > rl_completer_quote_characters
> > _rl_print_completions_horizontally
> > _rl_erase_entire_line
> > rl_readline_state
> > rl_callback_handler_install
> > rl_cleanup_after_signal
> > rl_catch_signals
> > rl_terminal_name
> > rl_set_prompt
> > rl_done
> > rl_filename_completion_function
> > rl_readline_name
> > rl_completion_entry_function
> > rl_complete
> > rl_special_prefixes
> > rl_linefunc
> > rl_set_keymap_name
> > rl_get_previous_history
> > rl_attempted_completion_function
> > rl_kill_text
> > rl_read_key
> > rl_reset_terminal
> > rl_stuff_char
> > rl_completion_display_matches_hook
> > rl_end
> > rl_prep_term_function
> > rl_callback_handler_remove
> > rl_completion_suppress_append
> > rl_prompt
> > root@grat-os1:/#
> >
> > Is my version of libedit too old --> 20221030-3.1 ?
> >
> > Best regards
> >
> > Daniel
> >
> > Le mar. 25 avr. 2023 =C3=A0 23:46, James Prestwood <prestwoj@gmail.com>=
 a =C3=A9crit :
> > >
> > > Hi Marcel,
> > >
> > > On 4/24/23 3:14 AM, Marcel Holtmann wrote:
> > > > Hi James,
> > > >
> > > >>>> I have tried to build iwd to the last commit "Allow building wit=
h
> > > >>>> libedit instead readline". The Pkgfile seems to need the option
> > > >>>> --enable-libedit to remove readline but it fails with
> > > >>>>   CC       wired/dbus.o
> > > >>>>   CCLD     ell/libell-internal.la
> > > >>>>   CCLD     client/iwctl
> > > >>>>   CCLD     src/iwd
> > > >>>>   CCLD     wired/ead
> > > >>>> /usr/bin/ld: client/command.o: in function `command_completion':
> > > >>>> command.c:(.text+0x6cc): undefined reference to `rl_copy_text'
> > > >>>> /usr/bin/ld: command.c:(.text+0x8b0): undefined reference to `rl=
_copy_text'
> > > >>>> /usr/bin/ld: client/display.o: in function `save_input':
> > > >>>> display.c:(.text+0x32): undefined reference to `rl_copy_text'
> > > >>>> /usr/bin/ld: display.c:(.text+0x3a): undefined reference to `rl_=
save_prompt'
> > > >>>> /usr/bin/ld: display.c:(.text+0x46): undefined reference to `rl_=
replace_line'
> > > >>>> /usr/bin/ld: client/display.o: in function `display_text':
> > > >>>> display.c:(.text+0x796): undefined reference to `rl_restore_prom=
pt'
> > > >>>> /usr/bin/ld: display.c:(.text+0x7a0): undefined reference to `rl=
_replace_line'
> > > >>>> /usr/bin/ld: client/display.o: in function `display_completion_m=
atches':
> > > >>>> display.c:(.text+0x834): undefined reference to `rl_copy_text'
> > > >>>> /usr/bin/ld: client/display.o: in function `timeout_callback':
> > > >>>> display.c:(.text+0x9d0): undefined reference to `rl_restore_prom=
pt'
> > > >>>> /usr/bin/ld: display.c:(.text+0x9da): undefined reference to `rl=
_replace_line'
> > > >>>> /usr/bin/ld: client/display.o: in function `display_table_footer=
':
> > > >>>> display.c:(.text+0x11a6): undefined reference to `rl_restore_pro=
mpt'
> > > >>>> /usr/bin/ld: display.c:(.text+0x11b1): undefined reference to `r=
l_replace_line'
> > > >>>> /usr/bin/ld: client/display.o: in function `display_enable_cmd_p=
rompt':
> > > >>>> display.c:(.text+0x168e): undefined reference to `rl_save_prompt=
'
> > > >>>> /usr/bin/ld: display.c:(.text+0x1698): undefined reference to
> > > >>>> `rl_restore_prompt'
> > > >>>> /usr/bin/ld: client/display.o: in function `display_agent_prompt=
':
> > > >>>> display.c:(.text+0x177d): undefined reference to `rl_copy_text'
> > > >>>> /usr/bin/ld: display.c:(.text+0x1797): undefined reference to `r=
l_replace_line'
> > > >>>> /usr/bin/ld: display.c:(.text+0x17a5): undefined reference to
> > > >>>> `rl_erase_empty_line'
> > > >>>> /usr/bin/ld: client/display.o: in function `display_agent_prompt=
_release':
> > > >>>> display.c:(.text+0x1889): undefined reference to `rl_copy_text'
> > > >>>> /usr/bin/ld: display.c:(.text+0x18cd): undefined reference to
> > > >>>> `rl_erase_empty_line'
> > > >>>> /usr/bin/ld: display.c:(.text+0x18db): undefined reference to `r=
l_replace_line'
> > > >>>> /usr/bin/ld: client/display.o: in function `display_init':
> > > >>>> display.c:(.text+0x1a3e): undefined reference to `rl_erase_empty=
_line'
> > > >>>> collect2: error: ld returned 1 exit status
> > > >>>> make[1]: *** [Makefile:1895: client/iwctl] Error 1
> > > >>>> make[1]: *** Waiting for unfinished jobs....
> > > >>>> make: *** [Makefile:1595: all] Error 2
> > > >>>> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building
> > > >>>> '/usr/ports/perso/iwd/iwd1682174379x86_64.cards.tar.xz' failed.
> > > >>>>
> > > >>>> It looks like some readline commands are always taken in count
> > > >>>>
> > > >>>> I have my Pkgfile and the compilation log
> > > >>> It does build for me just fine. What distro is this?
> > > >>> What does pkg-config --cflags --libs libedit show?
> > > >>
> > > >> I'm seeing the same build problem, Ubuntu 20.04:
> > > >>
> > > >> $ pkg-config --cflags --libs libedit
> > > >> -I/usr/include/editline -ledit
> > > >
> > > > so Ubuntu seems to have libeditreadline-dev and maybe it has
> > > > Its own pkg-config file for a library with the rl_ symbols.
> > >
> > > I see that Debian package, but Ubuntu doesn't have it (or my Ubuntu
> > > distro doesn't). It does have libedit-dev which is what I installed. =
It
> > > appears the libedit package just doesn't include ALL the rl_* symbols
> > > that iwctl uses:
> > >
> > > jprestwood@LOCLAP699:~/iwd$ objdump -TC
> > > /lib/x86_64-linux-gnu/libedit.so.2 | grep rl_ | cut -d' ' -f17
> > > rl_getc_function
> > > rl_pre_input_hook
> > > rl_inhibit_completion
> > > rl_readline_name
> > > rl_redisplay
> > > rl_deprep_terminal
> > > rl_completer_quote_characters
> > > rl_completer_word_break_characters
> > > rl_filename_completion_desired
> > > rl_prep_terminal
> > > rl_free_line_state
> > > rl_set_keymap
> > > rl_newline
> > > rl_resize_terminal
> > > rl_callback_handler_remove
> > > _rl_qsort_string_compare
> > > rl_completion_word_break_hook
> > > rl_instream
> > > rl_basic_word_break_characters
> > > rl_forced_update_display
> > > rl_readline_version
> > > rl_kill_text
> > > rl_startup_hook
> > > rl_set_screen_size
> > > rl_point
> > > rl_special_prefixes
> > > rl_startup1_hook
> > > rl_get_previous_history
> > > rl_stuff_char
> > > rl_completion_entry_function
> > > rl_completion_display_matches_hook
> > > rl_did_startup_hook
> > > rl_generic_bind
> > > rl_set_keyboard_input_timeout
> > > rl_event_hook
> > > rl_callback_handler_install
> > > rl_parse_and_bind
> > > rl_line_buffer
> > > rl_linefunc
> > > rl_variable_bind
> > > rl_terminal_name
> > > rl_deprep_term_function
> > > rl_on_new_line
> > > rl_done
> > > rl_redisplay_function
> > > rl_prep_term_function
> > > rl_outstream
> > > rl_end
> > > rl_read_key
> > > rl_catch_sigwinch
> > > rl_catch_signals
> > > rl_insert
> > > rl_completion_append_character
> > > rl_attempted_completion_over
> > > rl_reset_after_signal
> > > rl_completion_query_items
> > > rl_reset_terminal
> > > rl_library_version
> > > rl_already_prompted
> > > rl_bind_key
> > > rl_completion_matches
> > > rl_callback_read_char
> > > rl_set_prompt
> > > rl_get_screen_size
> > > rl_cleanup_after_signal
> > > rl_bind_key_in_map
> > > rl_make_bare_keymap
> > > rl_prompt
> > > rl_read_init_file
> > > rl_insert_text
> > > rl_add_defun
> > > _rl_print_completions_horizontally
> > > rl_echo_signal_char
> > > rl_display_match_list
> > > rl_ignore_completion_duplicates
> > > rl_filename_completion_function
> > > rl_completion_type
> > > rl_attempted_completion_function
> > > rl_get_keymap
> > > rl_initialize
> > > _rl_abort_internal
> > > rl_complete
> > >
> > > Why this would be different on Fedora is beyond me, very weird.
> > >
> > > Thanks,
> > > James
> > >
> > > >
> > > > Regards
> > > >
> > > > Marcel
> > > >
