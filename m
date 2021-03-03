Content-Type: multipart/mixed; boundary="===============5146137981778226733=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] netdev: offload handshake when requested
Date: Wed, 03 Mar 2021 09:47:30 -0800
Message-ID: <20210303174730.6738-4-prestwoj@gmail.com>
In-Reply-To: <20210303174730.6738-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5146137981778226733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Set the PMK attribute if offloading the handshake is requested.
Since station relies on handshake events the key setting event
must be simulated in order to sync the PSK. As of now, no other
handshake events are required explicitly.
---
 src/netdev.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 1f2aa51c..2c96d611 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1958,6 +1958,16 @@ process_resp_ies:
 		return;
 	}
 =

+	/*
+	 * In the offload case this handshake is completed, simulate setting
+	 * the keys so station sync's PSK and treats this the same as a
+	 * non-offload connection
+	 */
+	if (netdev->handshake->offload_psk) {
+		handshake_event(netdev->handshake,
+					HANDSHAKE_EVENT_SETTING_KEYS);
+	}
+
 	netdev_connect_ok(netdev);
 =

 	return;
@@ -2635,6 +2645,10 @@ static struct l_genl_msg *netdev_build_cmd_connect(s=
truct netdev *netdev,
 				NL80211_ATTR_CONTROL_PORT_OVER_NL80211,
 				0, NULL);
 =

+	if (hs->offload_psk)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, hs->pmk_len,
+					hs->pmk);
+
 	rm_enabled_capabilities =3D
 			wiphy_get_rm_enabled_capabilities(netdev->wiphy);
 	if (rm_enabled_capabilities && bss->capability & IE_BSS_CAP_RM) {
@@ -3000,7 +3014,7 @@ int netdev_connect(struct netdev *netdev, struct scan=
_bss *bss,
 		if (!cmd_connect)
 			return -EINVAL;
 =

-		if (is_rsn || hs->settings_8021x)
+		if (!hs->offload_psk && (is_rsn || hs->settings_8021x))
 			sm =3D eapol_sm_new(hs);
 	}
 =

-- =

2.26.2

--===============5146137981778226733==--

