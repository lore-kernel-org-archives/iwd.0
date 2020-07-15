Content-Type: multipart/mixed; boundary="===============3536251225192525836=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 11/18] p2p: Implement the p2p.ServiceManager interface
Date: Wed, 15 Jul 2020 16:25:14 +0200
Message-ID: <CAOq732Jw-_KworyZmAqtPEGYMUiKtby=6s2kzsCAjt653kqrQg@mail.gmail.com>
In-Reply-To: <e3cee5bf-3d8f-862a-4d71-fc2053399143@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3536251225192525836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 13 Jul 2020 at 21:48, Denis Kenzior <denkenz@gmail.com> wrote:
> On 7/10/20 8:00 PM, Andrew Zaborowski wrote:
> > +static void p2p_svc_mgr_destroy_cb(void *user_data)
>
> Can we name this p2p_service_manager_destroy instead?  The manager -> sho=
rtened
> form conversion is not really natural and leads to many possibilities, mg=
r,
> mngr, etc.  Similar with service -> 'svc', 'srvc', etc  You're only savin=
g a few
> characters, so lets just type these out.

Ok.

>
> > +{
> > +     if (p2p_own_wfd) {
> > +             l_dbus_remove_watch(dbus_get_bus(), p2p_wfd_disconnect_wa=
tch);
> > +             p2p_own_wfd_free();
> > +     }
> > +}
> > +
> >   static int p2p_init(void)
> >   {
> > -     if (!l_dbus_register_interface(dbus_get_bus(),
> > -                                     IWD_P2P_INTERFACE,
> > +     struct l_dbus *dbus =3D dbus_get_bus();
> > +
> > +     if (!l_dbus_register_interface(dbus, IWD_P2P_INTERFACE,
> >                                       p2p_interface_setup,
> >                                       NULL, false))
> >               l_error("Unable to register the %s interface",
> >                       IWD_P2P_INTERFACE);
> >
> > -     if (!l_dbus_register_interface(dbus_get_bus(),
> > -                                     IWD_P2P_PEER_INTERFACE,
> > +     if (!l_dbus_register_interface(dbus, IWD_P2P_PEER_INTERFACE,
> >                                       p2p_peer_interface_setup,
> >                                       NULL, false))
> >               l_error("Unable to register the %s interface",
> > @@ -3573,13 +3842,26 @@ static int p2p_init(void)
> >       p2p_dhcp_settings =3D l_settings_new();
> >       p2p_device_list =3D l_queue_new();
> >
> > +     if (!l_dbus_register_interface(dbus, IWD_P2P_SERVICE_MANAGER_INTE=
RFACE,
> > +                                     p2p_svc_mgr_interface_setup,
> > +                                     p2p_svc_mgr_destroy_cb, false))
> > +             l_error("Unable to register the %s interface",
> > +                     IWD_P2P_SERVICE_MANAGER_INTERFACE);
> > +     else if (!l_dbus_object_add_interface(dbus, IWD_AGENT_MANAGER_PAT=
H,
>
> Hmm, why IWD_AGENT_MANAGER_PATH?

I think I wanted to name these service agents earlier.  I'll add a new defi=
ne.

>
> > +                                     IWD_P2P_SERVICE_MANAGER_INTERFACE,
> > +                                     NULL))
> > +             l_error("Unable to register the P2P Service Manager objec=
t");
> > +
> >       return 0;
> >   }
> >
> >   static void p2p_exit(void)
> >   {
> > -     l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_INTERFACE);
> > -     l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_PEER_INTERFAC=
E);
> > +     struct l_dbus *dbus =3D dbus_get_bus();
>
> Also, do you need a corresponding l_dbus_object_remove_interface here?

The l_dbus_unregister_interface call should remove the interface from
the object automatically.

> And I
> suppose that agent.c might need to be updated not to call
> l_dbus_unregister_object now that you are adding another interface to the=
 same path.

Yes, good point.

Best regards
--===============3536251225192525836==--

