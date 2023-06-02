Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA436258F
	for <iwd@lists.linux.dev>; Fri,  2 Jun 2023 14:58:20 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5586f18e6c1so1064110eaf.2
        for <iwd@lists.linux.dev>; Fri, 02 Jun 2023 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685717899; x=1688309899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8oGqJbMbiIirVeK/mEBfCC1e8l/Xmu9e55fUbS1yRo=;
        b=lTVcTfs3lt+pi9jf8vkT7t936HF1ssWP/DXWa6kbOvPU8rG20Lsu5YwjDx3xU1e+Fa
         /RCdCGEeby44XIcVQAmXBCZiyqaAg9YsJd7KmunKjxsXY0/2cRZl7/p9Y7/O1hvplwJF
         uAxzvgZ2YT0DkALTx88ZolkJaRA+59DOovt/TWOHOuxhgCqK7WC8rTKkVZ/F5thCGfim
         BG8iHeBxzBGXAbYQ9kZpOiYojdFWoIeFJLkSjzH43FeQeVAnDJ3GpDiXHeizIYHXb49J
         YRUiTUOfIWbJ2umC1u5BmIWluse2VbSnNzG27fc2GtUum/gfQalQws/9Y4wZhTbk3cXa
         f4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717899; x=1688309899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8oGqJbMbiIirVeK/mEBfCC1e8l/Xmu9e55fUbS1yRo=;
        b=bujGmhdxPmAX1LXhsYVUORL3vkOeo5q7kSjJtQFy/f9viTc7DCfLmZyOsJ2D+eU3H5
         cwdjyODXuA7dXXUhcb1scWBkxBJaI3T6OQnWQ92BvsLV4kIp+TIRLLAMLQeMJB0ALupa
         7P0kA+XPVmjRE5H5OJdp4G8JN39yEehrkTtudp4RXLgDQlcVQZ61Vy529dG4GfuvOAoQ
         igLAGXaA7boBjGJoj39ZPTNh6sVYdDLO5lKW2TwIYghBF1yYiNtbSjRkM6g7z0tOfOuS
         KzK9+pDREQWYOurglQfusK+J2eEo+XinD980yt64rURbjloyniG6t6hMmRLEFCvzOmgh
         yYCQ==
X-Gm-Message-State: AC+VfDzkmN3hKeGlhPnDETmJF6DcP5cSVs0PIjiE8PWM+8r0uPEJARJL
	IaTRDyJeEEqWemjoF2UiezTQ3ps/X4LvbvrK
X-Google-Smtp-Source: ACHHUZ68hH6ZrLMAMJ/hwIYx2rJzne/g5sB/SoEgOVmK6U++vpmiZ9ZTcuN54apMOrg9dExlThRlqA==
X-Received: by 2002:a05:6358:9184:b0:121:306b:4dfe with SMTP id j4-20020a056358918400b00121306b4dfemr6956849rwa.7.1685717899440;
        Fri, 02 Jun 2023 07:58:19 -0700 (PDT)
Received: from localhost.localdomain (h134-215-217-184.bendor.broadband.dynamic.tds.net. [134.215.217.184])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090a609700b002563b38a2f7sm1389297pji.50.2023.06.02.07.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:58:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] ap: Remove opt-out DisableHT for opt-in EnableHT
Date: Fri,  2 Jun 2023 07:58:11 -0700
Message-Id: <20230602145812.22010-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HT support was added to AP mode which was not widely tested
across many different wireless adapters. The adapters tested
did not seem to mind the channel width setting but recently
several users have experienced AP mode breaking using the
default/no configuration. Disabling HT works around the issue
and allows AP mode to start in these cases.

This deserves further investigation but its looking like more
often than not users need to add DisableHT. This isn't so bad
for AP profiles since the user has to create a profile anyways,
but for the Start command its best if it "just works". To error
on the side of caution DisableHT is being renamed to EnableHT
making it opt-in rather than opt-out.
---
 src/ap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 398e469a..7e6c868e 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3668,19 +3668,22 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		ap->band = BAND_FREQ_2_4_GHZ;
 	}
 
-	if (l_settings_has_key(config, "General", "DisableHT")) {
+	if (l_settings_has_key(config, "General", "EnableHT")) {
 		bool boolval;
 
-		if (!l_settings_get_bool(config, "General", "DisableHT",
+		if (!l_settings_get_bool(config, "General", "EnableHT",
 						&boolval)) {
-			l_error("AP [General].DisableHT not a valid boolean");
+			l_error("AP [General].EnableHT not a valid boolean");
 			return -EINVAL;
 		}
 
-		ap->supports_ht = !boolval;
-	} else
-		ap->supports_ht = wiphy_get_ht_capabilities(wiphy, ap->band,
-							NULL) != NULL;
+		if (!wiphy_get_ht_capabilities(wiphy, ap->band, NULL)) {
+			l_error("AP hardware does not support HT");
+			return -EINVAL;
+		}
+
+		ap->supports_ht = boolval;
+	}
 
 	if (!ap_validate_band_channel(ap)) {
 		l_error("AP Band and Channel combination invalid");
-- 
2.25.1

