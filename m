Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305613698B
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083068; cv=none; b=RGwm+A5A8QJWxmMr8YkeiMqEhZCFRYp/6+Z3k8vYm4/dee0BS2HbuwaxoDor/mv0QwXBbmDMJcIngi/PtpKmtJMydpDLHEBooitq1GXvJ/x7Gd+mPMSK0QogahvNjLsgRiDVG8bkh6TnGAPgm4WXOUObd2oZ+x4R8qGTV74cJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083068; c=relaxed/simple;
	bh=RC1rsY0tGCRivMAspeEl23nEHI5GpA0HFim2qN46O1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QA1WYacJNhRAY9+IvyLhKSuXbTOBBd11AlkqdDZCsbIj3QKOSkVidlOqIoJkF481Jwq9ufPtKif3bw4WDTr0XifX9RUMHHQHFXfF8tqWj5w9adohPrs4PpDoJtqxyHW19UHOep/ItEYTmyLjssLP/DSwKgDiHUTRxwxo2u5WyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYdF0WaS; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYdF0WaS"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a115c427f1so2699317a12.0
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083066; x=1724687866; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOtO/WMTZo4GLFRZfbqnYPS7ONYYi4bw8wetTO1+J64=;
        b=RYdF0WaS9HBGSGWIJBPpV7M+0//HEN9WjAG7nou+C4ugGJFVfvll2YNKL83XkYaX39
         zMQt+TnAG59sEAHc0UjOqQmrCy4OZbEzp/frKCiWhZb/xswqdCjRkULm684n434+qvBm
         IwIBZbOhBl+M2TBUL4HLN3rm6kBipSlPzEnOAy9OnKIxe9tnhcL+mE4sZbbuanCYLjMz
         82rwgBierZuFyQozn+KEIqYMEcbmQPVdEc4Azr7mvySPvIQrRVPnF0WR7rv4rv/sMXf4
         FvD2Pk4fyOdobfZybY6N9fwRtcpIkxE58tg35WcLt7jYT2yO8Nd2BL9DUc9z/To4FrD2
         pC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083066; x=1724687866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOtO/WMTZo4GLFRZfbqnYPS7ONYYi4bw8wetTO1+J64=;
        b=rnvMLfmo8fumKywP5AnJthJjiWW5LiMlGW1gQA63kjmXiRdl5b9HpJDH8VLULacj21
         xfp9Ko7hDvPtQbEMYM57Yf4YL7+Uq7FqARcXjCW43/m3Nz6k671lZu2CxVOoAKE74X97
         w6FPKeaw75kwOO5CG9Cz0+4ZbeWRfzR/SaONCRbzg7PJIqTuGXwerjbFc/UHvCucq+CS
         nbF8DFQLvGatKg9e3WjISapAxdHovhvB4O+WWoVnZKanis2HqFh1mV/IU4HSwFAGtDGJ
         acrewdmVOJtClWKR4fAi0I0anx1avwhGfOtPuy4quHJrOu6lj9gAHYGEvYaGsbQF0UxS
         4OgQ==
X-Gm-Message-State: AOJu0YxE7wnOSkXno8gp5lCmqwLv2i00W8ey1Pd2F8uMlXjY2ntAB+4G
	mWrNQEgTXTj/SxHuvhSDMrTj05QL9fyONZayihKDoaI5Kj3j4Z9+y+1Xmw==
X-Google-Smtp-Source: AGHT+IGc+KwtYW733TUBIqSq6VTb4DrJsVWvhE7Hxz878dOW7bXHBckZRKR8Ac6E52lsHA8PKh2XKw==
X-Received: by 2002:a05:6a20:6f8a:b0:1c0:eba5:e192 with SMTP id adf61e73a8af0-1c904fb8e21mr11291845637.27.1724083065803;
        Mon, 19 Aug 2024 08:57:45 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb5asm6752277b3a.69.2024.08.19.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:57:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/6] network: add back network_bss_list_clear
Date: Mon, 19 Aug 2024 08:57:32 -0700
Message-Id: <20240819155734.1276476-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819155734.1276476-1-prestwoj@gmail.com>
References: <20240819155734.1276476-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename network_bss_update_start back to network_bss_list_clear, since
this is what its now doing again.
---
 src/network.c | 2 +-
 src/network.h | 2 +-
 src/station.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index b9194b3c..300e8090 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1146,7 +1146,7 @@ const char *network_bss_get_path(const struct network *network,
 	return __network_path_append_bss(network->object_path, bss);
 }
 
-void network_bss_start_update(struct network *network)
+void network_bss_list_clear(struct network *network)
 {
 	l_queue_destroy(network->bss_list, NULL);
 	network->bss_list = l_queue_new();
diff --git a/src/network.h b/src/network.h
index 73d2ddb0..849051dd 100644
--- a/src/network.h
+++ b/src/network.h
@@ -68,7 +68,7 @@ int network_can_connect_bss(struct network *network,
 						const struct scan_bss *bss);
 int network_autoconnect(struct network *network, struct scan_bss *bss);
 void network_connect_failed(struct network *network, bool in_handshake);
-void network_bss_start_update(struct network *network);
+void network_bss_list_clear(struct network *network);
 bool network_bss_add(struct network *network, struct scan_bss *bss);
 bool network_bss_update(struct network *network, struct scan_bss *bss);
 const char *network_bss_get_path(const struct network *network,
diff --git a/src/station.c b/src/station.c
index 2a58c69a..6a28254b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1016,7 +1016,7 @@ void station_set_scan_results(struct station *station,
 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 
 	while ((network = l_queue_pop_head(station->networks_sorted)))
-		network_bss_start_update(network);
+		network_bss_list_clear(network);
 
 	l_queue_clear(station->hidden_bss_list_sorted, NULL);
 
-- 
2.34.1

