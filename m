Content-Type: multipart/mixed; boundary="===============8823129299915712460=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Mon, 13 Jan 2020 19:38:05 +0100
Message-ID: <CAOq732+41a2Sshdz1E4s1ZwKMgtMjkkkDucx7rMd6Q_tpNHK9A@mail.gmail.com>
In-Reply-To: <989bd8f8-ffff-4a2b-6946-d0bba591239e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8823129299915712460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis!

On Mon, 13 Jan 2020 at 18:56, Denis Kenzior <denkenz@gmail.com> wrote:
> On 1/13/20 7:32 AM, Andrew Zaborowski wrote:
> > +void wsc_enrollee_cancel(struct wsc_enrollee *wsce)
> > +{
> > +     wsce->done_cb(-ECANCELED, NULL, 0, wsce->done_data);
> > +     wsce->done_cb =3D NULL;
> > +     /* Results in a call to wsc_enrollee_free */
> > +     netdev_disconnect(wsce->netdev, NULL, NULL);
>
> Are you sure you don't want to wait for netdev_disconnect to finish
> prior to signaling the request as aborted & canceled?  In theory this
> could lead to station bouncing against an -EBUSY error once
> station_set_autoconnect is called.

True, with dbus Cancel() this could happen, I'll add the callback.

>
> > +
> > +             /*
> > +              * TODO: Mark this network as known.  We might be getting
> > +              * multiple credentials from WSC, so there is a possibili=
ty
> > +              * that the network is not known and / or not in scan res=
ults.
> > +              * In both cases, the network should be considered for
> > +              * auto-connect.  Note, since we sync the settings, the n=
ext
> > +              * reboot will put the network on the known list.
> > +              */
>
> This TODO comment is now likely stale and can be removed (in a separate
> commit).

Ok.

>
> > +     }
> >   }
> >
> >   /* Done callback for when WSC is triggered by DBus methods */
> > @@ -541,14 +530,22 @@ static void wsc_dbus_done_cb(int err, struct wsc_=
credentials_info *creds,
> >   {
> >       struct wsc *wsc =3D user_data;
> >
> > +     wsc->enrollee =3D NULL;
> > +     wsc->target =3D NULL;
> > +
> >       l_debug("err=3D%i", err);
> >
> > +     if (err && wsc->station)
> > +             station_set_autoconnect(wsc->station, true);
> > +
> >       switch (err) {
> >       case 0:
> >               break;
> >       case -ECANCELED:
> > -             dbus_pending_reply(&wsc->pending,
> > +             if (wsc->pending)
> > +                     dbus_pending_reply(&wsc->pending,
> >                                       dbus_error_aborted(wsc->pending));
>
> Hmm, why the if ()?

In some scenario we're sending a not_available reply so this is a
mechanism to override the specific reply.

>
> Also, if you wait until netdev_disconnect_cb to signal done_cb with
> -ECANCELED, you can reply to both the pending and cancel messages here.

I think it's actually nicer to send the "pending" reply early.  It's
also a nice property that we can use wsc_enrollee_cancel to
immediately forget the done callback, also from P2P point of view
where we're destroying the netdev right after we call this.  So I
think it'll need a separate optional callback.

I wonder if we need to re-check that wsc->station still exists every
time we use it.

>
> > +
> >               return;
> >       case -ENOKEY:
> >               dbus_pending_reply(&wsc->pending,
>
> <snip>
>
> > diff --git a/src/wsc.h b/src/wsc.h
> > index ada08c89..48a3297a 100644
> > --- a/src/wsc.h
> > +++ b/src/wsc.h
> > @@ -31,5 +31,13 @@ struct wsc_credentials_info {
> >       bool has_passphrase;
> >   };
> >
> > +struct wsc_enrollee;
> > +
> >   typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *c=
reds,
> >                               unsigned int n_creds, void *user_data);
> > +
> > +struct wsc_enrollee *wsc_enrollee_new(struct netdev *netdev,
> > +                                     struct scan_bss *target,
> > +                                     const char *pin,
> > +                                     wsc_done_cb_t done_cb, void *user=
_data);
> > +void wsc_enrollee_cancel(struct wsc_enrollee *wsce);
> >
>
> You may still want an explicit wsc_enrollee_free for cases where
> netdev_disconnect shouldn't be used / attempted.

We'd need to be very sure that the netdev is also being freed.  We
mainly use netdev_disconnect to make sure netdev forgets our connect
callbacks, note that station also does this in station_free.

Best regards
--===============8823129299915712460==--

