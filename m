Content-Type: multipart/mixed; boundary="===============4391361476516007531=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Re: D-Bus policies
Date: Tue, 25 Jan 2022 22:48:06 +0100
Message-ID: <1693634.GKaMHTciCY@bagend>
In-Reply-To: 91fb09fe-27c0-c804-633e-aced18785d33@gmail.com

--===============4391361476516007531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks a lot for your response :-)

On Tuesday, 25 January 2022 16:38:09 CET Denis Kenzior wrote:
> On 1/25/22 08:49, Diederik de Haas wrote:
> > On Saturday, 22 January 2022 00:13:14 CET Denis Kenzior wrote:
> >> I think the solution chosen in BlueZ which gives blanket permission to
> >> access iwd D-Bus APIs to any local user is probably just fine.
> >> Particularly given that at_console effectively allowed any user to use
> >> iwd in the past.
> >> This effectively negates the need to provide a separate policy for
> >> wheel/netdev and so these can be removed.
> > =

> > Does this mean that any restrictions would be removed?
> =

> This would be similar to BlueZ, where any user could control the bluetooth
> device.

Ok, so Option 1 is to lift all restrictions.

> > Looking a bit further to see what others do and found some interesting
> > things.
> > =

> > In /etc/dbus-1/system.d/wpa_supplicant.conf I see 'allow' for 'root' and
> > 'netdev' and (explicit) deny for 'context=3D"default"'
> > =

> > In /usr/share/dbus-1/system.d/org.freedesktop.NetworkManager.conf there=
 is
> =

> Right, I don't think we really want to go that far and our APIs are quite
> simple compared to NM.  Our goal is to ship a minimal policy that works f=
or
> most users out of the box. =


Agreed that NM is far more extensive. I included it as a 2nd example where =

deny is the default policy, with some explicit exceptions.
But wpasupplicant's policy is far simpler (default deny, root/netdev allow) =

and that program seems comparable to iwd.

> If the distros need something else, they're free to modify the policy as
> they see fit.

Of course they have that freedom, but as noted in my OP, most distros just =
use =

what's provided upstream. =


> >> Alternatively we can limit the policy only to wheel/netdev groups.
> > =

> > Given the above, I am more inclined to this solution, but it appears to=
 me
> > like pretty much the opposite of the other solution?
> =

> Sort of.  I think in reality the vast majority of users are on single-user
> systems with the main user already part of the 'wheel' group. So even if =
we
> drop the at_console usage, and allowed iwd use only for root/netdev/wheel,
> the impact should be minimal.

When I setup a new Debian system, I *manually* add myself to "dialout, adm, =

plugdev, netdev, audio, video" groups, so this is not an automatic thing.
I just added a 2nd user on my system and its only group membership was to a =

group named the same as the user. This is the default behavior, but it may =
be =

(a bit) different for the first user, but likely also depends on how the sy=
stem =

is setup.
The 'wheel' group is not used/present on Debian (based distros).

So I think the impact is not minimal. OTOH, it should be common knowledge t=
hat =

users need netdev group permissions to modify network connections.

> > For example, if I granted access to a friend (over SSH) to my
> > machine, he was allowed access to iwd over D-Bus before, but because he=
's
> > not in the netdev group, he would then be denied access.
> =

> Correct.  But how likely is this scenario? :)

It's the default scenario on Debian and possibly its derivatives.
FTR: I don't want my friend(s) granted permission to change the network =

connection by default. If I want to grant a friend that permission, I would =

add him/her to the netdev group.

And Option 2 is restricted access.

For which Option would you like a patch?

Cheers,
  Diederik

--===============4391361476516007531==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWZCd0ZnQUtDUkRYYmx2T2VIN2IKYnRSaUFRRGdJTUxpRXBudG5w
MFN0N1loR0JGWHFIdUFvM0ZNNWNFV0czSzIwblBwaXdFQTBWRWV2b0E2NnAwbQpNaHorY2tvTFc5
N2U0aHRUN0J3amxSNWd2U3VmU3cwPQo9V0FoMQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============4391361476516007531==--

