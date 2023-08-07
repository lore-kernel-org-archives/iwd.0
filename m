Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D027107B6
	for <iwd@lists.linux.dev>; Mon,  7 Aug 2023 19:12:16 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d16639e16e6so4002716276.3
        for <iwd@lists.linux.dev>; Mon, 07 Aug 2023 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691435536; x=1692040336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76H/CS5B35/6k+0iu1/cU8Z69ilO5LoxkNZmUGCS6ZQ=;
        b=TQDO8K26/k66XOmVefkcnRizy22lO83SXulQNYjVkJ2C3JGpajvf7NTdeIz2jDnMYU
         NVp9Lw/J7Ib48g2tydGFzeLEV4ykrckA8iI2dSh21oUmHANDg54/DtPP2wWO7ERUreBk
         Thw/0ZQawqrPgda+SdirliztuSS3GBBTBt7f+93PZkGyBL1oYbZFp1zP6qcHZmHrjyFs
         by317Z98enzJeslGvQ5hZOfJfVF9IddUYECenfjzaARTw4zY9Z/TIghmZ3QIBGbZW61v
         O7r/E3Y9gP4bKDDS3Rp64H8+pdodm5kzIVcX1t7S+mlfqNf70cTXubH7QRtbESUpc+wj
         BdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691435536; x=1692040336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76H/CS5B35/6k+0iu1/cU8Z69ilO5LoxkNZmUGCS6ZQ=;
        b=OknsBYFqxiCAJffMDhQhDvLXFibr4TLDS5Z7Hxzfj48UMIgLgeZ5TBSH8zaX6lrS69
         8cAn7uAFiJNxE99nlv1f3XvWNKT5R5AfscdUcxZb2X9aYjf0Kc1lMroLJxLXgb9JBmZ9
         J008KOoXayKWRH7hSVM/CM7OOPjfffIN5LVBGBzGV7hJQzEnaHvXby7QpSF8pIVZyOyB
         56q4tgTyLcrCvzhnWeQtnpso+nZGI1w6NOW5K7W8YBWG73lkkl87oE/MvJq+tdGagE1f
         7S00QqZaO72y2TD80MxzsWgDjsKJOg2B3rpK2aqdCE5WEtZ1mgPOXtyDlaxCnYyX0Dnc
         s8XA==
X-Gm-Message-State: AOJu0Yz5Yc962vfrKm21o7yaaLS7kFccEHwOeDtAt8trHDAayKSsInSQ
	qFqkWGjrzMdbS1T9iVt9FU1KCT86EQujMw==
X-Google-Smtp-Source: AGHT+IEP5jDhC3/o7HE7WFM7o5ubtKJD7YgDzRB7Z4PgIIojbm0Z39hPS0O3d2dc7DZ9SwL8w1AG7A==
X-Received: by 2002:a25:2512:0:b0:d0e:42d7:8bf4 with SMTP id l18-20020a252512000000b00d0e42d78bf4mr7447197ybl.40.1691435535670;
        Mon, 07 Aug 2023 12:12:15 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id m184-20020a2571c1000000b00d06d47fd0b8sm2455200ybc.53.2023.08.07.12.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:12:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] scan: remove unneeded debug prints
Date: Mon,  7 Aug 2023 12:12:07 -0700
Message-Id: <20230807191207.442919-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed several debug prints which are very verbose and provide
little to no important information.

The get_scan_{done,callback} prints are pointless since all the
parsed scan results are printed by station anyways.

Printing the BSS load is also not that useful since it doesn't
include the BSSID. If anything the BSS load should be included
when station prints out each individual BSS (along with frequency,
rank, etc).

The advertisement protocol print was just just left in there by
accident when debugging, and also provides basically no useful
information.
---
 src/scan.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 48e53e9a..5a972efb 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1230,8 +1230,6 @@ static bool scan_parse_advertisement_protocol(struct scan_bss *bss,
 {
 	const uint8_t *ptr = data;
 
-	l_debug("");
-
 	while (len) {
 		/*
 		 * TODO: Store query info for GAS response length verification
@@ -1304,8 +1302,6 @@ static bool scan_parse_bss_information_elements(struct scan_bss *bss,
 						NULL) < 0)
 				l_warn("Unable to parse BSS Load IE for "
 					MAC, MAC_STR(bss->addr));
-			else
-				l_debug("Load: %u/255", bss->utilization);
 
 			break;
 		case IE_TYPE_VENDOR_SPECIFIC:
@@ -1795,8 +1791,6 @@ static void get_scan_callback(struct l_genl_msg *msg, void *user_data)
 	uint64_t wdev_id;
 	uint32_t seen_ms_ago = 0;
 
-	l_debug("get_scan_callback");
-
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV, &wdev_id,
 					NL80211_ATTR_UNSPEC) < 0)
 		return;
@@ -1875,8 +1869,6 @@ static void get_scan_done(void *user)
 	struct scan_results *results = user;
 	struct scan_context *sc = results->sc;
 
-	l_debug("get_scan_done");
-
 	sc->get_scan_cmd_id = 0;
 
 	if (!results->sr || !results->sr->canceled)
-- 
2.25.1

