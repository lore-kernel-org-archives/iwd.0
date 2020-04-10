Content-Type: multipart/mixed; boundary="===============5189778721080174888=="
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH 1/3] iwd: remove unnecessary semicolons
Date: Thu, 09 Apr 2020 17:38:29 -0700
Message-ID: <20200410003831.258910-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5189778721080174888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Found with clang's -Wextra-semi-stmt
---
 monitor/nlmon.c | 27 ++++++++++++++++-----------
 src/crypto.c    |  2 +-
 src/eapol.c     |  6 +++---
 src/erp.c       |  2 +-
 src/fils.c      |  3 ++-
 src/ie.c        | 10 ++++++----
 src/main.c      |  2 +-
 src/sae.c       |  4 ++--
 src/station.c   |  2 +-
 src/wsc.c       |  2 +-
 10 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 1f269ff0..df628c2c 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -199,7 +199,7 @@ do { \
 		print_indent(4 + (level) * 4, COLOR_OFF, "", "", color, \
 								fmt, ## args)
 =

-#define print_space(x) printf("%*c", (x), ' ');
+#define print_space(x) printf("%*c", (x), ' ')
 =

 static void print_packet(const struct timeval *tv, char ident,
 					const char *color, const char *label,
@@ -3042,10 +3042,13 @@ static void print_p2p_status(unsigned int level, co=
nst char *label,
 }
 =

 #define CHECK_CAPS_BIT(v, str)	\
-	if (caps & (v)) {	\
-		print_attr(level + 1, "%s", (str));	\
-		caps &=3D ~(v);	\
-	}
+	do {			\
+		if (caps & (v)) {				\
+			print_attr(level + 1, "%s", (str));	\
+			caps &=3D ~(v);				\
+		} 						\
+	} while(0)
+
 static void print_p2p_device_capability(unsigned int level, const char *la=
bel,
 					const void *data, uint16_t size)
 {
@@ -3178,11 +3181,13 @@ static void print_p2p_manageability(unsigned int le=
vel, const char *label,
 		return;
 	}
 =

-#define CHECK_BIT(v, str)	\
-	if (val & (v)) {	\
-		print_attr(level + 1, "%s", (str));	\
-		val &=3D ~(v);	\
-	}
+#define CHECK_BIT(v, str)					\
+	do {							\
+		if (val & (v)) {				\
+			print_attr(level + 1, "%s", (str));	\
+			val &=3D ~(v);				\
+		}						\
+	} while(0)
 =

 	val =3D *(const uint8_t *) data;
 =

@@ -5239,7 +5244,7 @@ static void print_eap(unsigned int level, const void =
*data, uint32_t size)
 	default:
 		str =3D "Reserved";
 		break;
-	};
+	}
 =

 	print_attr(level, "Code: %u (%s)", eap[0], str);
 	print_attr(level, "Identifier: %u", eap[1]);
diff --git a/src/crypto.c b/src/crypto.c
index c1fe83a2..696b5990 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -469,7 +469,7 @@ int crypto_cipher_key_len(enum crypto_cipher cipher)
 		return 16;
 	case CRYPTO_CIPHER_BIP:
 		return 16;
-	};
+	}
 =

 	return 0;
 }
diff --git a/src/eapol.c b/src/eapol.c
index 2c4b3dcd..b0036c10 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -279,7 +279,7 @@ uint8_t *eapol_decrypt_key_data(enum ie_rsn_akm_suite a=
km, const uint8_t *kek,
 		break;
 	default:
 		return NULL;
-	};
+	}
 =

 	buf =3D l_new(uint8_t, expected_len);
 =

@@ -1674,7 +1674,7 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm *=
sm,
 			return;
 		}
 =

-		igtk_key_index =3D l_get_le16(igtk);;
+		igtk_key_index =3D l_get_le16(igtk);
 		igtk +=3D 2;
 		igtk_len -=3D 2;
 	} else
@@ -1834,7 +1834,7 @@ static void eapol_handle_gtk_1_of_2(struct eapol_sm *=
sm,
 		if (!igtk)
 			return;
 =

-		igtk_key_index =3D l_get_le16(igtk);;
+		igtk_key_index =3D l_get_le16(igtk);
 		igtk +=3D 2;
 		igtk_len -=3D 2;
 	} else
