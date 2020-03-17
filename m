Content-Type: multipart/mixed; boundary="===============0590600092728832356=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] netdev: prepare for MAC randomization rework
Date: Tue, 17 Mar 2020 10:38:49 -0700
Message-ID: <20200317173855.19680-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0590600092728832356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new netdev error result for changing the MAC. This will allow
watchers to know if the reason for a failed connection was due to
changing the MAC. In these cases a descriptive log message could be
printed.

Adds a new enum netdev_set_mac_type. This type will be passed to
netdev_create_from_genl rather than the address directly.
---
 src/netdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/netdev.h b/src/netdev.h
index 58b63fbd..d468dc46 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -35,6 +35,7 @@ enum netdev_result {
 	NETDEV_RESULT_HANDSHAKE_FAILED,
 	NETDEV_RESULT_KEY_SETTING_FAILED,
 	NETDEV_RESULT_ABORTED,
+	NETDEV_RESULT_SET_MAC_FAILED,
 };
 =

 enum netdev_event {
@@ -65,6 +66,12 @@ enum netdev_iftype {
 	NETDEV_IFTYPE_P2P_GO,
 };
 =

+enum netdev_set_mac_type {
+	NETDEV_SET_MAC_DISABLED,
+	NETDEV_SET_MAC_ONCE,
+	NETDEV_SET_MAC_NETWORK,
+};
+
 typedef void (*netdev_command_cb_t)(struct netdev *netdev, int result,
 						void *user_data);
 /*
-- =

2.21.1

--===============0590600092728832356==--

