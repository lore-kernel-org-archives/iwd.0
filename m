Content-Type: multipart/mixed; boundary="===============0633125544184395459=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Re: D-Bus policies
Date: Tue, 25 Jan 2022 23:43:58 +0100
Message-ID: <1894865.INmhrTAWsV@bagend>
In-Reply-To: 02eb9123-8c12-29db-a279-1ba2a21f8e57@gmail.com

--===============0633125544184395459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, 25 January 2022 23:15:07 CET Denis Kenzior wrote:
> Sure, but the chances that the main user on a single-user system isn't pa=
rt
> of 'wheel' or 'netdev' should be pretty small, no?

No, but it is easy to 'fix' for the main user.
When you install a Debian system, you can explicitly use the 'root' user an=
d =

then you specify root's password. Next to that a normal user account gets =

created. Alternatively, you can use the sudo system which the first user, i=
e =

you, gets added to and then you can do all root-type actions via sudo.
So the person installing the system does get full administrative permission=
s, =

which he/she can use to further setup the system.

> The original intent was to disallow access to iwd for remote users.  So, =
in
> the scenario above, if your friend is not part of 'netdev' or 'wheel', th=
en
> their control of iwd should not have been possible.

Correct. But in the restricted scenario (option 2), my friend would also no=
t =

have access if directly logged on to the system (locally), if not in the =

'netdev' group.
This would thus be a change in behavior as originally intended.
 =

> > And Option 2 is restricted access.
> =

> Right.  We'd be 'breaking' the above scenario.  But, as I mentioned befor=
e,
> how likely was this scenario in the first place?  Did someone really want
> remote users to mess with wifi on their machine without netdev/wheel
> access?  Arguably we're just fixing a bug.

I think we're indeed fixing a bug by allowing only netdev/wheel users the =

permission to change the wifi settings.

> > For which Option would you like a patch?
> =

> I'm fine with either option.  It sounds like you're favoring Option 2.
> Whichever you go for, I'll let it sit on the list for a few days to see if
> anyone else complains :)

Yeah, I do favor Option 2 ;-)
A patch is coming your/the list's way (probably tomorrow, CET TZ here)

Cheers,
  Diederik

--===============0633125544184395459==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWZCOUxnQUtDUkRYYmx2T2VIN2IKYnFTdEFRRDZqTVhZeWw5c1ZW
eTVLbWVjaUZocGZUNXBCa2cvZE9tTnFGaldVVjhJa1FFQWdySGRRaFl3ZDJmagowRWFkb1F2YlhU
Wld1T0swektleTNwODk3Z2xFVWc4PQo9ZytzMAotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============0633125544184395459==--

