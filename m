Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621537157
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndLkQW1r"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5bf5d6eaf60so11582927b3.2
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 11:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699559846; x=1700164646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s3qq573CYtW+ASzlrHfJdeRn121Q+I8Rsm04kybWrk=;
        b=ndLkQW1rk7ppkIHdYCy7MxO/yBe1oRyPlUJ0WvHWu1OKuxBOu4SvlzfrVDz2V21eUQ
         sM/K1xBuA/aHQf7J+bfuznqNLSRfXPbpfh8KcsVPmOYqn9ekgJpbdjTWO9IMjR7HR5CK
         3JXFslBo53QAOOraxRl/EKskkcrXra2khWGv/GOqO2BAuXNaUvsft6zI7M+Ibn2Bok+0
         HF0D9PVN9jKGSMq+4cT3lfg/1o6zq2RvYoOX88wcQympOSoyKF8CSLaUfqj9vueXaISb
         VRPymyNmxtrIPcvErbsZQNYCdXSw4VL99tTRuSAQECqm42LMwnO3AnfKYqWaQUoI2TPo
         X/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699559846; x=1700164646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s3qq573CYtW+ASzlrHfJdeRn121Q+I8Rsm04kybWrk=;
        b=EqmwOU774MZaKk8JgS1Qwz0MSmFVweqfcGYVjQbH6/OjTfzb+OxuJC5+YGeKky9UQz
         CVWx1brTeKor3DEOF6wSfBfr2SiOjIkCcRTy8iXiDzZ9i0ziLYz1zM0ng2ISj1/caQsq
         DUVaGB7EOcWPoTS7D6iL1IljVZmwUnTm0aUdZZKjMT1Zp2FDen5giMc0/NwTWllbG9zk
         kKLP72RhN4doWJ11UhMPDMXIIcah+MI/NlFnq6aRPtHGK5PyudKJqKGi3M5vUjr/vh3s
         /fZK/MDVmmcMmBVrexlhj9QqUEWcL3i63IIqTgw9izw4szHgqn2fa5s2HIoLO7c67JxD
         UICg==
X-Gm-Message-State: AOJu0YyHa3EaH5SpwzcW1QdSQFeSMgb/KTBswa2B4ly+jxdKlspD7vAl
	V8vWz8RTx8aVUGijpZ0JRr4nLhjS4KA=
X-Google-Smtp-Source: AGHT+IE3OeJKMrap422IVD7mK/1wqSMlRE5WeBT37wDo+DC41y5Bf3pawzsk83LC7QF+VCdqfH7PLQ==
X-Received: by 2002:a81:484c:0:b0:5a8:1d18:a16 with SMTP id v73-20020a81484c000000b005a81d180a16mr6199224ywa.36.1699559845794;
        Thu, 09 Nov 2023 11:57:25 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w6-20020a817b06000000b0055a07e36659sm8052388ywc.145.2023.11.09.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:57:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] dpp: scan to pick up extra frequencies when enrolling
Date: Thu,  9 Nov 2023 11:57:19 -0800
Message-Id: <20231109195720.56352-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109195720.56352-1-prestwoj@gmail.com>
References: <20231109195720.56352-1-prestwoj@gmail.com>
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
 src/dpp.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index c54bd484..9be5241d 100644
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
@@ -3994,10 +4008,64 @@ static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
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
+	if (err < 0) {
+		dpp_reset(dpp);
+		return false;
+	}
+
+	freq_set = scan_freq_set_new();
+
+	if (!bss_list || l_queue_isempty(bss_list)) {
+		dpp->freqs = dpp_default_freqs(dpp, &dpp->freqs_len);
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
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	bool scan_discovery;
+	const struct l_settings *config = iwd_get_config();
 	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
 
 	if (station && station_get_connected_network(station)) {
@@ -4045,6 +4113,31 @@ static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
 
 	dpp_property_changed_notify(dpp);
 
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
+	if (l_settings_get_bool(config, "DeviceProvisioning",
+				"EnrolleeScanDiscovery", &scan_discovery) &&
+				scan_discovery) {
+		l_debug("Performing scan for frequencies to start PKEX");
+		dpp->pkex_scan_id = scan_active(dpp->wdev_id, NULL, 0,
+				dpp_pkex_scan_trigger, dpp_pkex_scan_notify,
+				dpp, dpp_pkex_scan_destroy);
+		if (!dpp->pkex_scan_id)
+			goto failed;
+
+		return true;
+	}
+
 	dpp->freqs = dpp_default_freqs(dpp, &dpp->freqs_len);
 	if (!dpp->freqs)
 		goto failed;
-- 
2.25.1

