Content-Type: multipart/mixed; boundary="===============0961215012457996089=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] ie: add ie_parse_oci
Date: Mon, 18 Oct 2021 15:33:56 -0700
Message-ID: <20211018223359.497849-1-prestwoj@gmail.com>

--===============0961215012457996089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a very minimal parser, more or less to put the type
and length checks into a single location.
---
 src/ie.c | 20 ++++++++++++++++++++
 src/ie.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 11746c5c..a5f3cbc2 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2552,3 +2552,23 @@ int ie_parse_owe_transition(const void *data, size_t=
 len,
 =

 	return 0;
 }
+
+int ie_parse_oci(const void *data, size_t len, const uint8_t **oci)
+{
+	struct ie_tlv_iter iter;
+
+	ie_tlv_iter_init(&iter, data, len);
+
+	if (!ie_tlv_iter_next(&iter))
+		return -EMSGSIZE;
+
+	if (ie_tlv_iter_get_length(&iter) !=3D 3)
+		return -EMSGSIZE;
+
+	if (ie_tlv_iter_get_tag(&iter) !=3D IE_TYPE_OCI)
+		return -EPROTOTYPE;
+
+	*oci =3D ie_tlv_iter_get_data(&iter);
+
+	return 0;
+}
diff --git a/src/ie.h b/src/ie.h
index f6b15abb..b122524b 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -645,3 +645,5 @@ int ie_parse_network_cost(const void *data, size_t len,
 =

 int ie_parse_owe_transition(const void *data, size_t len,
 				struct ie_owe_transition_info *info);
+
+int ie_parse_oci(const void *data, size_t len, const uint8_t **oci);
-- =

2.31.1

--===============0961215012457996089==--

