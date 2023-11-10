Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B661B28E
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9U3BBYH"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5849fc56c62so1157759eaf.3
        for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 06:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699625784; x=1700230584; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bW/vF11DaiBu7ZzBcky0tyeC7/56glDgVwk0J+pJFnM=;
        b=V9U3BBYHIehjZUGVx2DDjE/K31kXZIWrXA/06S6WGEzLgbo0KGXR+dd5rFPjKRLCk4
         L+FiX+JbKur+j3v3oG84nVRtpK/Xceg9l7PRdf7sjIDK9P7PyX6c+HMGtSKRBhABYZsd
         tDt6iSzk+SsklVw4vqa0hnhcsx4FfUHm3vOn9eOuwwICMHAoi+4BIMP9D1uecW+PLWgx
         Z6wihGilHAAtP5HzS1vAxM2eaRgFKAUMQkhteJClkuHrjIoY6TBNLZGWR0Q+hhhjMDhP
         x/7jxalGJ+m7PQkeJUwVp10FSjDwMNVl86WfxSITdG4JVa1k4rNZtnlbARXl6d23Mns1
         tCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625784; x=1700230584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW/vF11DaiBu7ZzBcky0tyeC7/56glDgVwk0J+pJFnM=;
        b=ryYb33gT1qMmEdSJ8mHZB82HKuXwS3YANjW1j9YstrnaOA0PePQRw2LxRPI6BVP8ah
         iJErH8lHJk1qHfQi/R6tCs15Sypj7ksyX5QPPXDRIQ+RQgeUTO2mPfxBM08fD5ZxuZi7
         AJh+uZkTeiHF6+2uWykuZEsNXBf4dtmpBo+tSS4VNgng25vuADNVh06DXMplvyuc5JkL
         Q0mScbQL7S1CjKWFz5kgu0ps2iUQFrr65HQl1jO60CAybBaNTwla6puxjRa/LUTFRoik
         4bwADureWPmUPdbEiaeHXWBRLmZM+OX3QOUhXoobZD/HKwgw1T+o0iwCiT4CIU6K3Qtu
         r+tg==
X-Gm-Message-State: AOJu0Yx4LyI8fuK9yff7vu1w+D0kwPDFEU6vuFbm6KnT6Z/ZMi7x1vVZ
	+5o267O6a4olncB4aNXb9BbO9aU5YPQ=
X-Google-Smtp-Source: AGHT+IErdVY3ft9sG83jYHnOTXDDmtSb/aFQ1mmT9mvd9pi0UDCzD7mhACLegGjRhnPoHI6cB1PHMA==
X-Received: by 2002:a05:6358:3411:b0:169:8620:a228 with SMTP id h17-20020a056358341100b001698620a228mr8282511rwd.3.1699625784228;
        Fri, 10 Nov 2023 06:16:24 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c10-20020a05621401ea00b0065b11053445sm2958163qvu.54.2023.11.10.06.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:16:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] dpp: scan to pick up extra frequencies when enrolling
Date: Fri, 10 Nov 2023 06:16:18 -0800
Message-Id: <20231110141620.80195-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPP-PKEX spec provides a very limited list of frequencies used
to discover configurators, only 3 on 2.4 and 5GHz bands. Since
configurators (at least in IWD's implementation) are only allowed
on the current operating frequency its very unlikely an enrollee
will find a configurator on these frequencies out of the entire
spectrum.

The spec does mention that the 3 default frequencies should be used
"In lieu of specific channel information obtained in a manner outside
the scope of this specification, ...". This allows the implementation
some flexibility in using a broader range of frequencies.

To increase the chances of finding a configurator shared code
enrollees will first issue a scan to determine what access points are
around, then iterate these frequencies. This is especially helpful
when the configurators are IWD-based since we know that they'll be
on the same channels as the APs in the area.
---
 src/dpp.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 10 deletions(-)

v2:
 * Removed user-option, scan by default
 * Fixed potential NULL return from dpp_default_freqs

diff --git a/src/dpp.c b/src/dpp.c
index c54bd484..daa49410 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -182,6 +182,7 @@ struct dpp_sm {
 	size_t z_len;
 	uint8_t u[L_ECC_SCALAR_MAX_BYTES];
 	size_t u_len;
+	uint32_t pkex_scan_id;
 
 	bool mcast_support : 1;
 	bool roc_started : 1;
@@ -507,6 +508,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->retry_timeout = NULL;
 	}
 
+	if (dpp->pkex_scan_id) {
+		scan_cancel(dpp->wdev_id, dpp->pkex_scan_id);
+		dpp->pkex_scan_id = 0;
+	}
+
 	dpp->state = DPP_STATE_NOTHING;
 	dpp->new_freq = 0;
 	dpp->frame_retry = 0;
@@ -3956,6 +3962,14 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(message);
 }
 
