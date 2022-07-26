Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7B6002
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:33 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so17861142pjq.4
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=938HBuN8/PrTz5GFsUu7VC25WsYBvaZnhaGeh+wBQP8=;
        b=GpNfMLTHzSBeghQvrYksFWJ6jLwciwzGUk7i6VreKv9HPwRmOL1+bDucJCFiVGyJNd
         jfGF6NLQyJUsb/fTbsTQee2+jOa5o0s/Hgqe2kFzQlV8KRVVemCNPTg3KCC9ZxD+pMgN
         smMUjsfJD5ZSnx9oTz+5d3BB9916YYAmrFwC734AI1LFRmiOeKp1axzcPx515FZmnJAu
         nhBBwJMed2m8L+LDI1s3343Eo5SkfsWiUNKLe04iCcx1HL5BEfCgncxPeQOR3lKzsz2g
         33SfWT2Cm8lOalYlP3mHW3BRi5W5Wt1VT4/jtOBG1ULXTnaAmWyu4tC/P4VIt9I89vvX
         IUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=938HBuN8/PrTz5GFsUu7VC25WsYBvaZnhaGeh+wBQP8=;
        b=nkzRMVNrLPb3RzupEWqpo9uoAN3W+uVj9CmUGw/cTdJldCAso4kqRYKXb1wNB30HUu
         8T88SbKsdxOtu2AMRcnlYha6/mKEHR/jRlHCQ0z+PdtTiQoLk3aAq0O8Z4+BOf57P6fX
         MXvOLD+FWlELfdqx405b6zNEMnRLT+A8ywCIkRWMX1+mH2SPoq1h1akiiz0iV1TEpuHI
         gIpbnkAsruffXxrEpg6viEMeh/gMpTPwWfTQ+7R8DQeDU1KJv+4du1kNi1YBMqbf/kwG
         zMjdrOH4iwsQtfxK8BNhs0919r3KAn9fLRFnHJKzc5oPx+Jvsv8qLwoN6Fpr87L0AWE+
         PqyA==
X-Gm-Message-State: AJIora9HPP1MWarUjf8Hru46Z0mym2BJm/kARhBj1cY5XmAyj74DA/6w
	LgH4Ia6+tS9J6kqRD7ljc5/dZYaoLZw=
X-Google-Smtp-Source: AGRyM1s+XDCatIjCnuq3f0xiLrmeBZWUYp9BT1LW/GwMAhSj5+awHIQQOyT9khStjUHJjPd95gQ+LA==
X-Received: by 2002:a17:90a:8a0e:b0:1f2:f07d:39bb with SMTP id w14-20020a17090a8a0e00b001f2f07d39bbmr209981pjn.94.1658855372582;
        Tue, 26 Jul 2022 10:09:32 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/10] nl80211util: add nested attribute support
Date: Tue, 26 Jul 2022 10:09:20 -0700
Message-Id: <20220726170920.15929-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for nested attributes in nl80211_parse_attrs
---
 src/nl80211util.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 9cd538ec..9092b204 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -128,6 +128,16 @@ static bool extract_iovec(const void *data, uint16_t len, void *o)
 	return true;
 }
 
+static bool extract_nested(const void *data, uint16_t len, void *o)
+{
+	const struct l_genl_attr *outer = data;
+	struct l_genl_attr *nested = o;
+
+	l_genl_attr_recurse(outer, nested);
+
+	return true;
+}
+
 static attr_handler handler_for_type(enum nl80211_attrs type)
 {
 	switch (type) {
@@ -157,6 +167,8 @@ static attr_handler handler_for_type(enum nl80211_attrs type)
 		return extract_uint32;
 	case NL80211_ATTR_FRAME:
 		return extract_iovec;
+	case NL80211_ATTR_WIPHY_BANDS:
+		return extract_nested;
 	default:
 		break;
 	}
@@ -222,6 +234,10 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
 			goto done;
 		}
 
+		/* For nested attributes use the outer attribute as data */
+		if (entry->handler == extract_nested)
+			data = &attr;
+
 		if (!entry->handler(data, len, entry->data)) {
 			ret = -EINVAL;
 			goto done;
-- 
2.34.3

