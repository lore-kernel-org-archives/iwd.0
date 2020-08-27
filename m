Content-Type: multipart/mixed; boundary="===============7029224098851946473=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 08/11] ap: Push Button mode API and beacon changes
Date: Thu, 27 Aug 2020 22:57:52 +0200
Message-ID: <CAOq732+4_ExBB1xNxvMq6=5Sa8hRcj7+ttvCNnAXjV_wgVsPUw@mail.gmail.com>
In-Reply-To: <1c918a34-562e-06b7-1716-5ba8ab47503e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7029224098851946473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 21:50, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> > @@ -29,6 +29,9 @@ enum ap_event_type {
> >       AP_EVENT_STOPPING,
> >       AP_EVENT_STATION_ADDED,
> >       AP_EVENT_STATION_REMOVED,
> > +     AP_EVENT_REGISTRATION_START,
> > +     AP_EVENT_REGISTRATION_SUCCESS,
>
> These two are not used in this patch, but ok..
>
> > +     AP_EVENT_PBC_MODE_EXIT,
> >   };
> >
> >   struct ap_event_station_added_data {
> > @@ -41,6 +44,14 @@ struct ap_event_station_removed_data {
> >       enum mmpdu_reason_code reason;
> >   };
> >
> > +struct ap_event_registration_started_data {
> > +     const uint8_t *mac;
> > +};
> > +
> > +struct ap_event_registration_success_data {
> > +     const uint8_t *mac;
> > +};
> > +
>
> As above

Right, I thought it would be easier to see the idea with the API
defined in one patch.

>
> >   typedef void (*ap_event_func_t)(enum ap_event_type type, const void *=
event_data,
> >                               void *user_data);
> >   typedef void (*ap_stopped_func_t)(void *user_data);
> > @@ -51,6 +62,8 @@ struct ap_config {
> >       uint8_t channel;
> >       uint8_t *authorized_macs;
> >       unsigned int authorized_macs_num;
> > +     char *wsc_name;
> > +     struct wsc_primary_device_type wsc_primary_device_type;
> >       bool no_cck_rates : 1;
> >   };
> >
> > @@ -64,3 +77,5 @@ void ap_free(struct ap_state *ap);
> >
> >   bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
> >                               enum mmpdu_reason_code reason);
> > +
> > +bool ap_push_button(struct ap_state *ap);
> >
>
> So correct me if I'm wrong, but the intent here seems to be:
>
> Have P2P-GO start AP in PBC mode by setting authorized_macs to whatever, =
then
> run ap_push_button().  Then the AP has to be shut down and restarted (or =
maybe
> not?)  But regardless, it seems that PBC cannot be restarted with AP runn=
ing
> after the previous PBC transaction has finished.
>
> This seems like an unnecessary limitation.  Why not implement PBC (and in=
 the
> future PIN) as a transitory state instead?  This way we could have our AP=
 (non
> P2P-GO) mode support push buttons / PINs almost for free...

So the idea was that this function corresponds to a physical button
press, i.e. whenever the AP UI senses button press it calls this, and
perhaps lights up the "WPS" LED until it receives
AP_EVENT_PBC_MODE_EXIT.

So in P2P we'd first wait for the AP_EVENT_STARTED event, call this,
and from there we should receive REGISTRATION_START -> PBC_MODE_EXIT
-> REGISTRATION_SUCCESS -> STATION_ADDED without doing much, except
perhaps restarting a timeout on each step.  The PBC mode doesn't
preclude an RSN connection or multiple connections from different
STAs, so the client can reassociate and do the 4-Way handshake as soon
as it receives the credentials.

>
> So something like:
>
> ap_push_button(struct ap_state *ap, struct wsc_config *wsc);

What information would go in wsc_config?

Best regards
--===============7029224098851946473==--

