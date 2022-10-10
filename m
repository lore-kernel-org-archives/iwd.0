Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3D5C8A
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 19:40:15 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id q9so11041286pgq.8
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqsYzApM6Z1MqTA2/xFnKsCLy3ac7h8gphO9sNqCxVw=;
        b=Hm+8dIYjoNeqaQIqIn7OBCQ0waJeouFhuSec3qLGHVXZBLHENLKWTDI9kRXvrMhhm9
         zP/rEnoNRqTgEo51Od+QTGp+vVFbcGtuwcgsBTPlN3KGytju968CIoCeqJFF49LgVv29
         sHecgc8MQEedo2xSeyY3xFKO98rXE0FHd3HcKhmwoWEU96BGnfvOEAKglBvYjqeUr72w
         Dhua9I52J357wzDaoJOKMycK1rdIsekboqtxQEOMFFMOWPNqjlhPkZ608dbrkMxwgYaG
         F9zN5y2AvfamYNAIbSqH4ERr/B9dSbrj5Tu7BaYfYaKGCqGIaRORXcR2Bgh2MtA+ehBJ
         8MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqsYzApM6Z1MqTA2/xFnKsCLy3ac7h8gphO9sNqCxVw=;
        b=yrQl5QOjNWLbltlzsygIklqMoYkrp/9P0O/R3FjWFEke95hXwG+Riy/ZK0KlVrEy4r
         qLvRsbyvF5Pa8FgCCoE7O33B/x871UlpjXbBvnvmW448c3/dH2Bman9Ggvjfqp0rDLW+
         u6Grv7xNN+QJz4pRos/5QK3cPT7uTSSew4GsJ5PCD4X2pXUnULHktcyCw8fODXM/EUi+
         QlCPIBdUiL86Q6HY0U76beLEu695nU9gYlyWlY3dPRR5LQb/TqeKqAq3uMpZV3QLA+i+
         RNp5Bh4pggww0ejpvBbCihG0J+6XitoVLWpsTEvdWvlY5MMS7mpz00Yhf1xLbW9xIAva
         GKpA==
X-Gm-Message-State: ACrzQf3PcYPIn55Y2QY9yxNIdnyvQY9QocI2ruR7j18EBZn0JJks7+jW
	+Cs0D8nbIlDfHjSXfTfUZM643RWnP/g=
X-Google-Smtp-Source: AMsMyM7Jw0zCShpZ2CJB1O5xAOH3ZZ0x6S59+u00bWpQ1QBjWF/j9bhtwrry9VvHZ9fKyO0WBfygyw==
X-Received: by 2002:a05:6a00:bc7:b0:563:2e85:1cf with SMTP id x7-20020a056a000bc700b005632e8501cfmr10124126pfu.1.1665430814912;
        Mon, 10 Oct 2022 12:40:14 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i4-20020a63bf44000000b0044046aec036sm6486995pgo.81.2022.10.10.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:40:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] station: contrain known frequencies before roam scan
Date: Mon, 10 Oct 2022 12:40:11 -0700
Message-Id: <20221010194011.55962-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221010194011.55962-1-prestwoj@gmail.com>
References: <20221010194011.55962-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The known frequency list may include frequencies that once were
allowed but are now disabled due to regulatory restrictions. Don't
include these frequencies in the roam scan.
---
 src/station.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index f138846d..986d6757 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2659,12 +2659,17 @@ static int station_roam_scan_known_freqs(struct station *station)
 						station->connected_network);
 	struct scan_freq_set *freqs = network_info_get_roam_frequencies(info,
 					station->connected_bss->frequency, 5);
-	int r;
+	int r = -ENODATA;
 
 	if (!freqs)
-		return -ENODATA;
+		return r;
+
+	if (!wiphy_constrain_freq_set(station->wiphy, freqs))
+		goto free_set;
 
 	r = station_roam_scan(station, freqs);
+
+free_set:
 	scan_freq_set_free(freqs);
 	return r;
 }
-- 
2.34.3

