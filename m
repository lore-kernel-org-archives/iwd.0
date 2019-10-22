Content-Type: multipart/mixed; boundary="===============1029496586047234640=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 02/11] netdev: Report RSSI to frame watch callbacks
Date: Tue, 22 Oct 2019 15:46:14 +0200
Message-ID: <CAOq732JvoB-SiLt0AeT0YmzuPp8Zdph+OE5vCT73xp8LnpEh7A@mail.gmail.com>
In-Reply-To: <4e176e94-776d-0474-9a2f-4a565c72cead@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1029496586047234640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 22 Oct 2019 at 05:34, Denis Kenzior <denkenz@gmail.com> wrote:
> >   #include <sys/socket.h>
> >   #include <errno.h>
> > +#include <limits.h>
>
> This would suck to have to use INT_MIN everywhere...

Because of the #include?  Most places don't care about the rssi though.

>
> >
> >   #include <ell/ell.h>
> >
>
> <snip>
>
> > @@ -3511,6 +3512,7 @@ static void netdev_mgmt_frame_event(struct l_genl=
_msg *msg,
> >       const struct mmpdu_header *mpdu =3D NULL;
> >       const uint8_t *body;
> >       struct frame_prefix_info info;
> > +     int rssi =3D INT_MIN;
>
> The kernel uses 0 as a flag value, so can't we do the same?

Ok.

Best regards
--===============1029496586047234640==--

