Content-Type: multipart/mixed; boundary="===============0600951298273789089=="
MIME-Version: 1.0
From: Yuri Kanivetsky <yuri.kanivetsky at gmail.com>
To: iwd at lists.01.org
Subject: iwd doesn't work with openresolv
Date: Mon, 27 Dec 2021 13:38:35 +0200
Message-ID: <CAMhVC3Ys77EghTkso415MgyDwag4KbT_9d_NF-M+X-QGmbD3aQ@mail.gmail.com>

--===============0600951298273789089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

If I run it as is, I get:

Dec 27 13:27:21 yuri iwd[716]: cp: cannot create regular file
'/etc/resolv.conf.bak': Read-only file system
Dec 27 13:27:21 yuri iwd[717]: /usr/lib/resolvconf/libc: line 230:
/etc/resolv.conf: Read-only file system
Dec 27 13:27:21 yuri iwd[761]: cp: cannot create regular file
'/etc/resolv.conf.bak': Read-only file system
Dec 27 13:27:21 yuri iwd[762]: /usr/lib/resolvconf/libc: line 230:
/etc/resolv.conf: Read-only file system

I can work around it by:

touch /etc/resolv.conf.bak

and overriding:

[Service]
ReadWritePaths=3D/etc/resolv.conf.bak
ReadWritePaths=3D/etc/resolv.conf

Others suggested another way to fix it:

RuntimeDirectory=3Dresolvconf
ReadWritePaths=3D/etc/resolv.conf

https://bugs.archlinux.org/task/67069

Can src/iwd.service.in be adjusted?

Regards,
Yuri
--===============0600951298273789089==--

