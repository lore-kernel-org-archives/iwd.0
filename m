Content-Type: multipart/mixed; boundary="===============1255666950008221421=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] handshake: add HANDSHAKE_EVENT_EAP_COMPLETE
Date: Thu, 08 Apr 2021 08:46:42 -0700
Message-ID: <20210408154646.1182833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1255666950008221421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is being added in order to support 8021x
offloading since there is no event available to
station which indicates that EAP has finished.
---
 src/handshake.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handshake.h b/src/handshake.h
index b738efd9..3740d7f0 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -54,6 +54,7 @@ enum handshake_event {
 	HANDSHAKE_EVENT_FAILED,
 	HANDSHAKE_EVENT_REKEY_FAILED,
 	HANDSHAKE_EVENT_EAP_NOTIFY,
+	HANDSHAKE_EVENT_EAP_COMPLETE,
 };
 =

 typedef void (*handshake_event_func_t)(struct handshake_state *hs,
-- =

2.26.2

--===============1255666950008221421==--

