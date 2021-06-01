Content-Type: multipart/mixed; boundary="===============3490048733216283182=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 6/8] ap: Save AP address as l_rtnl_address
Date: Wed, 02 Jun 2021 01:21:15 +0200
Message-ID: <CAOq732J=F5qJ87AFhXfAXSf0p1=w1oRntGs+usAH_5L8Ev2oHA@mail.gmail.com>
In-Reply-To: <393c3b03-37f2-0a9d-f2c9-300020f09745@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3490048733216283182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 1 Jun 2021 at 17:20, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> > -static const char *broadcast_from_ip(const char *ip)
> > +static const char *broadcast_from_ip(const char *ip, uint8_t prefix_le=
n)
> >   {
> >       struct in_addr ia;
> > -     uint32_t bcast;
> > +     uint32_t netmask =3D util_netmask_from_prefix(prefix_len);
> >
> >       if (inet_aton(ip, &ia) !=3D 1)
> >               return NULL;
> >
> > -     bcast =3D ntohl(ia.s_addr);
> > -     bcast &=3D 0xffffff00;
> > -     bcast |=3D 0x000000ff;
> > -
> > -     ia.s_addr =3D htonl(bcast);
> > -
> > +     ia.s_addr |=3D htonl(~netmask);
> >       return inet_ntoa(ia);
> >   }
> >
>
> Okay, but don't you really want to use l_rtnl_address_set_broadcast(rtnl,=
 NULL)
> instead?

Oh, I didn't know this existed, and apparently it's already done in
l_rtnl_address_new() so I can just drop this from ap.c.

>  Also, you may want to do this directly in ip-pool.c?

Considered that too but in this case we're creating a new l_rtnl_address.

Best regards
--===============3490048733216283182==--

