Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FE6FAE
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 21:44:10 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id z7so5817491pfq.13
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 13:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDjp2a34VLPVdioeq5pvirIQHvIfRItds4iqNSmrglE=;
        b=ghtBZRUDXSML/IReSR5wIMbyvLEuxrRExavPoAyE7fP08NAPytGER9QvcypxvjsV2L
         PzeSiHO3SNmzDJrwNoitL6t2KnvMtwQSfU4Z0fG66uez1D3IgW131Q3hbKUzuQimda2/
         r9a40TIbHmsg4jOjx+A7FIqKPrKWAF0QARiOMLJy6NDTkuVEikB/MbTta98lonIWy3gP
         kdK0d/t216dIe2pmN8kZU4An8u+ofM01HvZdjRtjoOoNve387MTwKRSyrWepU0CfgL1f
         UXkils38+HyF/+UrjhyqxcnH/SoAqV37W3REMFqX8TXacWHfUUn3SRlOVhy5+3CaHNlf
         yvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDjp2a34VLPVdioeq5pvirIQHvIfRItds4iqNSmrglE=;
        b=uzMtUMJYFKX0ELk4ODI7E/tSH1FAQixs2Q/DB4nDS1b5GxdUyWoIVtRkdF+b5ZQEkQ
         IfKIL4ZjJV4OGubuN5Ti10Dl/XJOex9Zv/e4BHzWIknO4DZcnwL/dk1CPKq6tqIi2YXy
         QiiOtAXnQsrMRp7qUQZQTegG9EY3+q8MLU7EwLhUKYgjsWtw/Qx6svv4t/P/3fsZ8iLK
         2tMeCKaTSqskXtG+Gu0MwleucrB8iHexxv4Esunjw28nTBJqmr0QZTxi9dugg/lmH6pf
         dxbxzvbMD6O45v97QUOhvrQce7QybfsFx4VKfVgwwp4DAQOaXhWmL2k9idj+snDDBSJL
         48hw==
X-Gm-Message-State: AFqh2kr757b4Vp/JwDn8NkknpSyB4bApaFbbndE1wcPseGDS6nUsHwsB
	Dnw5ZPjVnBfAh8wSrU3nLMlaEGqg8ro=
X-Google-Smtp-Source: AMrXdXtNm0vAmHo/jFTht/t014aaD5FgqjXCz7CgNg21iTUkZ3mq2d5THuhkQJtM+yuJksbhoVhu7A==
X-Received: by 2002:a05:6a00:13a4:b0:57f:f7a4:511a with SMTP id t36-20020a056a0013a400b0057ff7a4511amr35119026pfg.2.1672263850020;
        Wed, 28 Dec 2022 13:44:10 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b0057726bd7335sm5360103pfp.121.2022.12.28.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 13:44:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] ap: build HT Capabilities/Operation elements
Date: Wed, 28 Dec 2022 13:44:02 -0800
Message-Id: <20221228214403.2682418-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221228214403.2682418-1-prestwoj@gmail.com>
References: <20221228214403.2682418-1-prestwoj@gmail.com>
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
index b505499d..d9a81651 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -136,6 +136,9 @@ struct sta_state {
 	bool wsc_v2;
 	struct l_dhcp_lease *ip_alloc_lease;
 	bool ip_alloc_sent;
+
+	bool ht_support : 1;
+	bool ht_greenfield : 1;
 };
 
 struct ap_wsc_pbc_probe_record {
@@ -929,6 +932,66 @@ static size_t ap_write_extra_ies(struct ap_state *ap,
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
@@ -981,6 +1044,18 @@ static size_t ap_build_beacon_pr_head(struct ap_state *ap,
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
@@ -1639,6 +1714,18 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
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
 
@@ -1844,6 +1931,17 @@ static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 
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
@@ -2687,6 +2785,9 @@ static void ap_handle_new_station(struct ap_state *ap, struct l_genl_msg *msg)
 
 	l_queue_push_tail(ap->sta_states, sta);
 
+	if (ap->supports_ht)
+		ap_update_beacon(ap);
+
 	msg = nl80211_build_set_station_unauthorized(
 					netdev_get_ifindex(ap->netdev), mac);
 
@@ -3723,6 +3824,9 @@ bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
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

