Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DB6AA4
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 22:02:52 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id y141so676149pfb.7
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KrG7oocmPw8aTDDnqc+23rxGgN3aKuqTzl2qrU7VpfA=;
        b=ACL+H4BrXUlQ1bOhf8hUJdyyWgF23C5sRmA6Vd6vTkyZIdegrEr45yRYWTft2CGZtV
         yxQW0YgAqBGdXbtnj5gaJfCJ3MwMfbjegJTyuzOmXVor3gfs2Xa5Hvt9qcV96Fp7CCE5
         Z9w7ijrFVz5ee9SWfTxiH5AVMHw33bne279+DteI8EALvxFnZZd7HCsI8ISpKfXHxOZX
         dEF+w7dsUB/vVwT5rvlO6amCLziPVuKWQrAuAtdnpjaoF99weaRaIdpHQbBLxibu4qgs
         sdLOWKAwVCXFM6RkhvLNKGXZFqrE7l2ueUpRWihwhNg7ew2qdDjmDvJspmcrVZ8ZrZBb
         o8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KrG7oocmPw8aTDDnqc+23rxGgN3aKuqTzl2qrU7VpfA=;
        b=gpKSRRfKOvEP4KNTGDKvesuWb50HCNy50fZvNMfn3MAF49RuFkzyBwPuZaIbBR7PpR
         RhOgisZEckjT/TdyMh4JidsPr+6kiQRYBojxoPFN53CvXZzv/H1YIWfvclnCgJT22KGj
         ah8ojJJeTELrUAss95qGNAIkeoBwbEK7zDygUDaUGvBwR3ELHtOJeE4xP6cE5wxqWG+4
         sopcZu814V/zNmNEjNtGCDvd3Pg6ERXaVA3AWrsBxdcXcLl7slt5mmHLJAfZ4o6VDjmt
         WoEXtjdaaoTS0+A+c/u4DXCY2V59OAKtNACSsU1xlZKiQ7EIQ6WFW/4Y+JsVg38RFD87
         fwiQ==
X-Gm-Message-State: ACgBeo1Dq3RQJ2v7K1m37EskRyHA9p3QJDPBsA1szzHNmi3ig+d77mL3
	UjJOn1nY2sBAnV92OuAuNPNFEvhSUa0=
X-Google-Smtp-Source: AA6agR50TFpnoFIpm4GoO/6kdtGDIxs73gJWhg4CpvCWP0TEVEVCHUHfY+qYLWOGT9DEX5Bz7Ps0jw==
X-Received: by 2002:a63:7e4c:0:b0:412:f7e:9ab6 with SMTP id o12-20020a637e4c000000b004120f7e9ab6mr3163297pgn.494.1659650571709;
        Thu, 04 Aug 2022 15:02:51 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902ebc300b0016dbdf7b97bsm1376886plg.266.2022.08.04.15.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:02:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/3] util: add scan_freq_set_copy_bands
Date: Thu,  4 Aug 2022 15:02:47 -0700
Message-Id: <20220804220249.508207-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This creates a new scan_freq_set from an input set which only contains
frequencies from bands included in the mask.
---
 src/util.c | 21 +++++++++++++++++++++
 src/util.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/src/util.c b/src/util.c
index ebaff6a0..64d85cbc 100644
--- a/src/util.c
+++ b/src/util.c
@@ -554,3 +554,24 @@ uint32_t *scan_freq_set_to_fixed_array(const struct scan_freq_set *set,
 
 	return freqs;
 }
+
+struct scan_freq_set *scan_freq_set_copy_bands(const struct scan_freq_set *set,
+						uint32_t band_mask)
+{
+	struct scan_freq_set *new = l_new(struct scan_freq_set, 1);
+
+	if (band_mask & BAND_FREQ_2_4_GHZ)
+		new->channels_2ghz = set->channels_2ghz;
+
+	if (band_mask & BAND_FREQ_5_GHZ)
+		new->channels_5ghz = l_uintset_clone(set->channels_5ghz);
+	else
+		new->channels_5ghz = l_uintset_new_from_range(1, 200);
+
+	if (band_mask & BAND_FREQ_6_GHZ)
+		new->channels_6ghz = l_uintset_clone(set->channels_6ghz);
+	else
+		new->channels_6ghz = l_uintset_new_from_range(1, 233);
+
+	return new;
+}
diff --git a/src/util.h b/src/util.h
index 0b7832fb..9d3ec604 100644
--- a/src/util.h
+++ b/src/util.h
@@ -123,5 +123,7 @@ void scan_freq_set_subtract(struct scan_freq_set *set,
 bool scan_freq_set_isempty(const struct scan_freq_set *set);
 uint32_t *scan_freq_set_to_fixed_array(const struct scan_freq_set *set,
 					size_t *len_out);
+struct scan_freq_set *scan_freq_set_copy_bands(const struct scan_freq_set *set,
+						uint32_t band_mask);
 
 #endif /* __UTIL_H */
-- 
2.34.3

