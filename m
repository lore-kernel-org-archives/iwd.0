Content-Type: multipart/mixed; boundary="===============4107394921138092685=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 03/10] dpp: generate URI on StartEnrollee
Date: Tue, 14 Dec 2021 10:12:18 -0800
Message-ID: <20211214181225.2308043-3-prestwoj@gmail.com>
In-Reply-To: 20211214181225.2308043-1-prestwoj@gmail.com

--===============4107394921138092685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Generates the required keys, hashes, and sets the Uri property
---
 src/dpp.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 2 deletions(-)

v2;
 * Removed Frequency option and just choose a default
 * Use 19 as the default group

diff --git a/src/dpp.c b/src/dpp.c
index d727e639..10d8f542 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -29,11 +29,25 @@
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

 static void dpp_create(struct netdev *netdev)
@@ -47,8 +61,33 @@ static void dpp_create(struct netdev *netdev)
 					IWD_DPP_INTERFACE, dpp);
 }
 =

+static void dpp_reset(struct dpp_sm *dpp)
+{
+	if (dpp->uri) {
+		l_free(dpp->uri);
+		dpp->uri =3D NULL;
+	}
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
+}
+
 static void dpp_free(struct dpp_sm *dpp)
 {
+	dpp_reset(dpp);
+
 	l_free(dpp);
 }
 =

@@ -72,23 +111,100 @@ static void dpp_netdev_watch(struct netdev *netdev,
 	}
 }
 =

+static bool dpp_parse_enrollee_params(struct l_dbus_message *message,
+					const char **info_out,
+					const char **host_out)
+{
+	struct l_dbus_message_iter iter;
+	struct l_dbus_message_iter variant;
+	const char *key;
+	char *info =3D NULL, *host =3D NULL;
+
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter)) {
+		l_error("Failed to parse StartEnrollee parameters");
+		return false;
+	}
+
+	while (l_dbus_message_iter_next_entry(&iter, &key, &variant)) {
+		if (!strcmp(key, "Information")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&info))
+				return false;
+		} else if (!strcmp(key, "Host")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&host))
+				return false;
+		}
+		/*
+		 * TODO:
+		 *  - Allow a MAC to be specififed, this would require changing
+		 *    the device MAC prior to starting.
+		 *  - Allow a custom key pair to be supplied, or some way of
+		 *    deterministically generating one based on some seed.
+		 */
+	}
+
+	if (info_out && info)
+		*info_out =3D info;
+	else if (!info_out && info)
+		l_free(info);
+
+	if (host_out && host)
+		*host_out =3D host;
+	else if (!host_out && host)
+		l_free(host);
+
+	return true;
+}
+
 static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
 	struct dpp_sm *dpp =3D user_data;
+	const char *info =3D NULL, *host =3D NULL;
+	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 =

 	if (!netdev_get_is_up(dpp->netdev))
 		return dbus_error_not_available(message);
 =

-	return dbus_error_not_supported(message);
+	if (!dpp_parse_enrollee_params(message, &info, &host))
+		return dbus_error_invalid_args(message);
+
+	dpp->curve =3D l_ecc_curve_from_ike_group(19);
+	dpp->key_len =3D l_ecc_curve_get_scalar_bytes(dpp->curve);
+	dpp->nonce_len =3D dpp_nonce_len_from_key_len(dpp->key_len);
+
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->boot_private,
+					&dpp->boot_public);
+
+	dpp->pub_asn1 =3D l_ecc_point_to_asn1(dpp->boot_public,
+						&dpp->pub_asn1_len);
+
+	dpp_hash(L_CHECKSUM_SHA256, dpp->pub_boot_hash, 1,
+			dpp->pub_asn1, dpp->pub_asn1_len);
+
+	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
+					netdev_get_address(dpp->netdev), &freq,
+					1, info, host);
+
+	l_debug("DPP Start Enrollee: %s", dpp->uri);
+
+	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(dpp->netdev),
+					IWD_DPP_INTERFACE, "Uri");
+
+	return l_dbus_message_new_method_return(message);
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

--===============4107394921138092685==--

