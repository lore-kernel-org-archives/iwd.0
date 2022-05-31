Content-Type: multipart/mixed; boundary="===============8743393983111106236=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd fails to create device
Date: Tue, 31 May 2022 13:17:01 -0700
Message-ID: <2fec88f46974c051e5b4c277b50d2ae88c2fe5e5.camel@gmail.com>
In-Reply-To: 20220531183951.2010.25659@ml01.vlan13.01.org

--===============8743393983111106236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-05-31 at 18:39 +0000,
1148d778-20a8-4ab0-96b7-24572ddab965(a)simplelogin.co wrote:
> > It would be great if you could get some iwmon logs when this
> > happens.
> > Hopefully it happens frequent enough you can get a capture. More
> > info
> > about how to do that can be found here:
> > =

> > https://iwd.wiki.kernel.org/debugging
> =

> Sure, but it doesn't happen very frequently. I'm not sure about how
> to approach debugging for this, should I try to restart iwd when it
> happens? Maybe doing this the issue is not triggered. Having iwmon
> logging all time seems a bit too much, no?

It sounds like some kind of race condition in the kernel, which is why
its infrequent. And yes, running iwmon all the time is going to produce
a huge log...

Maybe someone else has a better solution, but you could create a bash
script (e.g. /usr/libexec/start-iwd.sh):

#!/bin/bash
timeout 60s iwmon --nortnl --noscan > /your/log/file &
iwd -d

And have your systemd unit file run this:

ExecStart=3D/usr/libexec/start-iwd.sh

Since this happens at startup running iwmon for 60 seconds should be
plenty to capture the wiphy dump. This of course assumes you're using
systemd.

Note: DO NOT use the --nowiphy. This disables the messages we need to
look at.

Thanks,
James


> =

> I could try to reproduce it somehow because it's mostly after a
> reboot when it happens.
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============8743393983111106236==--

