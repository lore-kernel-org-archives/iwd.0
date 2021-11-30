Content-Type: multipart/mixed; boundary="===============7699830997428796727=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 3/3] build: update unit tests with util.c/band.c dependency
Date: Tue, 30 Nov 2021 10:24:13 -0800
Message-ID: <20211130182413.437115-3-prestwoj@gmail.com>
In-Reply-To: 20211130182413.437115-1-prestwoj@gmail.com

--===============7699830997428796727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 275dd1b9..1e1c230f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -320,7 +320,8 @@ monitor_iwmon_SOURCES =3D monitor/main.c linux/nl80211.=
h \
 					src/eapolutil.h src/eapolutil.c \
 					src/nl80211cmd.h src/nl80211cmd.c \
 					src/p2putil.c src/p2putil.h \
-					src/anqputil.h src/anqputil.c
+					src/anqputil.h src/anqputil.c \
+					src/band.h src/band.c
 monitor_iwmon_LDADD =3D $(ell_ldadd)
 =

 if MANUAL_PAGES
@@ -335,6 +336,7 @@ wired_ead_SOURCES =3D wired/main.c wired/ethdev.h wired=
/ethdev.c \
 				wired/network.h wired/network.c \
 				wired/dbus.h wired/dbus.c \
 				src/module.h src/module.c \
+				src/band.h src/band.c \
 				$(eap_sources)
 wired_ead_LDADD =3D $(ell_ldadd)
 wired_ead_DEPENDENCIES =3D $(ell_dependencies)
@@ -361,7 +363,8 @@ tools_probe_req_SOURCES =3D tools/probe-req.c src/mpdu.=
h src/mpdu.c \
 					src/ie.h src/ie.c \
 					src/nl80211util.h src/nl80211util.c \
 					src/util.h src/util.c \
-					src/common.h src/common.c
+					src/common.h src/common.c \
+					src/band.h src/band.c
 tools_probe_req_LDADD =3D $(ell_ldadd)
 =

 if HWSIM
@@ -370,7 +373,8 @@ bin_PROGRAMS +=3D tools/hwsim
 tools_hwsim_SOURCES =3D tools/hwsim.c src/mpdu.h \
 					src/util.h src/util.c \
 					src/storage.h src/storage.c \
-					src/common.h src/common.c
+					src/common.h src/common.c \
+					src/band.h src/band.c
 tools_hwsim_LDADD =3D $(ell_ldadd)
 =

 if DBUS_POLICY
@@ -480,7 +484,7 @@ unit_test_eapol_DEPENDENCIES =3D $(ell_dependencies) \
 				unit/cert-client-key-pkcs8.pem \
 				unit/tls-settings.8021x
 =

-unit_test_util_SOURCES =3D src/util.h src/util.c \
+unit_test_util_SOURCES =3D src/util.h src/util.c src/band.c src/band.h \
 				unit/test-util.c
 unit_test_util_LDADD =3D $(ell_ldadd)
 =

@@ -537,7 +541,8 @@ unit_test_p2p_SOURCES =3D unit/test-p2p.c src/wscutil.h=
 src/wscutil.c \
 				src/crypto.h src/crypto.c \
 				src/ie.h src/ie.c \
 				src/util.h src/util.c \
-				src/p2putil.h src/p2putil.c
+				src/p2putil.h src/p2putil.c \
+				src/band.h src/band.c
 unit_test_p2p_LDADD =3D $(ell_ldadd)
 =

 TESTS =3D $(unit_tests)
-- =

2.31.1

--===============7699830997428796727==--

