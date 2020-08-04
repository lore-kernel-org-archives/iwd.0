Content-Type: multipart/mixed; boundary="===============3840021749052490805=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: build: hook up traditional dbus activation
Date: Tue, 04 Aug 2020 07:57:28 +0200
Message-ID: <344AF6D4-30F6-428A-9970-33B37C4DC858@holtmann.org>
In-Reply-To: <uruANJg_J76J43r_UsAABIzdnz2yDgDWjMCYMHBxe7yAx-xb1uhPW744L4BxF6bYTiDmC0A8LMEFLzwvXcAd6cEi5a4NT8sgP9uhLjVgEEM=@protonmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3840021749052490805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Job,

> Hi, I am the original reporter Andreas is talking about. I'm going to adm=
it that I have no idea on how to use dbus activation. I only know how to st=
art a service at boot via shell scripts.
> =

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
> =

> So whatever decision you guys make, I will respect it. As you said, we ca=
n ship a modified version instead for non-systemd users. I am already prepa=
ring a fork of the iwd package for Devuan users[1]. The patch is ugly, but =
it works.

so about 16 something years ago (long before systemd), I tried to provide i=
nit scripts for all the distributions. It was a disaster since all of them =
are a bit different. So I decided to not do that anymore and the distro pac=
kage maintainers have to do that job as downstream. It makes no sense that =
upstream carries the work of downstream anyway. It is just the wrong direct=
ion.

With systemd unit files there was a unified way across distribution to desc=
ribe the daemon/service and so I started to include these. So unit files et=
c. can stay upstream because they are common across all distribution. Any i=
nit scripts can=E2=80=99t be accepted.

D-Bus activation for system level daemons outside of systemd is something I=
 found always a bit hackish to begin with and thus it is not something that=
 is worth while supporting. iwd is designed to be start and it can linger a=
round until WiFi hardware is found since it is truly hotplug capable.

In summary, if distributions need a sysvinit or openrc integration, then it=
 is the job of the distro package maintainer to provide that.

Regards

Marcel

--===============3840021749052490805==--

