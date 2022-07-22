Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCA4A2E
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 16:37:14 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d10so4878480pfd.9
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnSQiZunjwkwihk4s4Mew9IVpaoXRgbw7DAEaraw7ow=;
        b=cKlYX+KGTvkJf+Ug00gViioF0RaKnsqBMr0+/j9gP3TBk87o77xa7QJ2Oqr28Br5MD
         XVo612ws+xbw8KMVl8wyjdK6y4kioMDDWjk8Uh57GYD/tUh2u32QsM7P3/uY4KARjOxr
         CtoQ0Z1iLDTT8SrnXryG28HBOBTqXoNjzDzYcpV5gAZaPTz3f+Aes4DoMf3nBf/LV19O
         9YsckbrkokZH4OsDfPvFy6yUoieXrnPAM04WdIauPcv9qtz7q0ovnP3vvA43PI/ioocn
         Cjp3Ctr7WxnEpWBaOeUmlW0gId/e8R+6oPUY23DrWtMvv0A5DrI31iT0Ntk1Fmwq/6cU
         cecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnSQiZunjwkwihk4s4Mew9IVpaoXRgbw7DAEaraw7ow=;
        b=s7oItZyKBBGxwZufnqIKHq7rMp4/E7taVyPd960VJXNkpcRUBaBSykULK3qhYyXuaQ
         etVDQCAjp/1IifegD2EpruEWNurKuuPcRuVaUwXFuPuMAS7Q0Onbu12MOF9tliCmevyY
         352jYHYzLfslo69gqL01jo3NeiKJPTuOE0mrXywxiYKZzmw90Kjj5pRYjvHNJYXzFudW
         l/YTbLDHp5vj4Y6ww8hSCBrxhhc81JsqSnxGa48iEhSAoA3BzPI32KC+eiU/uyScuhrX
         ztbhX8/LX5H+CJLtIw07o8pDizYctIjoc0e5h8uNcb/HGmaOTvgTj221h38yi3tvY0/A
         qH3g==
X-Gm-Message-State: AJIora8K1bhfRuMZNu+nMwz+eYAStEW7JjIagLuUbPiLlwyJg5skhVPS
	FDg5eMntaqsXoec/lz6G0lnNnw0h8y4=
X-Google-Smtp-Source: AGRyM1tp5uqBqV5HnoS2emW+CqbptwM3zS4XmDgx4xM6VX/o7pBnYZTG6dJM9q1RcohLbyheglchsg==
X-Received: by 2002:a63:6902:0:b0:41a:3743:c768 with SMTP id e2-20020a636902000000b0041a3743c768mr538140pgc.512.1658507833396;
        Fri, 22 Jul 2022 09:37:13 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0016a109c7606sm4013887plf.259.2022.07.22.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:37:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] util: add scan_freq_set_max
Date: Fri, 22 Jul 2022 09:34:14 -0700
Message-Id: <20220722163417.1119334-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722163417.1119334-1-prestwoj@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finds the maximum frequency in the set
---
 src/util.c | 19 +++++++++++++++++++
 src/util.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/src/util.c b/src/util.c
index 8fdb7f17..2563184e 100644
--- a/src/util.c
+++ b/src/util.c
@@ -379,6 +379,25 @@ bool scan_freq_set_remove(struct scan_freq_set *freqs, uint32_t freq)
 	return false;
 }
 
+uint32_t scan_freq_set_max(struct scan_freq_set *freqs)
+{
+	uint32_t channel;
+
+	if (!l_uintset_isempty(freqs->channels_6ghz)) {
+		channel = l_uintset_find_max(freqs->channels_6ghz);
+		return band_channel_to_freq(channel, BAND_FREQ_6_GHZ);
+	}
+
+	if (!l_uintset_isempty(freqs->channels_5ghz)) {
+		channel = l_uintset_find_max(freqs->channels_5ghz);
+		return band_channel_to_freq(channel, BAND_FREQ_5_GHZ);
+	}
+
+	channel = __builtin_popcount(freqs->channels_2ghz);
+
+	return band_channel_to_freq(channel, BAND_FREQ_2_4_GHZ);
+}
+
 bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t freq)
 {
 	enum band_freq band;
diff --git a/src/util.h b/src/util.h
index ff5211ed..964f6500 100644
--- a/src/util.h
+++ b/src/util.h
@@ -122,5 +122,6 @@ void scan_freq_set_constrain(struct scan_freq_set *set,
 bool scan_freq_set_isempty(const struct scan_freq_set *set);
 uint32_t *scan_freq_set_to_fixed_array(const struct scan_freq_set *set,
 					size_t *len_out);
+uint32_t scan_freq_set_max(struct scan_freq_set *freqs);
 
 #endif /* __UTIL_H */
-- 
2.34.1

