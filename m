Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF91DF27E
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288576; cv=none; b=QQt61RqnK3nmoOUCv1u7eBSFgVAckAg750BNhqvsCqivIeLPSTRCo3YkIZOcCaK2zRvPHKNf/edkMr3w0t5cImDGxHvyDhKtHPDroQtdqTv2ArT3FYIsXA/sMD1Ca6mpcqgXlwlAfeuoIFWLYI7lcvP3gAGJfQKAQeuTyzaPZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288576; c=relaxed/simple;
	bh=zrMZF1KWO93JDNcBPSsnDLOcds00UlA1nFhqaowfTs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVIZmDVGS6hELM+LG7L0egMm+wyR3iDWKUfKKeTLQ/nBoS5sdrXhZWubdVfBASLxTMarSM5mbEp5I8hQTpZvLsN+0F6TeJ7DBBQQYBjQBqC9Tj1oqmTDgIx3+dBoqXxNxh0OnafH67UAapMuCZweoZQMsZmi5/Ka37RALfAYjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU1cnser; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU1cnser"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d41176505fso19058786d6.2
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288573; x=1732893373; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j//uCjCp/01QAwP2eyAX/It1NsC6Kx58kuQzSAfbLI=;
        b=bU1cnserdV1DIocmm1KUx3WWleJC4r/n4fpKaXjqC0fMf1SKcDhEyMPgbsdgjOnqdo
         iagePjUMwexeR4kq8kurO/csG17zFJm3+noRqnihFEiU3bAukqdFixOPPGJDC0orspOU
         7Umtt3aXYw3JY3w55MX3Rs/HO9gljSZSM/DnCP4awE+LIXRcuttZeD6bZjhayH1JtPrR
         igndPDe2mpL1P1yS+ZDNB0OHubLRnOimz3R0sxI/1E41xdJtTD0EvCznzeO84S7nJ0Z5
         nfTZT0JgIvSY1RbjYowNBfNmKiITUZGvw4HWApYQfCkjewOl2YYqu63R7Rg6Qzaq0HF8
         LagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288573; x=1732893373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j//uCjCp/01QAwP2eyAX/It1NsC6Kx58kuQzSAfbLI=;
        b=SCEYctNl7vU0F0KdGZOauVNVqVucgEdkRRt4B93uiiG7uDrtiNSGiv/uYh7OLYYDst
         oc1E99Wyn5Y2O2xny2ydTnayRRXle3WBDyWgmkBtlmiGJjFfQdt/4jE4qGW8f2ZAAczD
         H040R/kxOwwpQ0njtZOGiTi1QshR8ln8bipeNg7XV0kZVFXlDVGCahotAZJZLfeXWARA
         4IzpG5fezFfu58BSnLcnGoTXrzzQOWsKebnolWE+NseUPN22omWY7QxLHd6HBKphvreF
         rDAzcRY7eIrixT3rhHTlDIZ3YxNN77+Tp481sMN1peVyg/86BKeKmd/HtwHl+M6Bd/zE
         LJSQ==
X-Gm-Message-State: AOJu0YxZwWIyeQwLkJJ6SJkOM7nocqNHV46H3ajq2jTykvx10A7FTKpn
	RGIuGHKdEq7ZuBPbTxYDaaveKDBlquc8C1TZ9MmVY/uNsXERZdv1Vi5/tw==
X-Gm-Gg: ASbGncuK39aBF6aezNWoqN2gzUAijXjqPidr3kjoVsza0iSfqRmUZUj+UzH/EyU1bFc
	FKC/c4S9WZPeVWIhVH2QTh7XMkIVUQeNIKjfDTNtiwHA3hKls3wsksamea5IjNxljN6idr9dE/R
	Ai/9spWNsnAvS4JdFQp2DagUwyyo9ymKbUvTsEA3Rxw/o9DYDhWB8O93XOYYakBP/Cl8JXx0T5J
	GaDXdHgAk1shhtuRguJ1pVAFUAbpmEiYTO7EJTOZUgN5EbADm07pEHjqkMC
X-Google-Smtp-Source: AGHT+IE9l1t6rg+RRXulLnlBKxKJAqwutpFnEjC4/iFXlk5I5xZzRqGbZeikX7OiFwmNN12So0VEcg==
X-Received: by 2002:a05:6214:5183:b0:6d4:ca5:7bfb with SMTP id 6a1803df08f44-6d450e6d219mr50686256d6.9.1732288573054;
        Fri, 22 Nov 2024 07:16:13 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:12 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/15] station: hold reference to handshake object
Date: Fri, 22 Nov 2024 07:15:48 -0800
Message-Id: <20241122151551.286355-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for PMKSA support station needs access to the handshake
object. This is because if PMKSA fails due to an expired/missing
PMKSA on the AP station should retry using the standard association.
This poses a problem currently because netdev frees the handshake
prior to calling the connect callback.
---
 src/station.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/station.c b/src/station.c
index c1c7ba9d..09193eed 100644
--- a/src/station.c
+++ b/src/station.c
@@ -135,6 +135,8 @@ struct station {
 	unsigned int affinity_watch;
 	char *affinity_client;
 
+	struct handshake_state *hs;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -1771,6 +1773,11 @@ static void station_enter_state(struct station *station,
 			station->affinity_watch = 0;
 		}
 
+		if (station->hs) {
+			handshake_state_unref(station->hs);
+			station->hs = NULL;
+		}
+
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_NETCONFIG:
@@ -2487,6 +2494,9 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 		handshake_state_unref(new_hs);
 		station_roam_failed(station);
 	}
+
+	handshake_state_unref(station->hs);
+	station->hs = handshake_state_ref(new_hs);
 }
 
 static void station_transition_start(struct station *station);
@@ -2691,6 +2701,9 @@ static bool station_try_next_transition(struct station *station,
 		return false;
 	}
 
+	handshake_state_unref(station->hs);
+	station->hs = handshake_state_ref(new_hs);
+
 	return true;
 }
 
@@ -3721,6 +3734,15 @@ int __station_connect_network(struct station *station, struct network *network,
 	struct handshake_state *hs;
 	int r;
 
+	/*
+	 * If we already have a handshake_state ref this is due to a retry,
+	 * unref that now
+	 */
+	if (station->hs) {
+		handshake_state_unref(station->hs);
+		station->hs = NULL;
+	}
+
 	if (station->netconfig && !netconfig_load_settings(
 					station->netconfig,
 					network_get_settings(network)))
@@ -3747,6 +3769,7 @@ int __station_connect_network(struct station *station, struct network *network,
 
 	station->connected_bss = bss;
 	station->connected_network = network;
+	station->hs = handshake_state_ref(hs);
 
 	if (station->state != state)
 		station_enter_state(station, state);
@@ -5039,6 +5062,11 @@ static void station_free(struct station *station)
 		l_queue_destroy(station->owe_hidden_scan_ids, NULL);
 	}
 
+	if (station->hs) {
+		handshake_state_unref(station->hs);
+		station->hs = NULL;
+	}
+
 	station_roam_state_clear(station);
 
 	l_queue_destroy(station->networks_sorted, NULL);
-- 
2.34.1

