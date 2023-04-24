Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA97C
	for <iwd@lists.linux.dev>; Mon, 24 Apr 2023 07:39:36 +0000 (UTC)
Received: from smtpclient.apple (p5b3d2302.dip0.t-ipconnect.de [91.61.35.2])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2E035CECD7;
	Mon, 24 Apr 2023 09:39:30 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
Date: Mon, 24 Apr 2023 09:39:29 +0200
Cc: daniel antoine <univac55@gmail.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <20E8A3D5-CA54-47CB-85B7-164AE2B01203@holtmann.org>
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
 <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hi James,

>>> I have tried to build iwd to the last commit "Allow building with
>>> libedit instead readline". The Pkgfile seems to need the option
>>> --enable-libedit to remove readline but it fails with
>>>  CC       wired/dbus.o
>>>  CCLD     ell/libell-internal.la
>>>  CCLD     client/iwctl
>>>  CCLD     src/iwd
>>>  CCLD     wired/ead
>>> /usr/bin/ld: client/command.o: in function `command_completion':
>>> command.c:(.text+0x6cc): undefined reference to `rl_copy_text'
>>> /usr/bin/ld: command.c:(.text+0x8b0): undefined reference to =
`rl_copy_text'
>>> /usr/bin/ld: client/display.o: in function `save_input':
>>> display.c:(.text+0x32): undefined reference to `rl_copy_text'
>>> /usr/bin/ld: display.c:(.text+0x3a): undefined reference to =
`rl_save_prompt'
>>> /usr/bin/ld: display.c:(.text+0x46): undefined reference to =
`rl_replace_line'
>>> /usr/bin/ld: client/display.o: in function `display_text':
>>> display.c:(.text+0x796): undefined reference to `rl_restore_prompt'
>>> /usr/bin/ld: display.c:(.text+0x7a0): undefined reference to =
`rl_replace_line'
>>> /usr/bin/ld: client/display.o: in function =
`display_completion_matches':
>>> display.c:(.text+0x834): undefined reference to `rl_copy_text'
>>> /usr/bin/ld: client/display.o: in function `timeout_callback':
>>> display.c:(.text+0x9d0): undefined reference to `rl_restore_prompt'
>>> /usr/bin/ld: display.c:(.text+0x9da): undefined reference to =
`rl_replace_line'
>>> /usr/bin/ld: client/display.o: in function `display_table_footer':
>>> display.c:(.text+0x11a6): undefined reference to `rl_restore_prompt'
>>> /usr/bin/ld: display.c:(.text+0x11b1): undefined reference to =
`rl_replace_line'
>>> /usr/bin/ld: client/display.o: in function =
`display_enable_cmd_prompt':
>>> display.c:(.text+0x168e): undefined reference to `rl_save_prompt'
>>> /usr/bin/ld: display.c:(.text+0x1698): undefined reference to
>>> `rl_restore_prompt'
>>> /usr/bin/ld: client/display.o: in function `display_agent_prompt':
>>> display.c:(.text+0x177d): undefined reference to `rl_copy_text'
>>> /usr/bin/ld: display.c:(.text+0x1797): undefined reference to =
`rl_replace_line'
>>> /usr/bin/ld: display.c:(.text+0x17a5): undefined reference to
>>> `rl_erase_empty_line'
>>> /usr/bin/ld: client/display.o: in function =
`display_agent_prompt_release':
>>> display.c:(.text+0x1889): undefined reference to `rl_copy_text'
>>> /usr/bin/ld: display.c:(.text+0x18cd): undefined reference to
>>> `rl_erase_empty_line'
>>> /usr/bin/ld: display.c:(.text+0x18db): undefined reference to =
`rl_replace_line'
>>> /usr/bin/ld: client/display.o: in function `display_init':
>>> display.c:(.text+0x1a3e): undefined reference to =
`rl_erase_empty_line'
>>> collect2: error: ld returned 1 exit status
>>> make[1]: *** [Makefile:1895: client/iwctl] Error 1
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:1595: all] Error 2
>>> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building
>>> '/usr/ports/perso/iwd/iwd1682174379x86_64.cards.tar.xz' failed.
>>>=20
>>> It looks like some readline commands are always taken in count
>>>=20
>>> I have my Pkgfile and the compilation log
>> It does build for me just fine. What distro is this?
>> What does pkg-config --cflags --libs libedit show?
>=20
> I'm seeing the same build problem, Ubuntu 20.04:
>=20
> $ pkg-config --cflags --libs libedit
> -I/usr/include/editline -ledit

so Fedora 38 has the same and it links just fine:

# ldd client/iwctl
	linux-vdso.so.1 (0x00007ffc1d884000)
	libedit.so.0 =3D> /lib64/libedit.so.0 (0x00007fd5ce18e000)
	libc.so.6 =3D> /lib64/libc.so.6 (0x00007fd5cdfaf000)
	libtinfo.so.6 =3D> /lib64/libtinfo.so.6 (0x00007fd5cdf7c000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fd5ce1d3000)

# rpm -qi libedit-devel
Name        : libedit-devel
Version     : 3.1
Release     : 45.20221030cvs.fc38
Architecture: x86_64
Install Date: Fri 21 Apr 2023 02:00:12 PM CEST
Group       : Unspecified
Size        : 60383
License     : BSD-3-Clause AND BSD-2-Clause AND ISC
Signature   : RSA/SHA256, Thu 19 Jan 2023 11:13:49 PM CET, Key ID =
809a8d7ceb10b464
Source RPM  : libedit-3.1-45.20221030cvs.fc38.src.rpm
Build Date  : Thu 19 Jan 2023 06:09:35 PM CET
Build Host  : buildhw-x86-15.iad2.fedoraproject.org
Packager    : Fedora Project
Vendor      : Fedora Project
URL         : https://www.thrysoee.dk/editline/

The GCC 13 is having some fun on Fedora 38, but that is a different =
story:

  CC       src/eap.o
In function =E2=80=98eap_handle_response=E2=80=99,
    inlined from =E2=80=98eap_rx_packet=E2=80=99 at src/eap.c:570:3:
src/eap.c:421:49: error: =E2=80=98vendor_id=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
  421 |         (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) =
&& vendor_type =3D=3D (t))
      |                                       ~~~~~~~~~~^~~~~~~
src/eap.c:533:20: note: in expansion of macro =E2=80=98IS_EXPANDED_RESPONS=
E=E2=80=99
  533 |         } else if (IS_EXPANDED_RESPONSE(our_vendor_id, =
our_vendor_type))
      |                    ^~~~~~~~~~~~~~~~~~~~
src/eap.c: In function =E2=80=98eap_rx_packet=E2=80=99:
src/eap.c:431:18: note: =E2=80=98vendor_id=E2=80=99 was declared here
  431 |         uint32_t vendor_id;
      |                  ^~~~~~~~~
In function =E2=80=98eap_handle_response=E2=80=99,
    inlined from =E2=80=98eap_rx_packet=E2=80=99 at src/eap.c:570:3:
src/eap.c:421:57: error: =E2=80=98vendor_type=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
  421 |         (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) =
&& vendor_type =3D=3D (t))
      |         =
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
src/eap.c:533:20: note: in expansion of macro =E2=80=98IS_EXPANDED_RESPONS=
E=E2=80=99
  533 |         } else if (IS_EXPANDED_RESPONSE(our_vendor_id, =
our_vendor_type))
      |                    ^~~~~~~~~~~~~~~~~~~~
src/eap.c: In function =E2=80=98eap_rx_packet=E2=80=99:
src/eap.c:432:18: note: =E2=80=98vendor_type=E2=80=99 was declared here
  432 |         uint32_t vendor_type;
      |                  ^~~~~~~~~~~
cc1: all warnings being treated as errors

Regards

Marcel

