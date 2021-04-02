Content-Type: multipart/mixed; boundary="===============1005818312643022772=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 2/4] netdev: fix CMD_ROAM for open networks
Date: Fri, 02 Apr 2021 15:06:15 -0700
Message-ID: <20210402220617.937790-2-prestwoj@gmail.com>
In-Reply-To: <20210402220617.937790-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1005818312643022772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the FW scan callback eapol was being stared unconditionally which
isn't correct as roaming on open networks is possible. Instead check
that a SM exists just like is done in netdev_connect_event.
---
 src/netdev.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index db7f6bbc..fe29de8f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4107,9 +4107,7 @@ static bool netdev_get_fw_scan_cb(int err, struct l_q=
ueue *bss_list,
 =

 	if (err < 0) {
 		l_error("Failed to get scan after roam (%d)", err);
-		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-					MMPDU_REASON_CODE_UNSPECIFIED);
-		return false;
+		goto failed;
 	}
 =

 	/*
@@ -4121,17 +4119,23 @@ static bool netdev_get_fw_scan_cb(int err, struct l=
_queue *bss_list,
 =

 	if (!bss) {
 		l_error("Roam target BSS not found in scan results");
-		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-					MMPDU_REASON_CODE_UNSPECIFIED);
-		return false;
+		goto failed;
 	}
 =

 	netdev->fw_roam_bss =3D bss;
 =

 	handshake_state_set_authenticator_ie(netdev->handshake, bss->rsne);
 =

-	eapol_start(netdev->sm);
+	if (netdev->sm) {
+		if (!eapol_start(netdev->sm))
+			goto failed;
+	}
+
+	return false;
 =

+failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
 	return false;
 }
 =

-- =

2.26.2

--===============1005818312643022772==--

