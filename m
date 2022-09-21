Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A02565
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:02 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so254199pjh.3
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oMG/6L27oDUjt1yWX3B9dwedAyj4ZZlZvws4V8yKJn8=;
        b=Zo/bTtcu8s/XOtWIL+VEhFZjPtlrsG1HaOJQNa/wWir7Tax3Eh3Vrqbioc59t6+5zA
         DcnZEKrAlsWSbt5O2LVlSj2dGplgYAnVVjnmpJ6UAGQgkCdYWx91EuMhOllN5oAM3f+v
         gCp8kKDL/l1zBYMXGw6TA3CyYPbn3ug0qSkt6m8woZAthnctuuDnlbwGZ4EAy32K3PaT
         mFLuthHvXxaxtwVLzN6irH0UqB6XWdVRPFOFFbyrOoa5cXyi0pVfusoG2F/fr/KrujQK
         Q9wHIvPdtq5Pn8H8n/v6eVUCBYmoQq96UoKXrK+lO5qw7aFLTDBm30OGGqJZo+Q1SsJu
         lKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oMG/6L27oDUjt1yWX3B9dwedAyj4ZZlZvws4V8yKJn8=;
        b=XFUBRGb8ZwyJrijS81TF/vKpOW4zcp8R8jDizbPIiTKoTM2NHShJrJiNYPMTFyfF7a
         NAwx0zrbQKXdb8FLcAuN6vP+cFE4bRTPOqEExK/wDEW9BIQfKg0SGEY7s8XxSZhd8i/c
         9oQGAKn5Af0rWTvF4MeI1zKrYaK55Va1lbZfVYsZ5Yz5m9SjrkvPIz6/4C/UwkkO3b1R
         6IN4LbMvztxHq+ynkb1SiZRR3003yxZmyQ9XksY1M/cCF+y9aTbb/zMexpiXnO1ktx3o
         zAQckC2S47XDT1r/zPoF18r4FxwHP6jk0/J89DCrm5Ng+aBxs4U+XfvQYU87GniYB9Ao
         fK4Q==
X-Gm-Message-State: ACrzQf0sr9+N8+KlDJbPkDG/jNOA1mczPM3K7mmr8LBj5qPTPQd5rAAE
	EpfAuD8/AHSL4fmR87Ot/rPSOuCuNFg=
X-Google-Smtp-Source: AMsMyM75ufX/wMUUf/qRPwBxdZF6Ad79clscKqas68sVPiQXAemTvlNJlRcUtPw/jowuM3KxSjcSvg==
X-Received: by 2002:a17:903:26d4:b0:178:8de:fb5f with SMTP id jg20-20020a17090326d400b0017808defb5fmr338070plb.45.1663799521278;
        Wed, 21 Sep 2022 15:32:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 02/15] nl80211util: include frame type with build_cmd_frame
Date: Wed, 21 Sep 2022 15:31:45 -0700
Message-Id: <20220921223158.704658-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CMD_FRAME builder assumed action frames but can just as easily
be used with any frame type.
---
 src/netdev.c      |  1 +
 src/nl80211util.c | 18 +++++++++---------
 src/nl80211util.h |  1 +
 src/rrm.c         |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7a14f1dd..7f4101be 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4338,6 +4338,7 @@ static uint32_t netdev_send_action_framev(struct netdev *netdev,
 {
 	uint32_t id;
 	struct l_genl_msg *msg = nl80211_build_cmd_frame(netdev->index,
+								0x00d0,
 								netdev->addr,
 								to, freq,
 								iov, iov_len);
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 8fe86ee6..5ba0097f 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -431,6 +431,7 @@ const void *nl80211_parse_get_key_seq(struct l_genl_msg *msg)
 }
 
 struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
+						uint16_t frame_type,
 						const uint8_t *addr,
 						const uint8_t *to,
 						uint32_t freq,
@@ -439,18 +440,17 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 {
 	struct l_genl_msg *msg;
 	struct iovec iovs[iov_len + 1];
-	const uint16_t frame_type = 0x00d0;
-	uint8_t action_frame[24];
+	uint8_t hdr[24];
 
-	memset(action_frame, 0, 24);
+	memset(hdr, 0, 24);
 
-	l_put_le16(frame_type, action_frame + 0);
-	memcpy(action_frame + 4, to, 6);
-	memcpy(action_frame + 10, addr, 6);
-	memcpy(action_frame + 16, to, 6);
+	l_put_le16(frame_type, hdr + 0);
+	memcpy(hdr + 4, to, 6);
+	memcpy(hdr + 10, addr, 6);
+	memcpy(hdr + 16, to, 6);
 
-	iovs[0].iov_base = action_frame;
-	iovs[0].iov_len = sizeof(action_frame);
+	iovs[0].iov_base = hdr;
+	iovs[0].iov_len = sizeof(hdr);
 	memcpy(iovs + 1, iov, sizeof(*iov) * iov_len);
 
 	msg = l_genl_msg_new_sized(NL80211_CMD_FRAME, 128 + 512);
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 1d32b700..44555a25 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -49,6 +49,7 @@ struct l_genl_msg *nl80211_build_get_key(uint32_t ifindex, uint8_t key_index);
 const void *nl80211_parse_get_key_seq(struct l_genl_msg *msg);
 
 struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
+						uint16_t frame_type,
 						const uint8_t *addr,
 						const uint8_t *to,
 						uint32_t freq,
diff --git a/src/rrm.c b/src/rrm.c
index fceff5c7..ed44cee6 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -194,7 +194,7 @@ static bool rrm_send_response(struct rrm_state *rrm,
 	iov.iov_base = (void *)frame;
 	iov.iov_len = len;
 
-	msg = nl80211_build_cmd_frame(rrm->ifindex, own_addr, bss->addr,
+	msg = nl80211_build_cmd_frame(rrm->ifindex, 0x00d0, own_addr, bss->addr,
 					bss->frequency, &iov, 1);
 
 	if (!l_genl_family_send(nl80211, msg, rrm_send_response_cb,
-- 
2.34.3

