Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC34C77
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:57:57 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id r24so1682282plg.3
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcxZhw4Qt+V1BJnHFmUpyU3PjwB6l6ojDBwLlt37U78=;
        b=cdubX3XtvQ1KRfTBHcx9m4mINj2wAp8noMBQI/iSUqdfgNvAn6LMFEes2Np69qnccH
         aSHlUke06ytEcR9KDyrwkNnRI4pToa3nxT6otQbbQiMm//i2HGavKrFFGj8w9rED+lRV
         upsodRlttyGhHHr6bfPMhVBUhdnAxZgVNTdJYwti3lMG2xHqQWLHei2oNvMzOv7t4WLo
         vUQw5C3czx8qs2Kkto54frO+H76DIixT6CGSDJWgiNBpolSguF5l+lB9WgSzX1U476G9
         98/Oj+AGnxjxhxjStxbC0sO6jPP4Iz6HCeqfKzNafCnJKSIMIBH/d+1R6ydmO2z7j0Qd
         /KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcxZhw4Qt+V1BJnHFmUpyU3PjwB6l6ojDBwLlt37U78=;
        b=MDDzyh7xpJqR1oubHBxsG/6G5tD74D8MPkbLML/WbN1rbJLz0X8fFV/7o8E8kSNm5t
         YbIIP/jSQTwmCrCvXPlA+Z3sklvF8PoRn7GTFuWSNJazYXiNJGLyiPobwVfGYp9cjrPn
         YM9ZZPVdj9th/+DH+bip23N9e4cRpvPm+avs6cZKBCbNLEflzEM8ooEjD8wYeZz/UQi/
         JpLW8wjLoshSgGU04lt9zSPc3/4oAl/rQD4RFHc8CwMGGLyRvVtxAlKi+9rV1EHec0Af
         5VlbFU7ZwHG0jlbM7+g2Fx8XWRPhsqLtw0XowiWkmYqFu6k+pS5l0VXW4EH5ENhX+/Rj
         ev9w==
X-Gm-Message-State: AJIora83gNi3uYuY6L7jtqzFJ8PtHIUHV6oMhLml4MQf9Db1tB8OCaOJ
	vn7N435rijmbBSIGD/uH9jdQDa9ghj0=
X-Google-Smtp-Source: AGRyM1sYP6h5ggvbBVULEus4vtaL79KDtK9x/IDLbzvrTWgknexGcyp8sCaIbGVfvjRg6IHxYr6LIw==
X-Received: by 2002:a17:90b:1642:b0:1f0:31c1:9e80 with SMTP id il2-20020a17090b164200b001f031c19e80mr833029pjb.157.1658257076692;
        Tue, 19 Jul 2022 11:57:56 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:57:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/12] scan: add colocated scan flag
Date: Tue, 19 Jul 2022 11:55:33 -0700
Message-Id: <20220719185544.456727-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 05e8f66e..e1c89fb2 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -394,6 +394,8 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 	if (params->ap_scan)
 		flags |= NL80211_SCAN_FLAG_AP;
 
+	flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
+
 	if (flags)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
 
-- 
2.34.1

