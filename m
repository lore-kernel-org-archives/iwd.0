Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4BDDA6
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id E08F8CECC8;
	Mon, 27 Nov 2023 11:26:08 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: IWD 2.9 Does Not Compile against Linux-4.9.212 and/or GLibC-2.28
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <268d40b9-63a8-4aad-9f02-e9765325ec72@gmail.com>
Date: Mon, 27 Nov 2023 11:25:58 +0100
Cc: Grant Erickson <gerickson@nuovations.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <18D5E5F4-0D14-48E5-B218-C1B3C27A82B2@holtmann.org>
References: <29B7EAE3-2BBD-43CA-B2E7-28CE588EE7A2@nuovations.com>
 <268d40b9-63a8-4aad-9f02-e9765325ec72@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Denis,

>>       CC       client/known-networks.o
>>     ${BuildRoot}/third_party/iwd/iwd-2.9/client/known-networks.c:27: =
warning: "_XOPEN_SOURCE" redefined
>>        27 | #define _XOPEN_SOURCE
>=20
> libreadline adds -D_XOPEN_SOURCE to the gcc command line.  Somehow =
newer GCC versions deal with this transparently and don't raise an =
error.  Maybe try
>=20
> #ifndef _XOPEN_SOURCE
> #define _XOPEN_SOURCE
> #endif
>=20
> in client/known-networks.c and report back?  I can't duplicate this on =
my end.

that is a really odd one, since client/known-networks.c does this =
correctly.

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#define _XOPEN_SOURCE
#include <time.h>
#include <ell/ell.h>

#include "client/command.h=E2=80=9D

So unless something weird ended up in config.h or your CFLAGS, this is =
impossible.

And yes, thank you readline :(

# pkg-config --cflags readline
-D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600

That is so stupid.

The fun part is actually if I take #define _XOPEN_SOURCE out of the =
file, it fails for me.

gcc -DHAVE_CONFIG_H -I.      -fvisibility=3Dhidden =
-DUNITDIR=3D\""./unit/"\" -DCERTDIR=3D\""./unit/"\" -DHAVE_PKCS8_SUPPORT =
-Wall -fsigned-char -fno-exceptions -Werror -Wextra =
-Wno-unused-parameter -Wno-missing-field-initializers =
-Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls =
-Wformat -Wformat-security -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 =
-g -fno-PIE -MT client/known-networks.o -MD -MP -MF $depbase.Tpo -c -o =
client/known-networks.o client/known-networks.c &&\
mv -f $depbase.Tpo $depbase.Po
client/known-networks.c: In function =E2=80=98format_iso8601=E2=80=99:
client/known-networks.c:57:9: error: implicit declaration of function =
=E2=80=98strptime=E2=80=99; did you mean =E2=80=98strftime=E2=80=99? =
[-Werror=3Dimplicit-function-declaration]
   57 |         strptime(time_str, "%FT%TZ", &tm);
      |         ^~~~~~~~
      |         strftime

So while my pkg-config shows it, it never ends up in the CFLAGS in the =
end. Maybe some autoconf tools version cleans this up. Or they started =
to use --cflags-only-I for pkg-config.

These kind of CFLAGS really don=E2=80=99t belong into pkg-config since =
the manpage of strptime is clear on how to use it.

SYNOPSIS
       #define _XOPEN_SOURCE       /* See feature_test_macros(7) */
       #include <time.h>

       char *strptime(const char *restrict s, const char *restrict =
format,
                      struct tm *restrict tm);

Actually this can't be the problem and I now remember that I run into =
this issue before. Our Makefile.am does this:

if LIBEDIT
client_cflags =3D $(LIBEDIT_CFLAGS)
client_ldadd =3D $(LIBEDIT_LIBS)
else
client_cflags =3D
client_ldadd =3D $(READLINE_LIBS)
endif

I ended up not using $(READLINE_CFLAGS) because of this stupidity of =
readline. How the duplicate definition of _XOPEN_SOURCE ended up in the =
build is unclear now. Certainly, not with a vanilla upstream iwd.

>>           |
>>     <command-line>: note: this is the location of the previous =
definition
>>     ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c: In =
function =E2=80=98display_init=E2=80=99:
>>     ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c:949:44: =
warning: assignment to =E2=80=98void (*)(void)=E2=80=99 from =
incompatible pointer type =E2=80=98void (*)(char **, int,  int)=E2=80=99 =
[-Wincompatible-pointer-types]
>>       949 |         rl_completion_display_matches_hook =3D =
display_completion_matches;
>>           |                                            ^
>=20
> This one is trickier since the signature of the function we provide is =
correct according to libreadline documentation.  What version of =
readline are you using?

And another readline mess. So besides its stupid move to GPLv3, it is =
also causing all sorts of fun issues for people.

I did add a --enable-libedit option to use libedit instead of readline, =
but due to our tricks with the refresh of iwctl, that doesn=E2=80=99t =
seem to fully work as expected. You could give that a try to get iwctl =
compiled (and worst case use the non-interactive mode). Same as =
--disable-client which will just not build iwctl at all.

However long-term (or maybe even short-term now) is to get rid of =
readline. License wise and programmatically it is causing tiny issues =
that just add up for no real gain.

I wrote my own command line editing that integrates as shell client and =
would be native to iwd. It is missing tab-completion and won=E2=80=99t =
work with our refresh tricks. Or I need to try to integrate linenoise =
since that is self-contained.

Not that I needed more convincing that readline is a problem child, but =
the arguments against using it keep piling up.

Regards

Marcel

