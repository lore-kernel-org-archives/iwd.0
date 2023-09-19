Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F0347AB
	for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 16:59:26 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bf7423ef3eso43969225ad.3
        for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695142766; x=1695747566; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N63+4dGwRwj8N7f/+hMABWds1ozcn674BhlsiLUpsS4=;
        b=fXbnTQeYfZyrpqrpsd/BGM6v+ohyrTSzcnnx+uIEjqSpNMIjFXLZYcSxVnXVxor/ay
         eWP/asWFYjDoUcfIz34L6Ml2FuAIKtqOFLI4CilmcX2twTglkvHuEpPRBsc2xoiUeEkL
         CvY+0O1SYzHQrdiSUOgx4Vt4v+z4XYht0rNi5OZb2/du8djEN8NtABgr4XfaomTM2ifp
         N7qMLRc5kldNuAOb34NZ3m9l0vueveh52Yhk5zdBjk+EfBJSn43EVWAOsFzeaoDwh8Nc
         E+VNKh/SoeNCGcSHQil8EbLJ6bw5cXR9Yc9iQgx/sF7Ps/LX/8bYzwvrKxUBhoFL0rrP
         SxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695142766; x=1695747566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N63+4dGwRwj8N7f/+hMABWds1ozcn674BhlsiLUpsS4=;
        b=sPR93D+ZMoglPfTdGeHQwHj3qzNH0WirRvd2Tacti4opRmwAvJihwjS6DtNMSklsUs
         Or0GLnpvRRqWOVfvjpjMelECmNTIAdIiPKHdhR1kMpEXwyCn+02909v/zrzlPPR9a7gh
         OytXVAIaK8olvzTB3ujBB6H8hOsa1PoXP8j7uuMz12bmTL+4RqUaR18VLRTubciKMOSY
         coIGmHSYY0LqRch9yc8F94x8yQXQ+jWYE8TW4HGwbOnE6iwwtFpG0iOYzLFU9hhAwfG8
         sEknKYUVNodr05FttnZd8TYjexCVBWEtaJia5VAzo81IhYmVfWj2sKTvpuLzhUzVV20e
         WVGw==
X-Gm-Message-State: AOJu0YyjdGB/sVyg1nTNQPxEZXQbtImuzf7Y2vAOC+g9DWn0vpsEG3Hm
	gr3kd1iKUVcDEFqOJx8V6trhz334070=
X-Google-Smtp-Source: AGHT+IEapyuB0/cs1C8S/1TyPG+7YXFZ4P/UvB7LEtS4WN6txN3Ff+ZpS7sH486QdbySu0AO3Hg27Q==
X-Received: by 2002:a17:902:cec4:b0:1c4:21f3:4be9 with SMTP id d4-20020a170902cec400b001c421f34be9mr12444716plg.62.1695142766132;
        Tue, 19 Sep 2023 09:59:26 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b8c689060dsm10323399plh.28.2023.09.19.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 09:59:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] wiphy: fix wiphy_contrain_freq_set skipping last channel
Date: Tue, 19 Sep 2023 09:59:22 -0700
Message-Id: <20230919165923.1352279-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop iterating the frequency attributes list was not including
the entire channel set since it was stopping at i < band->freqs_len.
The freq_attrs array is allocated to include the last channel:

band->freq_attrs = l_new(struct band_freq_attrs, num_channels + 1);
band->freqs_len = num_channels;

So instead the for loop should use i <= band->freqs_len. (I also
changed this to start the loop at 1 since channel zero is invalid).
---
 src/wiphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 77ed2acf..ccff701e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -843,7 +843,7 @@ bool wiphy_constrain_freq_set(const struct wiphy *wiphy,
 		if (!band)
 			continue;
 
-		for (i = 0; i < band->freqs_len; i++) {
+		for (i = 1; i <= band->freqs_len; i++) {
 			uint32_t freq;
 
 			if (!band->freq_attrs[i].supported)
-- 
2.25.1

