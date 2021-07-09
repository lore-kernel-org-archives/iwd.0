Content-Type: multipart/mixed; boundary="===============6870492773749046950=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] ap: Implement P2P GO-side 4-way handshake IP
 Allocation
Date: Fri, 09 Jul 2021 19:37:11 +0200
Message-ID: <CAOq732LuhUpE3bAgh+=q4do3oAaeb5gQyyH2TkeHTBAZKhiJJw@mail.gmail.com>
In-Reply-To: <3597a161-070e-3204-8072-6d6de195db0d@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6870492773749046950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 9 Jul 2021 at 17:40, Denis Kenzior <denkenz@gmail.com> wrote:
> On 7/9/21 6:49 AM, Andrew Zaborowski wrote:
> > @@ -177,6 +178,10 @@ static void ap_sta_free(void *data)
> >       if (sta->gtk_query_cmd_id)
> >               l_genl_family_cancel(ap->nl80211, sta->gtk_query_cmd_id);
> >
> > +     if (sta->ip_alloc_lease)
> > +             l_dhcp_server_release_lease(ap->netconfig_dhcp,
> > +                                             sta->ip_alloc_lease);
> > +
>
> Why are we tracking the lease past the handshake phase?  It seems a little
> asymmetric since we're not tracking the lease obtained from the 'other' p=
ath
> (i.e. normal DHCP request)

The idea was to use the same lease object for new associations but
there's little benefit from this so yeah, for simplicity I'll just
drop the reference after the handshake (if not immediately after use
-- but I think not -- we need to release the lease if the handshake
times out to make DoSing the DHCP server more difficult.)

