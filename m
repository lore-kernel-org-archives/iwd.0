Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40358F78
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:29 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id 4so13628262plj.3
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PhUqHny25tvQOECSmuzfAI/G8ExD1F6jtx/3IL2rT0=;
        b=H7erReB1D+8gyUj84AO3vqUYkGUUIsJZf9uhdw6WWEevQmPu2jzDLuThVd7UTPHXpD
         hyh3qZcFSFJq6C6WLmMq35BuobH6ZCXaX+aiSrgZpszI+xOQPoi7UflH6Cbx5cuHTD2t
         Zbw2Gwphs7xqppzGlnQvf6v0+5HFsRuKZKgg+mxGMvaT2avKDNHQw3NihB8NlkRNnKCj
         RMuO+Ty2GyjUG/1fmizVFWO9fjctR23WoVIKxuhkOrzEFATVEQnw8LC8mT/rp/K7B3UM
         5wiHNokglWxgMJ7C+hroi8wnvzW6dsTllErTgUWEkv6oApt4QNTrHCLgDLx9rc6aC19v
         QsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PhUqHny25tvQOECSmuzfAI/G8ExD1F6jtx/3IL2rT0=;
        b=A5OBIgfe/aKy2cSdg8xWA8fq/7KPlGnVeDkB7rYuXqXptqmOKYulXZGAEMzzcW9Xsn
         id8v17sptTyxb76BoLYea7/0ZDb58IH29NIGtD2L9KkZFFHHR6cvXY07vvgAP8f/cID8
         lcmC8KFa2IfhuAkOXzmgGajceHkgIEpVGrKtd7DyyOPvxLmcfexSB1JvkH+KMhy/YaGv
         PJtHPJjBFUC9u5fUH3P6cJR+JbDOFeehx+u9teHm+Lb61EEU8n4giMPmxyRTnx5aMi8x
         IYbHiKBH4Chp2QJ+8wckSKd+sYTU4dCGKh5d21MK3DhHIN78yo2VCjDOtiTDTjZAA/rE
         sESA==
X-Gm-Message-State: AFqh2kpfm+wCs6UXU2TSHLVIYlkMWpKtDvAF2bfVXaYiktXsxIelvhR6
	UJWj6/FJsiaRKo62J6yusBfp2t0H3As=
X-Google-Smtp-Source: AMrXdXtRbNbxm3DylYlacXo/xKA0v0VjGJWOji2gGDSWYcoiGgJ0vxWhH7qmivD/1t5oRB2l4GFW4w==
X-Received: by 2002:a17:90b:1895:b0:223:9e00:85bd with SMTP id mn21-20020a17090b189500b002239e0085bdmr18184626pjb.40.1671572609421;
        Tue, 20 Dec 2022 13:43:29 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/10] ap: build HT Capabilities/Operation elements
Date: Tue, 20 Dec 2022 13:43:17 -0800
Message-Id: <20221220214318.2041986-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
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
index d3188d1d..58fb4a6b 100644
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
@@ -918,6 +921,66 @@ static size_t ap_write_extra_ies(struct ap_state *ap,
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
@@ -970,6 +1033,18 @@ static size_t ap_build_beacon_pr_head(struct ap_state *ap,
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
@@ -1628,6 +1703,18 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
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
 
@@ -1833,6 +1920,17 @@ static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 
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
@@ -2676,6 +2774,9 @@ static void ap_handle_new_station(struct ap_state *ap, struct l_genl_msg *msg)
 
 	l_queue_push_tail(ap->sta_states, sta);
 
+	if (ap->supports_ht)
+		ap_update_beacon(ap);
+
 	msg = nl80211_build_set_station_unauthorized(
 					netdev_get_ifindex(ap->netdev), mac);
 
@@ -3712,6 +3813,9 @@ bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
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

