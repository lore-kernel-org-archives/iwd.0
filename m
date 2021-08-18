Content-Type: multipart/mixed; boundary="===============4814180899015342891=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] hwsim: remove unconditional packet delay
Date: Wed, 18 Aug 2021 15:09:29 -0700
Message-ID: <20210818220934.295721-3-prestwoj@gmail.com>
In-Reply-To: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4814180899015342891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was initially put in to solve an issue that was specific to
mac80211_hwsim where the connect callback would get queued and
delayed until after the connect event. This caused IWD to get very
confused.

Later it was found that "real" drivers can sometimes do this so
some code was added to IWD core to handle it.

Now there isn't much point to delay all frames unless a rule specifies
so change the behavior back to sending out frames immediately.
---
 tools/hwsim.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index c7b41750..cd4a99b7 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1436,9 +1436,11 @@ static void frame_delay_callback(struct l_timeout *t=
imeout, void *user_data)
 	else
 		send_frame_destroy(send_info);
 =

-	l_timeout_remove(timeout);
+	if (timeout)
+		l_timeout_remove(timeout);
 }
 =

+
 /*
  * Process frames in a similar way to how the kernel built-in hwsim medium
  * does this, with an additional optimization for unicast frames and
@@ -1457,7 +1459,7 @@ static void process_frame(struct hwsim_frame *frame)
 		struct radio_info_rec *radio =3D entry->data;
 		struct send_frame_info *send_info;
 		bool drop =3D drop_mcast;
-		uint32_t delay =3D HWSIM_DELAY_MIN_MS;
+		uint32_t delay =3D 0;
 =

 		if (radio =3D=3D frame->src_radio)
 			continue;
@@ -1499,11 +1501,16 @@ static void process_frame(struct hwsim_frame *frame)
 		send_info->radio =3D radio;
 		send_info->frame =3D hwsim_frame_ref(frame);
 =

-		if (!l_timeout_create_ms(delay, frame_delay_callback,
-						send_info, NULL)) {
-			l_error("Error delaying frame, frame will be dropped");
-			send_frame_destroy(send_info);
-		}
+		if (delay) {
+			if (!l_timeout_create_ms(delay, frame_delay_callback,
+							send_info, NULL)) {
+				l_error("Error delaying frame %ums, "
+						"frame will be dropped", delay);
+				send_frame_destroy(send_info);
+			}
+		} else
+			frame_delay_callback(NULL, send_info);
+
 	}
 =

 	hwsim_frame_unref(frame);
@@ -1999,7 +2006,7 @@ static struct l_dbus_message *rule_add(struct l_dbus =
*dbus,
 	rule->id =3D next_rule_id++;
 	rule->source_any =3D true;
 	rule->destination_any =3D true;
-	rule->delay =3D HWSIM_DELAY_MIN_MS;
+	rule->delay =3D 0;
 	rule->enabled =3D false;
 =

 	if (!rules)
-- =

2.31.1

--===============4814180899015342891==--

