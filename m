Content-Type: multipart/mixed; boundary="===============8614241070933300186=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 4/5] ap: add StartWithConfig DBus method
Date: Fri, 30 Oct 2020 11:42:57 -0700
Message-ID: <8fb55576de7b78c4a738e11923f8edd6765909ce.camel@gmail.com>
In-Reply-To: <a15dfd36-254e-08d8-bf7c-9554b26409d8@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8614241070933300186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> =

> > +	config =3D l_queue_find(ap_configs, match_ssid, ssid);
> > +	if (!config)
> > +		return dbus_error_not_found(message);
> =

> Question, why store the profiles in a list when you could simply try
> and load =

> the profile here?  Then you wouldn't really need to distinguish
> between =

> filesystem and non-filesystem based ap_configs.

Yes I like this much better. This would also allow the configs to be
changed while IWD was running as long as the AP is stopped.

> =

> > +
> > +	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err,
> > ap_if);
> > +	if (!ap_if->ap)
> > +		return dbus_error_from_errno(err, message);
> > +
> > +	ap_if->pending =3D l_dbus_message_ref(message);
> > +	return NULL;
> > +}
> > +
> >   static bool ap_dbus_property_get_started(struct l_dbus *dbus,
> >   					struct l_dbus_message *message,
> >   					struct l_dbus_message_builder
> > *builder,
> > @@ -2729,6 +2767,9 @@ static void ap_setup_interface(struct
> > l_dbus_interface *interface)
> >   	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start,
> > "",
> >   			"ss", "ssid", "wpa2_passphrase");
> >   	l_dbus_interface_method(interface, "Stop", 0, ap_dbus_stop, "",
> > "");
> > +	l_dbus_interface_method(interface, "StartWithConfig", 0,
> =

> Lets try to avoid shortened words in the API.  StartWithConfiguration
> or =

> StartProfile would be better.

Sure, StartProfile it is.

> =

> > +					ap_dbus_start_with_config, "",
> > "s",
> > +					"ssid");
> >   =

> >   	l_dbus_interface_property(interface, "Started", 0, "b",
> >   					ap_dbus_property_get_started,
> > NULL);
> > =

> =

> Regards,
> -Denis

--===============8614241070933300186==--

