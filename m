Content-Type: multipart/mixed; boundary="===============4150433539489403545=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd doesn't work with openresolv
Date: Mon, 03 Jan 2022 13:05:51 -0600
Message-ID: <2249097a-97e0-175a-6b02-e5d6be484498@gmail.com>
In-Reply-To: CAMhVC3Ys77EghTkso415MgyDwag4KbT_9d_NF-M+X-QGmbD3aQ@mail.gmail.com

--===============4150433539489403545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

<snip>

> [Service]
> ReadWritePaths=3D/etc/resolv.conf.bak
> ReadWritePaths=3D/etc/resolv.conf
> =

> Others suggested another way to fix it:
> =

> RuntimeDirectory=3Dresolvconf
> ReadWritePaths=3D/etc/resolv.conf
> =

> https://bugs.archlinux.org/task/67069
> =

> Can src/iwd.service.in be adjusted?

I think this or a similar issue has come up before.  The problem is that iw=
d =

supports either systemd-resolved or resolvconf.  So for systems that use =

systemd-resolved (which iwd defaults to), punching this security policy =

exception is not needed and arguably it should not be enabled by default.

Perhaps as a compromise we may be able to ship service.in with these lines =
added =

& commented out.  Not sure if this would be of any help though.  Other idea=
s are =

welcome.

Regards,
-Denis
--===============4150433539489403545==--

