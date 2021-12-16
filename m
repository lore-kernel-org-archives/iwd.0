Content-Type: multipart/mixed; boundary="===============8680536623239266841=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 04/10] dpp: generate URI on StartEnrollee
Date: Thu, 16 Dec 2021 10:08:48 -0800
Message-ID: <20211216180854.39470-4-prestwoj@gmail.com>
In-Reply-To: 20211216180854.39470-1-prestwoj@gmail.com

--===============8680536623239266841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Generates the required keys, hashes, and sets the Uri property
---
 src/dpp.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

v4:
 * Fixed issue with freeing key data in dpp_reset

diff --git a/src/dpp.c b/src/dpp.c
index 0136c8d3..93dc19ae 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -29,15 +29,54 @@
 #include "src/dbus.h"
 #include "src/netdev.h"
 #include "src/module.h"
+#include "src/dpp-util.h"
+#include "src/band.h"
 =

 static uint32_t netdev_watch;
 =

 struct dpp_sm {
 	struct netdev *netdev;
+	char *uri;
+
+	uint64_t wdev_id;
+
+	uint8_t *pub_asn1;
+	size_t pub_asn1_len;
+	uint8_t pub_boot_hash[32];
+	const struct l_ecc_curve *curve;
+	size_t key_len;
+	size_t nonce_len;
+	struct l_ecc_scalar *boot_private;
+	struct l_ecc_point *boot_public;
 };
 =

+static void dpp_reset(struct dpp_sm *dpp)
+{
+	if (dpp->uri) {
+		l_free(dpp->uri);
+		dpp->uri =3D NULL;
+	}
+}
+
 static void dpp_free(struct dpp_sm *dpp)
 {
+	dpp_reset(dpp);
+
+	if (dpp->pub_asn1) {
+		l_free(dpp->pub_asn1);
+		dpp->pub_asn1 =3D NULL;
+	}
+
+	if (dpp->boot_public) {
+		l_ecc_point_free(dpp->boot_public);
+		dpp->boot_public =3D NULL;
+	}
+
+	if (dpp->boot_private) {
+		l_ecc_scalar_free(dpp->boot_private);
+		dpp->boot_private =3D NULL;
+	}
+
 	l_free(dpp);
 }
 =

@@ -47,6 +86,17 @@ static void dpp_create(struct netdev *netdev)
 	struct dpp_sm *dpp =3D l_new(struct dpp_sm, 1);
 =

 	dpp->netdev =3D netdev;
+	dpp->curve =3D l_ecc_curve_from_ike_group(19);
+	dpp->key_len =3D l_ecc_curve_get_scalar_bytes(dpp->curve);
+	dpp->nonce_len =3D dpp_nonce_len_from_key_len(dpp->key_len);
+
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->boot_private,
+					&dpp->boot_public);
+
+	dpp->pub_asn1 =3D dpp_point_to_asn1(dpp->boot_public, &dpp->pub_asn1_len);
+
+	dpp_hash(L_CHECKSUM_SHA256, dpp->pub_boot_hash, 1,
+			dpp->pub_asn1, dpp->pub_asn1_len);
 =

 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
@@ -77,14 +127,32 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(=
struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	return dbus_error_not_supported(message);
+	struct dpp_sm *dpp =3D user_data;
+	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
+	struct l_dbus_message *reply;
+
+	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
+					netdev_get_address(dpp->netdev), &freq,
+					1, NULL, NULL);
+
+	l_debug("DPP Start Enrollee: %s", dpp->uri);
+
+	reply =3D l_dbus_message_new_method_return(message);
+
+	l_dbus_message_set_arguments(reply, "s", dpp->uri);
+
+	return reply;
 }
 =

 static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	return dbus_error_not_supported(message);
+	struct dpp_sm *dpp =3D user_data;
+
+	dpp_reset(dpp);
+
+	return l_dbus_message_new_method_return(message);
 }
 =

 static void dpp_setup_interface(struct l_dbus_interface *interface)
-- =

2.31.1

--===============8680536623239266841==--

