Content-Type: multipart/mixed; boundary="===============6776779226592294673=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: D-Bus policies
Date: Fri, 14 Jan 2022 18:15:57 +0100
Message-ID: <3141398.bvkd0EhLq2@bagend>

--===============6776779226592294673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Based on a Debian bug report I started a research into iwd's D-Bus policy a=
nd
found 2 items. I'll start with the 2nd as that's easier/shorter to describe.
This is purely informational as I'm not knowledgeable enough about iwd or =

D-Bus or how iwd intends to use DBus for certain functionality.

1) In src/iwd-dbus.conf I saw there was a policy for the wheel group, but n=
ot
for the netdev group. The wheel group is normally not used on Debian system=
s,
but the netdev group is. According to https://wiki.debian.org/SystemGroups: =

"netdev: Members of this group can manage network interfaces through
the network manager and wicd."

I have found (only) one distro which actually patches iwd to add netdev:
https://git.alpinelinux.org/aports/tree/community/iwd/dbus-netdev-group.pat=
ch =

The rest that _I_ have found just use what's provided by iwd.

2) The bug that started my research is https://bugs.debian.org/998427, sayi=
ng:
"dbus-broker-launch[2169]: Deprecated policy context in =

/usr/share/dbus-1/system.d/iwd-dbus.conf +21. The 'at_console' context
is deprecated and will be ignored in the future."

It is also a warning in Debian's Lintian tool:
https://lintian.debian.org/tags/dbus-policy-at-console which links to
https://bugs.freedesktop.org/39611 which is moved/continued at
https://gitlab.freedesktop.org/dbus/dbus/-/issues/52
The OP of that bug from 2011 states that the 'at_console' property should
be removed and that PolicyKit should be used instead.

Looking into possible solutions, I found 2 very similar commits, but in
different projects, bluez and system-config-printer:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D3ef0ce954b6=
6fdf45538a6cdc629f3dac6642832
https://github.com/OpenPrinting/system-config-printer/commit/19df47d2630b63=
7d1802efe2c3cd5a00f2e40c3b

They both link to https://www.spinics.net/lists/linux-bluetooth/msg75267.ht=
ml
While I lack the knowledge to fully understand what it says I did notice th=
is:
"The intent is clear: As long as you are logged in to a local machine, and =
you
are the foreground/active console, you are allowed to control bluetooth.
However, the behavior of 'at_console' does *not* match this intent."

In other places I saw the 'at_console' stanza just plainly removed without
any replacement, but it could have undesirable consequences for iwd.

The arch wiki does contain a section to restrict the 'at_console' policy:
https://wiki.archlinux.org/title/Iwd#Deny_console_(local)_user_from_modifyi=
ng_the_settings
It appears that they make the, likely incorrect, assumption about console
users, but they do restrict its permissions to mostly ReadOnly.

HTH,
  Diederik

--===============6776779226592294673==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWVHdnpRQUtDUkRYYmx2T2VIN2IKYnRrREFQOWhtU3laTXlpY3c3
NlVzbWI5RDMrU2lwSllCY3Zsc1dqK2RtMnRHVzQ3N3dFQXMyY1hoMGxPV21UKwoweTNrQUlVUWZB
WlJrQjA5T3BxQXppODkwMkNrNFFFPQo9MUxzdwotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============6776779226592294673==--

