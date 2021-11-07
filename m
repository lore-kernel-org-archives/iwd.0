Content-Type: multipart/mixed; boundary="===============8754060143098494387=="
MIME-Version: 1.0
From: Torsten Schmitz <noreply.torsten at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Prevent a NULL pointer access
Date: Sun, 07 Nov 2021 02:02:58 +0100
Message-ID: <CFJ558V5FNXE.2CP12NH8WWZ8X@hostname>
In-Reply-To: 3c0e6c34-3054-276c-9f0f-44c57b173f84@gmail.com

--===============8754060143098494387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Could you provide a bit more info about the
> network setup you managed to trigger this on? =


We have a mishmash of older and newer APs,
some supporting mesh some don't all advertising the same SSID.
There is an open and closed network.
owe_info->ssid in the crash was the SSID of the open network.
I do not use the open network and connecting to it with iwd
fails.

> This would imply that this network has a set of APs that advertise the
> same SSID, but do not advertise an OWE transition element, =

> and some APs that do advertise it? =


Sounds plausible.

>I.e. some legacy APs that do not have a hidden partner?

iwd shows three hidden APs for that open network. Their addresses =

suggest they belong to the older APs without mesh support.
So I think it is the older APs that do have hidden partners
and advertise OWE transitions.

> > +	if (!owe_info)
> > +		return false;
> > +
> This should not be necessary since owe_info is checked right before
> invoking
> this function. =


Oh, that's right. =

These big if statements seem good at hiding stuff.
Perhaps "O2: Try to avoid complex if body" should apply
to the if conditions as well?
--===============8754060143098494387==--

