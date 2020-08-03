Content-Type: multipart/mixed; boundary="===============5287989594383492913=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: build: hook up traditional dbus activation
Date: Mon, 03 Aug 2020 16:43:51 -0500
Message-ID: <d19ba61c-4a1a-56b4-c6c3-650abff346b1@gmail.com>
In-Reply-To: <uruANJg_J76J43r_UsAABIzdnz2yDgDWjMCYMHBxe7yAx-xb1uhPW744L4BxF6bYTiDmC0A8LMEFLzwvXcAd6cEi5a4NT8sgP9uhLjVgEEM=@protonmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5287989594383492913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Job,

> I understand if you won't support non-systemd init systems like sysvinit.=
 I haven't maintained daemons, but from the looks of it, maintaining suppor=
t for multiple inits is surely hard. However users who don't use systemd as=
 their init, like Devuan users, Gentoo users, and Debian users who replaced=
 systemd with sysvinit/openrc would appreciate it if upstream decided to su=
pport multiple inits. Gentoo users have a community which maintains their o=
wn iwd init script for openrc. Devuan users however, have to workaround thi=
s problem by converting the iwd systemd service file to a sysvinit script, =
and update-rc.d as root. If I haven't known about this, I would still be us=
ing wpa_supplicant by now. iwd actually made my wifi connection more reliab=
le. When I was using wpa_supplicant, I had to reboot my system everytime th=
e connection drops. With iwd, I only have to restart iwd and my connection =
is back. I figured that I should contribute back to the community by adding=
 sysvinit support.

I'm still a bit lost why D-Bus activation is needed?  Is sysvinit/openrc so=
mehow =

using it to start daemons?

Regards,
-Denis

--===============5287989594383492913==--