+static void dpp_pkex_scan_trigger(int err, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	if (err < 0)
+		dpp_reset(dpp);
+}
+
 /*
  * Section 5.6.1
  * In lieu of specific channel information obtained in a manner outside
@@ -3994,6 +4008,62 @@ static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
 	return freqs_out;
 }
 
+static bool dpp_pkex_scan_notify(int err, struct l_queue *bss_list,
+					const struct scan_freq_set *freqs,
+					void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const struct l_queue_entry *e;
+	_auto_(scan_freq_set_free) struct scan_freq_set *freq_set = NULL;
+
+	if (err < 0)
+		goto failed;
+
+	freq_set = scan_freq_set_new();
+
+	if (!bss_list || l_queue_isempty(bss_list)) {
+		dpp->freqs = dpp_default_freqs(dpp, &dpp->freqs_len);
+		if (!dpp->freqs)
+			goto failed;
+
+		l_debug("No BSS's seen, using default frequency list");
+		goto start;
+	}
+
+	for (e = l_queue_get_entries(bss_list); e; e = e->next) {
+		const struct scan_bss *bss = e->data;
+
+		scan_freq_set_add(freq_set, bss->frequency);
+	}
+
+	l_debug("Found %u frequencies to search for configurator",
+			l_queue_length(bss_list));
+
+	dpp->freqs = scan_freq_set_to_fixed_array(freq_set, &dpp->freqs_len);
+
+start:
+	dpp->current_freq = dpp->freqs[0];
+
+	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
+
+	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
+
+	dpp_start_offchannel(dpp, dpp->current_freq);
+
+	return false;
+
+failed:
+	dpp_reset(dpp);
+	return false;
+}
+
+static void dpp_pkex_scan_destroy(void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	dpp->pkex_scan_id = 0;
+}
+
 static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
 				const char *identifier)
 {
@@ -4045,17 +4115,25 @@ static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
 
 	dpp_property_changed_notify(dpp);
 
-	dpp->freqs = dpp_default_freqs(dpp, &dpp->freqs_len);
-	if (!dpp->freqs)
-		goto failed;
-
-	dpp->current_freq = dpp->freqs[dpp->freqs_idx];
-
-	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
-
-	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
+	/*
+	 * The 'dpp_default_freqs' function returns the default frequencies
+	 * outlined in section 5.6.1. For 2.4/5GHz this is only 3 frequencies
+	 * which is unlikely to result in discovery of a configurator. The spec
+	 * does allow frequencies to be "obtained in a manner outside the scope
+	 * of this specification" which is what is being done here.
+	 *
+	 * This is mainly geared towards IWD-based configurators; banking on the
+	 * fact that they are currently connected to nearby APs. Scanning lets
+	 * us see nearby BSS's which should be the same frequencies as our
+	 * target configurator.
+	 */
+	l_debug("Performing scan for frequencies to start PKEX");
 
-	dpp_start_offchannel(dpp, dpp->current_freq);
+	dpp->pkex_scan_id = scan_active(dpp->wdev_id, NULL, 0,
+				dpp_pkex_scan_trigger, dpp_pkex_scan_notify,
+				dpp, dpp_pkex_scan_destroy);
+	if (!dpp->pkex_scan_id)
+		goto failed;
 
 	return true;
 
-- 
2.25.1

