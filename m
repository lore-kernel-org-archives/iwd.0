Content-Type: multipart/mixed; boundary="===============4397340770226801697=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: D-Bus policies
Date: Tue, 25 Jan 2022 16:15:07 -0600
Message-ID: <02eb9123-8c12-29db-a279-1ba2a21f8e57@gmail.com>
In-Reply-To: 1693634.GKaMHTciCY@bagend

--===============4397340770226801697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diederik,

>> Sort of.  I think in reality the vast majority of users are on single-us=
er
>> systems with the main user already part of the 'wheel' group. So even if=
 we
>> drop the at_console usage, and allowed iwd use only for root/netdev/whee=
l,
>> the impact should be minimal.
> =

> When I setup a new Debian system, I *manually* add myself to "dialout, ad=
m,
> plugdev, netdev, audio, video" groups, so this is not an automatic thing.
> I just added a 2nd user on my system and its only group membership was to=
 a
> group named the same as the user. This is the default behavior, but it ma=
y be
> (a bit) different for the first user, but likely also depends on how the =
system
> is setup.
> The 'wheel' group is not used/present on Debian (based distros).

Sure, but the chances that the main user on a single-user system isn't part=
 of =

'wheel' or 'netdev' should be pretty small, no?

> =

> So I think the impact is not minimal. OTOH, it should be common knowledge=
 that
> users need netdev group permissions to modify network connections.
> =


Agreed.

>>> For example, if I granted access to a friend (over SSH) to my
>>> machine, he was allowed access to iwd over D-Bus before, but because he=
's
>>> not in the netdev group, he would then be denied access.
>>
>> Correct.  But how likely is this scenario? :)
> =

> It's the default scenario on Debian and possibly its derivatives.
> FTR: I don't want my friend(s) granted permission to change the network
> connection by default. If I want to grant a friend that permission, I wou=
ld
> add him/her to the netdev group.

The original intent was to disallow access to iwd for remote users.  So, in=
 the =

scenario above, if your friend is not part of 'netdev' or 'wheel', then the=
ir =

control of iwd should not have been possible.

> =

> And Option 2 is restricted access.

Right.  We'd be 'breaking' the above scenario.  But, as I mentioned before,=
 how =

likely was this scenario in the first place?  Did someone really want remot=
e =

users to mess with wifi on their machine without netdev/wheel access?  Argu=
ably =

we're just fixing a bug.

> =

> For which Option would you like a patch?
> =


I'm fine with either option.  It sounds like you're favoring Option 2. =

Whichever you go for, I'll let it sit on the list for a few days to see if =

anyone else complains :)

Regards,
-Denis
--===============4397340770226801697==--

