Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340932C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:39 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id o7so14409672pjj.1
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GtnkU7i1pwS9SprIM+W5irvBVAzuS+FEN0PF4dXon4=;
        b=VPsKkbmwm7xIUfDOXy+0Yqf7M7GbqUTUa7+3DTnUpS7ppapHvXSU46Kr2g47Pj4Ng+
         9wmnIuaCi7OaA5SnyUf0+v5WFWWJauFRv/J/f/HspJwN03jVzTHlCEqrRgKiYezQS/qR
         4y8oTTQde0yZg9RWBsNbnXIn1OsXgEIAaXb31UMehXHHnErtQ9be5MJDnqSHtku80i9T
         qS8dgOI3+Ydv7CPG4HTB9i84S4KBeP7Tt/UO2i3ysy2s9SKTediN4rKR9pYFXOZUYvs+
         yGOkTYKPOA7ppbqUM5stQ5QDtOBn5XIqZ4nQd7A/YQc9sqyudPM5FIHcv7jbcZPPPMYv
         Iy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GtnkU7i1pwS9SprIM+W5irvBVAzuS+FEN0PF4dXon4=;
        b=SEPdHu0fwgNmOo8RyBTTeK45GNH1TYCrRf79mVdlwjkhqrwGcxFkCpc4gAyVQ/eW9s
         dbKnGkS+4Gn6BfqmZuG1Ob3IWyLylh8o4JMj3hyNLJ2Kp85U7eE3jegEm84TC16iv9Wj
         myY29TeXs05/DTsirh/a/xi2/LsfPcVnaiY/jyWXhybYUgH5Y6juNrIpfRZWx1j//HDl
         ukgFFDetF79CQNIpoR7cjg6aUxXYuSxExB2+939zkOV+XJMAegFHuOSogxW1xICRblb0
         eQ4pSpn9Frc6w6AxC6OfRpl/Tzb9uslflzUXydJS9GtkU2LBYeQBtkIkE6hYWBxRAVFy
         DH2g==
X-Gm-Message-State: ACrzQf2chr9fcNEIb4JzUwdh9hkTbSjPNsx4ehyKKVUIx2+sN8bjhsSB
	FPXCG1q0+xWpSA+r+owSXr2YgXXCrL8=
X-Google-Smtp-Source: AMsMyM7ybzc4P1BWh5osoDtag0/C7QJ1405jX7+RBP3t0lhUoSSzdkpEdBOKv3D9r4Kjzz+16cR2Tw==
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id jm10-20020a17090304ca00b00179d21ff04bmr27180989plb.7.1667429498027;
        Wed, 02 Nov 2022 15:51:38 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 04/11] p2p: limit ciphers to CCMP
Date: Wed,  2 Nov 2022 15:51:09 -0700
Message-Id: <20221102225116.297129-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limitation of cipher selection in ap.c was done so to allow p2p to
work. Now with the ability to specify ciphers in the AP config put the
burden on p2p to limit ciphers as it needs which is only CCMP according
to the spec.
---
 src/p2p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index cfd8560a..5d96e682 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1273,6 +1273,9 @@ static void p2p_group_start(struct p2p_device *dev)
 	/* Enable netconfig, set maximum usable DHCP lease time */
 	l_settings_set_uint(config, "IPv4", "LeaseTime", 0x7fffffff);
 
+	l_settings_set_string(config, "Security", "PairwiseCiphers", "CCMP");
+	l_settings_set_string(config, "Security", "GroupCipher", "CCMP");
+
 	dev->capability.group_caps |= P2P_GROUP_CAP_GO;
 	dev->capability.group_caps |= P2P_GROUP_CAP_GROUP_FORMATION;
 	dev->capability.group_caps |= P2P_GROUP_CAP_IP_ALLOCATION;
-- 
2.34.3

