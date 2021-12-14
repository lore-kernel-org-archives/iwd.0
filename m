Content-Type: multipart/mixed; boundary="===============8150011950555481550=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 04/10] dpp-util: add dpp status and attribute types
Date: Tue, 14 Dec 2021 10:12:19 -0800
Message-ID: <20211214181225.2308043-4-prestwoj@gmail.com>
In-Reply-To: 20211214181225.2308043-1-prestwoj@gmail.com

--===============8150011950555481550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp-util.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

v2:
 * Remove __DPP_STATUS_INVALID

diff --git a/src/dpp-util.h b/src/dpp-util.h
index ad360cdd..75bc33c1 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -34,6 +34,46 @@ struct dpp_uri_info {
 	char *host;
 };
 =

+enum dpp_frame_type {
+	DPP_FRAME_AUTHENTICATION_REQUEST	=3D 0,
+	DPP_FRAME_AUTHENTICATION_RESPONSE	=3D 1,
+	DPP_FRAME_AUTHENTICATION_CONFIRM	=3D 2,
+	/* 3 - 4 reserved */
+	DPP_FRAME_PEER_DISCOVERY_REQUEST	=3D 5,
+	DPP_FRAME_PEER_DISCOVERY_RESPONSE	=3D 6,
+	DPP_FRAME_PKEX_VERSION1_XCHG_REQUST	=3D 7,
+	DPP_FRAME_PKEX_XCHG_RESPONSE		=3D 8,
+	DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST	=3D 9,
+	DPP_FRAME_PKEX_COMMIT_REVEAP_RESPONSE	=3D 10,
+	DPP_FRAME_CONFIGURATION_RESULT		=3D 11,
+	DPP_FRAME_CONNECTION_STATUS_RESULT	=3D 12,
+	DPP_FRAME_PRESENCE_ANNOUNCEMENT		=3D 13,
+	DPP_FRAME_RECONF_ANNOUNCEMENT		=3D 14,
+	DPP_FRAME_RECONF_AUTHENTICATION_REQUEST	=3D 15,
+	DPP_FRAME_RECONF_AUTHENTICATION_RESPONSE =3D 16,
+	DPP_FRAME_RECONF_AUTHENTICATION_CONFIRM =3D 17,
+	DPP_FRAME_PKEX_XCHG_REQUEST		=3D 18,
+	/* 19 - 255 reserved */
+};
+
+enum dpp_status {
+	DPP_STATUS_OK,
+	DPP_STATUS_NOT_COMPATIBLE,
+	DPP_STATUS_AUTH_FAILURE,
+	DPP_STATUS_BAD_CODE,
+	DPP_STATUS_BAD_GROUP,
+	DPP_STATUS_CONFIGURE_FAILURE,
+	DPP_STATUS_RESPONSE_PENDING,
+	DPP_STATUS_INVALID_CONNECTOR,
+	DPP_STATUS_NO_MATCH,
+	DPP_STATUS_CONFIG_REJECTED,
+	DPP_STATUS_NO_AP,
+	DPP_STATUS_CONFIGURE_PENDING,
+	DPP_STATUS_CSR_NEEDED,
+	DPP_STATUS_CSR_BAD,
+	DPP_STATUS_NEW_KEY_NEEDED,
+};
+
 enum dpp_attribute_type {
 	/* 0000 - 0FFF reserved */
 	DPP_ATTR_STATUS				=3D 0x1000,
-- =

2.31.1

--===============8150011950555481550==--

