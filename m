Content-Type: multipart/mixed; boundary="===============4705732401716146770=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 5/9] ie: Add FILS IP Address Assignment parsers and
 builders
Date: Wed, 25 Aug 2021 23:34:52 +0200
Message-ID: <CAOq732LtRF+Nze+u02jTFg4=S9iC0JFi_XMwP93ur=9J8_rjAg@mail.gmail.com>
In-Reply-To: <611d1fd3-fd8e-3b42-0e9f-32f0edcc4ac7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4705732401716146770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis.

On Wed, 25 Aug 2021 at 15:49, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/23/21 9:14 AM, Andrew Zaborowski wrote:
> > ---
> >   src/ie.c | 347 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   src/ie.h |  38 ++++++
> >   2 files changed, 385 insertions(+)
> >
>
> <snip>
>
> > +     if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV4_GW_INCLUDED) {
> > +             ptr =3D NEXT_FIELD(data, len, 10);
> > +             info.ipv4_gateway =3D l_get_u32(ptr);
> > +             memcpy(info.ipv4_gateway_mac, ptr + 4, 6);
> > +
> > +             /* Check gateway is on the same subnet */
> > +             if (info.ipv4_addr && (ntohl(info.ipv4_addr ^ info.ipv4_g=
ateway) &
> > +                             util_netmask_from_prefix(info.ipv4_prefix=
_len)))
>
> This line is over 80 chars.  Also, it seems you're repeating this pattern=
 in
> many places by now.  Please add a utility function so one doesn't wonder =
what
> this is doing on every reading ;)

Ok, makes sense.

Best regards
--===============4705732401716146770==--

