Content-Type: multipart/mixed; boundary="===============8123424522008058912=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/9] ap: Track IPv4 addresses in use
Date: Mon, 17 May 2021 14:55:28 +0200
Message-ID: <CAOq732J71su=Lyg4gFPrU3k_tx76zqH9ymTJA3Ty+SixJwn3JA@mail.gmail.com>
In-Reply-To: <CAOq732LRhXC_7bCJd4K4PHGWSYwvBL97ZeRScsVU-=cujavw7g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8123424522008058912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 15 May 2021 at 00:16, Andrew Zaborowski
<andrew.zaborowski@intel.com> wrote:
> On Fri, 14 May 2021 at 17:26, Denis Kenzior <denkenz@gmail.com> wrote:
> > On 5/13/21 1:47 PM, Andrew Zaborowski wrote:
> > > +             addr =3D l_new(struct ap_rtnl_addr4_record, 1);
> > > +             addr->addr =3D ntohl(ip.s_addr);
> > > +             addr->prefix_len =3D ifa->ifa_prefixlen;
> > > +             addr->ifindex =3D ifa->ifa_index;
> > > +             addr->secondary =3D !!(ifa->ifa_flags & IFA_F_SECONDARY=
);
> >
> > so why is l_rtnl_address not good enough?
>
> 1. Seems this is internal to ell/rtnl.c,

Ok, I see what you mean.  We can do this but I wouldn't see it as an
improvement because of the below and simply the extra indirection.

> 2. stores way more
> information than we need and sort-of implies network byte order which
> I didn't want to have to deal with (reduces readability too).

Best regards
--===============8123424522008058912==--

