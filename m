Content-Type: multipart/mixed; boundary="===============3218349416985505399=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Wed, 11 May 2022 19:13:13 +0100
Message-ID: <CACsRnHVzueqtOTO1vu73F7JkF2iv46F_2_dgzExH-vrKx5F6Gw@mail.gmail.com>
In-Reply-To: facd169d-1b0d-e1f2-7cb8-4e998593c69c@gmail.com

--===============3218349416985505399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you, I'll try it out.

One thing I was wondering is if some level of info logging would be
possible for the dhcp client. This could be similar in verbosity to
dhclient or networkd which would make it easier to see what happened
with this kind of thing. DHCP happens on a relatively slow basis so it
wouldn't spam much. I attempted to add this but I couldn't really find
a good place for it.

Regards,
Michael

On Wed, 11 May 2022 at 18:32, Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
>
> > The lease should always be 2 hours if dhcpd is working correctly. The
> > ones I've seen are always this value.
> >
>
> Ok.
>
> > For this one I did have DHCP debug on. You seem to be right, it looks
> > like we didn't renew until we timed out completely.
> >
>
> That would seem to confirm my hunch.  I just sent out a patch to the ell =
mailing
> list and to you.  See if that one fixes this particular issue.
>
> Regards,
> -Denis
--===============3218349416985505399==--

