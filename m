Content-Type: multipart/mixed; boundary="===============3985095947170538587=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 4/7] wsc: Refactor to separate station-specific code
Date: Sat, 14 Dec 2019 02:56:05 +0100
Message-ID: <CAOq732Jes-h7367fGwmvpw4Q+3MgCST_F34coZ3HWfXo+VS=7Q@mail.gmail.com>
In-Reply-To: <6166b743-403e-a0e1-0843-3bd0dc1800ed@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3985095947170538587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 9 Dec 2019 at 19:02, Denis Kenzior <denkenz@gmail.com> wrote:
> On 12/4/19 9:22 PM, Andrew Zaborowski wrote:
> > Split the interface-specific logic out of the core WSC logic.  The core
> > WSC code is the part that we can re-use between P2P and station and
> > doesn't include the scanning for the target BSS or the attempt to make
> > a station mode connection.
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
> > +             wsc->done_cb(0, creds, n_creds, wsc->done_data);
> > +             explicit_bzero(creds, sizeof(creds));
>
> Can you tell me why this temporary creds array is needed?  It would seem
> you can simply call done_cb with wsc->creds directly?

I wanted to allow done_cb to free the wsc state, meaning that we can't
touch wsc->creds after this call and I couldn't come up with a simpler
solution to this.

>
> >               return;
> >       }
> >
> >       switch (result) {
> >       case NETDEV_RESULT_ABORTED:
> > -             dbus_pending_reply(&wsc->pending,
> > -                                     dbus_error_aborted(wsc->pending));
> > +             wsc->done_cb(-ECANCELED, NULL, 0, wsc->done_data);
> >               return;
> >       case NETDEV_RESULT_HANDSHAKE_FAILED:
> > -             dbus_pending_reply(&wsc->pending,
> > -                                     wsc_error_no_credentials(wsc->pen=
ding));
> > +             wsc->done_cb(-ENOKEY, NULL, 0, wsc->done_data);
> >               break;
> >       default:
> > -             dbus_pending_reply(&wsc->pending,
> > -                                     dbus_error_failed(wsc->pending));
> > +             wsc->done_cb(-EIO, NULL, 0, wsc->done_data);
> >               break;
> >       }
> >
> > -     station_set_autoconnect(wsc->station, true);
> > +     if (wsc->station)
> > +             station_set_autoconnect(wsc->station, true);
> >   }
> >
> >   static void wsc_credential_obtained(struct wsc *wsc,
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
> This part seems tricky.  You remove DISPLAY_PIN and use either
> PUSH_BUTTON or KEYPAD below.  This won't really work as the spec
> mandates that the DISPLAY bit is used specially and we sort of depend on
> that to be set.  See Section 7.4.3, item 2.  Without Display bit set we
> can't use 4 digit PINs.  Not that this is a good idea, but still...

Ok, good point...

>
> Also, (a bit fuzzy now, so I might be incorrect here) we might be the
> initiator on a device with no keypad.  So we auto-generate the PIN,
> display it to the user and the user has to enter it into the AP UI.
>
> Generally I find the specs to be rather fuzzy on the use of
> Configuration Methods attribute.  Probe Requests should contain all
> methods we support, and seemingly M1 messages should as well.
>
> I think you probably want to use the DPID as the selector here instead.

Or perhaps wsc->pin?  I understand setting config_method to KEYPAD in
wsc_check_can_connect is slightly wrong because we could be using the
DISPLAY_PIN method but so is setting DPID to User-defined since it
implies keypad.

And apparently it's safe to have all three methods set in M1 so
perhaps I should just leave this piece of code as it was.

Best regards
--===============3985095947170538587==--

