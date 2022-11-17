Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69114290A
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 21:11:51 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id t25so8236831ejb.8
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyaZNIo28uZte+/H9uAnJdFw7iQO6XoasBPmRpCyjbg=;
        b=i2a+pKYjux9Ft0EqPtspA1hAdK5yce90Ps+kQn9vvl2RBSlzl2ikMtKeGHQlqXG73r
         1hcttP/RLC+5wM0YXsSkG7Ykg2enR+bvNgnYh49RF0b7362+Rg3+SXNg1DX8XnvjYye8
         Q1CBvO7dUFBeWL8VWbW7mR7rmsx0kZciA+8zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyaZNIo28uZte+/H9uAnJdFw7iQO6XoasBPmRpCyjbg=;
        b=5uWxzrGaNp++hgMQWzWuU8sgyLf/TjGF2TRxu2Tv+XzdHhCrghq5HsSVCdpMNOzcl4
         1XFEOPyuCrA921PSFjVeV7Sld6ee3oPDnKf/yvXy5clTIRpnfKAXykj3qNu3F0Sv24J1
         pX62pKOmZ3TNkCitbCumIcYYUhA3oGNjZZmeqeRC/RdvIkvDWZnCjKZosY06WGKZza0N
         CDnHQaEx8aqnFJ5O/VSQsW83S5jCEmRv136g6ArR1Sqlfgq6TaI/Zqs984aLdAm8Fag1
         oxjTgEny9xTXeJW7g+hcpFbMSPMkSfnFJbQMKOlH5VBv2bkhQqyXlE6OQnFses7PrlmK
         FzTA==
X-Gm-Message-State: ANoB5pmMirgiA8wh5tFqzREfrN8Zex+8RZLQl6S6Kt+pW6lL3NUR9BtZ
	IENgdz0Hyr9LcRu2/SOLNb5LdXOWpxRgVA==
X-Google-Smtp-Source: AA0mqf6Ui6vxD/zYO9a/Te6w88O/Ti6EvJBuiAiJTzzYHX7zwmWp+NWBM4Q+FX84ItT38/bajh+txQ==
X-Received: by 2002:a17:906:85cc:b0:781:ee12:814 with SMTP id i12-20020a17090685cc00b00781ee120814mr3635935ejy.63.1668719509487;
        Thu, 17 Nov 2022 13:11:49 -0800 (PST)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id ek19-20020a056402371300b00458824aee80sm981349edb.38.2022.11.17.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:11:49 -0800 (PST)
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To: iwd@lists.linux.dev
Cc: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH v2] scan: retry scan based on scan done events per wiphy, not wdev
Date: Thu, 17 Nov 2022 22:11:39 +0100
Message-Id: <20221117211139.2572553-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alvin Šipraga <alsi@bang-olufsen.dk>

If a CMD_TRIGGER_SCAN request fails with -EBUSY, iwd currently assumes
that a scan is ongoing on the underlying wdev and will retry the same
command when that scan is complete. It gets notified of that completion
via the scan_notify() function, and kicks the scan logic to try again.

However, if there is another wdev on the same wiphy and that wdev has a
scan request in flight, the kernel will also return -EBUSY. In other
words, only one scan request per wiphy is permitted.

As an example, the brcmfmac driver can create an AP interface on the
same wiphy as the default station interface, and scans can be triggered
on that AP interface.

If -EBUSY is returned because another wdev is scanning, then iwd won't
know when it can retry the original trigger request because the relevant
netlink event will arrive on a different wdev. Indeed, if no scan
context exists for that other wdev, then scan_notify will return early
and the scan logic will stall indefinitely.

Instead, and in the event that no scan context matches, use it as a cue
to retry a pending scan request that happens to be destined for the same
wiphy.
---
 src/scan.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index 5548914a12de..ef222f66409c 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2044,6 +2044,33 @@ static void scan_parse_result_frequencies(struct l_genl_msg *msg,
 	}
 }
 
+static void scan_retry_pending(uint32_t wiphy_id)
+{
+	const struct l_queue_entry *entry;
+
+	l_debug("");
+
+	for (entry = l_queue_get_entries(scan_contexts); entry;
+						entry = entry->next) {
+		struct scan_context *sc = entry->data;
+		struct scan_request *sr = l_queue_peek_head(sc->requests);
+
+		if (wiphy_get_id(sc->wiphy) != wiphy_id)
+			continue;
+
+		if (!sr)
+			continue;
+
+		if (!wiphy_radio_work_is_running(sc->wiphy, sr->work.id))
+			continue;
+
+		sc->state = SCAN_STATE_NOT_RUNNING;
+		start_next_scan_request(&sr->work);
+
+		return;
+	}
+}
+
 static void scan_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct l_genl_attr attr;
@@ -2065,8 +2092,17 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 		return;
 
 	sc = l_queue_find(scan_contexts, scan_context_match, &wdev_id);
-	if (!sc)
+	if (!sc) {
+		/*
+		 * If the event is for an unmanaged device, retry pending scan
+		 * requests on the same wiphy.
+		 */
+		if (cmd == NL80211_CMD_NEW_SCAN_RESULTS ||
+		    cmd == NL80211_CMD_SCAN_ABORTED)
+			scan_retry_pending(wiphy_id);
+
 		return;
+	}
 
 	l_debug("Scan notification %s(%u)", nl80211cmd_to_string(cmd), cmd);
 
-- 
2.37.3

