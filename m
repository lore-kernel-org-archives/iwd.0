Content-Type: multipart/mixed; boundary="===============8815731739875582745=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel at holtmann.org>
To: iwd at lists.01.org
Subject: Re: [PATCH] Enable DBus activation on non-systemd systems.
Date: Fri, 12 Nov 2021 15:57:59 +0100
Message-ID: <03794F82-EF3D-4970-A916-65966745E228@holtmann.org>
In-Reply-To: YY5z/bUKmNfGspVV@hindley.org.uk

--===============8815731739875582745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> I have been investigating why legacy DBus activation does not work for iw=
d on
> non-systemd systems. In Debian and Devuan (at least) this has required
> alternative means of starting the daemon by initscript be implemented.
> =

> However, DBus activation without systemd is possible, without any
> impact on systems running systemd.
> =

> For this to be supported there are 3 aspects that need to be addressed:
> =

> - net.connman.iwd.service: set Exec to iwd path.
> =

> - client/dbus-proxy.c: always call get_managed_objects() on init.
> =

> - src/main/c: register Object Manager before acquiring name otherwise the=
 call
>   to get_managed_objects() which triggers activation fails with 'No match=
ing
>   method found'.
> =

> Signed-off-by: Mark Hindley <mark(a)hindley.org.uk>
> ---
> client/dbus-proxy.c                                         | 3 +--
> src/main.c                                                  | 6 +++---
> src/{net.connman.iwd.service =3D> net.connman.iwd.service.in} | 2 +-
> 3 files changed, 5 insertions(+), 6 deletions(-)
> rename src/{net.connman.iwd.service =3D> net.connman.iwd.service.in} (77%)
> =

> diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
> index ab9fb5a5..15bb4128 100644
> --- a/client/dbus-proxy.c
> +++ b/client/dbus-proxy.c
> @@ -855,13 +855,12 @@ bool dbus_proxy_init(void)
> 	l_dbus_set_disconnect_handler(dbus, dbus_disconnect_callback, NULL,
> 									NULL);
> =

> +	get_managed_objects();
> 	if (command_is_interactive_mode())
> 		l_dbus_add_service_watch(dbus, IWD_SERVICE,
> 						service_appeared_callback,
> 						service_disappeared_callback,
> 						NULL, NULL);
> -	else
> -		get_managed_objects();

I don=E2=80=99t understand this change. The whole point is to actually wait=
 for the service to appear.

> =

> 	return true;
> }
> diff --git a/src/main.c b/src/main.c
> index 989665e4..8e3a5ca7 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -191,9 +191,6 @@ static void request_name_callback(struct l_dbus *dbus=
, bool success,
> 		goto fail_exit;
> 	}
> =

> -	if (!l_dbus_object_manager_enable(dbus, "/"))
> -		l_warn("Unable to register the ObjectManager");
> -
> 	if (!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
> 						IWD_DAEMON_INTERFACE,
> 						NULL) ||
> @@ -240,6 +237,9 @@ static void dbus_ready(void *user_data)
> {
> 	struct l_dbus *dbus =3D user_data;
> =

> +	if (!l_dbus_object_manager_enable(dbus, "/"))
> +		l_warn("Unable to register the ObjectManager");
> +

This change is unclear to me. Why would I register the ObjectManager if I c=
an=E2=80=99t acquire the name. I don=E2=80=99t get how this is suppose to w=
ork. This is actually the right thing to do.

> 	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
> 				request_name_callback, NULL);
> =

> diff --git a/src/net.connman.iwd.service b/src/net.connman.iwd.service.in
> similarity index 77%
> rename from src/net.connman.iwd.service
> rename to src/net.connman.iwd.service.in
> index d8ece4c3..a7cb7edd 100644
> --- a/src/net.connman.iwd.service
> +++ b/src/net.connman.iwd.service.in
> @@ -1,5 +1,5 @@
> [D-BUS Service]
> Name=3Dnet.connman.iwd
> -Exec=3D/bin/false
> +Exec=3D@libexecdir@/iwd
> User=3Droot
> SystemdService=3Diwd.service

This change is not for upstream git tree. Use --disable-systemd-service and=
 then provide your own files in the distro packaging. Long time ago we made=
 the decision to only provide systemd integration. All other things like in=
it scripts or custom distro specific files are left to the distro packages.

Regards

Marcel

--===============8815731739875582745==--

