Content-Type: multipart/mixed; boundary="===============4018101201905864610=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v2 1/5] station: commonize the building of diagnostic dict
Date: Thu, 21 Jan 2021 12:10:31 -0800
Message-ID: <7316bfd56e2edb107edefad2371868326234475c.camel@gmail.com>
In-Reply-To: <ea1a986d-a37c-f7d9-8ebd-45793a9213c1@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4018101201905864610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-01-21 at 14:08 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 1/21/21 12:11 PM, James Prestwood wrote:
> > AP mode will use the same structure for its diagnostic interface
> > and mostly the same dictionary keys. Apart from ConnectedBss and
> > Address being different, the remainder are the same so the
> > netdev_station_info to DBus dictionary conversion has been made
> > common so both station and AP can use it to build its diagnostic
> > dictionaries.
> > ---
> >   src/station.c | 71 ++++++++++++++++++++++++++++++--------------
> > -------
> >   src/station.h |  3 +++
> >   2 files changed, 45 insertions(+), 29 deletions(-)
> > =

> > v2:
> >   * Generalized the dictionary building so both station and AP
> > could
> >     use it.
> > =

> =

> <snip>
> =

> > +
> > +bool station_info_to_dict(const struct netdev_station_info *info,
> > +				struct l_dbus_message_builder
> > *builder);
> > =

> =

> This doesn't feel right to have ap (and possibly p2p, adhoc, etc)
> depend on =

> station for this.  Can we move the netdev_station_info structure
> definition to =

> src/common.h or maybe diagnostic.h (diagnostic_station_info?) or so
> and add this =

> to diagnostic.[ch] instead?

Sure, doing it in diagnostic.[ch] seems like the right way to go.

> =

> Regards,
> -Denis

--===============4018101201905864610==--

