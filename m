Content-Type: multipart/mixed; boundary="===============7901997687380079875=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/9] dpp: generate URI on StartEnrollee
Date: Mon, 13 Dec 2021 12:33:26 -0800
Message-ID: <20211213203332.2191003-3-prestwoj@gmail.com>
In-Reply-To: 20211213203332.2191003-1-prestwoj@gmail.com

--===============7901997687380079875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Generates the required keys, hashes, and sets the Uri property
---
 src/dpp.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index e93dc912..4e854780 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -29,11 +29,24 @@
 #include "src/dbus.h"
 #include "src/netdev.h"
 #include "src/module.h"
+#include "src/dpp-util.h"
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
@@ -47,8 +60,33 @@ static void dpp_create(struct netdev *netdev)
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

@@ -69,23 +107,136 @@ static void dpp_netdev_watch(struct netdev *netdev,
 	}
 }
 =

+static bool dpp_parse_enrollee_params(struct l_dbus_message *message,
+					const char **info_out,
+					const char **host_out,
+					uint32_t **freqs_out,
+					size_t *freqs_len)
+{
+	struct l_dbus_message_iter iter;
+	struct l_dbus_message_iter variant;
+	struct l_dbus_message_iter array;
+	const char *key;
+	char *info =3D NULL, *host =3D NULL;
+	uint32_t *freqs;
+	uint32_t num_freqs;
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
+		} else if (!strcmp(key, "Frequencies")) {
+			if (!l_dbus_message_iter_get_variant(&variant,
+								"au", &array))
+				return false;
+
+			if (!l_dbus_message_iter_get_fixed_array(&array, &freqs,
+								&num_freqs))
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
+	if (freqs_out && freqs) {
+		*freqs_out =3D l_memdup(freqs, sizeof(uint32_t) * num_freqs);
+		*freqs_len =3D num_freqs;
+	}
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
+	uint32_t *freqs =3D NULL;
+	size_t freqs_len =3D 0;
 =

 	if (!netdev_get_is_up(dpp->netdev))
 		return dbus_error_not_available(message);
 =

-	return dbus_error_not_supported(message);
+	if (!dpp_parse_enrollee_params(message, &info, &host, &freqs,
+					&freqs_len))
+		return dbus_error_invalid_args(message);
+
+	dpp->curve =3D l_ecc_curve_from_ike_group(20);
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
+					netdev_get_address(dpp->netdev), freqs,
+					freqs_len, info, host);
+
+	l_debug("DPP Start Enrollee: %s", dpp->uri);
+
+	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(dpp->netdev),
+					IWD_DPP_INTERFACE, "Uri");
+
+	return l_dbus_message_new_method_return(message);
 }
 =

 static struct l_dbus_message *dpp_dbus_stop_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	return dbus_error_not_supported(message);
+	struct dpp_sm *dpp =3D user_data;
+
+	dpp_reset(dpp);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool dpp_property_get_uri(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+	const char *str =3D "none";
+
+	if (dpp->uri)
+		str =3D dpp->uri;
+
+	l_dbus_message_builder_append_basic(builder, 's', str);
+
+	return true;
 }
 =

 static void dpp_setup_interface(struct l_dbus_interface *interface)
@@ -94,6 +245,9 @@ static void dpp_setup_interface(struct l_dbus_interface =
*interface)
 				dpp_dbus_start_enrollee, "", "a{sv}", "args");
 	l_dbus_interface_method(interface, "StopEnrollee", 0,
 				dpp_dbus_stop_enrollee, "", "");
+
+	l_dbus_interface_property(interface, "Uri", 0, "s",
+					dpp_property_get_uri, NULL);
 }
 =

 static void dpp_destroy_interface(void *user_data)
-- =

2.31.1

--===============7901997687380079875==--

