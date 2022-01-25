Content-Type: multipart/mixed; boundary="===============6266489838238565110=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: D-Bus policies
Date: Tue, 25 Jan 2022 09:38:09 -0600
Message-ID: <91fb09fe-27c0-c804-633e-aced18785d33@gmail.com>
In-Reply-To: 10342456.PfD6ZFRMnq@bagend

--===============6266489838238565110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diederik,

On 1/25/22 08:49, Diederik de Haas wrote:
> Hi Denis,
> =

> On Saturday, 22 January 2022 00:13:14 CET Denis Kenzior wrote:
>> Care to send a patch?
> =

> I technically can, but before doing that I'd like some clarification on t=
he
> impact of such a patch as I have no-where near enough understanding of bo=
th
> D-Bus and iwd of the impact of such a patch. I 'prefer' not to have my na=
me
> attached to a (potential) security breach ;-)
> =


No worries.

>>> Looking into possible solutions, I found 2 very similar commits ...
>>>
>>> They both link to
>>> https://www.spinics.net/lists/linux-bluetooth/msg75267.html While I lack
>>> the knowledge to fully understand what it says I did notice this: "The
>>> intent is clear: As long as you are logged in to a local machine, and y=
ou
>>> are the foreground/active console, you are allowed to control bluetooth.
>>> However, the behavior of 'at_console' does *not* match this intent."
>>>
>>> In other places I saw the 'at_console' stanza just plainly removed with=
out
>>> any replacement, but it could have undesirable consequences for iwd.
>>
>> I think the solution chosen in BlueZ which gives blanket permission to
>> access iwd D-Bus APIs to any local user is probably just fine.
>> Particularly given that at_console effectively allowed any user to use i=
wd
>> in the past.
>> This effectively negates the need to provide a separate policy for
>> wheel/netdev and so these can be removed.
> =

> Does this mean that any restrictions would be removed?
>

Yes, basically any logged in user could use iwctl or dbus-send to control i=
wd =

via the D-Bus API.  So any user could switch networks, power device up and =
down, =

etc.

This would be similar to BlueZ, where any user could control the bluetooth =
device.


> It is just an example, but the 'deluged' program runs under the 'debian-
> deluged' user. If that program has a (security) bug, would that allow a R=
CE
> wrt to iwd? Could it wreak havoc then?
> =


In theory, not really, since it would still have to go through the D-Bus AP=
I and =

the associated checks.  So it couldn't execute arbitrary code, but it could=
 do =

anything that a normal user can do as described above.

> Looking a bit further to see what others do and found some interesting th=
ings.
> =

> https://salsa.debian.org/bluetooth-team/bluez/-/blob/debian/sid/debian/
> patches/bluetooth.conf.patch is a modification of what upstream bluetooth=
 does
> and adds an allow for the 'bluetooth' group. That patch was explicitly ad=
ded,
> but without an explanation as to why, but as I understand it now, it means
> that 'bluetooth' group members get access, next to everyone else.
> IOW, it _seems_ (to me) like a pointless patch?

Seems pointless to me as well.  The intent seems to be to allow Bluetooth =

control only by the users of the 'bluetooth' group.  But I don't think that=
's =

what is actually happening due to the context=3D"default" hole being punche=
d.

> =

> In /etc/dbus-1/system.d/wpa_supplicant.conf I see 'allow' for 'root' and
> 'netdev' and (explicit) deny for 'context=3D"default"'
> =

> In /usr/share/dbus-1/system.d/org.freedesktop.NetworkManager.conf there i=
s a
> FAR more extensive policy, where 'root' can (ofc) do a LOT, but in the de=
fault
> context it starts with a 'deny' and then makes exceptions to grant mostly
> ReadOnly access to certain explicitly defined properties. In the comments=
 I see
> things like "read-only properties, no methods" and "read-only, no security
> required".
> There seem to be some properties/methods ReadWrite, but additionally secu=
red
> via PolicyKit ("read/write, secured with PolicyKit" in comments).
> =


Right, I don't think we really want to go that far and our APIs are quite s=
imple =

compared to NM.  Our goal is to ship a minimal policy that works for most u=
sers =

out of the box.  If the distros need something else, they're free to modify=
 the =

policy as they see fit.

>> Alternatively we can limit the policy only to wheel/netdev groups.
> =

> Given the above, I am more inclined to this solution, but it appears to me
> like pretty much the opposite of the other solution?

Sort of.  I think in reality the vast majority of users are on single-user =

systems with the main user already part of the 'wheel' group.  So even if w=
e =

drop the at_console usage, and allowed iwd use only for root/netdev/wheel, =
the =

impact should be minimal.

> But it could disallow use cases which iwd was meant to serve, which may be
> undesirable. For example, if I granted access to a friend (over SSH) to my
> machine, he was allowed access to iwd over D-Bus before, but because he's=
 not
> in the netdev group, he would then be denied access.

Correct.  But how likely is this scenario? :)

> =

> It could be that iwd only makes a (very) limited(/harmless?) set of
> functionality available over D-Bus, in which case my concerns are unfound=
ed.
> But I lack the knowledge to determine that.
> =

> Hope you can alleviate my concerns (before I send in a patch).
> =

> Cheers,
>    Diederik
> =



Regards,
-Denis
--===============6266489838238565110==--

