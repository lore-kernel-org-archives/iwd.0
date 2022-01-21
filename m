Content-Type: multipart/mixed; boundary="===============0339941457487871078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: D-Bus policies
Date: Fri, 21 Jan 2022 17:13:14 -0600
Message-ID: <b9d48284-32bc-5ede-b3e1-c17aa544e7eb@gmail.com>
In-Reply-To: 3141398.bvkd0EhLq2@bagend

--===============0339941457487871078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diederik,

> Looking into possible solutions, I found 2 very similar commits, but in
> different projects, bluez and system-config-printer:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D3ef0ce954=
b66fdf45538a6cdc629f3dac6642832
> https://github.com/OpenPrinting/system-config-printer/commit/19df47d2630b=
637d1802efe2c3cd5a00f2e40c3b
> =

> They both link to https://www.spinics.net/lists/linux-bluetooth/msg75267.=
html
> While I lack the knowledge to fully understand what it says I did notice =
this:
> "The intent is clear: As long as you are logged in to a local machine, an=
d you
> are the foreground/active console, you are allowed to control bluetooth.
> However, the behavior of 'at_console' does *not* match this intent."
> =

> In other places I saw the 'at_console' stanza just plainly removed without
> any replacement, but it could have undesirable consequences for iwd.

I think the solution chosen in BlueZ which gives blanket permission to acce=
ss =

iwd D-Bus APIs to any local user is probably just fine.  Particularly given=
 that =

at_console effectively allowed any user to use iwd in the past.
This effectively negates the need to provide a separate policy for wheel/ne=
tdev =

and so these can be removed.

Alternatively we can limit the policy only to wheel/netdev groups.

Care to send a patch?

Regards,
-Denis
--===============0339941457487871078==--

