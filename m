Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276927702
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:39 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id p21so3179plr.7
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOKtes0ZltwVRHNBy0LfGmRjRzyXYFUiWaVb+96yY0U=;
        b=Ox4B7wQRt/WLmRLRyvi0oesCc69XUiTaTkxDiKzXYweWwXLc3Eh0/C6s8KhsYgVamB
         7kiLBHljGhhEZMDeFZMVS/pOmbqh//+f9f/mbGo4+Q/uvYc/LC2w0EDzJGkGt3eOoHa3
         mARHM/WvYVGhL7OFVEQS5LqniMi6Fbgi1fMiz6YlnHqFwnyh0wykci/z+yNnk5EPBd5z
         RDhj4uo4GZ7zg1D8TPrY3IGOtM89dfFjph0XYYOBzeBjRZzmaqCWyICpmBeb/epPAtPe
         +2+skSaWfXhCoxeRp4Xwt4tiOUtrVeIri5cxvL64zjs8LcQvgOJEhNcNSQ1DYsTB4iv3
         +c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOKtes0ZltwVRHNBy0LfGmRjRzyXYFUiWaVb+96yY0U=;
        b=p9ZM0UMJCtZHJ36p1dFp+A51NH1jILNrONqi8F7ELUaSzvDUVKfbEkM0Oz1L0wrAWo
         wqZuYOr0l+a97wp3hHTe1B84Xl35duDF+XjX8W9t6eoWUywUCh5u61B9S5xq9eTSJGhw
         hl+IDctDfdDM9cMw4LXbyYsygMoYPRIYwqWTkJ2a3c+rNdyDBn+dshdW3/FGKDMtVjYC
         9y+XOFl2ei2ICvwzWWqklg9dv805jLqjcuBAkfa+FBP0vc3zgcqiLg8UX7DBP8Q4yRn3
         y/f4pLU8WJXnpB+PSy5jy9wvWTLPihhEzZSrncvVemo+PHQZo4Uf0a3q/lzgkbtGaTc7
         Ipwg==
X-Gm-Message-State: ACrzQf0S62Fd2GUyWXR+28i6OxY+yq50qM09NKFJa0UUICbpCE4gMitJ
	PxiRVcyt4GIOSmOZ9zv8e23NSKsSSSs=
X-Google-Smtp-Source: AMsMyM729ak0KVfB1TrKPbgfFbPVvCwVUOm/5PXnWCH8jdtFyN3pAtwVWp/4tqJBqaAt8J8yb1cfsw==
X-Received: by 2002:a17:902:ab45:b0:186:7b95:f767 with SMTP id ij5-20020a170902ab4500b001867b95f767mr27365949plb.107.1667422419229;
        Wed, 02 Nov 2022 13:53:39 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/10] p2p: limit ciphers to CCMP/TKIP
Date: Wed,  2 Nov 2022 13:53:21 -0700
Message-Id: <20221102205327.268693-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limitation of cipher selection in ap.c was done so to allow p2p to
work. Now with the ability to specify ciphers in the AP config put the
burden on p2p to limit ciphers as it needs.
---
 src/p2p.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index cfd8560a..ad2ac39f 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1234,6 +1234,8 @@ static void p2p_group_start(struct p2p_device *dev)
 		((uint64_t) pdt->oui[2] << 24) |
 		((uint64_t) pdt->oui_type << 16) |
 		pdt->subcategory;
+	char *ciphers[] = { "TKIP", "CCMP", NULL };
+	uint16_t cipher;
 
 	l_settings_set_string(config, "General", "SSID", dev->go_group_id.ssid);
 	l_settings_set_uint(config, "General", "Channel", dev->listen_channel);
@@ -1273,6 +1275,19 @@ static void p2p_group_start(struct p2p_device *dev)
 	/* Enable netconfig, set maximum usable DHCP lease time */
 	l_settings_set_uint(config, "IPv4", "LeaseTime", 0x7fffffff);
 
+	l_settings_set_string_list(config, "Security", "PairwiseCiphers",
+					ciphers, ',');
+
+	/* TODO: P2P only plays nice with CCMP or TKIP ciphers currently */
+	cipher = wiphy_select_cipher(dev->wiphy, IE_RSN_CIPHER_SUITE_TKIP |
+						IE_RSN_CIPHER_SUITE_CCMP);
+	if (cipher == IE_RSN_CIPHER_SUITE_CCMP)
+		l_settings_set_string(config, "Security", "GroupCipher",
+					"CCMP");
+	else
+		l_settings_set_string(config, "Security", "GroupCipher",
+					"TKIP");
+
 	dev->capability.group_caps |= P2P_GROUP_CAP_GO;
 	dev->capability.group_caps |= P2P_GROUP_CAP_GROUP_FORMATION;
 	dev->capability.group_caps |= P2P_GROUP_CAP_IP_ALLOCATION;
-- 
2.34.3

