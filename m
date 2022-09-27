Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27E4C94
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 23:15:54 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id y136so11015645pfb.3
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zI8Rbuhn8/NNo0p64mmMtHrGsxh0kBUjMQn/xfXf5dk=;
        b=M1ZhQFKLxEGqxLBlb/mRpvzaXR5QDefXG+m553QUXQs2BGfD11NBClKvUWF37TyD5Q
         zzyKNiHwjKdmaT9PcTcNFeYH9Vtd50VKTM5J43d7MRW1coUjirm34ce9AcOCWQz1gsZe
         MPQCbRFzFnW4/Q51TEO+z4Ml1vnww4udvt/zvRsm++eCW97jGBuVWx0FTaJKQaVMbymt
         e+NEC2JI9g2lWvqI6tUT9gjcahze9viwi5kS3b62Ze7V7NADzEwTE9va1wkF+hUpuNv6
         idqVtXcKIvA5h6Ri15QgO8tWoMeAcq0+OhOVkHIxd1tqUAgcgTseFjMLaWKfI2dpQVta
         xqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zI8Rbuhn8/NNo0p64mmMtHrGsxh0kBUjMQn/xfXf5dk=;
        b=5R3Gq7fAlRfgJ6zaQSkWBatEtWI5oO+eyFrD1+fOrNVUa2Kt7T7Pib0snzhC3broen
         hn4vpkHVvUOT6rAacKI2XnVvCYN4DJBvZc4qlIu1W+q31ftMU4wd7LpU1oGE6oVTUuT9
         GzepA8tzrKjE2vggQe+NSfMDL1m8/tvTWRseHIf3q0bD2XVH+DFn6G8qODJqU/MGuoLl
         NwHDhojfeRPEmcLapsMHn1IGkWlhJq5LFL6RECeESHfjo36P1PMDVF4gjrRI4r1SxTPD
         1f/AFPnvKrlqWxYzPDGNtAz2b+stKUDdobKWhU8g5pDjQsodLyXQY/DiC61d0ym3nEZ3
         3mQw==
X-Gm-Message-State: ACrzQf3KPbzeX/qfSG2d7YO+usAPSEjAaXEfw0lNfvwN5yUUSyziTtoi
	lyVGEjGZcJLOln8Uum+SABMe6CRghaE=
X-Google-Smtp-Source: AMsMyM4Ricp4LtnxJZfoqhLKrgjyvmXO3NY4YvPOH3+53iQ0E54KW/zpR6288vXsRJjepObKAcPt9g==
X-Received: by 2002:a05:6a00:190d:b0:550:6db3:b9be with SMTP id y13-20020a056a00190d00b005506db3b9bemr31795654pfi.1.1664320554172;
        Tue, 27 Sep 2022 16:15:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id c67-20020a624e46000000b0053eec4bb1b1sm2345349pfb.64.2022.09.27.16.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:15:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] ft: clear ft_info inside offchannel destroy
Date: Tue, 27 Sep 2022 16:15:48 -0700
Message-Id: <20220927231549.310800-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927231549.310800-1-prestwoj@gmail.com>
References: <20220927231549.310800-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once offchannel completes we can check if the info structure was
parsed, indicating authentication succeeded. If not there is no
reason to keep it around since IWD will either try another BSS or
fail.
---
 src/ft.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 72c42309..5b53810a 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -960,18 +960,17 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 					&status, &ies, &ies_len))
 		return;
 
-	/* Verified to be expected target, offchannel can be canceled */
-	offchannel_cancel(netdev_get_wdev_id(netdev), info->offchannel_id);
-
 	if (status != 0)
-		return;
+		goto cancel;
 
 	if (!ft_parse_ies(info, hs, ies, ies_len))
-		return;
+		goto cancel;
 
 	info->parsed = true;
 
-	return;
+cancel:
+	/* Verified to be expected target, offchannel can be canceled */
+	offchannel_cancel(netdev_get_wdev_id(netdev), info->offchannel_id);
 }
 
 static void ft_send_authenticate(void *user_data)
@@ -1007,6 +1006,11 @@ static void ft_authenticate_destroy(int error, void *user_data)
 	struct ft_info *info = user_data;
 
 	info->offchannel_id = 0;
+
+	if (!info->parsed) {
+		l_queue_remove(info_list, info);
+		ft_info_destroy(info);
+	}
 }
 
 /*
-- 
2.34.3