diff --git a/src/erp.c b/src/erp.c
index cacd37d1..8c6f971c 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -308,7 +308,7 @@ static bool erp_derive_reauth_keys(const uint8_t *emsk,=
 size_t emsk_len,
 					void *r_rk, void *r_ik)
 {
 	char info[256];
-	char *ptr;;
+	char *ptr;
 =

 	ptr =3D info + l_strlcpy(info, ERP_RRK_LABEL, sizeof(info)) + 1;
 =

diff --git a/src/fils.c b/src/fils.c
index 4291e792..2d2a0913 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -1,3 +1,4 @@
+
 /*
  *
  *  Wireless daemon for Linux
@@ -508,7 +509,7 @@ static int fils_rx_associate(struct auth_proto *driver,=
 const uint8_t *frame,
 			if (!igtk)
 				goto invalid_ies;
 =

-			igtk_key_index =3D l_get_le16(igtk);;
+			igtk_key_index =3D l_get_le16(igtk);
 			igtk +=3D 2;
 			igtk_len -=3D 2;
 =

diff --git a/src/ie.c b/src/ie.c
index 8d212ea0..4b2e3780 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -915,10 +915,12 @@ static bool ie_build_cipher_suite(uint8_t *data, cons=
t uint8_t *oui,
 	return false;
 }
 =

-#define RETURN_AKM(data, oui, id)	\
-	memcpy((data), (oui), 3);	\
-	(data)[3] =3D (id);		\
-	return true;
+#define RETURN_AKM(data, oui, id)		\
+	do {					\
+		memcpy((data), (oui), 3);	\
+		(data)[3] =3D (id);		\
+		return true;			\
+	} while(0)
 =

 /* 802.11-2016, Section 9.4.2.25.3 */
 static bool ie_build_rsn_akm_suite(uint8_t *data, enum ie_rsn_akm_suite su=
ite)
diff --git a/src/main.c b/src/main.c
index 831fb315..f8f3043d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -339,7 +339,7 @@ static int check_crypto()
 		l_hashmap_insert(options, "CONFIG_PKCS7_MESSAGE_PARSER", &r);
 		l_hashmap_insert(options,
 					"CONFIG_PKCS8_PRIVATE_KEY_PARSER", &r);
-	};
+	}
 =

 	if (l_hashmap_isempty(options))
 		goto done;
diff --git a/src/sae.c b/src/sae.c
index 6abbad5e..97e3348e 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -144,9 +144,9 @@ static bool sae_cn(const uint8_t *kck, uint16_t send_co=
nfirm,
 	iov[2].iov_base =3D (void *) e1;
 	iov[2].iov_len =3D l_ecc_point_get_data(element1, e1, sizeof(e1));
 	iov[3].iov_base =3D (void *) s2;
-	iov[3].iov_len =3D l_ecc_scalar_get_data(scalar2, s2, sizeof(s2));;
+	iov[3].iov_len =3D l_ecc_scalar_get_data(scalar2, s2, sizeof(s2));
 	iov[4].iov_base =3D (void *) e2;
-	iov[4].iov_len =3D l_ecc_point_get_data(element2, e2, sizeof(e2));;
+	iov[4].iov_len =3D l_ecc_point_get_data(element2, e2, sizeof(e2));
 =

 	l_checksum_updatev(hmac, iov, 5);
 =

diff --git a/src/station.c b/src/station.c
index ca47568c..d57a0f8d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2174,7 +2174,7 @@ static void station_netdev_event(struct netdev *netde=
v, enum netdev_event event,
 	case NETDEV_EVENT_RSSI_LEVEL_NOTIFY:
 		station_rssi_level_changed(station, l_get_u8(event_data));
 		break;
-	};
+	}
 }
 =

 static bool station_try_next_bss(struct station *station)
diff --git a/src/wsc.c b/src/wsc.c
index ba58b6d4..2ac6de9c 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -262,7 +262,7 @@ static void wsc_enrollee_netdev_event(struct netdev *ne=
tdev,
 	default:
 		l_debug("Unexpected event: %d", event);
 		break;
-	};
+	}
 }
 =

 static void wsc_enrollee_handshake_event(struct handshake_state *hs,
-- =

2.25.1

--===============5189778721080174888==--

