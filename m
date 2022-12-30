Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E798539F
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 22:12:23 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 36so14909132pgp.10
        for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v63Qgza2knrdkGo9SFBuLSbZMrXDMQUKkguG5XeoXL0=;
        b=HLqx9qbgnDkuCjoKAf5ciFz8ODdpuN8BdhzgpBzI4h2sZWTS/Tc1ag9/SeS5p3iMTk
         4nXUwqMJFmSjrbEjhlcZI39E5Y3soM6JNrHxliY6bJ3Mron/f7JAZami64qUDWG7dro8
         gGPAegsSlZEUuOZmHaP9+hEiQZerVY7rt3gxV1o6mwKlcgIIvOMeYeYZqlrhygQAOkMn
         ue1keIrDcJmaXUOs09lDGKxhUjY9ClgbY8ba0dxR5geVE/G1PpH2eXwFOhof1K18WaHt
         omEKmazSkpD81dsfc7lhuB7H0TJadJvDzefqh9YqUN+i9ebUQ+ZEFa5PSm+H2GPxb0Hl
         64FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v63Qgza2knrdkGo9SFBuLSbZMrXDMQUKkguG5XeoXL0=;
        b=Ri1TXZhj8utxd4RHWH0SIlP4bfnpOzlWmj48JPtzxtHNmpsxAKNcCWNWxfjwEyZGzx
         ZaBVYz2lqYk3uVPSnVpZBpZZQsIHmya2GMpr7dghuFmRsNcvYuwBN4lxw4mT77UYHZX7
         BRcqsz2HJAFPYlI9Aecn0EtQ8Y+Tq2NZPRC8LevFsE8DZdfC2GAzsOjR64AFlQPDPiAp
         xT5QdySe83lWjQay10Ivn/bJoaechtRoDJGuN8y0KG0hhfJmovUcD+5JlC+lJgY00/sx
         BPSPQLSDziKqWpiRiQMeoCOzsP2zqRZ3DS2WofHdL/gegq2Ejh4bZcXO4GwvleCOnC0y
         CE7Q==
X-Gm-Message-State: AFqh2kpC3Jt/dcYOVoEln+yz7Q2zVgRql6UgVT1QKiyGFF88Xcefb4zr
	m1s3ExKn8Ub6oSMXUIQpiSEhkz6+yvc=
X-Google-Smtp-Source: AMrXdXsZz11iM7BWVY7h7quLkJyCfM2gRQYV/xjhpszc3DMb1LTzswhtrgnGXkpaqpqFdTzpMXZkTA==
X-Received: by 2002:a62:ee0e:0:b0:580:cf1a:f2b5 with SMTP id e14-20020a62ee0e000000b00580cf1af2b5mr24639601pfi.12.1672438342752;
        Fri, 30 Dec 2022 14:12:22 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00528a097aeffsm14187833pfy.118.2022.12.30.14.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 14:12:22 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] wiphy: add wiphy_get_frequency_info_list
Date: Fri, 30 Dec 2022 14:12:13 -0800
Message-Id: <20221230221216.2985011-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gets the entire list of frequency attributes advertised. This is
needed for AP mode to create a country IE which includes subband
triplet fields.
---
 src/wiphy.c | 17 +++++++++++++++++
 src/wiphy.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 4ff3085a..9ca651f4 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -526,6 +526,23 @@ const struct band_freq_attrs *wiphy_get_frequency_info(
 	return attr;
 }
 
+const struct band_freq_attrs *wiphy_get_frequency_info_list(
+						const struct wiphy *wiphy,
+						enum band_freq band,
+						size_t *size)
+{
+	struct band *bandp;
+
+	bandp = wiphy_get_band(wiphy, band);
+	if (!bandp)
+		return NULL;
+
+	if (size)
+		*size = bandp->freqs_len;
+
+	return bandp->freq_attrs;
+}
+
 bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band)
 {
 	struct band_freq_attrs attr;
diff --git a/src/wiphy.h b/src/wiphy.h
index 1056ac0c..d5d1cc8f 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -104,6 +104,11 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 const struct band_freq_attrs *wiphy_get_frequency_info(
 						const struct wiphy *wiphy,
 						uint32_t freq);
+const struct band_freq_attrs *wiphy_get_frequency_info_list(
+						const struct wiphy *wiphy,
+						enum band_freq band,
+						size_t *size);
+
 bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band);
 
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
-- 
2.34.3

