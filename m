Content-Type: multipart/mixed; boundary="===============6057807756933269918=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: RE: Problems attempting to use ad-hoc mode, link state remains dormant
Date: Fri, 10 Apr 2020 00:29:57 +0000
Message-ID: <
 <VI1PR01MB5167A73E5B27C94F917805EE88DE0@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>>
In-Reply-To: <a838c6ae-4994-5a11-2578-19aa7240913e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6057807756933269918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Denis Kenzior <denkenz@gmail.com>
> Sent: 08 April 2020 23:35
> To: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>; iwd(a)lists.01.org
> Subject: Re: Problems attempting to use ad-hoc mode, link state remains
> dormant
> =

> Hi Diego,
> =

> >> The tricky part is that adhoc doesn't initialize its own rtnl object, =
so
> >> I need to think about a good fix for this.
> >>
> >
> > Thanks for the information, indeed it looked to me that there was
> something missing but I could not really figure it out for sure from the =
code. I
> do not think I can help out there.
> =

> This should now be fixed upstream.

Great! I gave it quick test to the patches and it works.

Many thanks,

Diego

-- =

Diego Santa Cruz, PhD
Technology Architect
spinetix.com



--===============6057807756933269918==--

