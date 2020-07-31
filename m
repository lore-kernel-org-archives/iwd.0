Content-Type: multipart/mixed; boundary="===============3697177907804157896=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: build: hook up traditional dbus activation
Date: Fri, 31 Jul 2020 20:39:25 +0200
Message-ID: <68660AED-EA63-4C5E-9FFD-88FA47571086@holtmann.org>
In-Reply-To: <20200731182407.8209-1-andreas@fatal.se>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3697177907804157896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

> On systems using systemd dbus will use the SystemdServices=3D directive,
> but on non-systemd systems the so called "traditional dbus activation"
> method involves reading the Exec=3D directive. Setting that to /bin/false
> means this service is not relevant on non-systemd systems, but
> apparently there's an interest from users of such systems to use
> iwd (and possibly ead). Thus hook up the expansion of the paths in the
> Exec=3D directive of the dbus service files to allow the traditional dbus
> activation to start respective daemon.
> =

> Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> ---
> Makefile.am                      | 11 ++++++-----
> src/net.connman.iwd.service      |  5 -----
> src/net.connman.iwd.service.in   |  5 +++++
> wired/net.connman.ead.service    |  5 -----
> wired/net.connman.ead.service.in |  5 +++++
> 5 files changed, 16 insertions(+), 15 deletions(-)
> delete mode 100644 src/net.connman.iwd.service
> create mode 100644 src/net.connman.iwd.service.in
> delete mode 100644 wired/net.connman.ead.service
> create mode 100644 wired/net.connman.ead.service.in
> =

> diff --git a/Makefile.am b/Makefile.am
> index 57c694d..006d1d1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -250,7 +250,7 @@ dist_dbus_data_DATA +=3D src/iwd-dbus.conf
> endif
> =

> if SYSTEMD_SERVICE
> -src_iwd_DEPENDENCIES +=3D src/iwd.service
> +src_iwd_DEPENDENCIES +=3D src/iwd.service src/net.connman.iwd.service
> =

> systemd_unit_DATA +=3D src/iwd.service
> dbus_bus_DATA +=3D src/net.connman.iwd.service
> @@ -328,7 +328,7 @@ dist_dbus_data_DATA +=3D wired/ead-dbus.conf
> endif
> =

> if SYSTEMD_SERVICE
> -wired_ead_DEPENDENCIES +=3D wired/ead.service
> +wired_ead_DEPENDENCIES +=3D wired/ead.service wired/net.connman.ead.serv=
ice
> =

> systemd_unit_DATA +=3D wired/ead.service
> dbus_bus_DATA +=3D wired/net.connman.ead.service
> @@ -524,8 +524,8 @@ unit_test_p2p_LDADD =3D $(ell_ldadd)
> =

> TESTS =3D $(unit_tests)
> =

> -EXTRA_DIST =3D src/genbuiltin src/iwd.service.in src/net.connman.iwd.ser=
vice \
> -			wired/ead.service.in wired/net.connman.ead.service \
> +EXTRA_DIST =3D src/genbuiltin src/iwd.service.in src/net.connman.iwd.ser=
vice.in \
> +			wired/ead.service.in wired/net.connman.ead.service.in \
> 			src/80-iwd.link src/pkcs8.conf unit/gencerts.cnf \
> 			$(manual_pages) $(patsubst %.1,%.rst, \
> 					$(patsubst %.5,%.rst, \
> @@ -539,7 +539,8 @@ if MAINTAINER_MODE
> AM_CFLAGS +=3D -DHAVE_PKCS8_SUPPORT
> endif
> =

> -CLEANFILES =3D src/iwd.service wired/ead.service
> +CLEANFILES =3D src/iwd.service wired/ead.service \
> +	     src/net.connman.iwd.service wired/net.connman.ead.service
> =

> DISTCHECK_CONFIGURE_FLAGS =3D --disable-dbus-policy --disable-systemd-ser=
vice \
> 				--enable-sim-hardcoded \
> diff --git a/src/net.connman.iwd.service b/src/net.connman.iwd.service
> deleted file mode 100644
> index d8ece4c..0000000
> --- a/src/net.connman.iwd.service
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -[D-BUS Service]
> -Name=3Dnet.connman.iwd
> -Exec=3D/bin/false
> -User=3Droot
> -SystemdService=3Diwd.service
> diff --git a/src/net.connman.iwd.service.in b/src/net.connman.iwd.service=
.in
> new file mode 100644
> index 0000000..a7cb7ed
> --- /dev/null
> +++ b/src/net.connman.iwd.service.in
> @@ -0,0 +1,5 @@
> +[D-BUS Service]
> +Name=3Dnet.connman.iwd
> +Exec=3D@libexecdir@/iwd
> +User=3Droot
> +SystemdService=3Diwd.service
> diff --git a/wired/net.connman.ead.service b/wired/net.connman.ead.service
> deleted file mode 100644
> index 24af96b..0000000
> --- a/wired/net.connman.ead.service
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -[D-BUS Service]
> -Name=3Dnet.connman.ead
> -Exec=3D/bin/false
> -User=3Droot
> -SystemdService=3Dead.service
> diff --git a/wired/net.connman.ead.service.in b/wired/net.connman.ead.ser=
vice.in
> new file mode 100644
> index 0000000..63e5011
> --- /dev/null
> +++ b/wired/net.connman.ead.service.in
> @@ -0,0 +1,5 @@
> +[D-BUS Service]
> +Name=3Dnet.connman.ead
> +Exec=3D@libexecdir@/ead
> +User=3Droot
> +SystemdService=3Dead.service

I am reluctant to go back to this since it is also not really working like =
this. This most likely needs a two-stage setup with an Alias (which we had =
at one point). And frankly the non-systemd distros can ship a modified file=
. We don=E2=80=99t have to make everybody happy.

Regards

Marcel

--===============3697177907804157896==--

