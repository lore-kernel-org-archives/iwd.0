Content-Type: multipart/mixed; boundary="===============1271454938187494791=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 06/17] p2p: Add device enable/disable logic
Date: Sat, 25 Apr 2020 10:45:08 +0200
Message-ID: <CAOq732+QxYxMsuiGZ+N3a1fDHQNNKOWxCESCrBDFWEUGmvzR0A@mail.gmail.com>
In-Reply-To: <e2eebf0a-21ef-fe32-0f59-0fdeea4b47b2@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1271454938187494791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
I forgot to reply to this email.

On Fri, 17 Apr 2020 at 18:41, Denis Kenzior <denkenz@gmail.com> wrote:
> On 4/3/20 11:14 AM, Andrew Zaborowski wrote:
> > Implement the Enabled property on device interface.  The P2P device is
> > currently disabled on startup but automatically enabling the P2P device
> > can be considered.
> > ---
> >   src/p2p.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 136 insertions(+)
> >
> > diff --git a/src/p2p.c b/src/p2p.c
> > index ab21239d..fa8e0e55 100644
> > --- a/src/p2p.c
> > +++ b/src/p2p.c
> > @@ -58,13 +58,19 @@
> >   struct p2p_device {
> >       uint64_t wdev_id;
> >       uint8_t addr[6];
> > +     struct l_genl_family *nl80211;
> >       struct wiphy *wiphy;
> >       unsigned int connections_left;
> >       struct p2p_capability_attr capability;
> >       struct p2p_device_info_attr device_info;
> > +     uint32_t start_stop_cmd_id;
> > +     l_dbus_property_complete_cb_t pending_complete;
> > +     struct l_dbus_message *pending_message;
> >
> >       uint8_t country[3];
> >       struct l_queue *peer_list;
> > +
> > +     bool enabled : 1;
> >   };
> >
> >   struct p2p_peer {
> > @@ -269,6 +275,78 @@ static void p2p_peer_put(void *user_data)
> >       p2p_peer_free(peer);
> >   }
> >
> > +static void p2p_device_enable_cb(struct l_genl_msg *msg, void *user_da=
ta)
> > +{
> > +     struct p2p_device *dev =3D user_data;
> > +     int error =3D l_genl_msg_get_error(msg);
> > +     struct l_dbus_message *message =3D dev->pending_message;
> > +
> > +     l_debug("START/STOP_P2P_DEVICE: %s (%i)", strerror(-error), -erro=
r);
> > +
> > +     if (error)
> > +             goto done;
> > +
> > +     dev->enabled =3D !dev->enabled;
> > +
> > +     if (!message)
> > +             l_dbus_property_changed(dbus_get_bus(),
> > +                                     p2p_device_get_path(dev),
> > +                                     IWD_P2P_INTERFACE, "Enabled");
>
> Whats this doing?  Shouldn't the property always be emitted?

Yeah, I'm not sure how this was supposed to work.

>
> > +
> > +done:
> > +     if (message) {
> > +             dev->pending_complete(dbus_get_bus(), message,
> > +                                     error ? dbus_error_failed(message=
) :
> > +                                     NULL);
> > +             dev->pending_message =3D NULL;
> > +             dev->pending_complete =3D NULL;
> > +     }
>
> What this is doing is also not quite clear?  Are you going to be
> invoking this outside the D-Bus path?

Initially I was automatically enabling P2P when the interface was
created, now I removed the condition here.

>
> > +}
> > +
> > +static void p2p_device_enable_destroy(void *user_data)
> > +{
> > +     struct p2p_device *dev =3D user_data;
> > +
> > +     dev->start_stop_cmd_id =3D 0;
> > +}
> > +
> > +static bool p2p_device_start_stop(struct p2p_device *dev,
> > +                             l_dbus_property_complete_cb_t complete,
> > +                             struct l_dbus_message *message)
> > +{
> > +     struct l_genl_msg *cmd;
> > +
> > +     if (!dev->enabled)
> > +             cmd =3D l_genl_msg_new_sized(NL80211_CMD_START_P2P_DEVICE=
, 16);
> > +     else
> > +             cmd =3D l_genl_msg_new_sized(NL80211_CMD_STOP_P2P_DEVICE,=
 16);
> > +
> > +     l_genl_msg_append_attr(cmd, NL80211_ATTR_WDEV, 8, &dev->wdev_id);
> > +
> > +     dev->start_stop_cmd_id =3D l_genl_family_send(dev->nl80211, cmd,
> > +                                             p2p_device_enable_cb, dev,
> > +                                             p2p_device_enable_destroy=
);
> > +     if (!dev->start_stop_cmd_id) {
> > +             l_genl_msg_unref(cmd);
> > +             complete(dbus_get_bus(), message, dbus_error_failed(messa=
ge));
> > +             return true;
> > +     }
> > +
> > +     dev->pending_message =3D message;
> > +     dev->pending_complete =3D complete;
> > +
> > +     if (dev->enabled) {
> > +             /*
> > +              * Stopping the P2P device, drop all peers as we can't st=
art
> > +              * new connections from now on.
> > +              */
> > +             l_queue_destroy(dev->peer_list, p2p_peer_put);
> > +             dev->peer_list =3D NULL;
> > +     }
> > +
> > +     return true;
> > +}
>
> Note that this function always returns true...

Right, I could have removed the return value when I removed the
automatic enabling of P2P.

>
> > +
> >   struct p2p_device *p2p_device_update_from_genl(struct l_genl_msg *msg,
> >                                               bool create)
> >   {
> > @@ -350,6 +428,7 @@ struct p2p_device *p2p_device_update_from_genl(stru=
ct l_genl_msg *msg,
> >       dev =3D l_new(struct p2p_device, 1);
> >       dev->wdev_id =3D *wdev_id;
> >       memcpy(dev->addr, ifaddr, ETH_ALEN);
> > +     dev->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_N=
AME);
> >       dev->wiphy =3D wiphy;
> >       gethostname(hostname, sizeof(hostname));
> >       dev->connections_left =3D 1;
> > @@ -510,8 +589,23 @@ static void p2p_device_free(void *user_data)
> >   {
> >       struct p2p_device *dev =3D user_data;
> >
> > +     if (dev->pending_message) {
> > +             struct l_dbus_message *reply =3D
> > +                     dbus_error_aborted(dev->pending_message);
> > +
> > +             if (dev->pending_complete)
>
> Can this ever be NULL?  I checked and at least in this series it doesn't
> seem to be the case...

Right.  I think this is from when I was storing the Connect/Disconnect
messages in pending_message.

Best regards
--===============1271454938187494791==--

