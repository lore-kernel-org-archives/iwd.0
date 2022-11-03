Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBD8465
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:00:53 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5833682pji.1
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOaG1GScb/lJbsqJtwI+4gsf1qpFpiYt0OC9iRcYb5s=;
        b=pONlPSwy+Z1/qpx9XhGkByqhbvV2NIhp9H+QHC/y4AN/QtpaF4MqAl8mUR3lQNyLVs
         4id6PZCacBrxJIqfdMufnPmwiP7+tCRy3AufGBHb0eERK2iQw+1CBf44rqT1v/GMbdhI
         UKU9SH+IHLhS2hTpWvsbbVQqTgI3+lKAglIY5qzIku0dR1eAVpT5JX4u6vs2KPtHqAwB
         /sXaiAOSJTMtQi2cpy+agrFj+S1zbVc6qsOsCmv13dE8NifD3oYgse/M8GqKEvoMdULw
         /qFvSsazvyZhDNv0kl5HbDnSAOdf//9anBvTWNQR4yupb/MV9O+CPvrZ7UgCBliQS0zU
         qxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOaG1GScb/lJbsqJtwI+4gsf1qpFpiYt0OC9iRcYb5s=;
        b=IyJhJ2oAnNO7wBIr3caXvuhuHx/qNxU1ChRRRSAzLQjVoFMBX3IN3ydFWGldkQl6Gp
         8n7pCXIH/GooT8JCbjRB79e6cAp5bNIJ49Ne0yUtleLGb6ExApCC1aKI9YZXsm8Q/AgX
         Q1bZoo8356Enz+QLa6xkj+cqdcn4gP0ssM/0kxI4dcZ1Pp5FbI5Xf1P4OzSVHh9m+u+e
         wVeu/8oksmGPZJBegyIv6WlRGXi7xFVWlhQ6W93qOIbWx0w9mLxqunQcWak444QYRNQ1
         G7WIC1F7jlhviVtSA02kLhAVKAnv2D0us3myXmLQqfvdbrnIuSof5PMeCquMBzm6HC/R
         Sudw==
X-Gm-Message-State: ACrzQf3WAT1PU/hXXlG5r7BipPSe8JrVR9/VDHMLfU3d13pYPlpoWPZa
	s6+E3FPGT0cxKtGwYTmi/sZFAH9bzck=
X-Google-Smtp-Source: AMsMyM6o7TXMu1QameoPEnrv92/suakN5WN+W8dLD8dWakATNb0wf+VLpb95qlu69cLMKUbOnjayGw==
X-Received: by 2002:a17:902:784b:b0:187:2296:2a35 with SMTP id e11-20020a170902784b00b0018722962a35mr21726240pln.103.1667494853260;
        Thu, 03 Nov 2022 10:00:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z3-20020a623303000000b0056c349f5c70sm995465pfz.79.2022.11.03.10.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:00:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] doc: document AP properties PairwiseCiphers/GroupCipher
Date: Thu,  3 Nov 2022 10:00:47 -0700
Message-Id: <20221103170050.379587-1-prestwoj@gmail.com>
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

