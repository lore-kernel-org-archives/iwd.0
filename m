Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F376AB5
	for <iwd@lists.linux.dev>; Sat, 22 Apr 2023 18:40:39 +0000 (UTC)
Received: from smtpclient.apple (p5b3d2302.dip0.t-ipconnect.de [91.61.35.2])
	by mail.holtmann.org (Postfix) with ESMTPSA id 3A4F6CED1C;
	Sat, 22 Apr 2023 20:32:17 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
Date: Sat, 22 Apr 2023 20:32:16 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
To: daniel antoine <univac55@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hi Daniel,

changing the mailing list ;)

> I have tried to build iwd to the last commit "Allow building with
> libedit instead readline". The Pkgfile seems to need the option
> --enable-libedit to remove readline but it fails with
>  CC       wired/dbus.o
>  CCLD     ell/libell-internal.la
>  CCLD     client/iwctl
>  CCLD     src/iwd
>  CCLD     wired/ead
> /usr/bin/ld: client/command.o: in function `command_completion':
> command.c:(.text+0x6cc): undefined reference to `rl_copy_text'
> /usr/bin/ld: command.c:(.text+0x8b0): undefined reference to =
`rl_copy_text'
> /usr/bin/ld: client/display.o: in function `save_input':
> display.c:(.text+0x32): undefined reference to `rl_copy_text'
> /usr/bin/ld: display.c:(.text+0x3a): undefined reference to =
`rl_save_prompt'
> /usr/bin/ld: display.c:(.text+0x46): undefined reference to =
`rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_text':
> display.c:(.text+0x796): undefined reference to `rl_restore_prompt'
> /usr/bin/ld: display.c:(.text+0x7a0): undefined reference to =
`rl_replace_line'
> /usr/bin/ld: client/display.o: in function =
`display_completion_matches':
> display.c:(.text+0x834): undefined reference to `rl_copy_text'
> /usr/bin/ld: client/display.o: in function `timeout_callback':
> display.c:(.text+0x9d0): undefined reference to `rl_restore_prompt'
> /usr/bin/ld: display.c:(.text+0x9da): undefined reference to =
`rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_table_footer':
> display.c:(.text+0x11a6): undefined reference to `rl_restore_prompt'
> /usr/bin/ld: display.c:(.text+0x11b1): undefined reference to =
`rl_replace_line'
> /usr/bin/ld: client/display.o: in function =
`display_enable_cmd_prompt':
> display.c:(.text+0x168e): undefined reference to `rl_save_prompt'
> /usr/bin/ld: display.c:(.text+0x1698): undefined reference to
> `rl_restore_prompt'
> /usr/bin/ld: client/display.o: in function `display_agent_prompt':
> display.c:(.text+0x177d): undefined reference to `rl_copy_text'
> /usr/bin/ld: display.c:(.text+0x1797): undefined reference to =
`rl_replace_line'
> /usr/bin/ld: display.c:(.text+0x17a5): undefined reference to
> `rl_erase_empty_line'
> /usr/bin/ld: client/display.o: in function =
`display_agent_prompt_release':
> display.c:(.text+0x1889): undefined reference to `rl_copy_text'
> /usr/bin/ld: display.c:(.text+0x18cd): undefined reference to
> `rl_erase_empty_line'
> /usr/bin/ld: display.c:(.text+0x18db): undefined reference to =
`rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_init':
> display.c:(.text+0x1a3e): undefined reference to `rl_erase_empty_line'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:1895: client/iwctl] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1595: all] Error 2
> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building
> '/usr/ports/perso/iwd/iwd1682174379x86_64.cards.tar.xz' failed.
>=20
> It looks like some readline commands are always taken in count
>=20
> I have my Pkgfile and the compilation log

It does build for me just fine. What distro is this?

What does pkg-config --cflags --libs libedit show?

Regards

Marcel

