Content-Type: multipart/mixed; boundary="===============2545095795327694827=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] tools: delay hwsim sending frame
Date: Mon, 04 May 2020 13:16:13 -0700
Message-ID: <20200504201613.5314-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2545095795327694827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using mac80211_hwsim can sometimes result in out of order messages
coming from the kernel. Since mac80211_hwsim immediately sends out
frames and the kernel keeps command responses in a separate queue,
bad scheduling can result in these messages being out of order.
In some cases we receive Auth/Assoc frames before the response to
our original CMD_CONNECT. This causes autotests to fail randomly,
some more often than others.

To fix this we can introduce a small delay into hwsim. Just a 1ms
delay makes the random failures disappear in the tests. This delay
is also makes hwsim more realistic since actual hardware will always
introduce some kind of delay when sending or receiving frames.
---
 tools/hwsim.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 951ead36..d066f814 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1350,6 +1350,19 @@ static bool interface_info_match_dst(const void *a, =
const void *b)
 		!memcmp(rec->addr, dst->addr, ETH_ALEN);
 }
 =

+static void frame_delay_callback(struct l_timeout *timeout, void *user_dat=
a)
+{
+	struct send_frame_info *send_info =3D user_data;
+
+	if (send_frame(send_info, send_frame_callback,
+					send_frame_destroy))
+		send_info->frame->pending_callback_count++;
+	else
+		send_frame_destroy(send_info);
+
+	l_timeout_remove(timeout);
+}
+
 /*
  * Process frames in a similar way to how the kernel built-in hwsim medium
  * does this, with an additional optimization for unicast frames and
@@ -1409,11 +1422,11 @@ static void process_frame(struct hwsim_frame *frame)
 		send_info->radio =3D radio;
 		send_info->frame =3D hwsim_frame_ref(frame);
 =

-		if (send_frame(send_info, send_frame_callback,
-					send_frame_destroy))
-			frame->pending_callback_count++;
-		else
+		if (!l_timeout_create_ms(1, frame_delay_callback,
+						send_info, NULL)) {
+			l_error("Error delaying frame, frame will be dropped");
 			send_frame_destroy(send_info);
+		}
 	}
 =

 	hwsim_frame_unref(frame);
-- =

2.21.1

--===============2545095795327694827==--

