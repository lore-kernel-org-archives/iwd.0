Content-Type: multipart/mixed; boundary="===============1070154553849489175=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/9] netconfig: Refactor setting new values to system
Date: Thu, 11 Nov 2021 14:21:02 -0600
Message-ID: <c9091fe7-3d70-bce6-eefe-48cba090d0a0@gmail.com>
In-Reply-To: 0880f7a8-c889-ef01-8342-e704d8d9257e@gmail.com

--===============1070154553849489175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> =

> What you say is absolutely correct.=C2=A0 Yet still wrong ;)=C2=A0 Just l=
ook at what =

> happens on a 'change'.=C2=A0 You try to call the notifier with 'connected=
' event. You =

> also print a debug message saying there's no gateway in the lease.=C2=A0 =
Neither make =

> sense.
> =


Note, I'm not saying you shouldn't use 'CHANGED'.  Perhaps that is the righ=
t =

approach if netconfig would inform the backend only of the 'new' settings. =
 But =

the way CHANGED is being handled in this patch seems problematic.

Regards,
-Denis
--===============1070154553849489175==--

