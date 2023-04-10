Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C86FB4
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:43 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id j8so4319343pjy.4
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0K8Lmj43PBGXMdgm/treQUpRe5ZPK6+q1fTDzraLa4=;
        b=CYTm6U673Zsg1GHGXeDGKG/q7vNyiMzQB+nDzAVYtLt2ccIISBXg8nL4VjpOv3wa4d
         1JMHdhldBSze7Pc9+yA/Yeyk7y6LFwU0x1i/RHKL8u/d0OZuARpfIuX/qB1IraOjyQeH
         UYASJYmSFxXwEgvs6MFwxDRU0LrLgWIRe3yLVL1vi4p0PvNzylTS1t3bchFRpkoyIg/+
         WTZ6/90KIZkgJ4CxocfonLX1HCqi6oc5sI9PE9KPTOSdUFtLoZQ2VWayr+KCrYM9Ib/R
         Vsv8dyoCSEEiqkAv/60dQnsAtFag0vX6DXgv3eodQfbL3AP6dkXjnDOtiDpa6+lOWetE
         yhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0K8Lmj43PBGXMdgm/treQUpRe5ZPK6+q1fTDzraLa4=;
        b=3zdD1Iuk+ggNukIho8v1ghlj+/4hiPHWERxvzLM2V7EbpzpI1CNfRSOeYIyByfTW4+
         QBw6g23/6tBxcUSYtysZDVuNefRTQNgJVrQhaAm1KwMqmmMpsn1Mp3B6cIKqEdruinUJ
         /mORywx5vHYoVzf+VKkuD0i29uP8ZufBGEagLmoL3BfisWvcQSJBpdOP2nMleObXvgtG
         c0inYgqZbZ4NwTpNjdExdX4+K1b1uqyVvQAsNsUQBYtgyH3x7sLDG5h9q907VOWw8o/8
         wrDYKU6sSBmAOMBcfc6BoxEnRVPr3l8XOegCEn8IhqEHA7LB3BRWThV0xcymMKg70JVH
         QdPg==
X-Gm-Message-State: AAQBX9fAurCIc/m28f2pU8RvsKTsHn5UyaXkPDQ8/SwFN03EysOiqPmW
	IkmpStmo1Ezi4Lmev8MvHQaRCodPw1SuGQ==
X-Google-Smtp-Source: AKy350YuwPqsb17CyCJhbedEHn1VQ7BMXNNQ0r2y3G1ryjHslS6gIUolcsLluDpgQoIGH3DbVRxBVw==
X-Received: by 2002:a17:903:2347:b0:1a6:413c:4a54 with SMTP id c7-20020a170903234700b001a6413c4a54mr5790505plh.1.1681164102412;
        Mon, 10 Apr 2023 15:01:42 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] handshake: include additional sha256 AKMs for PMKID generation
Date: Mon, 10 Apr 2023 15:01:28 -0700
Message-Id: <20230410220135.373872-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410220135.373872-1-prestwoj@gmail.com>
References: <20230410220135.373872-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 802.11 spec defines what AKMs should use sha256 to derive the
PMKID. Hostapd commit b6d3fd05e3 changed the PMKID derivation in
accordance with 802.11-2020 which then breaks PMKID validation in
IWD. This breaks FT-PSK/8021x AKMs in IWD if the AP uses this
hostapd version.

Updating IWD to use sha256 in these cases will now break backwards
compatibility with *older* APs, but this will be worked around in
future commits.
---
 src/handshake.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/handshake.c b/src/handshake.c
index 39a650c5..82e0c1c2 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -754,10 +754,23 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 	 * preauthentication, the AKM has not yet been negotiated. In this
 	 * case, the HMAC-SHA1-128 based derivation is used for the PMKID
 	 * calculation."
+	 *
+	 * 802.11-2020 Table 9-151 defines the hashing algorithm to use
+	 * for various AKM's. SHA256 should be used for the following
+	 * AKM's (for this API context):
+	 *
+	 * 00-0F-AC:3 (FT-8021X)
+	 * 00-0F-AC:4 (FT-PSK)
+	 * 00-0F-AC:5 (8021X-SHA256)
+	 * 00-0F-AC:6 (PSK-SHA256)
+	 *
+	 * (Note SAE/FILS were left out as they generate their own PMKID)
 	 */
 
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
-			IE_RSN_AKM_SUITE_PSK_SHA256))
+			IE_RSN_AKM_SUITE_PSK_SHA256 |
+			IE_RSN_AKM_SUITE_FT_OVER_8021X |
+			IE_RSN_AKM_SUITE_FT_USING_PSK))
 		sha = L_CHECKSUM_SHA256;
 	else
 		sha = L_CHECKSUM_SHA1;
-- 
2.25.1

