Content-Type: multipart/mixed; boundary="===============0745235919856613983=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] ap: Make ap_update_beacon public
Date: Wed, 10 Mar 2021 23:06:30 +0100
Message-ID: <20210310220635.944104-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0745235919856613983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let users call ap_update_beacon when a value has changed which should be
reflected in the beacon IEs.
---
 src/ap.c | 5 ++++-
 src/ap.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 5a86527f..6ab0c0fd 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -641,7 +641,7 @@ static void ap_set_beacon_cb(struct l_genl_msg *msg, vo=
id *user_data)
 		l_error("SET_BEACON failed: %s (%i)", strerror(-error), -error);
 }
 =

-static void ap_update_beacon(struct ap_state *ap)
+void ap_update_beacon(struct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 	uint8_t head[256], tail[256];
@@ -651,6 +651,9 @@ static void ap_update_beacon(struct ap_state *ap)
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 	};
 =

+	if (L_WARN_ON(!ap->started))
+		return;
+
 	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
 	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
diff --git a/src/ap.h b/src/ap.h
index dc57a0bb..6199bcbe 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -87,3 +87,4 @@ bool ap_station_disconnect(struct ap_state *ap, const uin=
t8_t *mac,
 				enum mmpdu_reason_code reason);
 =

 bool ap_push_button(struct ap_state *ap);
+void ap_update_beacon(struct ap_state *ap);
-- =

2.27.0

--===============0745235919856613983==--

