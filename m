Content-Type: multipart/mixed; boundary="===============2583451266754441498=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Thu, 12 May 2022 17:19:41 +0100
Message-ID: <CACsRnHUFixRz2QhQY=3cZi2e-2cr-de6AbJNmOt-XBHiNDjyXA@mail.gmail.com>
In-Reply-To: fb33cfae-3121-1cb0-3616-450346936856@gmail.com

--===============2583451266754441498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I'm trying out the ell patch on some clients and so far it's looking
good. I also have some clients running without the patch but with
IWD_DHCP_DEBUG enabled and I saw a very similar issue occur as the
original major issue.

This was caused by the retry timing out so wouldn't have happened with
the patch but the result is not what I expected in that after we do a
full rebind, we don't send a T1 renew. I expected that it would do a
full state refresh and so it should go back to working after the T2
timeout.

https://pastebin.com/ERyQZPhr

Regards,
Michael

On Wed, 11 May 2022 at 19:52, Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
> > I would be happy to contribute something like this if you were open to =
it.
>
> Sure.  I think that would be useful.
>
> Regards,
> -Denis
--===============2583451266754441498==--

