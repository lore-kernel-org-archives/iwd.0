Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE806EAE2
	for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 19:24:33 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f8cc042e2bso20376355e9.2
        for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857071; x=1689449071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxAhFMqWOuukV1XGKm8q4b9h3kuq2uZ21xIx1btzfCs=;
        b=Lh8W9j/mPPjiAMkg/caOpP3CUKWCRtkRetAfHpqjuyDx7qIkSVosVsSFTMtyGfXkDK
         aR2E4Gqz9p2QWkj3yukJ52O9oy8erqi7vJiay9iQcqie9nnc1r37ehUOZAH5QclOLgRm
         VHWeKphAZs278AJ3pD8FzbORRBXu6nWrN1aaEadV6qD4WSW9gS6oo5X/ANALHZs4PMWN
         Ez5aMixNrJQyOwNVe14jD05/VWxG1ChBGWrriQjK/FHj4NXhMkgjc4N7bHTHuqD/M2HP
         wgbqnttY9SkNRli407MP46vywMEBXgSdYh2kbNiJH2G77NNKhIwjXhI/irkDLEpuA1tm
         rqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857071; x=1689449071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxAhFMqWOuukV1XGKm8q4b9h3kuq2uZ21xIx1btzfCs=;
        b=jTCFhGpaCjNhLGVF2GtRc8ecpxFEurdgjNyKd8gBjcdrDtid6dItiV+t8yE46T0qjX
         db5g7yFDhoAIh4PRZa+Rzwgn2WTh7mEPTxFf1mD7EDST+UZK9H9lsj7CC666nieToMeW
         tbnrPEoZkLXd2jT8bI4PfakSB1q8z+O0slgiVSEcZpqlMbxnxMpFfYXFpSand1s6LPhT
         p8rtm10vlIO9goKJvE4ux8VAbk2q/HuOySa+Pl8c8BgHTwxP1aiKnkapLLyMiWdo6Ue9
         DZgBLdhmCELeZP8sZ2U3FL9UVnlPbiZdxVhF+BXtvNtGYD8xpj6o+dAoIErH7+Z/shJ4
         ewcg==
X-Gm-Message-State: AC+VfDzcjZNvmdDQx/bebVJcgJulPod9z2QQLtAoqvEhpOvCqrtk39sy
	EJTGijg8/z/qQvtvKFOkcFX9TkfdesXlrA==
X-Google-Smtp-Source: ACHHUZ59PPBTzVWs4hGbpW9iPxvt6f4kfXrVMYHncT518PvflfF5Xz/5aNbR1hLbEKBKXjdPcGSqPw==
X-Received: by 2002:a05:600c:215:b0:3f5:ff24:27de with SMTP id 21-20020a05600c021500b003f5ff2427demr139783wmi.32.1686857071445;
        Thu, 15 Jun 2023 12:24:31 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003f6028a4c85sm28241wmi.16.2023.06.15.12.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:24:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] wiphy: print driver flags on startup
Date: Thu, 15 Jun 2023 12:24:14 -0700
Message-Id: <20230615192415.1718516-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615192415.1718516-1-prestwoj@gmail.com>
References: <20230615192415.1718516-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to other basic information, print the driver flags so the
user is informed what is set.
---
 src/wiphy.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 2c09d47a..ebc91206 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1333,6 +1333,27 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 		l_free(joined);
 		l_strfreev(iftypes);
 	}
+
+	if (wiphy->driver_flags) {
+		char **flags = l_strv_new();
+		char *joined;
+
+		if (wiphy->driver_flags & DEFAULT_IF)
+			flags = l_strv_append(flags, "DefaultInterface");
+
+		if (wiphy->driver_flags & FORCE_PAE)
+			flags = l_strv_append(flags, "ForcePae");
+
+		if (wiphy->driver_flags & POWER_SAVE_DISABLE)
+			flags = l_strv_append(flags, "PowerSaveDisable");
+
+		joined = l_strjoinv(flags, ' ');
+
+		l_info("\tDriver Flags: %s", joined);
+
+		l_free(joined);
+		l_strfreev(flags);
+	}
 }
 
 static void parse_supported_commands(struct wiphy *wiphy,
-- 
2.25.1

