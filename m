Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D823A7
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:36:31 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id js9so4643866pjb.2
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1MBLcYioJ9cI9BSWf9OGFwTP7j5/zAAPm+IAYnB3xI=;
        b=kUauQvlpMLu35wR3uS55SbQErtjDqmVwi43eNzeuRykOpTutAriBe3djgqzv5i0p9b
         ocZi33iaJk7hq9wwvhKo3vLRnkvTYaEaZ5csK3U+xKpfvf8en7+qctDe4F8I6fBYkVKf
         w1dgLLoAre/1jf7YRlxXA8oJ5/qD9lx0ZfcEDwAbY+BISkuqWRhlh1xaDUsszwCGYfdr
         0LfiAe0Ow1SnJ1qPQjvHJQzf902bn2bGqppa9XBXYsaoW11dTkdUgEfYI0/xYoSGA0Kc
         VO5XKF7HAogjuaJ6uZBg8GXii02hW5MqeFWGiPJ5zg5+cmhxV2jodP7Oxg7G893O8B70
         rvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1MBLcYioJ9cI9BSWf9OGFwTP7j5/zAAPm+IAYnB3xI=;
        b=tDzMBfxUDzn6TpAuWSepCN+MtvIS5boNjF8PcUqC6x9p2m7HKNeudauDKCTg44w+T9
         2AY35YXlWlD9kQZIVeOAQzh3iQ0KyLfwlywAq0jEEooNDID16slGQwCzSV1iQ8JDEs0X
         dVZcXCE+LADeGkyjWfphAtCpeahF90VhIguHPusMsG1K4efECAoT+V57n8pzHrQPb0w/
         VyFAKbtVwTL3gHtu16zhp+UIejLGFDKwiDKnoMFaMs558YyM+GK17wXeqPucdU83uv0p
         nTvMUnT3AyUq5pJn6UfZ/z8OmgN743sE/rjbug7sQISTSda1kjH80gR9G/S8fppYdIez
         73tg==
X-Gm-Message-State: ANoB5plyc6/vOexksO1TJ89ujxC1OO44DElvCxweP6rDPce7n/Wk8b8v
	jeswZ7hi2cjzOOrjbMjfqtG0g82X5cI=
X-Google-Smtp-Source: AA0mqf6d8k+m66psoDyEmNRu+VGz9acRjiZjERkBcCMP6gOcejyT9yOuIfmbXLv8qTIISVNAakI0Yg==
X-Received: by 2002:a17:902:6547:b0:189:5506:a7 with SMTP id d7-20020a170902654700b00189550600a7mr21789713pln.19.1670963790397;
        Tue, 13 Dec 2022 12:36:30 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b00189f69c1aa0sm272113plo.270.2022.12.13.12.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:36:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] band: introduce new method of tracking frequencies
Date: Tue, 13 Dec 2022 12:36:18 -0800
Message-Id: <20221213203624.1423277-1-prestwoj@gmail.com>
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
be part of the band object and stored as a uint16_t array where
each index corresponds to a channel, and the value will contain
various flags for that frequency.
---
 src/band.c | 2 ++
 src/band.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/src/band.c b/src/band.c
index 01166b62..82ffc13e 100644
--- a/src/band.c
+++ b/src/band.c
@@ -36,6 +36,8 @@ void band_free(struct band *band)
 	if (band->he_capabilities)
 		l_queue_destroy(band->he_capabilities, l_free);
 
+	l_free(band->frequencies);
+
 	l_free(band);
 }
 
diff --git a/src/band.h b/src/band.h
index 9b307a77..06a8402a 100644
--- a/src/band.h
+++ b/src/band.h
@@ -55,8 +55,16 @@ struct band_he_capabilities {
 	uint8_t he_mcs_set[12];
 };
 
+enum band_freq_attribute {
+	BAND_FREQ_ATTR_SUPPORTED =	1 << 0,
+	BAND_FREQ_ATTR_DISABLED =	1 << 1,
+	BAND_FREQ_ATTR_NO_IR =		1 << 2,
+};
+
 struct band {
 	enum band_freq freq;
+	uint16_t *frequencies;
+	size_t freqs_len;
 	/* Each entry is type struct band_he_capabilities */
 	struct l_queue *he_capabilities;
 	uint8_t vht_mcs_set[8];
-- 
2.34.3

