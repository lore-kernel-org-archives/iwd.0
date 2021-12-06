Content-Type: multipart/mixed; boundary="===============3641365307554963036=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] offchannel: introduce new offchannel module
Date: Mon, 06 Dec 2021 11:01:49 -0800
Message-ID: <6a4d79d72167d4916fa7a52dc7486fe10bdcf240.camel@gmail.com>
In-Reply-To: 3b9d8507-3ae5-322d-06b0-92a7c7807196@gmail.com

--===============3641365307554963036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-12-06 at 12:48 -0600, Denis Kenzior wrote:
> Hi James,
> =

> > Even with this though I don't see a point of waiting for the ACK
> > since
> > the kernel will send cancel ROC. The ACK callback for this would
> > have
> > no purpose AFAIK.
> > =

> =

> If you always want to wait for the cancel event, then I would
> concur.=C2=A0 Question =

> is whether the kernel would always guarantee that this is sent.=C2=A0 I
> guess we'll =

> find out :)
> =

> > =

> > Yes, I need to only cancel conditionally. I don't see why we need
> > to
> > invoke destroy here though? I would rather keep destroy() in one
> > location, in the work done callback.
> =

> Mostly to be nice to the consumer of these methods.=C2=A0 They may want to
> assume =

> that cancel succeeds synchronously and that the destroy method is
> invoked right =

> away.=C2=A0 For example, this may be useful if the destroy method
> manipulates some =

> data hanging off the main object and the main object is about to be
> destroyed =

> (hence the cancel call on the ongoing request).

Ok makes sense. I guess in this case we can just call then NULL destroy
and all other cases it will still happen in the work done callback.
I've already sent v3 but I'll update this in the next round.

> =

> Regards,
> -Denis


--===============3641365307554963036==--

