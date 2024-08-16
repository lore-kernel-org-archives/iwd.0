Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC351741D2
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812744; cv=none; b=XKkYGmEhOfEhyTI0lKR1/0wuYiECl2FAD+GoRDoE6XgJm3gFwaEYlrXkyYVVCjlc7Qu6q0NV5gbMcZcE/lWIiXwshhWBPnbWSQlKk6C5VAANHZ4cU4alk+HXldGOZUa5UoBRIsNyZ85UcBuF1UFBzNlK6oy5/5wCCNy2RH28gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812744; c=relaxed/simple;
	bh=q7gotcoxEPZUezvxhZwIN1x/NWzLW6u93O+HoQ6zcEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEFoR7kwSakOx9WcABm5LF8A/Q63PbQ13A25G0RpVb+nxxwoSJ4/0YLywO88kxu6/Orngb8EDHw9xBVgYVCx0KiJiA088uhVDUSmbzbYC+fMvZs6+nVz56fFio2Qjfehy8dR00NvOtd6LLBguTAHilKak4YZnma8J+yydbO1iIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k481TFCn; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k481TFCn"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1e31bc1efso122913285a.3
        for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723812742; x=1724417542; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CngE5AZvTqb1OkmdQOJlNjvA6hGBVA2aS90ZfU/54X8=;
        b=k481TFCnNrDVbRw4szKisKNb5Sqk8G6Wgmodd3Bonp4wEQJwDmP9peplYcsmDBh7yy
         Dqg6aHCx1rkMyEb4YyCvSHZ+Kz7FYbxSCwzmGv1/OR3EEcQDMZTSGNz8kyohq3hn6ovf
         zYzOOmQsaTPmlEwuTtIF2OC7NZY5F90c5Wb+KkdiyH/MROizBmutHzZg+dkINyb0mOGk
         GrvK/bhrl8u+MAbzVYTlSjmAKjCNr6b8ztXtmvhk3unPw9VYAGlAlNA/ZaHowZg+RHyN
         tEO4G6Qk8Mgvoy33fB5y7OD12nLT7d/ud+kGo5LkAno1Caj8JX7oAN8lQcLQtEsiXtZZ
         gnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812742; x=1724417542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CngE5AZvTqb1OkmdQOJlNjvA6hGBVA2aS90ZfU/54X8=;
        b=ZgR4i3hA2i1iP01M/OivTj7m2sr/d1wwytT87oCx7pPmH7WTyTRlMQmx7llQbq0K5Z
         RRcwqsV772KkFEuflfO0Sh1rPjpEXghYhgGyN08+oLqUGYpZRFETVUZdt8N1sn1Ayclf
         SkdLe5ymT2ciHZP1YdiwDHbMYLPubfBe1DAkSI7Jb71KYQGJmKNsv1TkdvILT/NaC3sb
         0IAKhgd9BUq2P7/uEaekxIHi764FCpLueLRTO8gK6I5RwL39Em8RemUmJVCwz2Al/gh3
         1+w42Th+79pASITWRpHl2lcraaAiJmvYaZYzZrxmOd7gugSU3tF/76XWAJbgV8I7EAkj
         kkzA==
X-Gm-Message-State: AOJu0YyJ5+mRCgAyt1VMU4tT8IcKBqtWIbpqs8+RvHQC5NpPlyh4B6H8
	AgpeY+j53WXTnsQnkxAG+rpCq4K26g554uYNBcfC+gupGi2M5qHUwDSewg==
X-Google-Smtp-Source: AGHT+IH504mnSj0WfLYkQAefjIrDmsEIp3mXHrhPTg2R30T5sniwUxMO5iYyBDbleDSFT9sA+IspyQ==
X-Received: by 2002:a05:6214:5f10:b0:6bf:6a7a:c653 with SMTP id 6a1803df08f44-6bf7ce6f148mr38588696d6.31.1723812741945;
        Fri, 16 Aug 2024 05:52:21 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff54ffsm15921931cf.36.2024.08.16.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:52:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] network: add back network_bss_list_clear
Date: Fri, 16 Aug 2024 05:52:12 -0700
Message-Id: <20240816125214.1162415-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816125214.1162415-1-prestwoj@gmail.com>
References: <20240816125214.1162415-1-prestwoj@gmail.com>
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
index 25ddce43..e1352041 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1015,7 +1015,7 @@ void station_set_scan_results(struct station *station,
 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 
 	while ((network = l_queue_pop_head(station->networks_sorted)))
-		network_bss_start_update(network);
+		network_bss_list_clear(network);
 
 	l_queue_clear(station->hidden_bss_list_sorted, NULL);
 
-- 
2.34.1

