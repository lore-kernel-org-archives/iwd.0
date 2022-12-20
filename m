Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0B7E
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:27 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id 4so13628156plj.3
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek5hqy6TWDWFNDt2QXR4ustj3ResW2SSPn9ODwkCkzc=;
        b=nMvb2TkbrYoJf5Y+eRfaI3OZdNxv5osHygyoPQbj590CvYh2EbFkIMHx6tcSqZ+M59
         Oa3TFfuVaRhNxdssF+uID/rkzKib0Z6Rk/TOMPz1YPMVgy+r92Z9P3qgW2MlsVi5J8Hb
         fAW3/8woiIlnf+FaMm3C9e8caQt29m+6FpCyId21PuRNr+9xX6lq4yWPV/K/n9+fk4r+
         qrloktwMzvRfzK89lZh9WYAeEvPKvNG4O22o9mzAD7AmIMADmoqs0TRRbSjOcgun4Tj7
         fHCl4IdT43ThoZziBIUc0/gB0SRNdByrmwBTxR/jE22C6UxE3vGSj1SYAmSJe7WPYXpN
         nQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ek5hqy6TWDWFNDt2QXR4ustj3ResW2SSPn9ODwkCkzc=;
        b=ekDIjldd4CKB5f7inlfy4y07JYugOPJVBXN0+L2vWOeXNRh2enG0gS+xwt9vhOIjKx
         w+MXElTEX7gDmlEPJ8sqCgunHLUBglBVpL7S0C4qqV0TnR7DrUNtDgE8OJ5LfFnv3ewu
         3DqBdZSXB6qkgIT8aBXYF74rHycSJ53m0972MnUs/XrTYtEINtKXr3eM8Rz8lT08i3Kp
         OFNi8R4pESVxXrwTbI/+hdA0eiANeQ/g5gsEJUF/1bC6Bq2NRZy3TNu4f3Q5bbudCZ6K
         65sYjvbCdE/EwtR6k2hUeCh83z2ofY6Nn7x6azdMcMy2JlR5z/znkx7GYWzdgQn/ZJve
         CgSg==
X-Gm-Message-State: ANoB5pk9/xwfYT/nC7bnmtaQ+pisVFrjLVRbNJomqd2DzwC7VTPkVuVV
	qg2rzv8/6kEnCnAWXROEY5YMAL/fTPQ=
X-Google-Smtp-Source: AA0mqf4ASrwVC8ue5P1ILc8cYFx9d0KYImLbZHaMoS8XvivVTE1CEPiV0kNhi5GX1ljhbaER29fCgQ==
X-Received: by 2002:a17:90a:fc95:b0:218:ff8e:5d6b with SMTP id ci21-20020a17090afc9500b00218ff8e5d6bmr50207260pjb.16.1671572607307;
        Tue, 20 Dec 2022 13:43:27 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/10] band: add band_chandef_width_to_string
Date: Tue, 20 Dec 2022 13:43:14 -0800
Message-Id: <20221220214318.2041986-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/band.c | 20 ++++++++++++++++++++
 src/band.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/src/band.c b/src/band.c
index b1e319d7..73a63c79 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1581,3 +1581,23 @@ enum band_freq band_oper_class_to_band(const uint8_t *country,
 	else
 		return 0;
 }
+
+const char *band_chandef_width_to_string(enum band_chandef_width width)
+{
+	switch (width) {
+	case BAND_CHANDEF_WIDTH_20NOHT:
+		return "20MHz (no-HT)";
+	case BAND_CHANDEF_WIDTH_20:
+		return "20MHz";
+	case BAND_CHANDEF_WIDTH_40:
+		return "40MHz";
+	case BAND_CHANDEF_WIDTH_80:
+		return "80MHz";
+	case BAND_CHANDEF_WIDTH_80P80:
+		return "80+80MHz";
+	case BAND_CHANDEF_WIDTH_160:
+		return "160MHz";
+	}
+
+	return NULL;
+}
diff --git a/src/band.h b/src/band.h
index f7f0c318..1b3f1669 100644
--- a/src/band.h
+++ b/src/band.h
@@ -115,3 +115,4 @@ uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band);
 uint32_t band_channel_to_freq(uint8_t channel, enum band_freq band);
 enum band_freq band_oper_class_to_band(const uint8_t *country,
 					uint8_t oper_class);
+const char *band_chandef_width_to_string(enum band_chandef_width width);
-- 
2.34.3

