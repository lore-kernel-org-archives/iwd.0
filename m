Content-Type: multipart/mixed; boundary="===============2487293154341689089=="
MIME-Version: 1.0
From: Mark Hindley <mark at hindley.org.uk>
To: iwd at lists.01.org
Subject: Re: [PATCH] Enable DBus activation on non-systemd systems.
Date: Fri, 12 Nov 2021 15:56:10 +0000
Message-ID: <YY6OmlGcmTszos5h@hindley.org.uk>
In-Reply-To: 03794F82-EF3D-4970-A916-65966745E228@holtmann.org

--===============2487293154341689089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel,

Thanks

On Fri, Nov 12, 2021 at 03:57:59PM +0100, Marcel Holtmann wrote:
> > --- a/client/dbus-proxy.c
> > +++ b/client/dbus-proxy.c
> > @@ -855,13 +855,12 @@ bool dbus_proxy_init(void)
> > 	l_dbus_set_disconnect_handler(dbus, dbus_disconnect_callback, NULL,
> > 									NULL);
> > =

> > +	get_managed_objects();
> > 	if (command_is_interactive_mode())
> > 		l_dbus_add_service_watch(dbus, IWD_SERVICE,
> > 						service_appeared_callback,
> > 						service_disappeared_callback,
> > 						NULL, NULL);
> > -	else
> > -		get_managed_objects();
> =

> I don=E2=80=99t understand this change. The whole point is to actually wa=
it for the
> service to appear.

Yes, but it is a chicken and egg situation: plain DBus activation relies on=
 the
first call on the bus to trigger the activation[1].  The call at the end of
service_appeared_callback() is never going to be reached as interactive iwc=
t is
just waiting having called service_disappeared_callback().

> =

> > =

> > 	return true;
> > }
> > diff --git a/src/main.c b/src/main.c
> > index 989665e4..8e3a5ca7 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -191,9 +191,6 @@ static void request_name_callback(struct l_dbus *db=
us, bool success,
> > 		goto fail_exit;
> > 	}
> > =

> > -	if (!l_dbus_object_manager_enable(dbus, "/"))
> > -		l_warn("Unable to register the ObjectManager");
> > -
> > 	if (!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
> > 						IWD_DAEMON_INTERFACE,
> > 						NULL) ||
> > @@ -240,6 +237,9 @@ static void dbus_ready(void *user_data)
> > {
> > 	struct l_dbus *dbus =3D user_data;
> > =

> > +	if (!l_dbus_object_manager_enable(dbus, "/"))
> > +		l_warn("Unable to register the ObjectManager");
> > +
> =

> This change is unclear to me. Why would I register the ObjectManager if I
> can=E2=80=99t acquire the name. I don=E2=80=99t get how this is suppose t=
o work. =


Without this change, once the name is acquired, dbus still fails to find the
ObjectManager path as it hasn't (yet) been enabled. So the first call to
get_managed_objects() fails if it was also the one that caused the service
activation.

> This is the right thing to do.

I wondered about the order here too. I know that they are different binding=
s and
that it is deprecated, so it may well not be the most convincing argument, =
but
GDBus docs specify this requirement[2] and use it in their examples[3] where
object paths are registered on bus acquisition rather than name acquisition.

> =

> > 	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
> > 				request_name_callback, NULL);
> > =

> > diff --git a/src/net.connman.iwd.service b/src/net.connman.iwd.service.=
in
> > similarity index 77%
> > rename from src/net.connman.iwd.service
> > rename to src/net.connman.iwd.service.in
> > index d8ece4c3..a7cb7edd 100644
> > --- a/src/net.connman.iwd.service
> > +++ b/src/net.connman.iwd.service.in
> > @@ -1,5 +1,5 @@
> > [D-BUS Service]
> > Name=3Dnet.connman.iwd
> > -Exec=3D/bin/false
> > +Exec=3D@libexecdir@/iwd
> > User=3Droot
> > SystemdService=3Diwd.service
> =

> This change is not for upstream git tree. Use --disable-systemd-service a=
nd
> then provide your own files in the distro packaging.

But this isn't about distro specific packaging, I think it is a setup that =
works
both with systemd or without it. Debian has both systemd and several other =
inits
available so building with --disabled-systemd-service is not an option.

Thanks

Mark

[1]  https://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-s=
tarting-services

[2]  https://www.freedesktop.org/software/gstreamer-sdk/data/docs/latest/gi=
o/ch30s03.html

[3]  https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-exampl=
e-server.c

--===============2487293154341689089==--

