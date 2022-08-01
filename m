Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83D7F
	for <iwd@lists.linux.dev>; Mon,  1 Aug 2022 10:07:25 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id id17so5529800wmb.1
        for <iwd@lists.linux.dev>; Mon, 01 Aug 2022 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODmeCc1P7AkKfdbnOWix849B2GBaezz0zAcTWRxUvxQ=;
        b=HQOj4H21ep2IEy5xLQ97Ix8YjMb9QIgzeOYIUPjtIcNAN6nYD/DA3qTnO1RNr23glj
         hYS8qGqFH1urEc37KygD2ysFMt31s2T+pU2U4iGp96eff9eN8d/YuijbQ0pOwGzwRSJW
         jshMCwVcFFjE9p4fvfv+5BUXGQ80YGnj/3QRp6zR8c4u81oIV5/iOj+vod2Ef1dQ5Fpb
         pGjYNrue0uNbDWEUB5SCLcKGTu/d1bChyw7/KYB0i+hdUw8UCouRdhbOUYwTSTM3e/2T
         F85eZSE35UC0vdFpprGZe1bAcMousbbvW+jzvBi62wokwnZKlg4oCmrMjW4azVRM5FB2
         BXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODmeCc1P7AkKfdbnOWix849B2GBaezz0zAcTWRxUvxQ=;
        b=f51PmRjNkqm8ZOdzBrF8cncy7hXPV4zzTzoQi8rNcFWchpVzxTJGRaMNXHt/c384M+
         emeKB0jDuMzcaKsUtVwhvZ1OCI+MTn54Oo73xyMKxQhTk+9pPJHNv6CX9I5IBb6pcULp
         RfzgWqdTHo1OwWR6xOtgY1vH/XO5WMYHH/V1CCZ9y+tEIj9Esl0qx4ugrCBG68dSokYF
         O124U4uoCIRAOVaToHugbaHsiKPdjzR5vDEF8dUVKi6mc6xs6bkCcXlMEP9PsSIcKIso
         60FUNoU3sj2Fi7169s5GSG+7CdimkLv0eFKbjDF8W8nm519AmEaw96aKd7UlNhLzgkj3
         4nJg==
X-Gm-Message-State: AJIora8iL9hagy9y3mA/VytKC5GocRZCu4TbWFp92HrF2D1IrXLTLlub
	a1dJSpmwydW/x2V4dXDeETsKzCxz60o=
X-Google-Smtp-Source: AGRyM1v8fvZqTw6pO5qclYJIKvup/u9iIZm3juV782AYkmsS4rkKqQkIFRuB6wyLLF7sYVG0vclMOw==
X-Received: by 2002:a05:600c:2212:b0:3a3:328:5bd2 with SMTP id z18-20020a05600c221200b003a303285bd2mr10293848wml.146.1659348443875;
        Mon, 01 Aug 2022 03:07:23 -0700 (PDT)
Received: from localhost.localdomain (cpc156731-sgyl45-2-0-cust617.18-2.cable.virginm.net. [82.31.54.106])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b003a32167b8d4sm21686207wmg.13.2022.08.01.03.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:07:23 -0700 (PDT)
From: Michael Johnson <mjohnson459@gmail.com>
To: iwd@lists.linux.dev
Cc: Michael Johnson <mjohnson459@gmail.com>
Subject: [PATCH 1/2] netdev: Add logging for CQM messages
Date: Mon,  1 Aug 2022 11:06:30 +0100
Message-Id: <20220801100631.41605-1-mjohnson459@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra logging around CQM events to help track wifi status.

The signal strength logging matches wpa_supplicant's which looks like
this:

CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-60 noise=-96 txrate=6000
---
 src/netdev.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 5a6a7b70..f9acd639 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1092,12 +1092,26 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 					rssi_event = (uint32_t *) data;
 					break;
 
+				case NL80211_ATTR_CQM_PKT_LOSS_EVENT:
+					if (len != 4)
+						continue;
+
+					l_warn("Packets lost event: %d",
+							*(uint32_t *) data);
+					break;
+
+				case NL80211_ATTR_CQM_BEACON_LOSS_EVENT:
+					l_warn("Beacon lost event");
+					break;
+
 				case NL80211_ATTR_CQM_RSSI_LEVEL:
 					if (len != 4)
 						continue;
 
 					rssi_val = (int32_t *) data;
 					break;
+				default:
+					l_debug("Unknown CQM event: %d", type);
 				}
 			}
 
@@ -1106,10 +1120,14 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 	}
 
 	if (rssi_event) {
-		if (rssi_val)
+		if (rssi_val) {
+			l_info("Signal change event (above=%d signal=%d)",
+							*rssi_event, *rssi_val);
 			netdev_cqm_event_rssi_value(netdev, *rssi_val);
-		else
+		} else {
+			l_info("Signal change event (above=%d)", *rssi_event);
 			netdev_cqm_event_rssi_threshold(netdev, *rssi_event);
+		}
 	}
 }
 
-- 
2.25.1

