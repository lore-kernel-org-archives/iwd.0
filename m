Content-Type: multipart/mixed; boundary="===============7280563847450474921=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] ap: Make ap_update_beacon public
Date: Sat, 06 Feb 2021 00:46:49 +0100
Message-ID: <20210205234651.139105-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210205234651.139105-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7280563847450474921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let users call ap_update_beacon when a value has changed which should be
reflected in the beacon IEs.  It will cause the registered vendor IE
writers to be re-run.
---
 src/ap.c | 5 ++++-
 src/ap.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index dbc624c2..c9de2651 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -611,7 +611,7 @@ static void ap_set_beacon_cb(struct l_genl_msg *msg, vo=
id *user_data)
 		l_error("SET_BEACON failed: %s (%i)", strerror(-error), -error);
 }
 =

-static void ap_update_beacon(struct ap_state *ap)
+void ap_update_beacon(struct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 	uint8_t head[256];
@@ -623,6 +623,9 @@ static void ap_update_beacon(struct ap_state *ap)
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 	};
 =

+	if (L_WARN_ON(!ap->started))
+		return;
+
 	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
 	tail_len =3D ap_build_beacon_pr_tail(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
diff --git a/src/ap.h b/src/ap.h
index eb4f96df..9ee7a0b8 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -100,3 +100,4 @@ bool ap_station_disconnect(struct ap_state *ap, const u=
int8_t *mac,
 				enum mmpdu_reason_code reason);
 =

 bool ap_push_button(struct ap_state *ap);
+void ap_update_beacon(struct ap_state *ap);
-- =

2.27.0

--===============7280563847450474921==--

