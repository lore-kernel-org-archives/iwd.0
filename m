Content-Type: multipart/mixed; boundary="===============3994484236333302481=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] manager: Retry the interface setup if we get an EBUSY
Date: Tue, 28 Jan 2020 00:32:45 +0100
Message-ID: <CAOq732K6iEaVaH6cZze_B9_wfFELAe8aai4k+R_ngXP5VcvkjQ@mail.gmail.com>
In-Reply-To: <1da529da-8d4d-abdc-f796-b59b3b18ee0d@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3994484236333302481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 27 Jan 2020 at 23:17, Denis Kenzior <denkenz@gmail.com> wrote:
> On 1/27/20 8:16 AM, Andrew Zaborowski wrote:
> > Sometimes, at least with brcmfmac, the default interface apparently
> > takes a moment to get created after the NEW_WIPHY event.  We didn't
> > really consider this case in the NEW_WIPHY handler and we've got a race
> > condition.  It fixes the following bug for me:
> > https://bugs.archlinux.org/task/63912 -- tested by removing and
> > re-modprobing the brcmfmac module rather than rebooting.
>
> So it looks like that bug report is really several different issues
> (probably most due to the weirdly behaving brcmfmac driver).
>
> Issue #1: This was seemingly related to atheros drivers not reporting
> NEW_WIPHY at all, yet reporting NEW_INTERFACE.  At least this seemed to
> be the case based on one log I saw.

Yep maybe shouldn't have linked that bug.  In any case that should be
easy to work around but I'm surprised nl80211 doesn't enforce the
consistency of these events.

>
> Issue #2:
> Sep 15 13:21:51 holzi-dell iwd[622]: Error bringing interface 3 up:
> Device or resource busy
>
> This likely happens with UseDefaultInterface=3Dtrue and the weird brcmfmac
> not being ready when it signals that the interface is available.  So we
> might need to run a retry loop inside src/netdev.c
> netdev_initial_up_cb() to take care of this.
>
> I somehow doubt brcmfmac sends any notifications that the firmware is no
> longer 'busy', but an iwmon trace might prove otherwise.

I haven't seen this on my brcmfmac hardware so far.

>
> Issue #3 looks like:
>         - Wiphy dump returning a wiphy with no interfaces
>         - iwd issues a NEW_INTERFACE and gets an EBUSY.
>
> Somewhat related to #3, (lets call this issue #4) is that we don't allow
> for the possibility of the default interfaces being created
> significantly later than the wiphy object itself.  Thus if a new wiphy
> is detected, but interface dump comes back empty, we ignore any
> subsequent new_interface events.

So this seems to be a mostly legitimate scenario and #4 is our bug
that I'm trying to work around here.

