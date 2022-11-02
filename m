Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00C7ED
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 09:22:23 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id o7so12469131pjj.1
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AycpUcPx4n/G2pGkmRh3dcrhRrjkJB3ycDN98v9Ad8k=;
        b=DqWqqwrGKfE/zZODEc+rirkomOFOkNhrwDvrnKBJK0KRhuFiaQU5+7HHlL+qGGFdYt
         uab7gp+XqT0KE83Zhh007zpNYRHJTJYaQd2pbCGp05GFbxeTi9q3zkgTUHMSdgoBVmlB
         mI5sRXpG8w5LD9t0uf3O2Tenf4S1HK7VHpHuTBmAes2ugZxjaiYJfjikICclb2qOrCoI
         13rCEiXprntPeE5F2Hz1C8pHQ3GO/RdeLEjDlXxH5NU2CvRhjYSQGEYOF0r0YGiJ6DI4
         sx2bpC2MEVNGTk79nA1NdhKY7ivFq+2VIgyXEqdV5xl/iqwjCcWlw//kOvvH4+4lcsz5
         /kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AycpUcPx4n/G2pGkmRh3dcrhRrjkJB3ycDN98v9Ad8k=;
        b=ygMJCswSXb/w9cIRWW4XNMMdXlg6Ms9wn5GimDnQW4v5Fg82Ahy0Gv48I4JfGcv39k
         +b3SpZ2xnDwNkQ7c60TRQGUD1uuRgTNfjKuxbzV1fpPO7dj+J/7HNBLg8JuRhGsJ01f4
         SMz53Q4UFoFq/Ir2Lmowyr9jPoicQVqPB25J9+wms8Rl52tLUC7FpCF3p2V2YWQRYiV3
         hegMjY9IL4ZvxFdOGn2PJzMG723TNMMUVV2TLHzn8ENjJgxml+fpmV+HJrnarAoDQ3Nv
         AJfd08Lwiv9+jOQHM1BBKoSyR21FTY2lBDL4swqqlGZCts4MvNYyqfbomDOi1n+3BEGm
         yBPg==
X-Gm-Message-State: ACrzQf1kic88bDUJRiuhU+MwSoSQffT3L3/vflKXsxc3EuPaC+GKcHqJ
	wD4hnudu6ZVGMYkEFaeItzA24ShD5kdl/g==
X-Google-Smtp-Source: AMsMyM4tBM4U4zX04BLzk0xOb01lBrFd+oUpBGZsT1jekI4OXYu4ogh4ZkztwMMdUzbXMSRUpLFVkA==
X-Received: by 2002:a17:90a:5917:b0:213:b349:13fc with SMTP id k23-20020a17090a591700b00213b34913fcmr22519378pji.152.1667380942792;
        Wed, 02 Nov 2022 02:22:22 -0700 (PDT)
Received: from pvlnv.. ([2a09:bac1:36c0:80::1c5:63])
        by smtp.gmail.com with ESMTPSA id r10-20020aa79eca000000b0056b6a22d6c9sm7992827pfq.212.2022.11.02.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:22:22 -0700 (PDT)
From: eNV25 <env252525@gmail.com>
To: iwd@lists.linux.dev
Cc: eNV25 <env252525@gmail.com>
Subject: [PATCH 1/2] client: fix spurious newlines in station show
Date: Wed,  2 Nov 2022 14:51:55 +0530
Message-Id: <20221102092156.71357-1-env252525@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change removes duplicated calls to display_table_footer(), in
station show.

Before this change, the bug caused an extra newline to be output every
time the table updated. This only occurred when the network was
disconnected.

    $ iwctl
    [iwd]# station wlan0 show

---
 client/station.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/client/station.c b/client/station.c
index b070807b..1d958ef2 100644
--- a/client/station.c
+++ b/client/station.c
@@ -217,15 +217,9 @@ static void display_station(const char *device_name,
 			47, network_get_name(station->connected_network));
 
 		display_addresses(device_name);
-
-		/*
-		 * If connected the diagnostic interface is presumably up so
-		 * don't add the table footer just yet.
-		 */
-		return;
 	}
 
-	display_table_footer();
+	/* The table footer is handled by cmd_show. */
 }
 
 static void display_station_inline(const char *margin, const void *data)
-- 
2.38.1

