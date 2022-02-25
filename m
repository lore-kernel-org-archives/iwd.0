Content-Type: multipart/mixed; boundary="===============4691590126402347060=="
MIME-Version: 1.0
From: =?utf-8?q?Joakim_Lotseng=C3=A5rd_=3Cjoakim=2El_at_orbital-systems=2Ecom?=
 =?utf-8?q?=3E?=
To: iwd at lists.01.org
Subject: Re: lib to iwd
Date: Fri, 25 Feb 2022 08:24:41 +0100
Message-ID: <CAELJisz6noytw9XvMKbazY=d+AJVho2Qa6d3pQyLJZWvVsabSQ@mail.gmail.com>
In-Reply-To: 882393bf47a86c8fd848bde29e020dade28aa427.camel@gmail.com

--===============4691590126402347060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, and thanks for your answer. See inline.

On Thu, 24 Feb 2022 at 17:24, James Prestwood <prestwoj(a)gmail.com> wrote:
> >
> > We only want a minor "libiwd" or "libiwctl" just like libnm that can
> > configure an IoT device's SSID via a side channel. How can we do this
> > the easiest and most standard way?
>
> As far as a "libiwd" I don't think you're going to get a lot of
> support. Firstly it would be quite an intrusive code change to the core
> daemon. In addition this would be an entirely new maintanance front
> since we would now have two separate control points. I'm no authority
> here but I don't see it happening.
>

Oh, sorry. I was not clear enough. I don't propose to change either iwd
nor iwctl. What I am looking for is a "third" entity that helps developers
interact with iwd over the DBUS API. Just for the small part of having
an IoT device get its SSID+pass configured. To start with at least.

> As far as "libiwctl" I don't think there is anything stopping you. You
> could wrap the DBus API in a library but ultimately you'd still be
> using DBus.
>
> Note that ELL has quite an easy to use DBus API, which is what iwctl
> uses. iwctl implements nearly all of IWD's DBus API so the code is
> already written and could be modified or used as a reference in your
> application. Since your target already has ELL (if it has IWD) you
> aren't adding any dependencies. If it were me this is what I would do
> rather than creating a new library. I think you'd be surprised how
> little C code it takes to Scan/Connect/GetOrderedNetworks.
>

Thanks for the tip. I will look into it. Hopefully it is really easy
and the 'lib'
that I am looking for is really just a bunch of short example code. Based
on ELL.
--===============4691590126402347060==--