>  Note that mac80211 always sees to
> register both right away, so this doesn't manifest itself on most hw...
>
> >
> > To work around this wait for the NEW_INTERFACE event and then retry the
> > dump if we'd received an EBUSY on the first NEW_INTERFACE command
> > attempt.  We still do the initial attempt directly after NEW_WIPHY.
> > Alternatively we could assume a default interface is always going to be
> > created on a new wiphy (i.e. if it's not a pre-existing wiphy).
>
> So honestly I wonder if we should even add this code instead of simply
> blacklisting brcmfmac as incapable of interface removal anyway.  Then we
> don't have Issue #3 to contend with, but still have issue #4.

Right, since we have bug #4 blacklisting brcmfmac won't change
anything but feel free to do it, it won't break anything until
brcmfmac is significantly improved.

>
> > ---
> > This is a bit of an RFC, there may be better ways to handle this.  We
> > might also want to add a timeout for the NEW_INTERFACE event just in
> > case.
> > ---
> >   src/manager.c | 104 ++++++++++++++++++++++++++++++++++----------------
> >   1 file changed, 71 insertions(+), 33 deletions(-)
> >
> > diff --git a/src/manager.c b/src/manager.c
> > index a89bfc57..39264c43 100644
> > --- a/src/manager.c
> > +++ b/src/manager.c
> > @@ -54,6 +54,7 @@ struct wiphy_setup_state {
> >       struct wiphy *wiphy;
> >       unsigned int pending_cmd_count;
> >       bool aborted;
> > +     bool retry;
> >
> >       /*
> >        * Data we may need if the driver does not seem to support interf=
ace
> > @@ -127,15 +128,29 @@ static void manager_new_interface_cb(struct l_gen=
l_msg *msg, void *user_data)
> >       struct wiphy_setup_state *state =3D user_data;
> >       uint8_t addr_buf[6];
> >       uint8_t *addr =3D NULL;
> > +     int error;
> >
> >       l_debug("");
> >
> >       if (state->aborted)
> >               return;
> >
> > -     if (l_genl_msg_get_error(msg) < 0) {
> > +     error =3D l_genl_msg_get_error(msg);
> > +     if (error < 0) {
> >               l_error("NEW_INTERFACE failed: %s",
> >                       strerror(-l_genl_msg_get_error(msg)));
> > +
> > +             /*
> > +              * If we receive an EBUSY most likely the wiphy is still
> > +              * initilising, the default interface has not been created
> > +              * yet and the wiphy needs some time.  Retry when we
> > +              * receive a NEW_INTERFACE event.
> > +              */
> > +             if (error =3D=3D -EBUSY) {
> > +                     state->retry =3D true;
> > +                     return;
> > +             }
> > +
> >               /*
> >                * Nothing we can do to use this wiphy since by now we
> >                * will have successfully deleted any default interface
> > @@ -158,7 +173,9 @@ static void manager_new_interface_done(void *user_d=
ata)
> >       struct wiphy_setup_state *state =3D user_data;
> >
> >       state->pending_cmd_count--;
> > -     wiphy_setup_state_destroy(state);
> > +
> > +     if (!state->pending_cmd_count && !state->retry)
> > +             wiphy_setup_state_destroy(state);
> >   }
> >
> >   static void manager_create_interfaces(struct wiphy_setup_state *state)
> > @@ -229,7 +246,7 @@ static void manager_setup_cmd_done(void *user_data)
> >
> >       manager_create_interfaces(state);
> >
> > -     if (!state->pending_cmd_count)
> > +     if (!state->pending_cmd_count && !state->retry)
> >               wiphy_setup_state_destroy(state);
> >   }
> >
> > @@ -476,13 +493,13 @@ static bool manager_check_create_interfaces(void =
*data, void *user_data)
> >
> >       wiphy_create_complete(state->wiphy);
> >
> > -     if (state->pending_cmd_count)
> > +     if (state->pending_cmd_count || state->retry)
> >               return false;
> >
> >       /* If we are here, then there are no interfaces for this phy */
> >       manager_create_interfaces(state);
> >
> > -     if (state->pending_cmd_count)
> > +     if (state->pending_cmd_count || state->retry)
> >               return false;
> >
> >       wiphy_setup_state_free(state);
> > @@ -495,6 +512,38 @@ static void manager_interface_dump_done(void *user=
_data)
> >                               manager_check_create_interfaces, NULL);
> >   }
> >
> > +static bool manager_interface_dump_per_wiphy(uint32_t wiphy_id)
> > +{
> > +     unsigned int iface_cmd_id;
> > +     struct l_genl_msg *msg;
> > +
> > +     /*
> > +      * As the first step after new wiphy is detected we will query
> > +      * the initial interface setup, delete the default interfaces
> > +      * and create interfaces for our own use with NL80211_ATTR_SOCKET=
_OWNER
> > +      * on them.  After that if new interfaces are created outside of
> > +      * IWD, or removed outside of IWD, we don't touch them and will
> > +      * try to minimally adapt to handle the removals correctly.  It's
> > +      * a very unlikely situation in any case but it wouldn't make
> > +      * sense to try to continually enforce our setup fighting against
> > +      * some other process, and it wouldn't make sense to try to
> > +      * manage and use additional interfaces beyond the one or two
> > +      * we need for our operations.
> > +      */
> > +     msg =3D l_genl_msg_new(NL80211_CMD_GET_INTERFACE);
> > +     l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy_id);
> > +
> > +     iface_cmd_id =3D l_genl_family_dump(nl80211, msg,
> > +                                     manager_interface_dump_callback,
> > +                                     NULL, manager_interface_dump_done=
);
> > +     if (iface_cmd_id)
> > +             return true;
> > +
> > +     l_error("Could not dump interface for wiphy %u", wiphy_id);
> > +     l_genl_msg_unref(msg);
> > +     return false;
> > +}
> > +
> >   static void manager_wiphy_dump_callback(struct l_genl_msg *msg, void =
*user_data)
> >   {
> >       l_debug("");
> > @@ -505,7 +554,6 @@ static void manager_wiphy_dump_callback(struct l_ge=
nl_msg *msg, void *user_data)
> >   static void manager_new_wiphy_event(struct l_genl_msg *msg)
> >   {
> >       unsigned int wiphy_cmd_id;
> > -     unsigned int iface_cmd_id;
> >       uint32_t wiphy_id;
> >
> >       if (!pending_wiphys)
> > @@ -530,37 +578,15 @@ static void manager_new_wiphy_event(struct l_genl=
_msg *msg)
> >               return;
> >       }
> >
> > -     /*
> > -      * As the first step after new wiphy is detected we will query
> > -      * the initial interface setup, delete the default interfaces
> > -      * and create interfaces for our own use with NL80211_ATTR_SOCKET=
_OWNER
> > -      * on them.  After that if new interfaces are created outside of
> > -      * IWD, or removed outside of IWD, we don't touch them and will
> > -      * try to minimally adapt to handle the removals correctly.  It's
> > -      * a very unlikely situation in any case but it wouldn't make
> > -      * sense to try to continually enforce our setup fighting against
> > -      * some other process, and it wouldn't make sense to try to
> > -      * manage and use additional interfaces beyond the one or two
> > -      * we need for our operations.
> > -      */
> > -     msg =3D l_genl_msg_new(NL80211_CMD_GET_INTERFACE);
> > -     l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy_id);
> > -
> > -     iface_cmd_id =3D l_genl_family_dump(nl80211, msg,
> > -                                     manager_interface_dump_callback,
> > -                                     NULL, manager_interface_dump_done=
);
> > -
> > -     if (!iface_cmd_id) {
> > -             l_error("Could not dump interface for wiphy %u", wiphy_id=
);
> > +     if (!manager_interface_dump_per_wiphy(wiphy_id))
> >               l_genl_family_cancel(nl80211, wiphy_cmd_id);
> > -             l_genl_msg_unref(msg);
> > -     }
> >   }
> >
> >   static void manager_config_notify(struct l_genl_msg *msg, void *user_=
data)
> >   {
> >       uint8_t cmd;
> >       struct netdev *netdev;
> > +     struct wiphy_setup_state *state;
> >
> >       cmd =3D l_genl_msg_get_command(msg);
> >
> > @@ -578,11 +604,23 @@ static void manager_config_notify(struct l_genl_m=
sg *msg, void *user_data)
> >
> >       case NL80211_CMD_NEW_INTERFACE:
> >               /*
> > -              * TODO: Until NEW_WIPHY contains all required informatio=
n we
> > +              * Until NEW_WIPHY contains all required information we
> >                * are stuck always having to do a full dump. This specif=
ic
> > -              * interface must also be dumped, and this is taken care =
of
> > -              * in manager_new_wiphy_event.
> > +              * interface must also be dumped, and normally this is ta=
ken
> > +              * care of in manager_new_wiphy_event and we do nothing h=
ere.
> > +              * But check if we've already queried this wiphy and it w=
as
> > +              * still initialising, in that case retry the dump now.
> >                */
> > +
> > +             state =3D manager_find_pending(manager_parse_wiphy_id(msg=
));
> > +
> > +             if (state && state->retry) {
> > +                     l_debug("Retrying setup of wiphy %u", state->id);
> > +
> > +                     if (manager_interface_dump_per_wiphy(state->id))
> > +                             state->retry =3D false;
>
> Okay, so strictly speaking we probably don't need to issue a dump of the
> interfaces.  It is only the wiphy dump that contains info that a
> NEW_WIPHY event doesn't contain.  Interface dumps and NEW_INTERFACE
> events are equivalent.
>
> Also, we can probably safely assume that this is a new wiphy just
> plugged in or initialized, and it will create at most a single default
> interface.

You mean once we've checked state->retry is true we can safely assume
it's a new wiphy, right?  Then we could try deleting it, if that
succeeds, creating our own interface and if not, setting use_default.
But...

>  So an interface dump is pretty useless anyhow.

Right, but it's easier for us to use the same code path as with the
initial interface dump.  It's a workaround for a specific issue on
boot so I'm not sure the overhead is more important than easier to
read code.

Best regards
--===============3994484236333302481==--

