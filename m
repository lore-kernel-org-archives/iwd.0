Content-Type: multipart/mixed; boundary="===============6545287075506440775=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/9] ie: Add ie_tlv_extract_wfd_payload
Date: Thu, 19 Mar 2020 22:12:16 +0100
Message-ID: <20200319211218.32083-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200319211218.32083-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6545287075506440775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.c | 17 +++++++++++++++++
 src/ie.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index f120c89e..8d212ea0 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -200,6 +200,23 @@ void *ie_tlv_extract_p2p_payload(const unsigned char *=
ies, size_t len,
 					ies, len, true, out_len);
 }
 =

+/*
+ * Wi-Fi Display Technical Specification v2.1.0, Section 5.1.1:
+ * "More than one WFD IE may be included in a single frame.  If multiple W=
FD
+ * IEs are present, the complete WFD subelement data consists of the
+ * concatenation of the WFD subelement fields of the WFD IEs.  The WFD
+ * subelements field of each WFD IE may be any length up to the maximum
+ * (251 octets).  The order of the concatenated WFD subelement data shall =
be
+ * preserved in the ordering of the WFD IEs in the frame.  All of the WFD =
IEs
+ * shall fit within a single frame and shall be adjacent in the frame."
+ */
+void *ie_tlv_extract_wfd_payload(const unsigned char *ies, size_t len,
+							ssize_t *out_len)
+{
+	return ie_tlv_vendor_ie_concat(wifi_alliance_oui, 0x0a,
+					ies, len, true, out_len);
+}
+
 /*
  * Encapsulate & Fragment data into Vendor IE with a given OUI + type
  *
diff --git a/src/ie.h b/src/ie.h
index 12a664b5..47dc9eff 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -431,6 +431,9 @@ void *ie_tlv_extract_p2p_payload(const uint8_t *ies, si=
ze_t len,
 void *ie_tlv_encapsulate_p2p_payload(const uint8_t *data, size_t len,
 							size_t *out_len);
 =

+void *ie_tlv_extract_wfd_payload(const unsigned char *ies, size_t len,
+							ssize_t *out_len);
+
 bool ie_tlv_builder_init(struct ie_tlv_builder *builder, unsigned char *bu=
f,
 				size_t len);
 bool ie_tlv_builder_set_length(struct ie_tlv_builder *builder,
-- =

2.20.1

--===============6545287075506440775==--

