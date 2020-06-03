Content-Type: multipart/mixed; boundary="===============8629883498273606573=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Start iwd only after dbus
Date: Wed, 03 Jun 2020 16:03:22 +0200
Message-ID: <9bd7e278-4e48-35b3-1ffa-cd56925be439@molgen.mpg.de>
In-Reply-To: <20200602033512.2851.79090@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8629883498273606573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Dear dapolinario,


Am 02.06.20 um 05:35 schrieb dapolinario(a)gmail.com:
> When iwd is not synchronized to start after dbus, NetworkManager
> often does not identify that the service is already running and does
> not manage the wireless interface.
> =

> I suggest adding the line "After=3Ddbus.service" in "iwd.service" in
> the [Unit] section, so NetworkManager always identifies that iwd is
> working.
Did that fix that issue for you permanently?

How is iwd started? By NetworkManager over D-Bus or by systemd, because =

it was installed into it?

There is NetworkManager issue *iwd backend gets activated but NM =

considers the device unavailable* [1] about problems when iwd gets =

started by NM.


Kind regards,

Paul


[1]: =

https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/101
--===============8629883498273606573==--

