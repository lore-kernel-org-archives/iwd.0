Content-Type: multipart/mixed; boundary="===============0486761399515696810=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] handshake: add offload flag
Date: Thu, 18 Mar 2021 10:20:37 -0700
Message-ID: <20210318172039.278896-4-prestwoj@gmail.com>
In-Reply-To: <20210318172039.278896-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0486761399515696810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If true, this flag indicates the handshake is being offloaded to
the kernel/hardware.
---
 src/handshake.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handshake.h b/src/handshake.h
index b738efd9..e667fccd 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -116,6 +116,7 @@ struct handshake_state {
 	bool wait_for_gtk : 1;
 	bool no_rekey : 1;
 	bool support_fils : 1;
+	bool offload : 1;
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
-- =

2.26.2

--===============0486761399515696810==--

