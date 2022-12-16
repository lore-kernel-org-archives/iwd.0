Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F48BE4
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:47 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so7355884pjr.3
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8mQvfW4UcUupWINqwg26ZM0G6ITKW3l9EMP7M/v7XQ=;
        b=ftje4sJnw2s6bRGxv+d1eBkX2W3Z4XTnYQmnu7V4tp2XzNBbhK/Eec79zNp/fY9VxA
         jaMIhLOytDK0zmA9tJ2cWF3eDdYD3rm4p09GMNs5aVr3wYVQFVI9DluSZN+OtKDezUaH
         il+TgK2xSpsD6Ffvttv0bqzUOth+eSl2qK7QmpbZjMU6L3bjlP6M1LPLDg3RgOs/9uea
         bKJlgVHqqEjbaKNpVj7XfgT8IS9/pOcGtwJPpj3DmeY8D7KCRsOzTEpbZ/wZlYCE8+IG
         FCereLAxsad3Zqd7VWibfLAq/5zElQegIAr60WlDVAe6m3BCcjC6JGeyhrHNQALW8M2J
         CqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8mQvfW4UcUupWINqwg26ZM0G6ITKW3l9EMP7M/v7XQ=;
        b=1EBkyRdZeYcWeKIOwGSwkDmakXq88rOuDimXTrhbB7oTSkZmkTeVvD3knEqgFLH3Cg
         93hmd2+e7C6EeMz/CP/oT4elwcsCzBFG5aQtQroSBapWaSDaZOAfHJ9iOsjj50/PMKX+
         K6GgGNL9t9jRYoPM9GH2job4WlWDpoWyC6O0YbxEjGi6kHEC/HxrnH0qeodRP3lySk7f
         82uIraEeAfxncbsZNmo4tjKtSVpbkZV1eDtxmK+p7rMw27L8KPp76+epd27s1G75yDq6
         66Gc5DoQaw+ICp1k+IH6X/9Aib6SHxtSBPjRaAZp2W+xKpb50eun+p436UrGgidQeuzw
         ACQQ==
X-Gm-Message-State: ANoB5pk894kPJXPvpCo0q9mLSL7k5dLD2MIOHpqyTF4QLOWygEbkddJn
	SAp12m+rrSl8g76lvfN2sl9ch/IMp0Y=
X-Google-Smtp-Source: AA0mqf6ZqH1MI/Tza868qIfDo88Oohiijcvy1mZv+0i2K/eOG0vL03NeEs3lEg6cjvW1queeqy5A8w==
X-Received: by 2002:a17:90a:c396:b0:21d:6327:ab6 with SMTP id h22-20020a17090ac39600b0021d63270ab6mr31918045pjt.1.1671226066341;
        Fri, 16 Dec 2022 13:27:46 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:45 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/8] band: introduce new method of tracking frequencies
Date: Fri, 16 Dec 2022 13:27:34 -0800
Message-Id: <20221216212741.1833286-1-prestwoj@gmail.com>
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

