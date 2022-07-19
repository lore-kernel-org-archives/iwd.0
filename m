Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F24C82
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:57:59 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso22343885pjc.1
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d4MjSFXgWOJfY0OY4ByGcj2QUYiTbENckOsnVAO0y9U=;
        b=mESNFKUa4yINmY8b8gDJuqsFh0FeDSFcvN1aAmX/mk7tA3aesEswFaMjxKDzhWoL6f
         ViJdqC4w0VJnk8XSPuigTtdn3lj1AJ0AGmj7WVzsrBd+uLwseDOPk1N+e3HsOnUQlEQX
         GhtZIFLAKRJRtGgfLpylKQEtDJqyE84zG6AkaSa+lvTDzwatW+AbprJ7sCJw5L9dZxXk
         rW7u7w+Rt+lz709gACTZkpygtktH9/O7GzHnn002xravwSjxziz0WlXzP6yPmcMie3hP
         Bht7xhbMUi2se08Vb4fGaxJbaSF+Rm5HPf3sgDd6d6gNex9TsUFuqoKYVNwxCeXHZSPt
         PGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4MjSFXgWOJfY0OY4ByGcj2QUYiTbENckOsnVAO0y9U=;
        b=gSrCuohkz3WU1PM+N3S1t6sxHFlXxuiROU1JeLg8W74uatNYr41lH01BS4AfEzEkIm
         ewHnIcodDmEs6KoFg238pjFBNzryx+R7Xzv0ccHz0xyJrEJGp6EVCS2uTuf6iwS2HWwj
         WOXX0ZiAV6lXmrVR2jzP7VKzm/v4B9OnJQZB0J4NKZk+MohUtG8HiRLTltsBPySiW44E
         arbm6gTkMY8vrDHBqC75Saw5M0TD/ObpdbBR7FD8UJR0WO07PL9ddAojKmGDtsBdEqIG
         107pcUbFVehC5dcTDk+SXS9K3jAW/EV7T0x99jL021K+MIojtAQoFTRMgEKXKpVpOjie
         uzoA==
X-Gm-Message-State: AJIora+KbnoMmSPU6kXasNMKQJK7cvEgjOSytyIayP6V5emSrzCaSizW
	TXK0wS0WH/cIVYjzgiCT8fW2H3bkOEQ=
X-Google-Smtp-Source: AGRyM1s7HQP5LdMJbMOR+An1JkeJ58lYjnEyOfYIZQG1FS3E+G1sj9ouNDf7ocXhBD1Cm10Gv1TENw==
X-Received: by 2002:a17:90a:880a:b0:1ef:76fb:d8b6 with SMTP id s10-20020a17090a880a00b001ef76fbd8b6mr853195pjn.69.1658257078806;
        Tue, 19 Jul 2022 11:57:58 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:57:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/12] band: add he_capabilities queue
Date: Tue, 19 Jul 2022 11:55:36 -0700
Message-Id: <20220719185544.456727-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This queue will hold iftype(s) specific data for HE capabilities. Since
the capabilities may differ per-iftype the data is stored as such. Iftypes
may share a configuration so the band_he_capabilities structure has a
mask for each iftype using that configuration.
---
 src/band.c | 3 +++
 src/band.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/src/band.c b/src/band.c
index 984bc15d..67bbcd79 100644
--- a/src/band.c
+++ b/src/band.c
@@ -32,6 +32,9 @@
 
 void band_free(struct band *band)
 {
+	if (band->he_capabilities)
+		l_queue_destroy(band->he_capabilities, l_free);
+
 	l_free(band);
 }
 
diff --git a/src/band.h b/src/band.h
index ba887ee6..1f1269c7 100644
--- a/src/band.h
+++ b/src/band.h
@@ -49,8 +49,16 @@ struct band_chandef {
 	uint32_t center2_frequency;
 };
 
+struct band_he_capabilities {
+	uint32_t iftypes;
+	uint8_t he_phy_capa[11];
+	uint8_t he_mcs_set[12];
+};
+
 struct band {
 	enum band_freq freq;
+	/* Each entry is type struct band_he_capabilities */
+	struct l_queue *he_capabilities;
 	uint8_t vht_mcs_set[8];
 	uint8_t vht_capabilities[4];
 	bool vht_supported : 1;
-- 
2.34.1

