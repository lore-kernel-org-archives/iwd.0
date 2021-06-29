Content-Type: multipart/mixed; boundary="===============2731344214140629253=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: DHCP renewal
Date: Tue, 29 Jun 2021 11:40:09 -0500
Message-ID: <da938998-7b71-6490-e929-15d92c12d6c5@gmail.com>
In-Reply-To: <CACsRnHVS7cx-NWu0D-U=fByqTgBnxqdNS55d_inFmAKpG4oOvg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2731344214140629253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 6/29/21 11:23 AM, Michael Johnson wrote:
> Thanks Denis,
> =

> I tracked it down to a problem with capabilities in the systemd service. =
I have =

> sent a patch.
> =


Yep, nice catch.  I don't run systemd, otherwise I would have caught this s=
ooner.

> Along with the fix, I'm thinking it would be good to have extra logging i=
n =

> ell/dhcp.c to make these kinds of errors easier to find.

Right.  I think we were a bit sloppy here.

> Would you be open to a patch which=C2=A0adds `l_error()` output if the bi=
nd operation =

> fails? I know that `ell/dhcp.c` doesn't currently

Yes, definitely.  We should at least log this failure via CLIENT_DEBUG.

> have any error output but instead bubbles the errors up. Also I don't kno=
w how =

> fatal this kind of error should really be so maybe
> logging isn't enough?

We could.  I think we issue l_dhcp_client_stop in a few failure cases alrea=
dy. =

Perhaps we can also add an extra event to signal that a fatal error occurre=
d. =

Would make it easier to know something went wrong even if IWD_DHCP_DEBUG is=
n't set.

Regards,
-Denis
--===============2731344214140629253==--

