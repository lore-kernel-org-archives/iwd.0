Content-Type: multipart/mixed; boundary="===============5242630114311595668=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] ap: Implement P2P GO-side 4-way handshake IP
 Allocation
Date: Sat, 10 Jul 2021 02:52:44 +0200
Message-ID: <CAOq732LUGQS2ZA5A568wt1z3YeNyg7TdpsShWJiBbuQFVcye8w@mail.gmail.com>
In-Reply-To: <444fbf46-19e3-e30c-dd66-f6a066af2cd3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5242630114311595668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 9 Jul 2021 at 20:51, Denis Kenzior <denkenz@gmail.com> wrote:
> >>> +#define IP4_FROM_STR(str)                                           =
 \
> >>> +     (__extension__ ({                                              =
 \
> >>> +             struct in_addr ia;                                     =
 \
> >>> +             inet_pton(AF_INET, str, &ia) =3D=3D 1 ? ntohl(ia.s_addr=
) : 0; \
> >>
> >> Why the ntohl?  Why is handshake_state storing those parameters in hos=
t order
> >> anyway?
> >
> > I guess at this point it's just because why not.  We can use either
>
> So I really don't agree with such point of view.  IP addresses are usually
> assumed to be stored in network order.  Consistency is king.  We should a=
lways
> be consistent unless there's a good reason not to be, and then you want t=
o keep
> that inconsistency to a minimum.

I can switch these three fields in handshake_state to network
byte-order but ftr IWD itself doesn't store raw IPs as literal
uint32_t's except in ap/ip-pool/p2p all of which are host byte-order
now (you could say there's consistency).

>
> > order.  I still think it would be good to use a typedef if we want to
> > store a network byte-order value, like struct in_addr uses in_addr_t.
> >
>
> We could.  We also have __be32/16 types.  But all of these are just annot=
ations.
>   They're still not that helpful compared to just being consistent.
>
> >>> @@ -877,12 +916,18 @@ static void ap_handshake_event(struct handshake=
_state *hs,
> >>>                enum handshake_event event, void *user_data, ...)
> >>>    {
> >>>        struct sta_state *sta =3D user_data;
> >>> +     struct ap_state *ap =3D sta->ap;
> >>>        va_list args;
> >>>
> >>>        va_start(args, user_data);
> >>>
> >>>        switch (event) {
> >>>        case HANDSHAKE_EVENT_COMPLETE:
> >>> +             if (sta->ip_alloc_lease && !sta->hs->support_ip_allocat=
ion)
> >>> +                     /* Client sent no IP Address Request */
> >>> +                     l_dhcp_server_release_lease(ap->netconfig_dhcp,
> >>> +                                     l_steal_ptr(sta->ip_alloc_lease=
));
> >>> +
> >>
> >> I'm not sure about this part.  Is there any harm in just leaving the l=
ease be?
> >> Shouldn't l_dhcp_server just select the same lease if the client tries
> >> re-running DHCP?
> >
> > Yeah, I think it would re-use the memory (after memzeroing it) and the
> > IP.  Ideally we shouldn't assume this about the DHCP implementation,
> > is there any reason to not release the lease here?
> >
>
> I was wondering about potential race conditions here.  By the time we rec=
eive
> message 4, the client might already be running dhcp...  Would there be any
> issues with just hard-pulling a lease like this?

Looks like there could be a race condition indeed.  AFAIK DHCP can't
start before we send the SET_STATION to authorize the "data port" but
the HANDSHAKE_EVENT_COMPLETE is signalled inside the SET_STATION
callback (netdev_set_station_cb) and I guess l_dhcp_server could
receive a frame callback after we sent the SET_STATION command but
before we got the callback.

>
> >> You could also try to mess with the lease timeout in case
> >> you're worried about clients connecting and not running DHCP...
> >
> > Thinking about this there may also be future UIs that will display
> > active/expired DHCP leases like a lot of APs do.  Ideally the lease
> > list would really reflect the leases requested/acked.
>
> Maybe allocate the lease like we received a DISCOVER?  And only confirm i=
t once
> the handshake is done and the IP Allocation KDE was used?

This might work, I actually considered using two methods instead of
just l_dhcp_server_new_lease.  We'd need to start tracking the offered
lease expiry times though.  Right now we set a 5s timeout for offered
leases (lease->lifetime =3D OFFER_TIME) but
dhcp-server.c:set_next_expire_timer() disables all timeouts whenever
there's an offered lease so they're not tracked.

Another option would be to not re-use the l_dhcp_lease pointers in
get_lease(), so when the client requests a lease through DHCP the
other lease would be automatically released and an event emitted.
Even calling l_dhcp_server_release_lease() on it would not interfere
with anything then.

Best regards
--===============5242630114311595668==--

