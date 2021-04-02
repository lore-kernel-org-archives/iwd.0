Content-Type: multipart/mixed; boundary="===============3934622746194094946=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] netdev: move request IE parsing into function
Date: Fri, 02 Apr 2021 10:11:13 -0700
Message-ID: <20210402171118.915230-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3934622746194094946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Moves the parsing of NL80211_ATTR_REQ_IE into its own parsing
function for use elsewhere.
---
 src/netdev.c | 62 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index fe6232bd..9e665ee4 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1851,6 +1851,41 @@ static void netdev_send_qos_map_set(struct netdev *n=
etdev,
 						netdev, NULL);
 }
 =

+static void parse_request_ies(struct netdev *netdev, const uint8_t *ies,
+				size_t ies_len)
+{
+	struct ie_tlv_iter iter;
+	const void *data;
+
+	/*
+	 * The driver may have modified the IEs we passed to CMD_CONNECT
+	 * before sending them out, the actual IE sent is reflected in the
+	 * ATTR_REQ_IE sequence.  These are the values EAPoL will need to use.
+	 */
+	ie_tlv_iter_init(&iter, ies, ies_len);
+
+	while (ie_tlv_iter_next(&iter)) {
+		data =3D ie_tlv_iter_get_data(&iter);
+
+		switch (ie_tlv_iter_get_tag(&iter)) {
+		case IE_TYPE_RSN:
+			handshake_state_set_supplicant_ie(netdev->handshake,
+								data - 2);
+			break;
+		case IE_TYPE_VENDOR_SPECIFIC:
+			if (!is_ie_wpa_ie(data, ie_tlv_iter_get_length(&iter)))
+				break;
+
+			handshake_state_set_supplicant_ie(netdev->handshake,
+								data - 2);
+			break;
+		case IE_TYPE_MOBILITY_DOMAIN:
+			handshake_state_set_mde(netdev->handshake, data - 2);
+			break;
+		}
+	}
+}
+
 static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *ne=
tdev)
 {
 	struct l_genl_attr attr;
@@ -1929,33 +1964,8 @@ static void netdev_connect_event(struct l_genl_msg *=
msg, struct netdev *netdev)
 =

 	if (!ies)
 		goto process_resp_ies;
-	/*
-	 * The driver may have modified the IEs we passed to CMD_CONNECT
-	 * before sending them out, the actual IE sent is reflected in the
-	 * ATTR_REQ_IE sequence.  These are the values EAPoL will need to use.
-	 */
-	ie_tlv_iter_init(&iter, ies, ies_len);
-
-	while (ie_tlv_iter_next(&iter)) {
-		data =3D ie_tlv_iter_get_data(&iter);
 =

-		switch (ie_tlv_iter_get_tag(&iter)) {
-		case IE_TYPE_RSN:
-			handshake_state_set_supplicant_ie(netdev->handshake,
-								data - 2);
-			break;
-		case IE_TYPE_VENDOR_SPECIFIC:
-			if (!is_ie_wpa_ie(data, ie_tlv_iter_get_length(&iter)))
-				break;
-
-			handshake_state_set_supplicant_ie(netdev->handshake,
-								data - 2);
-			break;
-		case IE_TYPE_MOBILITY_DOMAIN:
-			handshake_state_set_mde(netdev->handshake, data - 2);
-			break;
-		}
-	}
+	parse_request_ies(netdev, ies, ies_len);
 =

 process_resp_ies:
 	if (resp_ies) {
-- =

2.26.2

--===============3934622746194094946==--

