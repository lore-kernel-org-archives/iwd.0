Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090074A1A
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 16:37:12 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id go3so4865870pjb.0
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gv0Gc6Eh6Spxe9fTHZB0uG90pjO05o2p3SJiOIb9gX4=;
        b=p8zw+GQSDlvyPeN814OGiOv23Ut8zZhsWt7JyOLvHsAddJBFw7W6s5AgiV6kaD/6Cz
         RsCwLdo7t4At3wpqQLiR1TdssLPCSqgK79+z1v63JGh9tGwvCJy4x48nGWT2yyt3UpUT
         0sZIP5kAf1FXh9oaD1UkyLoPaw1GWtfpM8rYW6CXeTMi03yl2fvdpYL8eze4NjsZrMB8
         ocsJDONngvAcSjds6ucq054ekvJUzQjGi7Bp/el35IaQavKg0/ht1ikSnclnFR/Ag45n
         p7t9ePJqYoZMJ7z4pn/XwlqYnUPWvZJkgfLTdd9+l7xCXiefAv1124CABiHTVSuoengt
         fZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gv0Gc6Eh6Spxe9fTHZB0uG90pjO05o2p3SJiOIb9gX4=;
        b=lSJIbdzM5TFsGyuJOjOPKNNCx2lwjwi38VTFXuq1YcajBqdq0PSUJWh+3xL3KrUuxp
         v08Q8jJAeEV5mtnuowYkXbfJFTgEIDft4PtwyO8FwLfthGlvhe4NpkudghdazTDTR6+q
         lfLOj3UAW3yUZ5xhgtbqU3pbPqrry3zTCRfwE9Z2trlFXrDtDdKEDe0CFdGA0UGHCdxC
         pKzAUXd6JaenOyeSeja0fj9rDjWtH6AHg/Yezhcu6+YH0gpdO5QIubUj6EyEEpC+5AlO
         vSx/ogZ58bHzb4mlvd8w6NJB7/ixbEYqKppBqF6844dgr7slVigaeC8vldcm0Jp/1PEW
         aKjw==
X-Gm-Message-State: AJIora8dduZtLpB44yQbKPOtR5c+S/6aFphFq/3iWzaVI1GJ6VCuVG1e
	WPnt7fcCXtwdrsFcsQffdoZinZJSAlI=
X-Google-Smtp-Source: AGRyM1tai/uhXNF/vymVXXkh4Iq+zC9flMoydoSEsI+xHcaQdIO3+JBKLcB3Ovxw0rde4kLk4IW6+g==
X-Received: by 2002:a17:902:d5cf:b0:16c:e0ce:dbd8 with SMTP id g15-20020a170902d5cf00b0016ce0cedbd8mr373006plh.55.1658507832102;
        Fri, 22 Jul 2022 09:37:12 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0016a109c7606sm4013887plf.259.2022.07.22.09.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:37:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] scan: make scan_freq_set const in scan_passive
Date: Fri, 22 Jul 2022 09:34:12 -0700
Message-Id: <20220722163417.1119334-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722163417.1119334-1-prestwoj@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan_passive API wasn't using a const struct scan_freq_set as it
should be since it's not modifying the contents. Changing this to
const did require some additional changes like making the scan_parameters
'freqs' member const as well.

