Content-Type: multipart/mixed; boundary="===============0436803094471849509=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/9] auth-proto: add auth_proto_rx_oci
Date: Tue, 28 Sep 2021 08:46:52 -0700
Message-ID: <20210928154658.2382597-3-prestwoj@gmail.com>
In-Reply-To: 20210928154658.2382597-1-prestwoj@gmail.com

--===============0436803094471849509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows auth protos to get notified when the chandef has been
set. Since netdev sets chandef already there is no arguments.
---
 src/auth-proto.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/auth-proto.h b/src/auth-proto.h
index 33a74291..9f8da604 100644
--- a/src/auth-proto.h
+++ b/src/auth-proto.h
@@ -44,6 +44,7 @@ struct auth_proto {
 					const uint8_t *frame, size_t len);
 	int (*rx_associate)(struct auth_proto *driver,
 					const uint8_t *frame, size_t len);
+	int (*rx_oci)(struct auth_proto *driver);
 	bool (*auth_timeout)(struct auth_proto *ap);
 	bool (*assoc_timeout)(struct auth_proto *ap);
 	uint8_t prev_bssid[6];
@@ -98,3 +99,11 @@ static inline bool auth_proto_assoc_timeout(struct auth_=
proto *ap)
 =

 	return false;
 }
+
+static inline int auth_proto_rx_oci(struct auth_proto *ap)
+{
+	if (ap && ap->rx_oci)
+		return ap->rx_oci(ap);
+
+	return -ENOTSUP;
+}
-- =

2.31.1

--===============0436803094471849509==--

