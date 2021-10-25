Content-Type: multipart/mixed; boundary="===============7160034780713989914=="
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael at amarulasolutions.com>
To: iwd at lists.01.org
Subject: Re: [RFC PATCH V2] ap: Expose connected stations property
Date: Mon, 25 Oct 2021 20:59:39 +0200
Message-ID: <CAOf5uwnLSk9BaCJjEhj9=h8f3awNKOutvDvoPcGkErbDKeKKsw@mail.gmail.com>
In-Reply-To: f1469c75-9918-6b4d-30ed-c8fc59ae972f@gmail.com

--===============7160034780713989914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Oct 25, 2021 at 8:45 PM Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
> On 10/24/21 4:15 AM, Michael Trimarchi wrote:
> > Add a way to be notified about the connected stations in access
> > point mode. This can be used in order to ask from Diagnostic
> > interface the properties for each station or to just use them
> > from other services like connman or network manager to report
> > the number of clients
>
> So do you want the actual number of clients or a way to know when the cli=
ent
> list has changed?  If it is the latter, then a signal might be better.
>
> Also, you should document the new property in doc/access-point-api.txt in=
 a
> separate patch.

I'm thinking even about:

StaAuthorized ( s : mac )

A new station has been authorized to the interface.

Arguments

s : mac A mac address which has been authorized.

StaDeauthorized ( s : mac )

A station has been deauthorized to the interface.

Arguments

s : mac A mac address which has been deauthorized.

This will be then compatible on what we have in wpa_supplicant.

I will address all your comments. Do you like more this approach?

Michael

>
> >
> > Signed-off-by: Michael Trimarchi <michael(a)amarulasolutions.com>
>
> We don't use S-o-B in ell/iwd.
>
> > ---
> > Changes V1->V2:
> >       typo in message dbus type
> > ---
> >   src/ap.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/src/ap.c b/src/ap.c
> > index 46a7a6a8..e88be99c 100644
> > --- a/src/ap.c
> > +++ b/src/ap.c
> > @@ -98,6 +98,7 @@ struct ap_state {
> >       uint8_t netconfig_gateway4_mac[6];
> >       uint8_t netconfig_dns4_mac[6];
> >
> > +     uint16_t connected_stations;
>
> num_connected_stations?
>
> >       bool started : 1;
> >       bool gtk_set : 1;
> >       bool netconfig_set_addr4 : 1;
> > @@ -347,6 +348,7 @@ static void ap_new_rsna(struct sta_state *sta)
> >               event_data.assoc_ies_len =3D sta->assoc_ies_len;
> >               ap->ops->handle_event(AP_EVENT_STATION_ADDED, &event_data,
> >                                       ap->user_data);
> > +             ap->connected_stations++;
> >       }
> >   }
> >
> > @@ -385,6 +387,7 @@ static void ap_drop_rsna(struct sta_state *sta)
> >               event_data.mac =3D sta->addr;
> >               ap->ops->handle_event(AP_EVENT_STATION_REMOVED, &event_da=
ta,
> >                                       ap->user_data);
> > +             ap->connected_stations++;
>
> do you mean ap->connected_stations-- here?
>
> >       }
> >   }
> >
> > @@ -3495,6 +3498,10 @@ static void ap_if_event_func(enum ap_event_type =
type, const void *event_data,
> >
> >       case AP_EVENT_STATION_ADDED:
> >       case AP_EVENT_STATION_REMOVED:
> > +             l_dbus_property_changed(dbus_get_bus(),
> > +                                     netdev_get_path(ap_if->netdev),
> > +                                     IWD_AP_INTERFACE, "ConnectedStati=
ons");
> > +             break;
> >       case AP_EVENT_REGISTRATION_START:
> >       case AP_EVENT_REGISTRATION_SUCCESS:
> >       case AP_EVENT_PBC_MODE_EXIT:
> > @@ -3626,6 +3633,19 @@ error:
> >       return dbus_error_from_errno(err, message);
> >   }
> >
> > +static bool ap_dbus_property_connected_stations(struct l_dbus *dbus,
> > +                                             struct l_dbus_message *me=
ssage,
> > +                                             struct l_dbus_message_bui=
lder *builder,
> > +                                             void *user_data)
> > +{
> > +     struct ap_if_data *ap_if =3D user_data;
> > +     uint16_t stations =3D ap_if->ap ? ap_if->ap->connected_stations :=
 0;
>
> You could simply omit this property if the AP isn't started by returning =
false.
>
> > +
> > +     l_dbus_message_builder_append_basic(builder, 'q', &stations);
> > +
> > +     return true;
> > +}
> > +
> >   static bool ap_dbus_property_get_started(struct l_dbus *dbus,
> >                                       struct l_dbus_message *message,
> >                                       struct l_dbus_message_builder *bu=
ilder,
> > @@ -3668,6 +3688,9 @@ static void ap_setup_interface(struct l_dbus_inte=
rface *interface)
> >                                       ap_dbus_property_get_started, NUL=
L);
> >       l_dbus_interface_property(interface, "Name", 0, "s",
> >                                       ap_dbus_property_get_name, NULL);
> > +
> > +     l_dbus_interface_property(interface, "ConnectedStations", 0, "q",
>
> Just curious, why was uint16_t chosen as the return type?
>
> > +                                     ap_dbus_property_connected_statio=
ns, NULL);
> >   }
> >
> >   static void ap_destroy_interface(void *user_data)
> >
>
> Regards,
> -Denis



-- =

Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael(a)amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info(a)amarulasolutions.com
www.amarulasolutions.com
--===============7160034780713989914==--

