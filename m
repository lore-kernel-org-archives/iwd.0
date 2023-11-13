Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9822EEE
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6H4gsT1"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-671357f0209so29733136d6.0
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699898048; x=1700502848; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6EjcynQLIN6eDclbce5RkriaZkHKhyZbdj7USndYfU=;
        b=b6H4gsT1bC0RXRFTPkhUaURZVNdUYNzrhQIxLXJWOMf7zCxLhX9+igqtF8utAtgRLs
         ppm6KtChUrTb8tUUNcUlN+uzEUt5GXUh9zoy4BoKDNeVP2IYHrc5xcDhnzAhjqR2wGYP
         EdmPRyUR37PbLaKB/RKtS7vuvQe3ArYMAQMTZVutbjKlKdxzeKrFg9bvIdYXlzp37w+x
         0igUR1mRwiQi3Lrq4u4fjA10zEVcmt4zALQjvbV1mbuxO0BrnGnaxD4nAf9jfAd9iMun
         xbO9o6AFbu9e356Oha+l1achpTgj+vrLxisdJdoxhI2da0TbAvhT3UUM72oQf+VlyBG7
         MF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898048; x=1700502848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6EjcynQLIN6eDclbce5RkriaZkHKhyZbdj7USndYfU=;
        b=JqcNAeckT0vxInRrMYrA25wpAMiljvvjBJUxzI3wrwwtOTP6sYrP0a36toXpevoIV0
         +NWyHouHxOMgAxtTctYr1sAlD/HAsYsQMIh4ak3OZH6Qh19S2maJQ4nvfcMyz01vDY5X
         PdYH8r+3ltJjZKv9Fkgp3V+dg2sXGussrqId3cj8KYk91qarFlPHoXxunApjncljyDTt
         d3YW/5V5xV44j+b48ny+kIAA28cJZIi09MiMVVrQqNKRt+yBpq3g8TktSWS4tC8j/pn6
         7BwTJlH02xBII8Thv6SgN1RA9bPL/Vx41fZGNWgJjwiC0jLwAJt201hCJhvetpd7DKjs
         oRMQ==
X-Gm-Message-State: AOJu0YxpdYrkBiHtsyBmfaknauBaiF3BsXj+UbLJkLbdRPnxc/wGZclr
	0z5vs/z27kNYTh8B49Sn8rEfFYQVY4g=
X-Google-Smtp-Source: AGHT+IFyCpUO9r5VBQMq873CvjDYep/o0Hu/gg/ArwNhWUu46KEuwXc9x2VUqR11wS03dm7U/9XOdw==
X-Received: by 2002:ad4:4e13:0:b0:658:65ed:7e8 with SMTP id dl19-20020ad44e13000000b0065865ed07e8mr6063114qvb.57.1699898048568;
        Mon, 13 Nov 2023 09:54:08 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id n11-20020a05620a294b00b007756c0853a5sm2010975qkp.58.2023.11.13.09.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:54:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] dpp: scan to pick up extra frequencies when enrolling
Date: Mon, 13 Nov 2023 09:54:01 -0800
Message-Id: <20231113175401.343239-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113175401.343239-1-prestwoj@gmail.com>
References: <20231113175401.343239-1-prestwoj@gmail.com>
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

diff --git a/src/dpp.c b/src/dpp.c
index a95f93e2..41b7c70e 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -183,6 +183,7 @@ struct dpp_sm {
 	size_t z_len;
 	uint8_t u[L_ECC_SCALAR_MAX_BYTES];
 	size_t u_len;
+	uint32_t pkex_scan_id;
 
 	bool mcast_support : 1;
 	bool roc_started : 1;
@@ -508,6 +509,11 @@ static void dpp_reset(struct dpp_sm *dpp)
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
@@ -4073,6 +4079,14 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
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
@@ -4111,6 +4125,62 @@ static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
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
@@ -4156,17 +4226,25 @@ static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
 
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

