Content-Type: multipart/mixed; boundary="===============9209376853086430321=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] p2p,netdev: Fix event name typo in comments
Date: Mon, 26 Apr 2021 15:26:34 +0200
Message-ID: <20210426132638.758600-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9209376853086430321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the spelling of NETDEV_RESULT_KEY_SETTING_FAILED in two comments.
---
 src/netdev.h | 2 +-
 src/p2p.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/netdev.h b/src/netdev.h
index 0e09ae69..43ea3893 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -80,7 +80,7 @@ typedef void (*netdev_command_cb_t)(struct netdev *netdev=
, int result,
  * NETDEV_RESULT_AUTHENTICATION_FAILED - MMPDU_STATUS_CODE
  * NETDEV_RESULT_ASSOCIATION_FAILED - MMPDU_STATUS_CODE
  * NETDEV_RESULT_HANDSHAKE_FAILED - MMPDU_REASON_CODE
- * NETDEV_RESULT_KEY_SETTINGS_FAILED - unused
+ * NETDEV_RESULT_KEY_SETTING_FAILED - unused
  * NETDEV_RESULT_ABORTED - unused.
  */
 typedef void (*netdev_connect_cb_t)(struct netdev *netdev,
diff --git a/src/p2p.c b/src/p2p.c
index e3130e21..f0324d31 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1321,7 +1321,7 @@ static void p2p_netdev_connect_cb(struct netdev *netd=
ev,
 		/*
 		 * In the AUTHENTICATION_FAILED and ASSOCIATION_FAILED
 		 * cases there's nothing to disconnect.  In the
-		 * HANDSHAKE_FAILED and KEY_SETTINGS failed cases
+		 * HANDSHAKE_FAILED and KEY_SETTING failed cases
 		 * netdev disconnects from the GO automatically and we are
 		 * called already from within the disconnect callback,
 		 * so we can directly free the netdev.
-- =

2.27.0

--===============9209376853086430321==--

