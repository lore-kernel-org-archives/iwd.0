Content-Type: multipart/mixed; boundary="===============5354520484282151812=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/5] auth-proto: document acceptable return values for
 auth-protos
Date: Wed, 08 Sep 2021 14:31:58 -0700
Message-ID: <20210908213201.97115-2-prestwoj@gmail.com>
In-Reply-To: <20210908213201.97115-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5354520484282151812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since all auth-protos are hidden behind an abstraction they need
to be consisten with the return values as some should be handled
specially.
---
 src/auth-proto.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/auth-proto.h b/src/auth-proto.h
index d3c4686f..33a74291 100644
--- a/src/auth-proto.h
+++ b/src/auth-proto.h
@@ -25,6 +25,21 @@
 struct auth_proto {
 	bool (*start)(struct auth_proto *ap);
 	void (*free)(struct auth_proto *ap);
+	/*
+	 * Callback to receive an Authenticate frame. auth-protos should
+	 * return error codes consistent with one another as some are treated
+	 * specially:
+	 *
+	 * 0 indicates success, and that a state transition occurred.
+	 * -ENOMSG or -EBADMSG indicates the message should be ignored silently
+	 * -EAGAIN indicates a retry, and no state transition occurred. Any
+	 *         retry is handled by the auth-proto internally
+	 * -EPROTO indicates a fatal error
+	 * Any other < 0 return will be treated as a fatal error
+	 * > 0 indicates a fatal error with status code. This only applies to
+	 *         non-sta cases as non-zero status codes are rejected by the
+	 *         kernel when in station mode.
+	 */
 	int (*rx_authenticate)(struct auth_proto *driver,
 					const uint8_t *frame, size_t len);
 	int (*rx_associate)(struct auth_proto *driver,
-- =

2.31.1

--===============5354520484282151812==--

