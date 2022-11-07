Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE982F37
	for <iwd@lists.linux.dev>; Mon,  7 Nov 2022 18:50:47 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id b62so11275872pgc.0
        for <iwd@lists.linux.dev>; Mon, 07 Nov 2022 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrWTz/Wf7DnyYEZSQkL3/Hb+KipN/rlBfDdFjKB0oMI=;
        b=otOh/w4sOi/ohLw4K0fI8I/yINALeozsP26+WJ4sSSFP6gRHTEMK6qeeLydHW34QVZ
         91Gi9P+OpUS33UHQBa9BcizMEGfH3yQFtoLMICnn04MkeluXPEUG3VG+MlcQA+WtNOnI
         1G+EPRfdtUYFGsntBApgSoK/CegtMHL4ldxlSahJMw1bMr9EUnycpqKaThKqcpaYUdf/
         Cs3exU7YjNpaFJFSHehbK9JegH2PiNnyEToKfNrKiqQtISQkQpadn2VDp/sSCLdb6RMA
         IWPm6zpMUihOrFTtxccWzIOsqD2J9R/LTz8xX7/1fG4B0cSrPN7soQvmkzzbahPIFEep
         x08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrWTz/Wf7DnyYEZSQkL3/Hb+KipN/rlBfDdFjKB0oMI=;
        b=IZ+m/GlPLp9+SEY/ln7GvVpN5WoPh8iesXijVsmA5MgnEAar/gq3JnVtCRdu1Alyqm
         QYgIg0YxZmD/0KToPRmTEL/MtAl0e4fzg3lBMcNYFCj/buQcKYvRg2xzIVijID5W4vdF
         0kdKHHO4RgSoOa1kXEhapg4O+ePluQGPYuixCpb6YasbHBywb3VHGvlid+sZNA7RK8pw
         HWDbyxRuTJcFVdqWqU31Dmgn/3sEoaULJDlJeVzBnsxo63Mj6e07Am1CdLqSMN2GC/Ir
         iRQyH6AYZAF7+Ex92nXulP0ar4/hY5gFtxitW7pCuTT5U1qUJYoFITxfV2twcvteZNo8
         DiSA==
X-Gm-Message-State: ACrzQf0O+zzgBarmYDFPXcAx+TxBaDs8oQ84oX1V/cCpsB1OnG4AXQWZ
	sEb1XBKtUmSaVNI87HDEq2RNdLegNPQ=
X-Google-Smtp-Source: AMsMyM7pW8wdxKk38MGJp2gswqCrOr9K3k0VG5ufMcGt9mSkwXNCyaNO4Dh7/sTYensPCxPz1X5SJg==
X-Received: by 2002:a65:4ccc:0:b0:470:1a0a:a821 with SMTP id n12-20020a654ccc000000b004701a0aa821mr22387754pgt.447.1667847046965;
        Mon, 07 Nov 2022 10:50:46 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b00181e55d02dcsm5341530plh.139.2022.11.07.10.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:50:46 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: try catching buggy driver behavior to avoid hangs
Date: Mon,  7 Nov 2022 10:49:44 -0800
Message-Id: <20221107184944.675454-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that IWD hangs during roaming due to the kernel never
sending any expected events after authentication. This was likely
due to buggy firmware but ultimately got IWD into an unrecoverable
state waiting for an event which never came.

The only indication of this to userspace was a DEL_STATION event
which happens after the successful authenticate event. Now IWD will
watch for this and if the conditions are right IWD will fail the
connection.
---
 src/netdev.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index cda8d183..817b8737 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4933,13 +4933,12 @@ static void netdev_station_event(struct l_genl_msg *msg,
 					struct netdev *netdev, bool added)
 {
 	struct l_genl_attr attr;
+	struct l_genl_attr nested;
 	uint16_t type;
 	uint16_t len;
 	const void *data;
 	const uint8_t *mac = NULL;
-
-	if (netdev_get_iftype(netdev) != NETDEV_IFTYPE_ADHOC)
-		return;
+	uint32_t connected_time = 0;
 
 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -4948,6 +4947,22 @@ static void netdev_station_event(struct l_genl_msg *msg,
 		switch (type) {
 		case NL80211_ATTR_MAC:
 			mac = data;
+			break;
+		case NL80211_ATTR_STA_INFO:
+			if (!l_genl_attr_recurse(&attr, &nested))
+				continue;
+
+			while (l_genl_attr_next(&nested, &type, &len, &data)) {
+				if (type != NL80211_STA_INFO_CONNECTED_TIME)
+					continue;
+
+				if (len != 4)
+					continue;
+
+				connected_time = l_get_u32(data);
+				break;
+			}
+
 			break;
 		}
 	}
@@ -4958,6 +4973,49 @@ static void netdev_station_event(struct l_genl_msg *msg,
 		return;
 	}
 
+	/*
+	 * Check in case buggy drivers never send the events we expect. This
+	 * has been seen on iwlwifi where a 'connection loss' in the firmware
+	 * results in no events after authentication. The only indication of
+	 * failure we see is a DEL_STATION after the successful authenticate
+	 * event.
+	 *
+	 * Any protocol using CMD_AUTHENTICATE/CMD_ASSOCIATE could end up in
+	 * this situation:
+	 *  - SAE, during auth or assoc
+	 *  - FILS, during auth or assoc
+	 *  - FT, during associate (since CMD_AUTH is not used)
+	 *  - Reassociation, during assoc
+	 *
+	 * It should be noted that protocols such as SAE and OWE may reject
+	 * authentication with the intent of retrying (status 77) which does
+	 * result in a DEL_STATION event. In these cases the connection time is
+	 * zero, and the event can be ignored.
+	 *
+	 * If the following conditions are met we can assume this is a buggy
+	 * driver:
+	 *  - Current handshake exists
+	 *  - Handshake is not for an authenticator
+	 *  - Connected time is non-zero
+	 *  - The STA address matches our handshake authenticator address
+	 *  - Currently running auth/assoc protocol (auth-proto, ft, or reassoc)
+	 */
+	if (netdev->handshake && !netdev->handshake->authenticator &&
+			!added && connected_time &&
+			!memcmp(mac, netdev->handshake->aa, 6) &&
+			(netdev->ap || netdev->in_ft || netdev->in_reassoc)) {
+		l_warn("Kernel never sent a connect event to indicate failure! "
+			"This is a kernel bug and needs to be fixed");
+		netdev_connect_failed(netdev, netdev->associated ?
+					NETDEV_RESULT_ASSOCIATION_FAILED :
+					NETDEV_RESULT_AUTHENTICATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+		return;
+	}
+
+	if (netdev_get_iftype(netdev) != NETDEV_IFTYPE_ADHOC)
+		return;
+
 	WATCHLIST_NOTIFY(&netdev->station_watches,
 			netdev_station_watch_func_t, netdev, mac, added);
 }
-- 
2.34.3

