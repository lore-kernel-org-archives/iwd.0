Content-Type: multipart/mixed; boundary="===============8189249427263947408=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/9] handshake: Add HANDSHAKE_EVENT_IP_REQUEST
Date: Sat, 14 Aug 2021 05:00:33 +0200
Message-ID: <CAOq732LZAqfz1aO71U_2tUhhFFQjpB+H7VC6XmTbt2LkLuWU_Q@mail.gmail.com>
In-Reply-To: <4bca9b33-128d-1aee-ed25-9c73eb847f80@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8189249427263947408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Aug 2021 at 03:58, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/6/21 9:10 PM, Andrew Zaborowski wrote:
> > Add a handshake event for use by the AP side for mechanisms that
> > allocate client IPs during the handshake: P2P address allocation and
> > FILS address assignment.  This is emitted only when EAPOL or the
> > auth_proto is actually about to send the network configuration data to
> > the client so that ap.c can skip allocating a DHCP leases altogether if
> > the client doesn't send the required KDE or IE.
> > ---
> >   src/eapol.c     | 8 ++++++++
> >   src/handshake.h | 1 +
> >   src/station.c   | 1 +
> >   3 files changed, 10 insertions(+)
> >
> > diff --git a/src/eapol.c b/src/eapol.c
> > index f78bef2f..e2892c0e 100644
> > --- a/src/eapol.c
> > +++ b/src/eapol.c
> > @@ -1350,6 +1350,14 @@ static void eapol_send_ptk_3_of_4(struct eapol_s=
m *sm)
> >               key_data_len +=3D gtk_kde[1] + 2;
> >       }
> >
> > +     if (sm->handshake->support_ip_allocation &&
> > +                     !sm->handshake->client_ip_addr) {
> > +             handshake_event(sm->handshake, HANDSHAKE_EVENT_IP_REQUEST=
);
> > +
> > +             if (!sm->handshake->client_ip_addr)
>
> Isn't this condition already checked above?

The intention was for the handshake_event handler to try to set this,
so this is expected to have changed since then.  But if it's still
NULL then we assume there was some problem with the IP allocation.

>
> > +                     sm->handshake->support_ip_allocation =3D false;
>
> What happens on retransmissions of PTK 3/4?

We'll have either set sm->handshake->client_ip_addr or cleared
sm->handshake->support_ip_allocation so we shouldn't enter this code
block again and the values won't change during the resends.

>
> > +     }
> > +
> >       if (sm->handshake->support_ip_allocation) {
> >               /* Wi-Fi P2P Technical Specification v1.7 Table 59 */
> >               key_data_buf[key_data_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
> > diff --git a/src/handshake.h b/src/handshake.h
> > index a4c54b5a..1bc1b2fa 100644
> > --- a/src/handshake.h
> > +++ b/src/handshake.h
> > @@ -57,6 +57,7 @@ enum handshake_event {
> >       HANDSHAKE_EVENT_REKEY_FAILED,
> >       HANDSHAKE_EVENT_EAP_NOTIFY,
> >       HANDSHAKE_EVENT_TRANSITION_DISABLE,
> > +     HANDSHAKE_EVENT_IP_REQUEST,
>
> Do you want to distinguish between P2P IP request and FILS IP Request?  M=
ight
> make things a bit more explicit ?

I thought the API could be the same for both (granted FILS sends more
bits of data from the lease, but I was thinking eventually we'd store
a whole struct l_dhcp_lease object in the handshake_state, replacing
client_ip_addr, subnet_mask and go_ip_addr).

In reality, on the authenticator side we only create a struct
handshake_state after the association, so this only applies for P2P, I
can put P2P in the event name.

Best regards
--===============8189249427263947408==--

