Content-Type: multipart/mixed; boundary="===============9175522239218064925=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 04/11] ap: Add subnet address selection logic
Date: Tue, 11 May 2021 23:04:42 +0200
Message-ID: <CAOq732+uYG44riSqnxBprt0YsLXeFHY4aJ4KR8JV=buaUj+UCQ@mail.gmail.com>
In-Reply-To: <bff1b2f2-c61e-bc8a-0574-ce371a897ec2@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9175522239218064925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 11 May 2021 at 17:06, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/10/21 3:57 AM, Andrew Zaborowski wrote:
> > Add the ap_select_addr4 function to select a random subnet of requested
> > size from an address space defined by a string list (for use with the
> > AP profile [IPv4].Address and the global [IPv4].APAddressPool settings),
> > avoiding those subnets that conflict with subnets from a second list.
> > We take care to give a similar weight to all subnets contained in the
> > specified ranges regardless of how many ranges contain each, basically
> > so that overlapping ranges don't affect the probabilities (debatable.)
> >
> > This is added as src/ap-addr.c so that it's self-contained.
> > ---
> >   Makefile.am   |   3 +-
> >   src/ap-addr.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >   src/ap.h      |   9 ++
> >   3 files changed, 242 insertions(+), 1 deletion(-)
> >   create mode 100644 src/ap-addr.c
> >
>
> I would rather we made this into a self contained module that pays attent=
ion to
> RTNL and tracks any addresses added / removed.  That way the caller isn't=
 forced
> into performing an RTNL dump first...

That is something I considered too but think about how many RTNL
events and process wakeups we're generating this way compared to how
often this data is actually used in a typical IWD session... do you
still think it's a good idea?

Also note we wouldn't be saving any code because the RTNL dump is
still needed at the module init, it's only moved to a different file.

>
> > diff --git a/src/ap.h b/src/ap.h
> > index b0100f34..2163d2db 100644
> > --- a/src/ap.h
> > +++ b/src/ap.h
> > @@ -97,3 +97,12 @@ bool ap_station_disconnect(struct ap_state *ap, cons=
t uint8_t *mac,
> >
> >   bool ap_push_button(struct ap_state *ap);
> >   void ap_update_beacon(struct ap_state *ap);
> > +
> > +struct ap_rtnl_addr4_record {
> > +     uint32_t addr;
> > +     uint8_t prefix_len;
> > +};
> > +
> > +int ap_select_addr4(const char **addr_str_list, uint8_t prefix,
> > +                     const struct l_queue *used_addr_dump,
> > +                     uint32_t *out_addr);
> >
>
> Do we have a chance of collisions if 2 APs are brought up simultaneously?
> Should there be an explicit reserve / release semantic?  I know you use
> l_getrandom to pick the subnet, but what if the IP pool size is pretty sm=
all?

If you started the APs simultaneously and the RTNL dumps had been
running simultaneously then yeah, I guess this can happen.  I wouldn't
worry about this, we're trying to do the best thing that's easily
doable here but there's no guarantees that the subnets are unique on
the system.  We can always have a race with another process, or that
process may not even be trying to avoid conflicts or not be able to,
because it receives a conflicting IP from DHCP.

Best regards
--===============9175522239218064925==--