>
> >       ap_stop_handshake(sta);
> >
> >       l_free(sta);
> > @@ -830,6 +835,12 @@ static uint32_t ap_send_mgmt_frame(struct ap_state=
 *ap,
> >                                       callback, user_data, NULL, NULL);
> >   }
> >
> > +#define IP4_FROM_STR(str)                                            \
> > +     (__extension__ ({                                               \
> > +             struct in_addr ia;                                      \
> > +             inet_pton(AF_INET, str, &ia) =3D=3D 1 ? ntohl(ia.s_addr) =
: 0; \
>
> Why the ntohl?  Why is handshake_state storing those parameters in host o=
rder
> anyway?

I guess at this point it's just because why not.  We can use either
order.  I still think it would be good to use a typedef if we want to
store a network byte-order value, like struct in_addr uses in_addr_t.

>
> > +     }))
> > +
> >   static void ap_start_handshake(struct sta_state *sta, bool use_eapol_=
start,
> >                               const uint8_t *gtk_rsc)
> >   {
> > @@ -854,6 +865,34 @@ static void ap_start_handshake(struct sta_state *s=
ta, bool use_eapol_start,
> >               handshake_state_set_gtk(sta->hs, sta->ap->gtk,
> >                                       sta->ap->gtk_index, gtk_rsc);
> >
> > +     if (ap->netconfig_dhcp) {
> > +             L_AUTO_FREE_VAR(char *, lease_addr_str) =3D NULL;
> > +             L_AUTO_FREE_VAR(char *, lease_netmask_str) =3D NULL;
> > +             char own_addr_str[INET_ADDRSTRLEN];
> > +
> > +             if (!sta->ip_alloc_lease)
> > +                     sta->ip_alloc_lease =3D l_dhcp_server_new_lease(
> > +                                                     ap->netconfig_dhc=
p,
> > +                                                     sta->addr);
> > +
> > +             if (!sta->ip_alloc_lease) {
> > +                     l_error("l_dhcp_server_new_lease failed, see "
> > +                             "IWD_DHCP_DEBUG output");
> > +                     ap_stop_handshake(sta);
>
> Really?  Can't we just go on without sending the IP Alloc KDE?

This is basically an L_WARN for an internal error but I can try to
handle it anyway.

>
> > +                     goto error;
> > +             }
> > +
> > +             lease_addr_str =3D l_dhcp_lease_get_address(sta->ip_alloc=
_lease);
> > +             lease_netmask_str =3D
> > +                     l_dhcp_lease_get_netmask(sta->ip_alloc_lease);
> > +             l_rtnl_address_get_address(ap->netconfig_addr4, own_addr_=
str);
> > +
> > +             sta->hs->support_ip_allocation =3D true;
> > +             sta->hs->client_ip_addr =3D IP4_FROM_STR(lease_addr_str);
> > +             sta->hs->subnet_mask =3D IP4_FROM_STR(lease_netmask_str);
> > +             sta->hs->go_ip_addr =3D IP4_FROM_STR(own_addr_str);
> > +     }
> > +
> >       sta->sm =3D eapol_sm_new(sta->hs);
> >       if (!sta->sm) {
> >               ap_stop_handshake(sta);
> > @@ -877,12 +916,18 @@ static void ap_handshake_event(struct handshake_s=
tate *hs,
> >               enum handshake_event event, void *user_data, ...)
> >   {
> >       struct sta_state *sta =3D user_data;
> > +     struct ap_state *ap =3D sta->ap;
> >       va_list args;
> >
> >       va_start(args, user_data);
> >
> >       switch (event) {
> >       case HANDSHAKE_EVENT_COMPLETE:
> > +             if (sta->ip_alloc_lease && !sta->hs->support_ip_allocatio=
n)
> > +                     /* Client sent no IP Address Request */
> > +                     l_dhcp_server_release_lease(ap->netconfig_dhcp,
> > +                                     l_steal_ptr(sta->ip_alloc_lease));
> > +
>
> I'm not sure about this part.  Is there any harm in just leaving the leas=
e be?
> Shouldn't l_dhcp_server just select the same lease if the client tries
> re-running DHCP?

Yeah, I think it would re-use the memory (after memzeroing it) and the
IP.  Ideally we shouldn't assume this about the DHCP implementation,
is there any reason to not release the lease here?

> You could also try to mess with the lease timeout in case
> you're worried about clients connecting and not running DHCP...

Thinking about this there may also be future UIs that will display
active/expired DHCP leases like a lot of APs do.  Ideally the lease
list would really reflect the leases requested/acked.

Speaking of this I wonder if instead of relying on only the lease
timeouts for AP clients that have disassociated, instead ap.c should
notify the l_dhcp_server to automatically move the client's lease to
the expired list.  If the client reconnects before the IP pool becomes
full it can still re-use the lease, assuming it's using a permanent
BSSID.  I wonder if automatic reconnects by clients that randomize
BSSIDs could dry out to the IP pool too quickly.

>
> >               ap_new_rsna(sta);
> >               break;
> >       case HANDSHAKE_EVENT_FAILED:
>
> What do you do with the lease in the failure case?

We end up freeing it in ap_sta_free().

>
> > @@ -2044,6 +2089,14 @@ static void ap_start_failed(struct ap_state *ap,=
 int err)
> >       l_free(ap);
> >   }
> >
> > +static void ap_sta_lease_expired(void *data, void *user_data)
> > +{
> > +     struct sta_state *sta =3D data;
> > +
> > +     if (sta->ip_alloc_lease =3D=3D user_data)
> > +             sta->ip_alloc_lease =3D NULL;
> > +}
> > +
> >   static void ap_dhcp_event_cb(struct l_dhcp_server *server,
> >                               enum l_dhcp_server_event event, void *use=
r_data,
> >                               const struct l_dhcp_lease *lease)
> > @@ -2057,6 +2110,9 @@ static void ap_dhcp_event_cb(struct l_dhcp_server=
 *server,
> >               break;
> >
> >       case L_DHCP_SERVER_EVENT_LEASE_EXPIRED:
> > +             l_queue_foreach(ap->sta_states, ap_sta_lease_expired,
> > +                             (void *) lease);
> > +
>
> If you're not tracking leases past handshake time, then this part would b=
e unneeded?

Yep, then I guess we can skip this but we might as well keep it to
avoid future surprises.

Best regards
--===============6870492773749046950==--

