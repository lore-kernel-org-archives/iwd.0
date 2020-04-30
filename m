Content-Type: multipart/mixed; boundary="===============0447446323774192912=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] netdev: Handle P2P-client iftype in
 netdev_setting_keys_failed
Date: Thu, 30 Apr 2020 15:48:45 +0200
Message-ID: <20200430134847.62234-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200430134847.62234-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0447446323774192912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netdev.c b/src/netdev.c
index 32c76b17..69f9ab85 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1054,6 +1054,7 @@ static void netdev_setting_keys_failed(struct netdev_=
handshake_state *nhs,
 =

 	switch (netdev->type) {
 	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
 		msg =3D netdev_build_cmd_disconnect(netdev,
 						MMPDU_REASON_CODE_UNSPECIFIED);
 		netdev->disconnect_cmd_id =3D l_genl_family_send(nl80211, msg,
-- =

2.25.1

--===============0447446323774192912==--

