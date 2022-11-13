Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A61374
	for <iwd@lists.linux.dev>; Sun, 13 Nov 2022 14:13:22 +0000 (UTC)
Received: from nuc.. (p4fefcef1.dip0.t-ipconnect.de [79.239.206.241])
	by mail.holtmann.org (Postfix) with ESMTPSA id C5127CECFE
	for <iwd@lists.linux.dev>; Sun, 13 Nov 2022 15:07:38 +0100 (CET)
From: Marcel Holtmann <marcel@holtmann.org>
To: iwd@lists.linux.dev
Subject: [PATCH] scan: Add support for separate 6Ghz band modifier
Date: Sun, 13 Nov 2022 15:07:35 +0100
Message-Id: <20221113140735.2325-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst |  7 +++++++
 src/scan.c         | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index bafb6b8513db..d77ed0776da8 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -310,6 +310,13 @@ autoconnect purposes.
        networks are highly RSSI sensitive, so it is still possible for IWD to
        prefer 2.4Ghz APs in certain circumstances.
 
+   * - BandModifier6Ghz
+     - Values: floating point value (default: **1.0**)
+
+       Increase or decrease the preference for 6GHz access points by increasing
+       or decreasing the value of this modifier.  Since 6GHz networks are highly
+       RSSI sensitive, this gives an option to prefer 6GHz APs over 5GHz APs.
+
 Scan
 ----
 
diff --git a/src/scan.c b/src/scan.c
index ee2d843c6127..5548914a12de 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -54,6 +54,7 @@
 
 /* User configurable options */
 static double RANK_5G_FACTOR;
+static double RANK_6G_FACTOR;
 static uint32_t SCAN_MAX_INTERVAL;
 static uint32_t SCAN_INIT_INTERVAL;
 
@@ -1645,10 +1646,14 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 
 	rank = (double)bss->data_rate / max_rate * USHRT_MAX;
 
-	/* Prefer 5G/6G networks over 2.4G */
-	if (bss->frequency > 4000)
+	/* Prefer 5G networks over 2.4G and 6G */
+	if (bss->frequency >= 4900 && bss->frequency < 5900)
 		rank *= RANK_5G_FACTOR;
 
+	/* Prefer 6G networks over 2.4G and 5G */
+	if (bss->frequency >= 5900 && bss->frequency < 7200)
+		rank *= RANK_6G_FACTOR;
+
 	/* Rank loaded APs lower and lightly loaded APs higher */
 	if (bss->utilization >= 192)
 		rank *= RANK_HIGH_UTILIZATION_FACTOR;
@@ -2343,6 +2348,10 @@ static int scan_init(void)
 					&RANK_5G_FACTOR))
 		RANK_5G_FACTOR = 1.0;
 
+	if (!l_settings_get_double(config, "Rank", "BandModifier6Ghz",
+					&RANK_6G_FACTOR))
+		RANK_6G_FACTOR = 1.0;
+
 	if (!l_settings_get_uint(config, "Scan", "InitialPeriodicScanInterval",
 					&SCAN_INIT_INTERVAL))
 		SCAN_INIT_INTERVAL = 10;
-- 
2.38.1

