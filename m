Content-Type: multipart/mixed; boundary="===============1678201428897454404=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] station: add Security key to GetDiagnostics
Date: Mon, 29 Mar 2021 10:33:09 -0700
Message-ID: <20210329173310.706671-3-prestwoj@gmail.com>
In-Reply-To: <20210329173310.706671-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1678201428897454404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index bfc23f88..ba4483e6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3631,6 +3631,7 @@ static void station_get_diagnostic_cb(
 	struct station *station =3D user_data;
 	struct l_dbus_message *reply;
 	struct l_dbus_message_builder *builder;
+	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
 =

 	if (!info) {
 		reply =3D dbus_error_aborted(station->get_station_pending);
@@ -3647,6 +3648,9 @@ static void station_get_diagnostic_cb(
 					util_address_to_string(info->addr));
 	dbus_append_dict_basic(builder, "Frequency", 'u',
 				&station->connected_bss->frequency);
+	dbus_append_dict_basic(builder, "Security", 's',
+				diagnostic_akm_suite_to_security(hs->akm_suite,
+								hs->wpa_ie));
 =

 	diagnostic_info_to_dict(info, builder);
 =

-- =

2.26.2

--===============1678201428897454404==--

