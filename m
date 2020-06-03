Content-Type: multipart/mixed; boundary="===============6016409756293570201=="
MIME-Version: 1.0
From: Daniel Apolinario <dapolinario@gmail.com>
Subject: Re: Start iwd only after dbus
Date: Wed, 03 Jun 2020 14:06:43 +0000
Message-ID: <20200603140643.2851.43252@ml01.vlan13.01.org>
In-Reply-To: <9bd7e278-4e48-35b3-1ffa-cd56925be439@molgen.mpg.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6016409756293570201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello!

> How is iwd started? By NetworkManager over D-Bus or by systemd, because =

> it was installed into it?
Iwd is started by NetworkManager over D-Bus instead of systemd.

> There is NetworkManager issue *iwd backend gets activated but NM =

> considers the device unavailable* [1] about problems when iwd gets =

> started by NM.
Yes, this fix solves my problem and the referenced NetworkManager issue. I =
performed several tests and every time the interface was available for Netw=
orkManager.

Kind regards

Daniel
--===============6016409756293570201==--

