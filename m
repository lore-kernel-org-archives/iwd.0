Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF332119
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:20 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3043280pjm.2
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8mQvfW4UcUupWINqwg26ZM0G6ITKW3l9EMP7M/v7XQ=;
        b=O9jXDzhn08fQuvw5vNmhSp9w/gHiGlaGgSyZAxMYSlG5UqWtIG9EU4sS6XtSub1Yu6
         T12DmQAuWd51BuoSyAtkWKnZF/VU0dag/zYIXW23ZDr9DR/+kwin8TXILvPXF5xyVvd2
         44B2dd1s1/tcKyKbPlOqfPobOufY4IeMIXiE7VLbKKPPkFpDm4dhkEZiUraCzPCRgWIW
         HafBI/Z62PlLsUVIfz/27+fpUQM4ETjund84i6/ZNgZN2FE4aff0aL7MHRnSu0wuxjNL
         ++bfG1vyM09pK6iF8xcNR3ny8luUmLXyLxGyJyxVJ3jwGkar8D5ZlIOchaJMTjCvGxr0
         8c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8mQvfW4UcUupWINqwg26ZM0G6ITKW3l9EMP7M/v7XQ=;
        b=Xbo7YXT4fHgPr+JHyH7VHG/YQeth9n5ipdwhHkjAzM+kyq+mu3oCSAis7LM54/SB95
         jDSsrvOErptU2OlJ1A6uCy0PCQuGU5IlOBBTG0YUVTuARt4cJb7bFfPSVXn33wVQ2pt1
         o0Gp9beu+Ef3n/8XBN5pbNPmjlOCPNO74TC+IJiX1k8/QZmRheKmkTTOuW4MoOTF1smn
         TTIlRJUzRJqlkJdxCltJ9dCBb1AgovVqZa6Sz3QxW5oY2acmC0jo+FjYvem5QehH1cHn
         UxxyHypgSH2jnqAXt2xbROHkB4AqCP8LChiJ8ghqJ+CwagvxFXcPTKS55Mk4dgkIyfQb
         s8NQ==
X-Gm-Message-State: ANoB5pknbQARncoD3dBQrxmzSC1+wd4TuSs3BltNavQrxKIQ+dDOH7dO
	xdKUzIYj+6AtbtoRILs90fQtBYsVe8I=
X-Google-Smtp-Source: AA0mqf4VzQgbsGjpFcMfhXPuABx6n1qsXZqGI9EUqHfr2hnMqrSaBGAgmqkSnw+7RqdhaxBGHpkVQw==
X-Received: by 2002:a17:902:74c5:b0:187:dc9:ef64 with SMTP id f5-20020a17090274c500b001870dc9ef64mr35485481plt.60.1671211579316;
        Fri, 16 Dec 2022 09:26:19 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:18 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/8] band: introduce new method of tracking frequencies
Date: Fri, 16 Dec 2022 09:25:59 -0800
Message-Id: <20221216172606.1799396-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the wiphy object keeps track of supported and disabled
frequencies as two separate scan_freq_set's. This is very expensive
and limiting since we have to add more sets in order to track
additional frequency flags (no-IR, no-HT, no-HE etc).

Instead we can refactor how frequencies are stored. They will now
be part of the band object and stored as a list of flag structures
where each index corresponds to a channel
---
 src/band.c | 2 ++
 src/band.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/src/band.c b/src/band.c
index 01166b62..d89b2a90 100644
--- a/src/band.c
+++ b/src/band.c
@@ -36,6 +36,8 @@ void band_free(struct band *band)
 	if (band->he_capabilities)
 		l_queue_destroy(band->he_capabilities, l_free);
 
+	l_free(band->freq_attrs);
+
 	l_free(band);
 }
 
diff --git a/src/band.h b/src/band.h
index 9b307a77..da4c0ae5 100644
--- a/src/band.h
+++ b/src/band.h
@@ -55,8 +55,16 @@ struct band_he_capabilities {
 	uint8_t he_mcs_set[12];
 };
 
+struct band_freq_attrs {
+	bool supported : 1;
+	bool disabled : 1;
+	bool no_ir : 1;
+} __attribute__ ((packed));
+
 struct band {
 	enum band_freq freq;
+	struct band_freq_attrs *freq_attrs;
+	size_t freqs_len;
 	/* Each entry is type struct band_he_capabilities */
 	struct l_queue *he_capabilities;
 	uint8_t vht_mcs_set[8];
-- 
2.34.3

