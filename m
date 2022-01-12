Content-Type: multipart/mixed; boundary="===============6530750769847045025=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/7] dpp: stop periodic scanning when starting DPP
Date: Wed, 12 Jan 2022 10:08:42 -0800
Message-ID: <20220112180845.1240661-4-prestwoj@gmail.com>
In-Reply-To: 20220112180845.1240661-1-prestwoj@gmail.com

--===============6530750769847045025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 5f24de57..f33b655b 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1809,6 +1809,8 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 	 */
 	dpp_start_presence(dpp, &freq, 1);
 =

+	scan_periodic_stop(dpp->wdev_id);
+
 	return NULL;
 }
 =

@@ -1857,6 +1859,8 @@ static struct l_dbus_message *dpp_dbus_start_configur=
ator(struct l_dbus *dbus,
 						network_get_ssid(network),
 						hs->akm_suite);
 =

+	scan_periodic_stop(dpp->wdev_id);
+
 	l_debug("DPP Start Configurator: %s", dpp->uri);
 =

 	reply =3D l_dbus_message_new_method_return(message);
-- =

2.31.1

--===============6530750769847045025==--

