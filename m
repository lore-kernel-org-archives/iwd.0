Content-Type: multipart/mixed; boundary="===============3844645085430930122=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] netdev: fix crash from not cancelling netdev_get_oci
Date: Mon, 07 Feb 2022 11:43:34 -0800
Message-ID: <20220207194334.402597-1-prestwoj@gmail.com>

--===============3844645085430930122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If netdev_connect_failed is called before netdev_get_oci_cb() the
netdev's handshake will be destroyed and ultimately crash when the
callback is called.

This patch moves the cancelation into netdev_connect_free rather than
netdev_free.

++++++++ backtrace ++++++++
0  0x7f4e1787d320 in /lib64/libc.so.6
1  0x42634c in handshake_state_set_chandef() at src/handshake.c:1057
2  0x40a11b in netdev_get_oci_cb() at src/netdev.c:2387
3  0x483d7b in process_unicast() at ell/genl.c:986
4  0x480d3c in io_callback() at ell/io.c:120
5  0x48004d in l_main_iterate() at ell/main.c:472 (discriminator 2)
6  0x4800fc in l_main_run() at ell/main.c:521
7  0x48032c in l_main_run_with_signal() at ell/main.c:649
8  0x403e95 in main() at src/main.c:532
9  0x7f4e17867b75 in /lib64/libc.so.6
+++++++++++++++++++++++++++
---
 src/netdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index cda0c7fc..bac6860c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -838,6 +838,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->disconnect_cmd_id =3D 0;
 	}
 =

+	if (netdev->get_oci_cmd_id) {
+		l_genl_family_cancel(nl80211, netdev->get_oci_cmd_id);
+		netdev->get_oci_cmd_id =3D 0;
+	}
+
 	if (netdev->ft_ds_list) {
 		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
 		netdev->ft_ds_list =3D NULL;
@@ -949,11 +954,6 @@ static void netdev_free(void *data)
 		netdev->get_station_cmd_id =3D 0;
 	}
 =

-	if (netdev->get_oci_cmd_id) {
-		l_genl_family_cancel(nl80211, netdev->get_oci_cmd_id);
-		netdev->get_oci_cmd_id =3D 0;
-	}
-
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 =

-- =

2.31.1

--===============3844645085430930122==--

