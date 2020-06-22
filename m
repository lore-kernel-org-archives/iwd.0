Content-Type: multipart/mixed; boundary="===============2548014680134449412=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [RFC 4/6] frame-xchg: refactor to work with offchannel module
Date: Mon, 22 Jun 2020 13:06:15 -0700
Message-ID: <a269cebf6371386da73ba45be2501710ef63b4e4.camel@gmail.com>
In-Reply-To: <5ed8ec95-5175-c844-750b-1ba8b7940890@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2548014680134449412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-22 at 15:03 -0500, Denis Kenzior wrote:
> Hi James,
> =

> > > > -void frame_xchg_stop(uint64_t wdev_id);
> > > > +void frame_xchg_stop(uint64_t wdev_id, uint32_t id);
> > > =

> > > Do we even need the wdev_id here now? Also, should this be
> > > _cancel?
> > =

> > It just made the lookup easier, but yeah we could iterate each
> > queue in
> > the phy list. And yeah, I could change that to _cancel.
> > =

> =

> Hmm, how so? I don't even see wdev_id being used now.

Ah yeah not in frame-xchg now. I moved that into offchannel.c. So it
just makes *that* lookup easier :)

But when I think about it we will generally only ever have a couple
phy's (or just one), and barely any requests per-phy anyways so a full
lookup isnt too expensive.

> =

> Regards,
> -Denis
>=20

--===============2548014680134449412==--

