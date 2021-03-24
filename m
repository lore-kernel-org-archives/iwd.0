Content-Type: multipart/mixed; boundary="===============5235604512874776036=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] station: add AKMSuite to GetDiagnostics
Date: Wed, 24 Mar 2021 16:05:37 -0700
Message-ID: <20210324230538.583325-3-prestwoj@gmail.com>
In-Reply-To: <20210324230538.583325-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5235604512874776036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 8049fd85..2289ab39 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3629,6 +3629,7 @@ static void station_get_diagnostic_cb(
 	struct station *station =3D user_data;
 	struct l_dbus_message *reply;
 	struct l_dbus_message_builder *builder;
+	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
 =

 	if (!info) {
 		reply =3D dbus_error_aborted(station->get_station_pending);
@@ -3645,6 +3646,8 @@ static void station_get_diagnostic_cb(
 					util_address_to_string(info->addr));
 	dbus_append_dict_basic(builder, "Frequency", 'u',
 				&station->connected_bss->frequency);
+	dbus_append_dict_basic(builder, "AKMSuite", 's',
+				ie_akm_suite_to_string(hs->akm_suite));
 =

 	diagnostic_info_to_dict(info, builder);
 =

-- =

2.26.2

--===============5235604512874776036==--

