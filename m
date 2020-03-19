Content-Type: multipart/mixed; boundary="===============6375607127271773344=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/9] p2putil: Add WFD IE parsing utilities
Date: Thu, 19 Mar 2020 22:12:15 +0100
Message-ID: <20200319211218.32083-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200319211218.32083-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6375607127271773344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only add constants for parsing the Device Information subelement as that
is the main thing we care about in P2P code.  And since our own WFD IEs
will likely only need to contain the Device Information subelement, we
don't need builder utilities.  We do need iterator utilities because we
may receive WFD IEs with more subelements.
---
This could also be placed in a header file on its own if preferred.  On
the other hand iterating over the WFD IE elements and P2P IE elements
works the same way except for the endiannes of the length field, so
those functions could be replaced with macros pointing at the P2P IE
utils (p2p_attr_iter_*) with the exception of wfd_subelem_iter_next.
---
 src/p2putil.c | 22 +++++++++++++++++
 src/p2putil.h | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/src/p2putil.c b/src/p2putil.c
index 58a75a11..ef69f88d 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -58,6 +58,28 @@ bool p2p_attr_iter_next(struct p2p_attr_iter *iter)
 	return true;
 }
 =

+void wfd_subelem_iter_init(struct wfd_subelem_iter *iter, const uint8_t *p=
du,
+				size_t len)
+{
+	iter->pos =3D pdu;
+	iter->end =3D pdu + len;
+	iter->type =3D -1;
+}
+
+bool wfd_subelem_iter_next(struct wfd_subelem_iter *iter)
+{
+	if (iter->type !=3D (enum wfd_subelem_type) -1)
+		iter->pos +=3D 3 + iter->len;
+
+	if (iter->pos + 3 > iter->end ||
+			iter->pos + 3 + l_get_be16(iter->pos + 1) > iter->end)
+		return false;
+
+	iter->type =3D iter->pos[0];
+	iter->len =3D l_get_be16(iter->pos + 1);
+	return true;
+}
+
 enum attr_flag {
 	ATTR_FLAG_REQUIRED  =3D 0x1,  /* Always required */
 };
diff --git a/src/p2putil.h b/src/p2putil.h
index 09c72c74..c609ab16 100644
--- a/src/p2putil.h
+++ b/src/p2putil.h
@@ -152,6 +152,73 @@ static inline const uint8_t *p2p_attr_iter_get_data(st=
ruct p2p_attr_iter *iter)
 	return iter->pos + 3;
 }
 =

+/* Wi-Fi Display Technical Specification v2.1.0 Table 27 */
+enum wfd_subelem_type {
+	WFD_SUBELEM_WFD_DEVICE_INFORMATION	=3D 0,
+	WFD_SUBELEM_ASSOCIATED_BSSID		=3D 1,
+	WFD_SUBELEM_COUPLED_SINK_INFORMATION	=3D 6,
+	WFD_SUBELEM_EXTENDED_CAPABILITY		=3D 7,
+	WFD_SUBELEM_LOCAL_IP_ADDRESS		=3D 8,
+	WFD_SUBELEM_SESION_INFORMATION		=3D 9,
+	WFD_SUBELEM_ALTERNATIVE_MAC_ADDRESS	=3D 10,
+	WFD_SUBELEM_R2_DEVICE_INFORMATION	=3D 11,
+};
+
+enum wfd_dev_info_bits {
+	WFD_DEV_INFO_DEVICE_TYPE		=3D 0x0003,
+	WFD_DEV_INFO_COUPLED_SINK_AT_SOURCE_OK	=3D 0x0004,
+	WFD_DEV_INFO_COUPLED_SINK_AT_SINK_OK	=3D 0x0008,
+	WFD_DEV_INFO_SESSION_AVAILABILITY	=3D 0x0030,
+	WFD_DEV_INFO_SERVICE_DISCOVERY_SUPPORT	=3D 0x0040,
+	WFD_DEV_INFO_PREFER_TDLS_CONNECTIVITY	=3D 0x0080,
+	WFD_DEV_INFO_CONTENT_PROTECTION_SUPPORT	=3D 0x0100,
+	WFD_DEV_INFO_8021AS_TIME_SYNC_SUPPORT	=3D 0x0200,
+	WFD_DEV_INFO_NO_AUDIO_AT_PRIMARY_SINK	=3D 0x0400,
+	WFD_DEV_INFO_AUDIO_ONLY_AT_SOURCE	=3D 0x0800,
+	WFD_DEV_INFO_TDLS_PERSISTENT_GROUP	=3D 0x1000,
+	WFD_DEV_INFO_REINVOKE_TDLS_GROUP	=3D 0x2000,
+};
+
+enum wfd_dev_info_type {
+	WFD_DEV_INFO_TYPE_SOURCE		=3D 0x0000,
+	WFD_DEV_INFO_TYPE_PRIMARY_SINK		=3D 0x0001,
+	WFD_DEV_INFO_TYPE_SECONDARY_SINK	=3D 0x0002,
+	WFD_DEV_INFO_TYPE_DUAL_ROLE		=3D 0x0003,
+};
+
+enum wfd_dev_info_session_availability {
+	WFD_DEV_INFO_SESSION_NOT_AVAILABLE	=3D 0x0000,
+	WFD_DEV_INFO_SESSION_AVAILABLE		=3D 0x0010,
+};
+
+struct wfd_subelem_iter {
+	const uint8_t *pos;
+	const uint8_t *end;
+	enum wfd_subelem_type type;
+	size_t len;
+};
+
+void wfd_subelem_iter_init(struct wfd_subelem_iter *iter, const uint8_t *p=
du,
+				size_t len);
+bool wfd_subelem_iter_next(struct wfd_subelem_iter *iter);
+
+static inline enum wfd_subelem_type wfd_subelem_iter_get_type(
+						struct wfd_subelem_iter *iter)
+{
+	return iter->type;
+}
+
+static inline size_t wfd_subelem_iter_get_length(struct wfd_subelem_iter *=
iter)
+{
+	return iter->len;
+}
+
+static inline const uint8_t *wfd_subelem_iter_get_data(
+						struct wfd_subelem_iter *iter)
+{
+	return iter->pos + 3;
+}
+
 struct p2p_capability_attr {
 	uint8_t device_caps;
 	uint8_t group_caps;
-- =

2.20.1

--===============6375607127271773344==--

