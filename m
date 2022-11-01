Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2321D42
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:04 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso40045pjc.2
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAgiBi84vL5+0ESFh6tvm8krO8ZajAxFMxugRLqCevM=;
        b=AxFr6YCREUmIJ/0bYbaownnDg0/5zCg4lauMW1soQ8iiSwpO033rx/AWcPj6a17TVY
         B+Sf8FO6gk3ZYvw6m9kw79/1ohIcHKvkgra/eSY7fuEnsNYeNrTiWUXkplvU+goms2dA
         w+CUHBk4GcD8Hr39Csq/OmC8J5KyDVNQWolFRNWNpN0Va/kG7LTiDUCH5ESqR2Zy4twC
         0cr+NsbG/weDzUcb2q00vjXxgeUoFfIdgvlVIVjKqFaP6oOEeaJHNExuxQYGzX/HmxJx
         rUI3tZeILDxUUSOA1c3/iGLUH0sfpzLon3D8SVRBKUl5Eq3dYQdIQkPnQnUbtAdEWp+6
         9Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAgiBi84vL5+0ESFh6tvm8krO8ZajAxFMxugRLqCevM=;
        b=3cdKhQMnIIh4MKJnhAV9+IEfiFYh613/8MJPFenL/G4gCwNjmCXcZ5/Ep+15jgQwxM
         AiaK7flBneJjzFZ1HLzzb/K+KcgUF+o5BEvi1txklD597v5P3d2YbLB+8G2ydkO3qFy8
         hAwQCkAqGQ6SWa00dDAvoFf5vYT4r14PpZL3yGQeBggg8a3CxImXfGb+mzmvvzxnX6XE
         TPLdJa3ef6DMcRihPL4gEanUxDB8wyApwUTOUe+G123cbuR/0ow9+V51QQ2LSZ+JbJ1R
         TRYObv1t6QuwGT7fnrHxzMGBuTJKJrFMXfxJ0qWZ0xW0ewErL2MOW+IHqe42zzdVcjT3
         nbBw==
X-Gm-Message-State: ACrzQf3sdxAOE2aWaUru0sV+ZHYUOeX6nr7w6Je+jBoCDPbXGoOH8Lwr
	kQ5CKKbpllvGumXP0tAQV/58Mdj9WKw=
X-Google-Smtp-Source: AMsMyM5O1+1JCrk+iukNwb45IWIGzbZ/jNT3Rex6EgZbLaLsryUyVMehR0PN7369Z/rYSPmW0oVm9g==
X-Received: by 2002:a17:902:d511:b0:186:ae37:c041 with SMTP id b17-20020a170902d51100b00186ae37c041mr21512903plg.14.1667333883891;
        Tue, 01 Nov 2022 13:18:03 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 15/17] nl80211util: add key type/idx to nl80211_parse_attrs
Date: Tue,  1 Nov 2022 13:17:45 -0700
Message-Id: <20221101201747.143379-15-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211util.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 5ba0097f..da36d936 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -139,6 +139,17 @@ static bool extract_nested(const void *data, uint16_t len, void *o)
 	return true;
 }
 
+static bool extract_u8(const void *data, uint16_t len, void *o)
+{
+	uint8_t *out = o;
+
+	if (len != 1)
+		return false;
+
+	*out = l_get_u8(data);
+	return true;
+}
+
 static attr_handler handler_for_type(enum nl80211_attrs type)
 {
 	switch (type) {
@@ -146,6 +157,7 @@ static attr_handler handler_for_type(enum nl80211_attrs type)
 		return extract_ifindex;
 	case NL80211_ATTR_WIPHY:
 	case NL80211_ATTR_IFTYPE:
+	case NL80211_ATTR_KEY_TYPE:
 		return extract_uint32;
 	case NL80211_ATTR_WDEV:
 	case NL80211_ATTR_COOKIE:
@@ -170,6 +182,8 @@ static attr_handler handler_for_type(enum nl80211_attrs type)
 		return extract_iovec;
 	case NL80211_ATTR_WIPHY_BANDS:
 		return extract_nested;
+	case NL80211_ATTR_KEY_IDX:
+		return extract_u8;
 	default:
 		break;
 	}
-- 
2.34.3

