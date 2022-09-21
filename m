Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A51257A
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:03 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id c24so7076951plo.3
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=USxIiZ4ZzbLnnEER7a8iKhRxw/BjVn2U8EORnHl89BA=;
        b=gS3A/YTBNEUH+f0WzJUXR2Rl5LSCaV3cSPi44X5JBL///VWfFt2Vx1C+cwF0HA+wYS
         z2elkByI4ErdC66ut9Divj1RnJzjNmuIa49GEOovKwOVlzLP2muLcCv3yyBLWexPTFMH
         +BHQTAGlCztnSIJlNorpsDsR9VfCpviZOzboVDsISWU7NQRFHOMS0b/2VOs9W+oR4OVS
         SD1RoWkoS94ZIBmyAHZIgCKElvdA8AQ2lmfUXwtIu2oFIFGwEfuHy9qywc6RUS36UMh6
         D+ZryHYYjj7f7eXll29onJAIe4QXf2jiQ0C0YRU+557l18JWUkR7ncxQS66WahxZclAw
         qW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=USxIiZ4ZzbLnnEER7a8iKhRxw/BjVn2U8EORnHl89BA=;
        b=snl/iy5FxwPeGiCeGcuRjC2CZHEadNsbb49of7LgY9T8TBmwGf2lRHMXPHyiTf1ATc
         u4H8Ocu4u4dEr9JtfD+mjht2KaFVpoTjQPTOxvowkBUCVnDFWlK6gt3qD43XlDDIAmoG
         6WDyWfxU/+35VTymQ6Gwvn4j0z8vPlND4ZkIOGFCukJ4c19W7C7w65a56qklevkcWiTS
         NECff22wVyBau5wknx0h8l9t7lG2v+VHl3IlwVZ76COE9qzecRwDD7iaW7Uypv+ieOdA
         XSi8IMB29+krnvDHikrreRYZ16aRpJoLOaS3JnaJJzP2Df/7JhTKjt1Db7jj2r+uOh7j
         ONoQ==
X-Gm-Message-State: ACrzQf229cJMB8ZX2cHeTZq5dSCFWBpR9mtUpq0NKD4kf1ZMw6U7KCTk
	vJcvg8OiRh87wXfK5tPesLh4When1gM=
X-Google-Smtp-Source: AMsMyM7BNdFuxy/ygOWHI1Al9bqd19/ilVxjvtQb9zC/pKzoyM4Z6csZpyLx1qKI28x+WjH3x2XNWQ==
X-Received: by 2002:a17:903:1205:b0:178:ac4e:70b8 with SMTP id l5-20020a170903120500b00178ac4e70b8mr272234plh.52.1663799522426;
        Wed, 21 Sep 2022 15:32:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 04/15] offchannel: add priority to start call
Date: Wed, 21 Sep 2022 15:31:47 -0700
Message-Id: <20220921223158.704658-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will let the caller specify their own priority.
---
 src/dpp.c        | 1 +
 src/offchannel.c | 9 ++++-----
 src/offchannel.h | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 2c8832ff..6abf539a 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1622,6 +1622,7 @@ static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq)
 	 * called).
 	 */
 	uint32_t id = offchannel_start(netdev_get_wdev_id(dpp->netdev),
+				WIPHY_WORK_PRIORITY_OFFCHANNEL,
 				freq, dpp->dwell, dpp_roc_started,
 				dpp, dpp_presence_timeout);
 
diff --git a/src/offchannel.c b/src/offchannel.c
index 80d4ad56..b9cdc117 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -150,9 +150,9 @@ static const struct wiphy_radio_work_item_ops offchannel_work_ops = {
 	.destroy = offchannel_work_destroy,
 };
 
-uint32_t offchannel_start(uint64_t wdev_id, uint32_t freq, uint32_t duration,
-			offchannel_started_cb_t started, void *user_data,
-			offchannel_destroy_cb_t destroy)
+uint32_t offchannel_start(uint64_t wdev_id, int priority, uint32_t freq,
+			uint32_t duration, offchannel_started_cb_t started,
+			void *user_data, offchannel_destroy_cb_t destroy)
 {
 	struct offchannel_info *info = l_new(struct offchannel_info, 1);
 
@@ -169,8 +169,7 @@ uint32_t offchannel_start(uint64_t wdev_id, uint32_t freq, uint32_t duration,
 	info->error = -ECANCELED;
 
 	return wiphy_radio_work_insert(wiphy_find_by_wdev(wdev_id), &info->work,
-					WIPHY_WORK_PRIORITY_OFFCHANNEL,
-					&offchannel_work_ops);
+					priority, &offchannel_work_ops);
 }
 
 void offchannel_cancel(uint64_t wdev_id, uint32_t id)
diff --git a/src/offchannel.h b/src/offchannel.h
index 1ffa94f1..7912f1e8 100644
--- a/src/offchannel.h
+++ b/src/offchannel.h
@@ -23,7 +23,7 @@
 typedef void (*offchannel_started_cb_t)(void *user_data);
 typedef void (*offchannel_destroy_cb_t)(int error, void *user_data);
 
-uint32_t offchannel_start(uint64_t wdev_id, uint32_t freq, uint32_t duration,
-			offchannel_started_cb_t started, void *user_data,
-			offchannel_destroy_cb_t destroy);
+uint32_t offchannel_start(uint64_t wdev_id, int priority, uint32_t freq,
+			uint32_t duration, offchannel_started_cb_t started,
+			void *user_data, offchannel_destroy_cb_t destroy);
 void offchannel_cancel(uint64_t wdev_id, uint32_t id);
-- 
2.34.3

