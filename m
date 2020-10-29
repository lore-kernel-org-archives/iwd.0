Content-Type: multipart/mixed; boundary="===============0745670113447251385=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] frame-xchg: fix invalid read
Date: Thu, 29 Oct 2020 09:37:11 -0700
Message-ID: <20201029163711.2377089-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0745670113447251385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This seems to happen occationally with testAP (potentially others).
The invalid read appears to happen when the frame_xchg_tx_cb detects
an early status and no ACK. In this particular case there is no
retry interval so we reach the retry limit and 'done' the frame.
This frees the 'fx' data all before the destroy callback can get
called. Once we finally return and the destroy callback is called
'fx' is freed and we see the invalid write.

=3D=3D206=3D=3D Memcheck, a memory error detector
=3D=3D206=3D=3D Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et=
 al.
=3D=3D206=3D=3D Using Valgrind-3.16.1 and LibVEX; rerun with -h for copyrig=
ht info
=3D=3D206=3D=3D Command: iwd -p rad1,rad2,rad3,rad4 -d
=3D=3D206=3D=3D Parent PID: 140
=3D=3D206=3D=3D
=3D=3D206=3D=3D Invalid write of size 4
=3D=3D206=3D=3D    at 0x4493A0: frame_xchg_tx_destroy (frame-xchg.c:941)
=3D=3D206=3D=3D    by 0x46DAF6: destroy_request (genl.c:673)
=3D=3D206=3D=3D    by 0x46DAF6: process_unicast (genl.c:1002)
=3D=3D206=3D=3D    by 0x46DAF6: received_data (genl.c:1101)
=3D=3D206=3D=3D    by 0x46AA4B: io_callback (io.c:118)
=3D=3D206=3D=3D    by 0x469D6C: l_main_iterate (main.c:477)
=3D=3D206=3D=3D    by 0x469E1B: l_main_run (main.c:524)
=3D=3D206=3D=3D    by 0x469E1B: l_main_run (main.c:506)
=3D=3D206=3D=3D    by 0x46A02B: l_main_run_with_signal (main.c:646)
=3D=3D206=3D=3D    by 0x403E78: main (main.c:490)
=3D=3D206=3D=3D  Address 0x4c59c6c is 172 bytes inside a block of size 176 =
free'd
=3D=3D206=3D=3D    at 0x483B9F5: free (vg_replace_malloc.c:538)
=3D=3D206=3D=3D    by 0x40F14C: destroy_work (wiphy.c:248)
=3D=3D206=3D=3D    by 0x40F14C: wiphy_radio_work_done (wiphy.c:1578)
=3D=3D206=3D=3D    by 0x44A916: frame_xchg_tx_cb (frame-xchg.c:930)
=3D=3D206=3D=3D    by 0x46DAD9: process_unicast (genl.c:993)
=3D=3D206=3D=3D    by 0x46DAD9: received_data (genl.c:1101)
=3D=3D206=3D=3D    by 0x46AA4B: io_callback (io.c:118)
=3D=3D206=3D=3D    by 0x469D6C: l_main_iterate (main.c:477)
=3D=3D206=3D=3D    by 0x469E1B: l_main_run (main.c:524)
=3D=3D206=3D=3D    by 0x469E1B: l_main_run (main.c:506)
=3D=3D206=3D=3D    by 0x46A02B: l_main_run_with_signal (main.c:646)
=3D=3D206=3D=3D    by 0x403E78: main (main.c:490)
=3D=3D206=3D=3D  Block was alloc'd at
=3D=3D206=3D=3D    at 0x483A809: malloc (vg_replace_malloc.c:307)
=3D=3D206=3D=3D    by 0x4643CD: l_malloc (util.c:61)
=3D=3D206=3D=3D    by 0x44AF8C: frame_xchg_startv (frame-xchg.c:1155)
=3D=3D206=3D=3D    by 0x44B2A4: frame_xchg_start (frame-xchg.c:1108)
=3D=3D206=3D=3D    by 0x42BC55: ap_send_mgmt_frame (ap.c:709)
=3D=3D206=3D=3D    by 0x42F513: ap_probe_req_cb (ap.c:1869)
=3D=3D206=3D=3D    by 0x449752: frame_watch_unicast_notify (frame-xchg.c:23=
3)
=3D=3D206=3D=3D    by 0x46DA2F: dispatch_unicast_watches (genl.c:961)
=3D=3D206=3D=3D    by 0x46DA2F: process_unicast (genl.c:980)
=3D=3D206=3D=3D    by 0x46DA2F: received_data (genl.c:1101)
=3D=3D206=3D=3D    by 0x46AA4B: io_callback (io.c:118)
=3D=3D206=3D=3D    by 0x469D6C: l_main_iterate (main.c:477)
=3D=3D206=3D=3D    by 0x469E1B: l_main_run (main.c:524)
=3D=3D206=3D=3D    by 0x469E1B: l_main_run (main.c:506)
=3D=3D206=3D=3D    by 0x46A02B: l_main_run_with_signal (main.c:646)
=3D=3D206=3D=3D
---
 src/frame-xchg.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 0e3e330d..21dfd706 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -901,6 +901,8 @@ static void frame_xchg_tx_cb(struct l_genl_msg *msg, vo=
id *user_data)
 	uint64_t cookie;
 	bool early_status;
 =

+	fx->tx_cmd_id =3D 0;
+
 	l_debug("err %i", -error);
 =

 	if (error < 0) {
@@ -934,13 +936,6 @@ error:
 	frame_xchg_done(fx, error);
 }
 =

-static void frame_xchg_tx_destroy(void *user_data)
-{
-	struct frame_xchg_data *fx =3D user_data;
-
-	fx->tx_cmd_id =3D 0;
-}
-
 static bool frame_xchg_tx_retry(struct wiphy_radio_work_item *item)
 {
 	struct frame_xchg_data *fx =3D l_container_of(item,
@@ -974,7 +969,7 @@ static bool frame_xchg_tx_retry(struct wiphy_radio_work=
_item *item)
 					&duration);
 =

 	fx->tx_cmd_id =3D l_genl_family_send(nl80211, msg, frame_xchg_tx_cb, fx,
-						frame_xchg_tx_destroy);
+						NULL);
 	if (!fx->tx_cmd_id) {
 		l_error("Error sending frame");
 		l_genl_msg_unref(msg);
-- =

2.26.2

--===============0745670113447251385==--

