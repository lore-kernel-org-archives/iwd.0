Content-Type: multipart/mixed; boundary="===============7346792046046835481=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/7] auth-proto: document acceptable return values for
 auth-protos
Date: Wed, 08 Sep 2021 11:19:00 -0700
Message-ID: <20210908181904.84594-3-prestwoj@gmail.com>
In-Reply-To: <20210908181904.84594-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7346792046046835481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since all auth-protos are hidden behind an abstraction they need
to be consisten with the return values as some should be handled
specially.
---
 src/auth-proto.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/auth-proto.h b/src/auth-proto.h
index d3c4686f..f39c361c 100644
--- a/src/auth-proto.h
+++ b/src/auth-proto.h
@@ -25,6 +25,18 @@
 struct auth_proto {
 	bool (*start)(struct auth_proto *ap);
 	void (*free)(struct auth_proto *ap);
+	/*
+	 * Callback to receive an Authenticate frame. auth-protos should
+	 * return error codes consistent with one another as some are treated
+	 * specially:
+	 *
+	 * 0 indicates success
+	 * -ENOMSG or -EBADMSG indicates the message should be ignored silently
+	 * -EAGAIN indicates to try again (handled by auth-proto internally)
+	 * -EPROTO indicates a fatal error
+	 * Any other < 0 return will be treated as a fatal error
+	 * > 0 indicates a fatal error with status code.
+	 */
 	int (*rx_authenticate)(struct auth_proto *driver,
 					const uint8_t *frame, size_t len);
 	int (*rx_associate)(struct auth_proto *driver,
-- =

2.31.1

--===============7346792046046835481==--

