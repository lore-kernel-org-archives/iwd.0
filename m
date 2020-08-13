Content-Type: multipart/mixed; boundary="===============4832932305914007722=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 06/16] eapol: Basic EAP support in authenticator mode
Date: Fri, 14 Aug 2020 01:47:53 +0200
Message-ID: <CAOq732Lt3sJ0gsqQERBXVF+XeRf2E-2EEE7XU9DyYFjQQtaUEw@mail.gmail.com>
In-Reply-To: <fcba2913-0b5a-fecf-e3ee-f7141f75adba@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4832932305914007722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 13 Aug 2020 at 18:34, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/12/20 7:50 PM, Andrew Zaborowski wrote:
> > Handle EAPoL-EAP frames using our eap.c methods in authenticator mode
> > same as we do on the supplicant side.  The user (ap.c) will only need to
> > set a valid 8021x_settings in the handshake object, same as on the
> > supplicant side.
> > ---
> >   src/eapol.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 72 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/eapol.c b/src/eapol.c
> > index 299de13f..06b8a2f6 100644
> > --- a/src/eapol.c
> > +++ b/src/eapol.c
> > @@ -2067,6 +2067,17 @@ static void eapol_eap_complete_cb(enum eap_resul=
t result, void *user_data)
> >       }
> >
> >       eap_reset(sm->eap);
> > +
> > +     if (sm->handshake->authenticator) {
> > +             if (L_WARN_ON(!sm->handshake->have_pmk))
> > +                     return;
>
> Shouldn't this result in handshake_failed or something?

Probably, although this was intended basically as an assert()

>
> > +
> > +             sm->mic_len =3D eapol_get_mic_length(sm->handshake->akm_s=
uite,
> > +                                             sm->handshake->pmk_len);
> > +
> > +             /* Kick off 4-Way Handshake */
> > +             eapol_ptk_1_of_4_retry(NULL, sm);
> > +     }
> >   }
> >
> >   /* This respresentes the eapResults message */
>
> <snip>
>
> > @@ -2341,16 +2379,46 @@ void eapol_register(struct eapol_sm *sm)
> >                       sm->protocol_version =3D sm->handshake->proto_ver=
sion;
> >
> >               sm->started =3D true;
> > -             /* Since AP/AdHoc only support AKM PSK we can hard code t=
his */
> > -             sm->mic_len =3D 16;
> >
> > -             /* kick off handshake */
> > -             eapol_ptk_1_of_4_retry(NULL, sm);
> > +             if (sm->handshake->settings_8021x) {
> > +                     sm->eap =3D eap_new(eapol_eap_msg_cb,
> > +                                             eapol_eap_complete_cb, sm=
);
> > +                     if (!sm->eap)
> > +                             goto eap_error;
> > +
> > +                     eap_set_key_material_func(sm->eap,
> > +                                                     eapol_eap_results=
_cb);
> > +                     eap_set_event_func(sm->eap, eapol_eap_event_cb);
> > +
> > +                     if (!eap_load_settings(sm->eap,
> > +                                             sm->handshake->settings_8=
021x,
> > +                                             "EAP-")) {
> > +                             eap_free(sm->eap);
> > +                             sm->eap =3D NULL;
> > +                             goto eap_error;
> > +                     }
>
> So this seems to be a copy-paste from eapol_start.  And the fact that the=
re's no
> error returned from this function begs the question...
>
> > +             } else {
> > +                     if (L_WARN_ON(!sm->handshake->have_pmk))
> > +                             return;
> > +
> > +                     sm->mic_len =3D eapol_get_mic_length(
> > +                                             sm->handshake->akm_suite,
> > +                                             sm->handshake->pmk_len);
> > +
> > +                     /* kick off handshake */
> > +                     eapol_ptk_1_of_4_retry(NULL, sm);
> > +             }
> >       } else {
> >               sm->watch_id =3D eapol_frame_watch_add(sm->handshake->ifi=
ndex,
> >                                               eapol_rx_packet, sm);
> >               sm->protocol_version =3D sm->handshake->proto_version;
> >       }
> > +
> > +     return;
> > +
> > +eap_error:
> > +     l_error("Error initializing EAP for ifindex %i",
> > +                     (int) sm->handshake->ifindex);
>
> Is ap.c using the eapol API properly?  From what I recall the intent was =
that
> eapol_sm_register cannot fail and the only thing it does is register the =
eapol
> state machine to receive packets.  This is needed for early packet detect=
ion
> (early_frame handling added due to race conditions in cfg80211)...
>
> It seems that ap.c never needed to use eapol_start.  Perhaps it should?

Agreed. I don't know if there was some reason to avoid reusing
eapol_start when ap.c was converted to use eapol_sm but I'll try if we
can make it work this way and include a patch.

Best regards
--===============4832932305914007722==--

