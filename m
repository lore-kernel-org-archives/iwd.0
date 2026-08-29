Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5936A343
	for <iwd@lists.linux.dev>; Sat, 29 Aug 2026 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787989484; cv=none; b=E4Rtk5Dj1qUD6b/bp3mwth0PQXpgbnElQLV9twNWUI04HntEAqouXC93hR7xcTvPka66aFYUAsNG8qZavSSOd7efl94jb0uBDZvcXhg6kDmPVJtYH+7LEUJ7AtcHLt2oP8cCjw2/LSg4aUpfurA94e4dY3xM5m4eOf5JVpCbhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787989484; c=relaxed/simple;
	bh=kx7iFd4kffx4dKdWPeEk8fICJzU2EHvCFt5JMKGz85s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bD8qbUQ7bB5xTwSiBPSbGzgFgFn8pUZePmudrkpIh5IX+5LzFuqTa+ghgt2EEYoVqhtmvMc9wmreu6Anc6oT4++xDXJMWKIBJWQVGZC7KU/OoWXmfvfWK/57M8u5/yUqxF5TEgJZrSdiNqy8VcX0BoKHwgjpVuv0Y/n5pOnOf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=serenium@gmx.com header.b=ZMoPFZHl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=serenium@gmx.com header.b="ZMoPFZHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1787989480; x=1788594280; i=serenium@gmx.com;
	bh=6ZQbnNDaqrOgrT+4lFuEPhSaLtarvnmgZ4d6W9uAGRw=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZMoPFZHlBfCNxSkw8zuuTFfpgZtlaq3rnfW50oid6TGmm8A5KyFTw2w48wVvsio1
	 RXOfy7VUdjmoRueEcLvLH+wkLi2s/37tp04wdCB5UUk3Ti3rHY9JWyoSWPr124IGM
	 u+F5k3oPRkS4ELt2O7egLh5RG+f0rQhuX743HNOJt45SFkOOh5KHdTrt9soHA5Nzx
	 bm/vA70+YNJOfX66Q2kLxxjZPp7jCliLVzO6HfNzOjLPbsQkFA4BWP7nxRL1UNaYq
	 eJA1uKKh17hxTYtu+Skm+2bX7Serv5GTn/ZpdPcQtSRstobORcG2AGwSW5tR6LWUf
	 8XxGGvWEjrhJRaHVQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1weAaN2cDY-013Xvn for
 <iwd@lists.linux.dev>; Sat, 29 Aug 2026 09:44:40 +0200
From: Serenium <serenium@gmx.com>
To: iwd@lists.linux.dev
Subject: [PATCH v2] ap: pass HT and WME station capabilities to kernel
Date: Sat, 29 Aug 2026 17:44:34 +1000
Message-ID: <20260829074434.11115-1-serenium@gmx.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rv57tmdYV4aLFiPTSLk7QkuquwnZ8fen4YNpF/C9bOlDWYz566z
 QNX8G/UnfPgRLwSLzPiwsSetTDKEUk/sAh92WGbQTGMgX3aziqksJPUA2PlJ1Gae724Am5t
 hin2VKNx0gI/O+YNO/iAwxwrl+eG5unXxWx3eBuHI+LTdMg34wbp35nYBfh2QUNJfTWdKWd
 Adu+aXl+uGTuV1kNF0snA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tXdTJqH9bKM=;hlBXYHV2ev02VIgDTxZ2x7tPLpF
 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
 gGnO3hXs45nUbOyhGu/4=

The AP advertises HT capabilities and a WMM parameter element, but
the association path discards the station HT capability element and does
not pass WME state to the kernel when creating the station.

Consequently, mac80211 treats associated stations as non-HT and non-WME,
restricting traffic to legacy rates even though both the AP and stations
advertise HT and WMM support.

Retain the HT capability and WMM information elements from the association
request. Pass the HT capability, WME parameters, and WME station flag in
NL80211_CMD_NEW_STATION.

