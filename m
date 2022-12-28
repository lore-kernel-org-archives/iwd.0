Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1956FC0
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 22:32:36 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso17305630pjh.1
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 14:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pDTDOklxzemxLsT4G3Eh/E9QZVHITXP30ONr+m9PSk=;
        b=DIOdWXsGRn4i/pP+33Kvp2CAX6yu3aMI5PnYZJZ08L/2aSf4K+txTDiB3hGqx3goXr
         8xUd2ttPYN+hBhdWRsLGMK+mZ2kLgRUZarDuI661ajs1BLDyceY7IWqFy4K8JZ4RtfEz
         9R61+reTuSNR1ghL3hHUfTxxUp/Rp545xsrJHd0oOKcbMxc+V2b2uguA+c/S14lMgMi9
         CeIp1ebHm2/G6D0Oha8QhP1k9nScMqsLXVCyJpH4WEQhxT6Ki6vMNMhB29RTXxjn9RgF
         0V7OfJk/NkGNfpzYjD30ikyTp9NigVGFGgHZYy0OTQvC95vkEmgYMJRl2Yme9iTRLye3
         gEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pDTDOklxzemxLsT4G3Eh/E9QZVHITXP30ONr+m9PSk=;
        b=rdgtFXsatAwt0IFLbxX9POTkc6T5E5YAwkoW7YMZNsrSwrrJPWYpMFv+S5EXcrN7Vh
         RHcRflxnsaAK6PC/Y7n1IEhLt/mSFuGDOMzjuC8CFFByCCgR+756i5A0f47qgKv0J/vh
         B2jD74LUfHzl4VfEnshVUdofxD0fxcnMM8DRpL40R3M4jsLcu8/iohvXrqTR+jkGuhxc
         IwVLgxTDJ6aqx5rFC1LBFhcKjZMt5+9ABo4MdZoctvgBec7Ve+ZkP3nFkTGmO7bpr5Mn
         pRTe0gs2Ya5RhVnvwlhJ2XcgQpV+XumjIMnBwruMMJlIZ2mxKgHHLWbt/7Uxqd9ymTPu
         53AQ==
X-Gm-Message-State: AFqh2koSqvGIzFcXYM9cXBZ+XfW8JPG2NP+XehA96DVyZIvh4is6yHMI
	zfR4rglLnVmG/X+MvmerwqsSnDAmS4Q=
X-Google-Smtp-Source: AMrXdXtGhgwqQ+2ih6xHIcmlb0WZkaRkZ/Q+6FJR3sB7hsUY6/BU89PGR3/+hBI1cyA1z6LygchH4w==
X-Received: by 2002:a17:902:e54f:b0:191:1e88:ea4c with SMTP id n15-20020a170902e54f00b001911e88ea4cmr37308874plf.40.1672266755894;
        Wed, 28 Dec 2022 14:32:35 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm11549544plg.46.2022.12.28.14.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 14:32:35 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] ap: build HT Capabilities/Operation elements
Date: Wed, 28 Dec 2022 14:32:31 -0800
Message-Id: <20221228223231.2686276-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221228223231.2686276-1-prestwoj@gmail.com>
References: <20221228223231.2686276-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If supported this will include the HT capabilities and HT
operations elements in beacons/probes. Some shortcuts were taken
here since not all the information is currently parsed from the
hardware. Namely the HT operation element does not include the
basic MCS set. Still, this will at least show stations that the
AP is capable of more than just basic rates.

