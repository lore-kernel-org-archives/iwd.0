Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B863A0
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:31:00 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5894502pjc.3
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOaG1GScb/lJbsqJtwI+4gsf1qpFpiYt0OC9iRcYb5s=;
        b=L9wCbd6e6Q56SvbGq7zGvseX9afDRjFh3J3nK04O6ysWz3TGCi9m62SYpTHndLInBU
         vbRJHUeX44ieQSq+p2RGLyF8Bfe6ks2+brn67lHNteqeXJWmpBuBH9L53VzcvHy31MFB
         73cK7hWKjJZWjeqETSV1HQ4VAB+1lYV0zbEmrknQ4a3PjDtK78tDvSLoUtqflWumalHy
         2DGY3sQmc+k/rbACr/99Pc2IbQZdhQga9GbiwwUaspXDBkdUV4Mt8vxCg8HfrbM8AOr5
         IxJu7QGlmcfooBFY/vLkIU/pDaGOGcuUMHEcwzpgLxq93H0jl2NQ8u6m8Jb9Yt8m0gIy
         vRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOaG1GScb/lJbsqJtwI+4gsf1qpFpiYt0OC9iRcYb5s=;
        b=Vp87AoqN9BmfupeljhmNcRAbE68sTrnF41t9W/OUWypjGcf3n8K8vI1IgBFN41FOvm
         kUbwC93bs3zLFTHZb/axsvSUVyD/ug3KM0WnGWixTaoeft9ansQI8FfYyY6KdTnKn8JM
         N8YEJjHyA1xZxIWfWjAfcmXRTYo0ovkf8ODdhuFkV/Q2gcFvSkDYP2XqJvipCyjP1zRA
         OkH1NIU/hoQzeKjhIQcdJxQ7b3VsrrcuB9MqDh4ca5fXBzM1GaxTP+ISDU9SrMy4Oz1o
         xhhfIByg9pbWsnpMOYfWIoC5Q+OUnhYH5Kx1d5dw0modJ283b22/YrRSUawdSrUDbGre
         693A==
X-Gm-Message-State: ACrzQf1vHMZ0oiVn5JQ61ZG9m2Apa+nI9+X5YTYu95ityCd21mf3nh0K
	OlBhCc950Gk/gtOzOzHRpBZURXdmTns=
X-Google-Smtp-Source: AMsMyM6SLL1c3tj8M2iSuEMLvoWMd4OQb3gg4dFlCYTr0hLCdOFL0837qVhdeTiv1yZvzRbNNLqtRQ==
X-Received: by 2002:a17:90b:4a92:b0:213:2421:5f38 with SMTP id lp18-20020a17090b4a9200b0021324215f38mr33179610pjb.10.1667496659335;
        Thu, 03 Nov 2022 10:30:59 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79d12000000b0056afd55722asm979721pfp.153.2022.11.03.10.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:30:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] doc: document AP properties PairwiseCiphers/GroupCipher
Date: Thu,  3 Nov 2022 10:30:54 -0700
Message-Id: <20221103173057.381232-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/access-point-api.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 63e61d49..28e6437d 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -71,3 +71,16 @@ Properties	boolean Started [readonly]
 		uint32 Frequency [readonly, optional]
 
 			The frequency that the Access Point is operating on.
+
+		string PairwiseCiphers [readonly, optional]
+
+			Comma separated list of pairwise ciphers the access
+			point supports. The same format as setting a list of
+			ciphers for an AP  profile, i.e. TKIP, CCMP-128,
+			GCMP-128, CCMP-256, GCMP-256 etc.
+
+		string GroupCipher [readonly, optional]
+
+			The group cipher suite the access point is using.
+			Possible values are the same as what could be included
+			in the PairwiseCiphers list.
-- 
2.34.3

