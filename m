Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391613A272
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939538; cv=none; b=VYZe2qqeg6Q7FIGK3duLi/yARtaO4F38OWYMbTPUJPTug+R5bmV0xZsIC3InIpEZvMr6XJhXp/cdCH1KDtGtQ5vGAowbXT2rfSSzhRMpcCdcyzg8n6XxZ5ROShdJgu4SfpX1/E83hPUQ8db1uFmi5k5FgqNZhkWi9W4Gpl4JF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939538; c=relaxed/simple;
	bh=oyLfx7/pnzUxmYnnnTiool80jLMxFi8o1pp12AKBvjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiZ7mkb6BZ3W5yqNJagSv6dpKUIWh41u6OD/d2eT4jb6Lrzr8K7ox1rU+KN1rmL6/imlQOFsjC+vmwsUH9/d5rVlW2KgNJDjyQXwOikUldo0SSzptKfbdjCXETUA8IM3S2SjXNtVlLHmnxB4gFMiSOwuWFC1uS2QLULx+/Hoxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAkcZEnN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAkcZEnN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d73066880eso696885ad.3
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939536; x=1708544336; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnLoxeM6Ty2uLw1/hnm+dZ2siXT53vfl6N5L3jiKhsQ=;
        b=MAkcZEnN+9ividRviUd9hc+uoOdAU96B12WRi2runrNEDv++2NkB8xgrfaXANQaJRY
         S6HjLrrTbeKKU3TcKI1eahdEZ5suA3d9MxyEfscHz1TEtQryJ5umMTmvP+T3grbiR4uR
         26kzUxWHyEra9Pc/nX7fkmDhLF4dmagG/Wk1Fa9fTAvhhMC3ZE7g5OiJWoXM7Htq5i03
         Pbhp1hCX83UPKYdz+NW+U4Hm6DrzVzN6zsP/bCJDDsbycvuFVXzaEsnxze4or7SIxu5I
         4OnqvzU6oQXRICDP5m5pSok++A30tes/+s2HtZJRSg8yaTnldWtTf5WIM2wO7Xw3oB2k
         FkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939536; x=1708544336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnLoxeM6Ty2uLw1/hnm+dZ2siXT53vfl6N5L3jiKhsQ=;
        b=hhevC/m5V/1KCWbuDMuWZgsVB90lQM9bQXu+HNsX/qarDaNiZnODLSQExNng3s3kcE
         KXQ36/Cj2cdCvBRfx4qqVfqKJi1j/Vy4T6ofhu2Db9jATbS1DoyySe+8Bj35iLjpgIMq
         l2YDwDiPWZgvTYGyVTWpHYaWVy6Vf3cgtlIti/7CB6rjPKXUCYht2Xep6xuq54JEnEDz
         5O8EUdF4syC/Vw7dsm1llmTmvn7LF9EBW9XABmVH265MDLExaRX/tUSLr7nv114ZQa5p
         2i5/uHJ5OflAiZH+0yVjmksRwmP0MzADxUyj39i9i5DQjufe9Gnxf/bBgrXfuaeSvFql
         mXcw==
X-Gm-Message-State: AOJu0YxVecGGUXfuSy84BRYdXh/e8aSvfVxTnPpuV7X8NjrlAqEbHi0i
	ZqL8OLltQbIX0y3i22DUKGuWr5svxKbfr1AwMATL7wvgx28LJEIJtYcOWWEB/Jk=
X-Google-Smtp-Source: AGHT+IH0ds7LpZpT6ZKmV6td9M8+9B37eeg+zWwdUx11p0enmU3WiLn36+dBxV7m6a5asfdM6J4qtw==
X-Received: by 2002:a17:903:120b:b0:1d9:c876:b825 with SMTP id l11-20020a170903120b00b001d9c876b825mr4853270plh.56.1707939536071;
        Wed, 14 Feb 2024 11:38:56 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d08200b001db53ccb856sm1761606plv.108.2024.02.14.11.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 3/5] station: add additional station_debug_event's
Date: Wed, 14 Feb 2024 11:37:41 -0800
Message-Id: <20240214193743.963349-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214193743.963349-1-prestwoj@gmail.com>
References: <20240214193743.963349-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add events/notifications for roaming, connecting and disconnecting
information.
---
 src/station.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index a097174e..7d6a8023 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2389,8 +2389,11 @@ disassociate:
 		station_disassociated(station);
 		break;
 	default:
-		if (ret > 0)
+		if (ret > 0) {
+			station_debug_event(station, "ft-roam-failed",
+						"status: %d", ret);
 			goto try_next;
+		}
 
 		station_roam_failed(station);
 		break;
@@ -2462,8 +2465,11 @@ static bool station_try_next_transition(struct station *station,
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
 
-	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
-			util_address_to_string(bss->addr));
+	station_debug_event(station, "roaming-info", "bss: "MAC", "
+					"signal: %d, load: %d/255",
+					MAC_STR(bss->addr),
+					bss->signal_strength / 100,
+					bss->utilization);
 
 	/* Reset AP roam flag, at this point the roaming behaves the same */
 	station->ap_directed_roaming = false;
@@ -3164,6 +3170,9 @@ static bool station_retry_owe_default_group(struct station *station)
 static bool station_retry_with_reason(struct station *station,
 					uint16_t reason_code)
 {
+	station_debug_event(station, "connect-failed", "reason: %u",
+				reason_code);
+
 	/*
 	 * We don't want to cause a retry and blacklist if the password was
 	 * incorrect. Otherwise we would just continue to fail.
@@ -3214,6 +3223,9 @@ static bool station_retry_with_status(struct station *station,
 	else
 		blacklist_add_bss(station->connected_bss->addr);
 
+	station_debug_event(station, "connect-failed", "status: %u",
+				status_code);
+
 	return station_try_next_bss(station);
 }
 
@@ -3374,6 +3386,8 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
 	case STATION_STATE_NETCONFIG:
+		station_debug_event(station, "disconnected-info", "reason: %u",
+					l_get_u16(event_data));
 		station_disassociated(station);
 		return;
 	default:
@@ -3513,7 +3527,12 @@ int __station_connect_network(struct station *station, struct network *network,
 		return r;
 	}
 
-	l_debug("connecting to BSS "MAC, MAC_STR(bss->addr));
+	station_debug_event(station, "connecting-info", "ssid: %s, bss: "MAC", "
+					"signal: %d, load: %d/255",
+					network_get_ssid(network),
+					MAC_STR(bss->addr),
+					bss->signal_strength / 100,
+					bss->utilization);
 
 	station->connected_bss = bss;
 	station->connected_network = network;
-- 
2.34.1

