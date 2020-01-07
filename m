Content-Type: multipart/mixed; boundary="===============1949924312597452411=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/4] wsc: Refactor to separate station-specific code
Date: Tue, 07 Jan 2020 01:51:38 +0100
Message-ID: <CAOq732LTqSnbOpdkH+6cZAQ2CCbQzd2otG7W6eiwBK0-_BDxpw@mail.gmail.com>
In-Reply-To: <a8a79c2b-6f1f-f0bb-5647-fe6ebc13ceda@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1949924312597452411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 6 Jan 2020 at 18:55, Denis Kenzior <denkenz@gmail.com> wrote:
> On 12/18/19 9:50 PM, Andrew Zaborowski wrote:
> > Split the interface-specific logic from the core WSC logic.  The core
> > WSC code is the part that we can re-use between P2P and station and
> > doesn't include the D-Bus code, scanning for the target BSS or the
> > attempt to make a station mode connection.
> > ---
> >   src/wsc.c | 141 ++++++++++++++++++++++++++++++++++++++----------------
> >   src/wsc.h |   3 ++
> >   2 files changed, 103 insertions(+), 41 deletions(-)
> >
>
> <snip>
>
> > @@ -224,33 +242,34 @@ static void wsc_connect_cb(struct netdev *netdev,=
 enum netdev_result result,
> >
> >       l_debug("%d, result: %d", netdev_get_ifindex(wsc->netdev), result=
);
> >
> > -     wsc->wsc_association =3D false;
> > -
> > -     l_settings_free(wsc->eap_settings);
> > -     wsc->eap_settings =3D NULL;
> > +     wsc_connect_cleanup(wsc);
> >
> >       if (result =3D=3D NETDEV_RESULT_HANDSHAKE_FAILED && wsc->n_creds =
> 0) {
> > -             wsc_store_credentials(wsc);
> > -             wsc_try_credentials(wsc);
> > +             struct wsc_credentials_info creds[L_ARRAY_SIZE(wsc->creds=
)];
> > +             uint32_t n_creds =3D wsc->n_creds;
> > +
> > +             memcpy(creds, wsc->creds, sizeof(creds));
> > +             explicit_bzero(wsc->creds, sizeof(creds));
> > +             wsc->n_creds =3D 0;
>
> I added a comment here based on your response to my previous question
> about this.  Please check to see that I got the gist of it correctly.

Ok, good idea.  The reason was basically that done_cb should be able
to free @wsc (and it would in my earlier p2p implementation), but we
needed to wipe the creds before freeing the memory so my only option
was to always wipe it.

> > +             wsc->done_cb(0, creds, n_creds, wsc->done_data);
> > +             explicit_bzero(creds, sizeof(creds));
> >               return;
> >       }
> >
>
> <snip>
>
> > @@ -452,30 +471,24 @@ static void wsc_connect(struct wsc *wsc)
> >       l_settings_set_uint(settings, "WSC", "RFBand",
> >                                       freq_to_rf_band(bss->frequency));
> >       l_settings_set_uint(settings, "WSC", "ConfigurationMethods",
> > -                             WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_=
PIN |
> > -                             WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUT=
TON |
> > -                             WSC_CONFIGURATION_METHOD_KEYPAD);
> > +                                     wsc->config_method);
>
> I squashed this for now.  I don't think it is actually correct and I
> brought this up previously.  ConfigurationMethods are supposed to be all
> the methods we support, not the selected one...  Why this is useful
> inside the EAP-WSC protocol is unclear, but that seems to be what the
> spec wants...

Oops, I think you brought this up twice actually and I definitely
looked at the spec and dropped this change.  So I don't know how it
made it into the last iteration of this patch.

Best regards
--===============1949924312597452411==--

