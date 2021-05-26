Content-Type: multipart/mixed; boundary="===============2901218131454124767=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Thu, 27 May 2021 01:26:44 +0200
Message-ID: <CAOq732J2bNd5+BXfzpS3nfEJEJ9gdTVDztDvuDtYu9Ph7jzSTQ@mail.gmail.com>
In-Reply-To: <83306935-fb0e-ef46-0384-79975b6627e1@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2901218131454124767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 May 2021 at 00:55, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/26/21 5:36 PM, Andrew Zaborowski wrote:
> > On Wed, 26 May 2021 at 23:56, Denis Kenzior <denkenz@gmail.com> wrote:
> >>> Again, convenience, readability, better fit for the use case.  But
> >>
> >> readability? Yeah I don't buy that one ;)
> >
> > If you can write
> >    ret_val =3D ip_pool_select_addr4(...);
> >
> >    do_some_maths(ret_val->addr)
> >
>
> What maths are you performing and why?

Outside of ip_pool_select_addr4() itself (which will suffer internally
too), there's some broadcast_from_ip() for example.

But fair enough that should go away if we switch to
l_rtnl_ifaddr_add() (But again this is a change out of the scope of
this patchset that I've been rewriting since before the big ap.h
change to use an l_settings and other unrelated changes)

Best regards
--===============2901218131454124767==--