After changing scan_parameters, p2p needed updating since it was using
scan_parameters.freqs directly. This was changed to using a separate
scan_freq_set pointer, then setting to scan_parameters.freqs when needed.
---
 src/p2p.c  | 21 +++++++++++++--------
 src/scan.c |  4 ++--
 src/scan.h |  4 ++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index a7207c30..ff3b8e45 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1977,6 +1977,7 @@ static bool p2p_provision_scan_notify(int err, struct l_queue *bss_list,
 static void p2p_provision_scan_start(struct p2p_device *dev)
 {
 	struct scan_parameters params = {};
+	struct scan_freq_set *freqs = NULL;
 	uint8_t buf[256];
 
 	params.flush = true;
@@ -2005,16 +2006,17 @@ static void p2p_provision_scan_start(struct p2p_device *dev)
 	 * contain all of the 2.4 and 5G channels.
 	 */
 	if (dev->conn_go_scan_retry < 12) {
-		params.freqs = scan_freq_set_new();
-		scan_freq_set_add(params.freqs, dev->conn_go_oper_freq);
+		freqs = scan_freq_set_new();
+		scan_freq_set_add(freqs, dev->conn_go_oper_freq);
+		params.freqs = freqs;
 	}
 
 	dev->scan_id = scan_active_full(dev->wdev_id, &params, NULL,
 					p2p_provision_scan_notify, dev,
 					p2p_scan_destroy);
 
-	if (params.freqs)
-		scan_freq_set_free(params.freqs);
+	if (freqs)
+		scan_freq_set_free(freqs);
 }
 
 static void p2p_start_client_provision(struct p2p_device *dev)
@@ -3777,6 +3779,7 @@ schedule:
 static bool p2p_device_scan_start(struct p2p_device *dev)
 {
 	struct scan_parameters params = {};
+	struct scan_freq_set *freqs;
 	uint8_t buf[256];
 	unsigned int i;
 
@@ -3812,13 +3815,13 @@ static bool p2p_device_scan_start(struct p2p_device *dev)
 	 * Request frames intended for both P2P Devices and non-P2P Devices."
 	 */
 	params.no_cck_rates = true;
-	params.freqs = scan_freq_set_new();
+	freqs = scan_freq_set_new();
 
 	for (i = 0; i < L_ARRAY_SIZE(channels_social); i++) {
 		int chan = channels_social[i];
 		uint32_t freq = band_channel_to_freq(chan, BAND_FREQ_2_4_GHZ);
 
-		scan_freq_set_add(params.freqs, freq);
+		scan_freq_set_add(freqs, freq);
 	}
 
 	/*
@@ -3845,12 +3848,14 @@ static bool p2p_device_scan_start(struct p2p_device *dev)
 			dev->chans_per_scan = CHANS_PER_SCAN;
 		}
 
-		scan_freq_set_add(params.freqs, freq);
+		scan_freq_set_add(freqs, freq);
 	}
 
+	params.freqs = freqs;
+
 	dev->scan_id = scan_active_full(dev->wdev_id, &params, NULL,
 					p2p_scan_notify, dev, p2p_scan_destroy);
-	scan_freq_set_free(params.freqs);
+	scan_freq_set_free(freqs);
 
 	return dev->scan_id != 0;
 }
diff --git a/src/scan.c b/src/scan.c
index 39aef625..03e5b8d9 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -279,7 +279,7 @@ static void scan_freq_append(uint32_t freq, void *user_data)
 }
 
 static void scan_build_attr_scan_frequencies(struct l_genl_msg *msg,
-						struct scan_freq_set *freqs)
+					const struct scan_freq_set *freqs)
 {
 	struct scan_freq_append_data append_data = { msg, 0 };
 
@@ -654,7 +654,7 @@ static uint32_t scan_common(uint64_t wdev_id, bool passive,
 					priority, &work_ops);
 }
 
-uint32_t scan_passive(uint64_t wdev_id, struct scan_freq_set *freqs,
+uint32_t scan_passive(uint64_t wdev_id, const struct scan_freq_set *freqs,
 			scan_trigger_func_t trigger, scan_notify_func_t notify,
 			void *userdata, scan_destroy_func_t destroy)
 {
diff --git a/src/scan.h b/src/scan.h
index 79bec605..58b8332b 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -93,7 +93,7 @@ struct scan_bss {
 struct scan_parameters {
 	const uint8_t *extra_ie;
 	size_t extra_ie_size;
-	struct scan_freq_set *freqs;
+	const struct scan_freq_set *freqs;
 	uint16_t duration;
 	bool flush : 1;
 	bool randomize_mac_addr_hint : 1;
@@ -130,7 +130,7 @@ struct l_genl_msg *scan_build_trigger_scan_bss(uint32_t ifindex,
 						const uint8_t *ssid,
 						uint32_t ssid_len);
 
-uint32_t scan_passive(uint64_t wdev_id, struct scan_freq_set *freqs,
+uint32_t scan_passive(uint64_t wdev_id, const struct scan_freq_set *freqs,
 			scan_trigger_func_t trigger, scan_notify_func_t notify,
 			void *userdata, scan_destroy_func_t destroy);
 uint32_t scan_passive_full(uint64_t wdev_id,
-- 
2.34.1

