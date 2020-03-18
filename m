Content-Type: multipart/mixed; boundary="===============6030023653350281746=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/12] cleanup: Remove extra empty lines
Date: Wed, 18 Mar 2020 15:51:33 +0100
Message-ID: <20200318145133.30811-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6030023653350281746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
This is a resend with some more cases I missed in git add.
---
 src/eap-mschapv2.h | 1 -
 src/eap-pwd.c      | 1 -
 src/ie.c           | 1 -
 src/sae.h          | 1 -
 src/station.c      | 2 --
 5 files changed, 6 deletions(-)

diff --git a/src/eap-mschapv2.h b/src/eap-mschapv2.h
index 6b090969..d1f4fd53 100644
--- a/src/eap-mschapv2.h
+++ b/src/eap-mschapv2.h
@@ -28,7 +28,6 @@
 #include <stdint.h>
 #include <stdbool.h>
 =

-
 bool mschapv2_get_asymmetric_start_key(const uint8_t master_key[static 16],
 				uint8_t *session_key, size_t session_len,
 				bool server, bool send);
diff --git a/src/eap-pwd.c b/src/eap-pwd.c
index 74d0997f..a77f21b9 100644
--- a/src/eap-pwd.c
+++ b/src/eap-pwd.c
@@ -435,7 +435,6 @@ error:
 	eap_method_error(eap);
 }
 =

-
 static void eap_pwd_handle_confirm(struct eap_state *eap,
 					const uint8_t *pkt, size_t len)
 {
diff --git a/src/ie.c b/src/ie.c
index 9b1127ce..f120c89e 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2406,7 +2406,6 @@ int ie_parse_neighbor_report(struct ie_tlv_iter *iter,
 	return 0;
 }
 =

-
 int ie_parse_roaming_consortium(struct ie_tlv_iter *iter, size_t *num_anqp=
_out,
 				const uint8_t **oi1_out, size_t *oi1_len_out,
 				const uint8_t **oi2_out, size_t *oi2_len_out,
diff --git a/src/sae.h b/src/sae.h
index 3a051931..4ae49795 100644
--- a/src/sae.h
+++ b/src/sae.h
@@ -31,4 +31,3 @@ struct auth_proto *sae_sm_new(struct handshake_state *hs,
 				sae_tx_authenticate_func_t tx_auth,
 				sae_tx_associate_func_t tx_assoc,
 				void *user_data);
-
diff --git a/src/station.c b/src/station.c
index 6ec7eb4b..36b41f64 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2066,7 +2066,6 @@ void station_ap_directed_roam(struct station *station,
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout =3D NULL;
 =

-
 	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
@@ -2560,7 +2559,6 @@ static void station_disconnect_cb(struct netdev *netd=
ev, bool success,
 		} else
 			reply =3D dbus_error_failed(station->disconnect_pending);
 =

-
 		dbus_pending_reply(&station->disconnect_pending, reply);
 =

 	}
-- =

2.20.1

--===============6030023653350281746==--

