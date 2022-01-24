Content-Type: multipart/mixed; boundary="===============1278547492824512347=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] iwd: Mark only reachable networks as available
Date: Mon, 24 Jan 2022 13:54:32 -0800
Message-ID: <cff392fd1d28547d00b24d8f39e43e7741bd7ce4.camel@gmail.com>
In-Reply-To: 20220123131447.yxpmf5y3ku6cefu4@beryllium.lan

--===============1278547492824512347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2022-01-23 at 14:14 +0100, Daniel Wagner wrote:
> On Fri, Jan 21, 2022 at 09:43:04AM +0000, VAUTRIN Emmanuel (Canal
> Plus Prestataire) wrote:
> > > Patch applied. I was not aware that iwd shows networks with no
> > > signal
> > > strength. Thanks!
> > =

> > Great news, thank you Daniel!
> > Indeed, it is really rare, but I have noticed that during some full
> > test
> > campaigns, what I have never noticed (during years) with wpa-
> > supplicant.
> =

> Alright, let's add the iwd mailing list. Maybe it's a bug, no idea.

I only see one way this could happen, with a select few drivers.
Looks like the kernel has two possible attributes for the signal
stength based on what the driver sets 'signal_type' to. IWD only
handles SIGNAL_DBM, but SIGNAL_UNSPEC is also possible.
 =

What hardware did you see this on? Based on what I'm seeing in the
kernel it is probably one of zd1211rw, at76c50x-usb, adm8211, or
rtl8180?

I'm gonna guess this never got handled because the nl80211 docs say
this attribute is "unspecified units"...

Thanks,
James


> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============1278547492824512347==--

