Content-Type: multipart/mixed; boundary="===============3427745412459539844=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/4] wsc: Refactor to make the DBus interface reusable
Date: Wed, 08 Jan 2020 13:42:03 +0100
Message-ID: <CAOq732+r6Jj1rci_DL3uus2GnvW_D7UFGHPwSmBhkBZYOMV3bw@mail.gmail.com>
In-Reply-To: <801f0705-a12d-fe74-cc84-4b3d30f2257e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3427745412459539844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 7 Jan 2020 at 17:54, Denis Kenzior <denkenz@gmail.com> wrote:
> On 1/6/20 8:55 PM, Andrew Zaborowski wrote:
> > So in the new setup we have parts of wsc.c that are common between the
> > Station mode use case and the external user use case (i.e. P2P), and
> > then we have parts that are relevant to Station mode only.  We sort of
> > have 3 parts:
> >
> > 1. the core part that sets up the EAP method config, starts the
> > connection and receives the credentials.
> > 2. the DBus interface that lives even when we're not doing WSC (also
> > common to both modes now)
> > 3. the Station-specific code which interfaces between 1. and 2. and
> > does the scanning etc., i.e. everything used by @wsc_device_ops
> >
> > wsc_disconnect_cb belongs in 3., while wsc->wsc_association belongs in
> > 2. so wsc_disconnect_cb shouldn't be touching wsc->wsc_association.
>
> Not quite sure I follow.  wsc_disconnect_cb is called when cancel is
> invoked via D-Bus API (or in your proposal it would be invoked via
> wsc_cancel).  wsc->association tracks whether we have a connection
> established for the purposes of EAP-WSC.  Hence if wsc->association is
> true, we have to disconnect it first.  I see these two as inherently link=
ed?

The disconnect is handled at a lower level, by wsc_cancel.
wsc_disconnect_cb doesn't need to do anything related to the internal
protocol state.

The part 1. exposes an API that is used by 3. in wsc.c, or by the
external caller which also supplies a callback like wsc_disconnect_cb.
That callback also can't mess with variables like wsc->wsc_association
(sitting outside wsc.c it has no way anyway).

>
> >> <snip>
> >>
> >>> @@ -525,40 +523,19 @@ static void wsc_connect(struct wsc *wsc)
> >>>    error:
> >>>        handshake_state_free(hs);
> >>>        wsc_connect_cleanup(wsc);
> >>> -     wsc->done_cb(r, NULL, 0, wsc->done_data);
> >>> +     wsc->ops->enrollee_done_cb(r, NULL, 0, wsc->user_data);
> >>>    }
> >>>
> >>> -/* Done callback for when WSC is triggered by DBus methods */
> >>> -static void wsc_dbus_done_cb(int err, struct wsc_credentials_info *c=
reds,
> >>> -                             unsigned int n_creds, void *user_data)
> >>> +static void wsc_connect_set_method(struct wsc *wsc)
> >>>    {
> >>> -     struct wsc *wsc =3D user_data;
> >>> -
> >>> -     l_debug("err=3D%i", err);
> >>> +     const char *pin;
> >>>
> >>> -     switch (err) {
> >>> -     case 0:
> >>> -             break;
> >>> -     case -ECANCELED:
> >>> -             dbus_pending_reply(&wsc->pending,
> >>> -                                     dbus_error_aborted(wsc->pending=
));
> >>> -             return;
> >>> -     case -ENOKEY:
> >>> -             dbus_pending_reply(&wsc->pending,
> >>> -                                     wsc_error_no_credentials(wsc->p=
ending));
> >>> -             return;
> >>> -     case -EBUSY:
> >>> -             dbus_pending_reply(&wsc->pending,
> >>> -                                     dbus_error_busy(wsc->pending));
> >>> -             return;
> >>> -     default:
> >>> -             dbus_pending_reply(&wsc->pending,
> >>> -                                     dbus_error_failed(wsc->pending)=
);
> >>> -             return;
> >>> -     }
> >>> +     if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin"=
))
> >>> +             l_dbus_message_get_arguments(wsc->pending, "s", &pin);
> >>> +     else
> >>> +             pin =3D NULL;
> >>>
> >>> -     wsc_store_credentials(wsc);
> >>> -     wsc_try_credentials(wsc);
> >>> +     wsc_start_enrollee(wsc, wsc->netdev, wsc->target, pin, NULL, 0);
> >>
> >> Is wsc_start_enrollee going to be called from p2p directly or only via
> >> the D-Bus API?
> >
> > So the D-Bus API will call the P2P code (to do GO Negotiation /
> > Provision Discovery etc.) or the station-specific code inside wsc.c
> > (to do the scanning) and they'll both call wsc_start_enrollee when
> > ready.  wsc_connect_set_method is the station-specific code path where
> > this happens.
>
> Okay, but the PIN / PushButton setup is common to both, no?  And it
> seems that would logically belong in the overall D-Bus layer handlers.
> No point passing pin around, especially since you already made the
> change to store it inside the wsc object.

Right, I guess the pin can be set directly when the method is called
and cleared whenever we're replying to the method.

