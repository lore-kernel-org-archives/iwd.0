Content-Type: multipart/mixed; boundary="===============7200908172337195155=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 05/10] dpp: rework order of operations after being configured
Date: Tue, 11 Jan 2022 16:55:53 -0800
Message-ID: <20220112005558.1158405-5-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============7200908172337195155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now the result is sent immediately. Prior a connect attempt or
scan could have started, potentially losing this frame. In addition
the offchannel operation is cancelled after sending the result
which will allow the subsequent connect or scan to happen much
faster since it doesn't have to wait for ROC to expire.
---
 src/dpp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 5e07a61a..e0ae8aa6 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -639,6 +639,11 @@ static void dpp_handle_config_response_frame(const str=
uct mmpdu_header *frame,
 	}
 =

 	dpp_write_config(config, network);
+	dpp_configuration_free(config);
+
+	send_config_result(dpp, dpp->auth_addr);
+
+	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 =

 	if (network && bss)
 		__station_connect_network(station, network, bss);
@@ -647,15 +652,10 @@ static void dpp_handle_config_response_frame(const st=
ruct mmpdu_header *frame,
 						dpp_scan_triggered,
 						dpp_scan_results, dpp,
 						dpp_scan_destroy);
-		if (!dpp->connect_scan_id)
-			goto scan_failed;
+		if (dpp->connect_scan_id)
+			return;
 	}
 =

-	dpp_configuration_free(config);
-
-	send_config_result(dpp, dpp->auth_addr);
-
-scan_failed:
 	dpp_reset(dpp);
 }
 =

-- =

2.31.1

--===============7200908172337195155==--