The builders themselves are structured similar to the basic rates
builder where they build only the contents and return the length.
The caller must set the type/length manually. This is to support
the two use cases of using with an IE builder vs direct pointer.
---
 src/ap.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index a8c415d5..a989c454 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -137,6 +137,9 @@ struct sta_state {
 	bool wsc_v2;
 	struct l_dhcp_lease *ip_alloc_lease;
 	bool ip_alloc_sent;
+
+	bool ht_support : 1;
+	bool ht_greenfield : 1;
 };
 
 struct ap_wsc_pbc_probe_record {
@@ -930,6 +933,66 @@ static size_t ap_write_extra_ies(struct ap_state *ap,
 	return len;
 }
 
+static size_t ap_build_ht_capability(struct ap_state *ap, uint8_t *buf)
+{
+	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
+	size_t ht_capa_len;
+	const uint8_t *ht_capa = wiphy_get_ht_capabilities(wiphy, ap->band,
+								&ht_capa_len);
+
+	memcpy(buf, ht_capa, ht_capa_len);
+
+	return ht_capa_len;
+}
+
+static size_t ap_build_ht_operation(struct ap_state *ap, uint8_t *buf)
+{
+	const struct l_queue_entry *e;
+	unsigned int non_ht = false;
+	unsigned int non_greenfield = false;
+
+	memset(buf, 0, 22);
+	*buf++ = ap->channel;
+
+	/*
+	 * If 40MHz set 'Secondary Channel Offset' (bits 0-1) to above/below
+	 * and set 'STA Channel Width' (bit 2) to indicate non-20Mhz.
+	 */
+	if (ap->chandef.channel_width == BAND_CHANDEF_WIDTH_20)
+		goto check_stas;
+	else if (ap->chandef.frequency < ap->chandef.center1_frequency)
+		*buf |= 1 & 0x3;
+	else
+		*buf |= 3 & 0x3;
+
+	*buf |= 1 << 2;
+
+check_stas:
+	for (e = l_queue_get_entries(ap->sta_states); e; e = e->next) {
+		struct sta_state *sta = e->data;
+
+		if (!sta->associated)
+			continue;
+
+		if (!sta->ht_support)
+			non_ht = true;
+		else if (!sta->ht_greenfield)
+			non_greenfield = true;
+	}
+
+	if (non_greenfield)
+		set_bit(buf, 10);
+
+	if (non_ht)
+		set_bit(buf, 12);
+
+	/*
+	 * TODO: Basic MCS set for all associated STAs
+	 */
+
+	return 22;
+}
+
 /*
  * Build a Beacon frame or a Probe Response frame's header and body until
  * the TIM IE.  Except for the optional TIM IE which is inserted by the
@@ -982,6 +1045,18 @@ static size_t ap_build_beacon_pr_head(struct ap_state *ap,
 	ie_tlv_builder_next(&builder, IE_TYPE_DSSS_PARAMETER_SET);
 	ie_tlv_builder_set_data(&builder, &ap->channel, 1);
 
+	if (ap->supports_ht) {
+		ie_tlv_builder_next(&builder, IE_TYPE_HT_CAPABILITIES);
+		len = ap_build_ht_capability(ap,
+					ie_tlv_builder_get_data(&builder));
+		ie_tlv_builder_set_length(&builder, len);
+
+		ie_tlv_builder_next(&builder, IE_TYPE_HT_OPERATION);
+		len = ap_build_ht_operation(ap,
+					ie_tlv_builder_get_data(&builder));
+		ie_tlv_builder_set_length(&builder, len);
+	}
+
 	ie_tlv_builder_finalize(&builder, &out_len);
 	return 36 + out_len;
 }
@@ -1640,6 +1715,18 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
 	resp->ies[ies_len++] = len;
 	ies_len += len;
 
+	if (ap->supports_ht) {
+		resp->ies[ies_len++] = IE_TYPE_HT_CAPABILITIES;
+		len = ap_build_ht_capability(ap, resp->ies + ies_len + 1);
+		resp->ies[ies_len++] = len;
+		ies_len += len;
+
+		resp->ies[ies_len++] = IE_TYPE_HT_OPERATION;
+		len = ap_build_ht_operation(ap, resp->ies + ies_len + 1);
+		resp->ies[ies_len++] = len;
+		ies_len += len;
+	}
+
 	ies_len += ap_write_extra_ies(ap, stype, req, req_len,
 					resp->ies + ies_len);
 
@@ -1845,6 +1932,17 @@ static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 
 			fils_ip_req = true;
 			break;
+		case IE_TYPE_HT_CAPABILITIES:
+			if (ie_tlv_iter_get_length(&iter) != 26) {
+				err = MMPDU_REASON_CODE_INVALID_IE;
+				goto bad_frame;
+			}
+
+			if (test_bit(ie_tlv_iter_get_data(&iter), 4))
+				sta->ht_greenfield = true;
+
+			sta->ht_support = true;
+			break;
 		}
 
 	if (!rates || !ssid || (!wsc_data && !rsn) ||
@@ -2691,6 +2789,9 @@ static void ap_handle_new_station(struct ap_state *ap, struct l_genl_msg *msg)
 
 	l_queue_push_tail(ap->sta_states, sta);
 
+	if (ap->supports_ht)
+		ap_update_beacon(ap);
+
 	msg = nl80211_build_set_station_unauthorized(
 					netdev_get_ifindex(ap->netdev), mac);
 
@@ -3753,6 +3854,9 @@ bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
 	if (!sta)
 		return false;
 
+	if (ap->supports_ht)
+		ap_update_beacon(ap);
+
 	ap_del_station(sta, reason, false);
 	ap_sta_free(sta);
 	return true;
-- 
2.34.3

