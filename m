Content-Type: multipart/mixed; boundary="===============8067289912530755050=="
MIME-Version: 1.0
From: Anton Khirnov <anton@khirnov.net>
Subject: [RFC/PATCH] Install iwd and ead into $sbindir rather than $libexecdir.
Date: Tue, 18 Feb 2020 12:34:27 +0100
Message-ID: <20200218113427.25752-1-anton@khirnov.net>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8067289912530755050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

$libexecdir is supposed to contain "internal" binaries that are not
supposed to be executed "from the outside", e.g. directly by users.
Since iwd is a normal daemon that is directly executed from the outside,
$sbindir is the appropriate place for it.
---
 Makefile.am          | 8 ++++----
 README               | 4 ++--
 src/iwd.service.in   | 2 +-
 wired/ead.service.in | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9d378d3d..9e033599 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -135,7 +135,7 @@ ell_libell_internal_la_SOURCES =3D $(ell_headers) $(ell=
_sources)
 endif
 =

 bin_PROGRAMS =3D
-libexec_PROGRAMS =3D
+sbin_PROGRAMS =3D
 noinst_PROGRAMS =3D
 =

 if DBUS_POLICY
@@ -185,7 +185,7 @@ eap_sources =3D src/eap.c src/eap.h src/eap-private.h \
 				src/mschaputil.h src/mschaputil.c
 =

 if DAEMON
-libexec_PROGRAMS +=3D src/iwd
+sbin_PROGRAMS +=3D src/iwd
 =

 src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.h src/missing.h \
 					src/plugin.h src/plugin.c \
@@ -313,7 +313,7 @@ endif
 endif
 =

 if WIRED
-libexec_PROGRAMS +=3D wired/ead
+sbin_PROGRAMS +=3D wired/ead
 =

 wired_ead_SOURCES =3D wired/main.c wired/ethdev.h wired/ethdev.c \
 				wired/network.h wired/network.c \
@@ -627,7 +627,7 @@ ell/ell.h: Makefile
 	done
 =

 SED_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) && $(SED) \
-		-e 's,@libexecdir\@,$(libexecdir),g' \
+		-e 's,@sbindir\@,$(sbindir),g' \
 		< $< > $@
 =

 if RUN_RST2MAN
diff --git a/README b/README
index fed9cf62..cffb8b1b 100644
--- a/README
+++ b/README
@@ -80,7 +80,7 @@ configuration options which are generally useful and enab=
led by default:
 		Disable installation of Wireless daemon
 =

 		By default the Wireless daemon binary iwd is enabled and
-		placed into --libexecdir directory.
+		placed into --sbindir directory.
 =

 	--disable-client
 =

@@ -159,7 +159,7 @@ that can be enabled if the functionality is required:
 		Enable installation of Ethernet authentication daemon
 =

 		This allows enabling the Ethernet daemon binary ead which
-		is then placed into --libexecdir directory.
+		is then placed into --sbindir directory.
 =

 		With this option the support for 802.1x for wired Ethernet
 		connections can be enabled. It provides its own D-Bus
diff --git a/src/iwd.service.in b/src/iwd.service.in
index 77819eaf..a85f11fb 100644
--- a/src/iwd.service.in
+++ b/src/iwd.service.in
@@ -6,7 +6,7 @@ Wants=3Dnetwork.target
 [Service]
 Type=3Ddbus
 BusName=3Dnet.connman.iwd
-ExecStart=3D@libexecdir@/iwd
+ExecStart=3D@sbindir@/iwd
 NotifyAccess=3Dmain
 LimitNPROC=3D1
 Restart=3Don-failure
diff --git a/wired/ead.service.in b/wired/ead.service.in
index 387fdb68..49b998a5 100644
--- a/wired/ead.service.in
+++ b/wired/ead.service.in
@@ -6,7 +6,7 @@ Wants=3Dnetwork.target
 [Service]
 Type=3Ddbus
 BusName=3Dnet.connman.ead
-ExecStart=3D@libexecdir@/ead
+ExecStart=3D@sbindir@/ead
 NotifyAccess=3Dmain
 LimitNPROC=3D1
 Restart=3Don-failure
-- =

2.20.1

--===============8067289912530755050==--

