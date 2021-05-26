Content-Type: multipart/mixed; boundary="===============6440299664795933476=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Wed, 26 May 2021 17:02:19 -0500
Message-ID: <a94d4551-9559-d4d5-cc1c-862d030a43d1@gmail.com>
In-Reply-To: <5b4e127b-33a4-545a-8041-98a1db8430df@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6440299664795933476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> netconfig depends on netdev right now, but it really shouldn't.=C2=A0 The=
 only reason =

> is that it needs the device name, which really belongs elsewhere since ne=
tconfig =

> will end up being used by ead, which will not even come with netconfig mo=
dule at =

> all.
> =


Whoops, s/netconfig/netdev

So that last line should read ... netdev module ...

Regards,
-Denis
--===============6440299664795933476==--

