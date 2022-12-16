Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E38BE4
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:48 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so3607648pjj.4
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTDdI4aYLss09n2Vx+1DB4AKeW+kEyCe6GmYOQFENm4=;
        b=aMexB6WRy0fc791wgGw0OiIuNTHdxUoNeq7d+GlBPy7ESAvN9QEuXUR543wAPKXaB9
         A60vA5vBXEeKuGVEpHkcNqB0X+xGifPhKW0g+ZZZcWWa8o2RHK+M369ezkwJsPpCno6M
         qJWTHYGek+DeT3KCgdly+g/rytOTVpRNH+GReHVphGsqhY9S4I5a7kJ+QdXVZO+rI8p7
         rDHc1fWlCyu4maLvigk6MSVOfjUHL83s9O59uKoFh5gMaMVLnDiZBRf/YRLAvZ/2Vkaq
         oM7dyUintLyW7RABcYij+wmJSoba0zUQ1w8qu0Qn1Tyar5n0YqOdaSU4LMzqR8KvnR/o
         CIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTDdI4aYLss09n2Vx+1DB4AKeW+kEyCe6GmYOQFENm4=;
        b=uMGVICDn67u/zBRf76rT1u3ogDeEADdMF/kMjucbjVus1rR7+yuqSohkpmrUFtMVqV
         hKflyiKTvt1QJUScnzAbE0fEGERVhEJmaTHXwVpjfbFyVBQmaAglsZWJ5pTeiaxsaCWW
         Al8Ebi6pP2cI8swF8iPN/GCDNgVBWM0yDj/PIE7U29atjOIkkEKgFu8m+AFK39HecFed
         SI+tBQZV1aYE5u1Vp6xFvCeum5ERiqU8lTmwWM7oG44O8PaiAcaHRiQnW/dyV9ow7ZGQ
         mZntm/mxKqe4Y1rJyq1YLYT+cHwoLyzDGB5nmeex4CQDYiya7hz7NwmwpVeLxrxENIdq
         8RgA==
X-Gm-Message-State: ANoB5pmX6CkCNj6T264iiIVrlM/yx4rrKMDn/L9lEs9IBYh8nadiWSQd
	cEdalrmvqsWF8lz7jXs5DR9xYo+QMcY=
X-Google-Smtp-Source: AA0mqf5BFLTu3AffgjNbw/78IW+XfKISj7d2qxQtLfTSx1yMVQK6O8i65oo0f1/tTiCHEW/G0d9Zmw==
X-Received: by 2002:a17:90a:e2c6:b0:219:5f5a:7197 with SMTP id fr6-20020a17090ae2c600b002195f5a7197mr34945052pjb.0.1671226068207;
        Fri, 16 Dec 2022 13:27:48 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:47 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/8] wiphy: don't parse dumps from unregistered wiphy's
Date: Fri, 16 Dec 2022 13:27:37 -0800
Message-Id: <20221216212741.1833286-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216212741.1833286-1-prestwoj@gmail.com>
References: <20221216212741.1833286-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to parse these since IWD won't use them.
---
 src/wiphy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3777bd58..f3a2a039 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2015,6 +2015,10 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 	if (L_WARN_ON(!wiphy))
 		return;
 
+	/* Unregistered means the wiphy is blacklisted, don't bother parsing */
+	if (!wiphy->registered)
+		return;
+
 	while (l_genl_attr_next(&bands, &type, NULL, NULL)) {
 		switch (type) {
 		case NL80211_BAND_2GHZ:
-- 
2.34.3

