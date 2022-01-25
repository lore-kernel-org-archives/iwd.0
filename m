Content-Type: multipart/mixed; boundary="===============4926879397713715705=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Re: D-Bus policies
Date: Tue, 25 Jan 2022 15:49:49 +0100
Message-ID: <10342456.PfD6ZFRMnq@bagend>
In-Reply-To: b9d48284-32bc-5ede-b3e1-c17aa544e7eb@gmail.com

--===============4926879397713715705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Saturday, 22 January 2022 00:13:14 CET Denis Kenzior wrote:
> Care to send a patch?

I technically can, but before doing that I'd like some clarification on the =

impact of such a patch as I have no-where near enough understanding of both =

D-Bus and iwd of the impact of such a patch. I 'prefer' not to have my name =

attached to a (potential) security breach ;-)

> > Looking into possible solutions, I found 2 very similar commits ...
> > =

> > They both link to
> > https://www.spinics.net/lists/linux-bluetooth/msg75267.html While I lack
> > the knowledge to fully understand what it says I did notice this: "The
> > intent is clear: As long as you are logged in to a local machine, and y=
ou
> > are the foreground/active console, you are allowed to control bluetooth.
> > However, the behavior of 'at_console' does *not* match this intent."
> > =

> > In other places I saw the 'at_console' stanza just plainly removed with=
out
> > any replacement, but it could have undesirable consequences for iwd.
> =

> I think the solution chosen in BlueZ which gives blanket permission to
> access iwd D-Bus APIs to any local user is probably just fine. =

> Particularly given that at_console effectively allowed any user to use iwd
> in the past.
> This effectively negates the need to provide a separate policy for
> wheel/netdev and so these can be removed.

Does this mean that any restrictions would be removed?

It is just an example, but the 'deluged' program runs under the 'debian-
deluged' user. If that program has a (security) bug, would that allow a RCE =

wrt to iwd? Could it wreak havoc then?

Looking a bit further to see what others do and found some interesting thin=
gs.

https://salsa.debian.org/bluetooth-team/bluez/-/blob/debian/sid/debian/
patches/bluetooth.conf.patch is a modification of what upstream bluetooth d=
oes =

and adds an allow for the 'bluetooth' group. That patch was explicitly adde=
d, =

but without an explanation as to why, but as I understand it now, it means =

that 'bluetooth' group members get access, next to everyone else.
IOW, it _seems_ (to me) like a pointless patch?

In /etc/dbus-1/system.d/wpa_supplicant.conf I see 'allow' for 'root' and =

'netdev' and (explicit) deny for 'context=3D"default"'

In /usr/share/dbus-1/system.d/org.freedesktop.NetworkManager.conf there is =
a =

FAR more extensive policy, where 'root' can (ofc) do a LOT, but in the defa=
ult =

context it starts with a 'deny' and then makes exceptions to grant mostly =

ReadOnly access to certain explicitly defined properties. In the comments I=
 see =

things like "read-only properties, no methods" and "read-only, no security =

required".
There seem to be some properties/methods ReadWrite, but additionally secure=
d =

via PolicyKit ("read/write, secured with PolicyKit" in comments).

> Alternatively we can limit the policy only to wheel/netdev groups.

Given the above, I am more inclined to this solution, but it appears to me =

like pretty much the opposite of the other solution?
But it could disallow use cases which iwd was meant to serve, which may be =

undesirable. For example, if I granted access to a friend (over SSH) to my =

machine, he was allowed access to iwd over D-Bus before, but because he's n=
ot =

in the netdev group, he would then be denied access.

It could be that iwd only makes a (very) limited(/harmless?) set of =

functionality available over D-Bus, in which case my concerns are unfounded=
. =

But I lack the knowledge to determine that.

Hope you can alleviate my concerns (before I send in a patch).

Cheers,
  Diederik

--===============4926879397713715705==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWZBT0RRQUtDUkRYYmx2T2VIN2IKYm5ZQkFQOWlOamZQTFNjcis1
UHNhWUxYN2syODkxNUdNR0NDcEhhWFRyR3pWMEhmYmdEOUdYV0NDUGJkUWY5TwpQZ0F0WGRMUTAz
ZjZUdkIwSlYyUGhPZXY2OEhjSndZPQo9V0k0NQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============4926879397713715705==--