Tested with iwd 3.12 and an Intel AX200 in AP mode. Before this change,
associated stations reported WMM/WME: no and used 5.5 or 11 Mbit/s legacy
rates. Afterwards, all tested stations reported WMM/WME: yes, selected HT
MCS rates, and sustained approximately 100 Mbit/s in a 256 MiB transfer.

Signed-off-by: Serenium <serenium@gmx.com>
=2D--
 src/ap.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 416e1104..3857d82e 100644
=2D-- a/src/ap.c
+++ b/src/ap.c
@@ -127,6 +127,9 @@ struct sta_state {
 	bool rsna;
 	uint16_t aid;
 	struct mmpdu_field_capability capability;
+	uint8_t ht_capabilities[26];
+	uint8_t wmm_uapsd_queues;
+	uint8_t wmm_max_sp;
 	uint16_t listen_interval;
 	struct l_uintset *rates;
 	uint32_t assoc_resp_cmd_id;
@@ -147,6 +150,7 @@ struct sta_state {
=20
 	bool ht_support : 1;
 	bool ht_greenfield : 1;
+	bool wmm_support : 1;
 };
=20
 struct ap_wsc_pbc_probe_record {
@@ -1683,6 +1687,11 @@ static struct l_genl_msg *ap_build_cmd_new_station(=
struct sta_state *sta)
 		flags.mask |=3D (1 << NL80211_STA_FLAG_ASSOCIATED) |
 				(1 << NL80211_STA_FLAG_AUTHENTICATED);
=20
+	if (sta->wmm_support) {
+		flags.mask |=3D 1 << NL80211_STA_FLAG_WME;
+		flags.set |=3D 1 << NL80211_STA_FLAG_WME;
+	}
+
 	msg =3D l_genl_msg_new_sized(NL80211_CMD_NEW_STATION, 300);
=20
 	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
@@ -1835,6 +1844,21 @@ static void ap_associate_sta(struct ap_state *ap, s=
truct sta_state *sta)
 			rates[count++] =3D r;
=20
 	l_genl_msg_append_attr(msg, NL80211_ATTR_STA_AID, 2, &sta->aid);
+	if (sta->ht_support)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_HT_CAPABILITY,
+					sizeof(sta->ht_capabilities),
+					sta->ht_capabilities);
+
+	if (sta->wmm_support) {
+		l_genl_msg_enter_nested(msg, NL80211_ATTR_STA_WME);
+		l_genl_msg_append_attr(msg,
+					NL80211_STA_WME_UAPSD_QUEUES, 1,
+					&sta->wmm_uapsd_queues);
+		l_genl_msg_append_attr(msg, NL80211_STA_WME_MAX_SP, 1,
+					&sta->wmm_max_sp);
+		l_genl_msg_leave_nested(msg);
+	}
+
 	l_genl_msg_append_attr(msg, NL80211_ATTR_STA_SUPPORTED_RATES,
 				count, &rates);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_STA_LISTEN_INTERVAL, 2,
@@ -2173,8 +2197,29 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 			if (test_bit(ie_tlv_iter_get_data(&iter), 4))
 				sta->ht_greenfield =3D true;
=20
+			memcpy(sta->ht_capabilities,
+					ie_tlv_iter_get_data(&iter),
+					sizeof(sta->ht_capabilities));
 			sta->ht_support =3D true;
 			break;
+		case IE_TYPE_VENDOR_SPECIFIC: {
+			const uint8_t *vendor =3D
+					ie_tlv_iter_get_data(&iter);
+			uint8_t qos_info;
+
+			if (ie_tlv_iter_get_length(&iter) !=3D 7 ||
+					memcmp(vendor, microsoft_oui, 3) ||
+					vendor[3] !=3D 2 ||
+					vendor[4] !=3D 0 ||
+					vendor[5] !=3D 1)
+				break;
+
+			qos_info =3D vendor[6];
+			sta->wmm_uapsd_queues =3D qos_info & 0x0f;
+			sta->wmm_max_sp =3D (qos_info >> 5) & 0x03;
+			sta->wmm_support =3D true;
+			break;
+		}
 		}
=20
 	if (!rates || !ssid || (!wsc_data && !rsn) ||
=2D-=20
2.55.0