> >>> @@ -1001,20 +955,7 @@ static struct l_dbus_message *wsc_push_button(s=
truct l_dbus *dbus,
> >>>
> >>>        l_debug("");
> >>>
> >>> -     if (wsc->pending)
> >>> -             return dbus_error_busy(message);
> >>> -
> >>
> >> So why would you move this check out into the ops provided operation a=
nd
> >> not keep it here?
> >>
> > ...
> >>> -     wsc->pending =3D l_dbus_message_ref(message);
> >>> -
> >>
> >> Pending tracking should also likely be managed here...
> >>
> > ...
> >>> -     if (wsc->pending)
> >>> -             return dbus_error_busy(message);
> >>
> >> Same comments as above apply here ...
> >
> > For one, in the P2P case, it's not going to have access to the
> > internals of struct wsc, so if P2P replies with success or an error
> > message to the PushButton call, it would need some way to also clear
> > wsc->pending.  That's doable but it seems simpler to leave full
> > control to the actual implementation.  So my idea in this version was
> > that the DBus handlers would be really simple and stateless.
> >
>
> But how would p2p set wsc->pending if it has no access to the wsc
> object?  Or are you duplicating the D-Bus handling code inside p2p?  I
> guess I was under the impression that you'd want to unify the D-Bus bits
> as well.

In this case wsc->pending was only part of 3. (out of the three state
machines in wsc.c I mentioned) and p2p.c had it's own "pending" which
is also used as a flag internally.  I guess it makes sense to change
this to handle the dbus message completely in wsc.c so p2p.c doesn't
have to see the actual messages.

>
> If you want to re-invent this inside p2p, then there's really no need
> for this wsc_ops abstraction.  Just have something like:
>
> struct wsc_dbus_object {
>         bool station;
>         union {
>                 struct wsc_p2p *p2p;
>                 struct wsc *wsc;
>         }
> }

I don't follow.  Our entry points are the DBus method handlers, which
are in wsc.c.  How will the control pass from wsc.c to p2p.c (or to
the station specific CBs) without the wsc_ops?

In terms of the structs in wsc.c, yeah, I was thinking of splitting
the state of 1., 2. and 3. into separate structs, something I didn't
do so they're all together in struct wsc now.

>
> > Also remember that in the P2P case the PushButton method will kick off
> > the connection process but there's a few different steps and WSC is
> > just one of them and might be skipped completely in some scenarios.
> >
>
> Sure, so you'd abstract wsc eap connection behind
> wsc_eap_start_enrollee, wsc_eap_cancel, etc.  This ends up being re-used
> and the rest you can do separate.
>
> >>> @@ -1155,7 +1048,194 @@ static void wsc_free(void *userdata)
> >>>        l_free(wsc);
> >>>    }
> >>>
> >>> -static void wsc_add_interface(struct netdev *netdev)
> >>> +struct wsc *wsc_new(const struct wsc_ops *ops, void *user_data)
> >>> +{
> >>> +     struct l_dbus *dbus =3D dbus_get_bus();
> >>> +     struct wsc *wsc;
> >>> +     const char *path;
> >>> +
> >>> +     wsc =3D l_new(struct wsc, 1);
> >>> +     wsc->ops =3D ops;
> >>> +     wsc->user_data =3D user_data;
> >>
> >> This part seems rather weird
> >
> > Do you mean the whole function? and why?
>
> I really meant the user_data setting.  You pass in user_data to all the
> callbacks, but it is set to NULL in wsc_new.  I think the intent was for
> user_data to be the wsc object itself, but I don't see how that would
> even be accomplished in this setup.  Have you actually tested this patch
> standalone?

I think I did (this was a month ago) ;-)  You're right, the idea is
for the user_data to be the wsc object itself because I didn't split
the state into separate structs.  So in the station mode case
wsc_add_interface calls wsc_new, then overwrites wsc->user_data.

>
> >>> @@ -31,5 +36,17 @@ struct wsc_credentials_info {
> >>>        bool has_passphrase;
> >>>    };
> >>>
> >>> -typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *=
creds,
> >>> -                             unsigned int n_creds, void *user_data);
> >>> +struct wsc_ops {
> >>> +     const char *(*get_path)(void *user_data);
> >>> +     void (*connect)(struct l_dbus_message *message, const char *pin,
> >>> +                     void *user_data);
> >>> +     void (*cancel)(struct l_dbus_message *message, void *user_data);
> >>> +     void (*enrollee_done_cb)(int err, struct wsc_credentials_info *=
creds,
> >>> +                                     unsigned int n_creds, void *use=
r_data);
> >>
> >> So one thing I find very weird about this setup is the fact that you're
> >> mixing operations with a callback in something called 'wsc_ops'.  Can't
> >> your 'connect' operation simply set the callback or perhaps provide the
> >> callback directly to wsc_start_enrollee?
> >
> > It would work equally well, yes.  Maybe I was being lazy, I'll fix this.
> >
> > One argument for keeping all the callbacks in this struct is that they
> > implicitly use the same "user_data" and so we save both the callback
> > parameter to wsc_start_enrollee, the user_data parameter (we often
> > complained about our functions having too many arguments) and 2 fields
> > in struct wsc for storing these two parameters.
>
> Well, so far I only see a single callback being utilized.  So there
> seems to be no need for this just yet?

.connect and .cancel are both being utilized, and .enrollee_done_cb is
also being utilized but at a different level.  There's currently one
user_data for them.

What I meant is that if I move enrollee_done_cb outside of the "ops"
it's going to be part of the wsc instance state and it probably should
have its own user_data so those are 2 new parameters and 2 new
variables.  But it may be worth it anyway.

Best regards
--===============3427745412459539844==--

