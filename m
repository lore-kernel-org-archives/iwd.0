Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A43D9C
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 18:23:02 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id h28so8773049pfq.11
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QPxobyoSPXi7wu+uxSJ38AV7JCzaebxdelL8vx0niH8=;
        b=dXqTKyB7n2lgHFxvfcGNTvLcDT5whS58ThPZ3zVOVAtKZIchtbAFDmuPMhIYwmH4YJ
         qQ49LoFjHtq5TBpR+4XyqJ2IRbv5WBfjWux2vCF7RgeSLqkX1tArQxBNmUmkmyrRQwry
         DyY13LQYMlIkofeSPJp45Meb5b1Zm3zGDiI80yHg8iueBJPqeSTGpCeLa4riG5OpBF8n
         4+SVpatoZWfJEYFFPP4e+ieOH8ljGxJsKR8z1Z/KgVLCwLbUF118mfLvQmfXKChocLaH
         MNM5U0CMWRwhqtK/CX9h2NzAYv/1VXVkWGTCTFE8nuu3YhHR0swf64H4HIPyB1klRLjS
         zOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QPxobyoSPXi7wu+uxSJ38AV7JCzaebxdelL8vx0niH8=;
        b=QrDOdmtqb2LzUk9K7tFgTT9Vtd/mb5Wc/xQcG0OOpbKNL5Ww6LDZtfch23DdsrZtog
         L+RNC5tWzcotMppN68OnhcqVK/p3qgS6QBsM1Ipax4Zos1P6EVfi98s+3aGSAtXGV/xY
         NQVNoPnpxh6AyoSYi0/QE+XpYso2Ct3NW2SNMPnR2dvIpbdUJHS8X+xuYoqoDw1Nuyr2
         KtF03mCGv5Mcv6qfDxdWABhadgyHyDjUW1FYalmq45NkULp+NiN6LIg+ZEqeQhB/WBj8
         51zMYZLqeScYF2jG22m45MuUabZlWnG1p34NiOSLOTya1pqFrmH6Te4+tbAhgmpekLoW
         bXPw==
X-Gm-Message-State: ACgBeo0ZCP23ocy1ymLN3VL5sNlZh/xpC9+ZwUV/V8TgbvFET9gqxt2t
	DeRP9sSdER9Q6DuagqLg4A48Vcd2drs=
X-Google-Smtp-Source: AA6agR7jIRENUBsWqoEY3mLJSfGKG2RzDw8/swyHAQpGdOOSaap4qN7rHyljGyv0qnkVIFqexYYUcA==
X-Received: by 2002:a05:6a00:1a0b:b0:52f:3789:9604 with SMTP id g11-20020a056a001a0b00b0052f37899604mr6752856pfv.61.1659982981441;
        Mon, 08 Aug 2022 11:23:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id 129-20020a620587000000b0052516db7123sm8972197pff.35.2022.08.08.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:23:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] owe: allow OWE to force group 19
Date: Mon,  8 Aug 2022 11:22:57 -0700
Message-Id: <20220808182259.19402-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220808182259.19402-1-prestwoj@gmail.com>
References: <20220808182259.19402-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly with SAE, some AP's either don't do group negotiations
right, or specifically with OWE, incorrectly derive the PTK unless
group 19 is used.
---
 src/owe.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

v2:
 * Remove extra flag from owe_sm since this is already in handshake_state

diff --git a/src/owe.c b/src/owe.c
index eed3e266..faa4e17d 100644
--- a/src/owe.c
+++ b/src/owe.c
@@ -45,6 +45,20 @@ struct owe_sm {
 
 static bool owe_reset(struct owe_sm *owe)
 {
+	if (owe->hs->force_default_owe_group) {
+		if (owe->retry != 0) {
+			l_warn("Forced default OWE group but was rejected!");
+			return false;
+		}
+
+		l_debug("Forcing default OWE group 19");
+
+		owe->retry++;
+		owe->group = 19;
+
+		goto get_curve;
+	}
+
 	/*
 	 * Reset OWE with a different curve group and generate a new key pair
 	 */
@@ -52,6 +66,8 @@ static bool owe_reset(struct owe_sm *owe)
 		return false;
 
 	owe->group = owe->ecc_groups[owe->retry];
+
+get_curve:
 	owe->curve = l_ecc_curve_from_ike_group(owe->group);
 
 	if (owe->private)
-- 
2.34.3

