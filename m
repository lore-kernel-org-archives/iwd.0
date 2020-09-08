Content-Type: multipart/mixed; boundary="===============3307963638807764223=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/17] ap: Make ap_update_beacon public
Date: Wed, 09 Sep 2020 01:49:32 +0200
Message-ID: <20200908234933.301439-16-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3307963638807764223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let users call ap_update_beacon when they've changed something in the
beacon IEs returned by ops->write_mgmt_frame_ies(BEACON) to cause a new
call to that method.
---
 src/ap.c | 5 ++++-
 src/ap.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index c1e1e389..8ef42c77 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -511,7 +511,7 @@ static void ap_set_beacon_cb(struct l_genl_msg *msg, vo=
id *user_data)
 		l_error("SET_BEACON failed: %s (%i)", strerror(-error), -error);
 }
 =

-static void ap_update_beacon(struct ap_state *ap)
+void ap_update_beacon(struct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 	size_t extra_ies_len =3D ap->ops->get_mgmt_frame_ies_len ?
@@ -525,6 +525,9 @@ static void ap_update_beacon(struct ap_state *ap)
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
index 25ecc15a..233e9269 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -90,3 +90,4 @@ bool ap_station_disconnect(struct ap_state *ap, const uin=
t8_t *mac,
 				enum mmpdu_reason_code reason);
 =

 bool ap_push_button(struct ap_state *ap);
+void ap_update_beacon(struct ap_state *ap);
-- =

2.25.1

--===============3307963638807764223==--

