Content-Type: multipart/mixed; boundary="===============7393392592794480131=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] offchannel: introduce new offchannel module
Date: Mon, 06 Dec 2021 12:48:20 -0600
Message-ID: <3b9d8507-3ae5-322d-06b0-92a7c7807196@gmail.com>
In-Reply-To: f38627a0c4c02189f3cc2e08619b6349452b58eb.camel@gmail.com

--===============7393392592794480131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> Even with this though I don't see a point of waiting for the ACK since
> the kernel will send cancel ROC. The ACK callback for this would have
> no purpose AFAIK.
> =


If you always want to wait for the cancel event, then I would concur.  Ques=
tion =

is whether the kernel would always guarantee that this is sent.  I guess we=
'll =

find out :)

> =

> Yes, I need to only cancel conditionally. I don't see why we need to
> invoke destroy here though? I would rather keep destroy() in one
> location, in the work done callback.

Mostly to be nice to the consumer of these methods.  They may want to assum=
e =

that cancel succeeds synchronously and that the destroy method is invoked r=
ight =

away.  For example, this may be useful if the destroy method manipulates so=
me =

data hanging off the main object and the main object is about to be destroy=
ed =

(hence the cancel call on the ongoing request).

Regards,
-Denis
--===============7393392592794480131==--

