Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17E3D8F
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 17:14:11 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id 130so8606137pfv.13
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lodhUZ4NNTPXPE6yHi8gdypRoPUpzO5iOmdbIuGOfsc=;
        b=bhEc7HTXI2HPmBHVCp9jog5TTNle+en/S79CycfgN98/8HBZGTCSroGdOWM34LizHO
         jsMPd5R8INxDNYQ2w9MnYLiN3qANu6KwqtCDtTOyInjboZ4eJGpvvmSaBFAheWPJljRn
         za6i0q4QTbw/KndgKA8kS/cvAeqwnP6rn5z8j8mQvEfnEFNrb9yvUu9rgteMFkC7WX3W
         OAQm6I3o+vnTAm9PUJueUC9OfsJfzrHEh2yJYkPDCOcT+Y9dwKLOqsBUX4KSfzkl9AaS
         WLKMczVrjXHXeZqZwZTN5Rjmf3RgRKN3aqnCMHwMpVFJRuXNr9g8exVGiwmeOH9IiwIj
         bEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lodhUZ4NNTPXPE6yHi8gdypRoPUpzO5iOmdbIuGOfsc=;
        b=4Wu81SLaeW0Ys8zK6vtYwgHZhYvT7RaL3zcr1c4OPea3eAC11qi4LsG01ZPg5PXbR0
         LHjNH7jilWrxWyX6KU/eQbfVcTZjaxuBEGX/tzc4E+ved8Ow4yA30RsfxvuE+MIwIoFt
         PXZNN6zfq1ePoV3fjiDsydnKIVwYoWTAefE6LcVITDLdudnD1lAbvZEoIe8PDukUOHrs
         28oabv9/J5GyPU+sxmZjeGenaPIg+Do+fFi6FhuEzgO4Oon5MCpPF37LbQoUFiupiF3l
         6rn70tAs0lYik7MfL4uJ1alsBoGVOQE6Uijej3CtOYoZ/AYgByHZHtQch/j6hGW++Z7f
         1nPA==
X-Gm-Message-State: ACgBeo0S9nKtkJo4JRHaKodLZq+RIX6i5BGoutsMJXhoRmSZva+Qw1X5
	8BfdtG2X6fuG8RPbeumpieT9C1bQKy4=
X-Google-Smtp-Source: AA6agR5Nbz+RszTWo7lTG4BsYiD3hnVY6B2NkRHGGYM6doJjowJlF66EZE1SXxsuoEGVX5UQNLVu7g==
X-Received: by 2002:a65:6c07:0:b0:41d:9ddd:4266 with SMTP id y7-20020a656c07000000b0041d9ddd4266mr2530227pgu.326.1659978850749;
        Mon, 08 Aug 2022 10:14:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b0016dd667d511sm8932754plk.252.2022.08.08.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:14:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] owe: allow OWE to force group 19
Date: Mon,  8 Aug 2022 10:14:04 -0700
Message-Id: <20220808171406.12931-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220808171406.12931-1-prestwoj@gmail.com>
References: <20220808171406.12931-1-prestwoj@gmail.com>
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
 src/owe.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/owe.c b/src/owe.c
index eed3e266..c4808cf4 100644
--- a/src/owe.c
+++ b/src/owe.c
@@ -41,10 +41,26 @@ struct owe_sm {
 	uint8_t retry;
 	uint16_t group;
 	const unsigned int *ecc_groups;
+
+	bool force_default_group : 1;
 };
 
 static bool owe_reset(struct owe_sm *owe)
 {
+	if (owe->force_default_group) {
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
@@ -52,6 +68,8 @@ static bool owe_reset(struct owe_sm *owe)
 		return false;
 
 	owe->group = owe->ecc_groups[owe->retry];
+
+get_curve:
 	owe->curve = l_ecc_curve_from_ike_group(owe->group);
 
 	if (owe->private)
@@ -222,6 +240,7 @@ struct owe_sm *owe_sm_new(struct handshake_state *hs)
 
 	owe->hs = hs;
 	owe->ecc_groups = l_ecc_supported_ike_groups();
+	owe->force_default_group = hs->force_default_owe_group;
 
 	if (!owe_reset(owe)) {
 		l_free(owe);
-- 
2.34.3

