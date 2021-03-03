Content-Type: multipart/mixed; boundary="===============0026843059136580024=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] handshake: add offload member
Date: Wed, 03 Mar 2021 09:47:28 -0800
Message-ID: <20210303174730.6738-2-prestwoj@gmail.com>
In-Reply-To: <20210303174730.6738-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0026843059136580024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This flag indicates the handshake is being offloaded to the
kernel/driver.
---
 src/handshake.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handshake.h b/src/handshake.h
index b738efd9..0468cbd1 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -116,6 +116,7 @@ struct handshake_state {
 	bool wait_for_gtk : 1;
 	bool no_rekey : 1;
 	bool support_fils : 1;
+	bool offload_psk : 1;
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
-- =

2.26.2

--===============0026843059136580024==--

