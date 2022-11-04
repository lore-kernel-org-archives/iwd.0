Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B968471
	for <iwd@lists.linux.dev>; Fri,  4 Nov 2022 16:38:11 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso8758659pjc.0
        for <iwd@lists.linux.dev>; Fri, 04 Nov 2022 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYK496Z2pWP9IG3NNodMvaDGW/2norS2aZTnMpVS6Z8=;
        b=lC9JNbMk7ctlCnt6JP4QVg57i8a39iBRlbm7lViYjIfDkr4u4DjZAvNR06J6DTzehZ
         vJ9cIBwUToy5PtoBf/9U9jTvQOA8iOBMYMGLk73GgV4wSOPAMDR+6djRv1QD1yLr0aEO
         gHU4bRQPq9anX49CfQSb7tW4IbUR+qF9AESzaI4pNt9woR/bfjCgvIVvxS6/sJQxR4cd
         j00yRVZiVFeGiVYZiOr6Pby1/6Isl+ZQ+EgpsmCccofXp+Vj7/l0mvabAOwqeZANGZON
         4xFb1eBBGipRBc/QG1n2KPkaLWhfAGE0jLlxuesh7OJ3Cvo6TTL5KYqPxsRyMJi3rJ6K
         gVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYK496Z2pWP9IG3NNodMvaDGW/2norS2aZTnMpVS6Z8=;
        b=yn1Vp9JH4RiPZRkzImzJ+Q1nE2ZZXiY0o/u07FAD2z+KSbWEwqDbBKkTJjti8ub68Y
         phyZseMX7nshIXckfQuUD5KTYUDqXc1zEWIDKCQVrgpMeFDF+tTN+jcybZ5z8hJILQH7
         SqWBJQsc4u1PuSFGrEAxURIZKQxch6f4pKbz6XqdsIZyKNnN0uOTnmmMqnxPbK5FD7KM
         VozYltXuC/bosZAcN5fkHeROaSzM+59hzbce78YTQT8ns2UxhqmO1BWBGyYvdtHsC0iu
         5HkZL7G0zDHf/p1tGFgZJcggOXxuYO8r8YeeTE7EYmd1EYRfcjZTf7NX1WwzEvRLbF/d
         Qnjg==
X-Gm-Message-State: ACrzQf011ic+YAjLOiCaY9Q1PG/868A2hclfJ8cL0rOZVLQNyZ/lifEn
	pPI173pcdekMy1BurGZpcIrXdW3RIrA=
X-Google-Smtp-Source: AMsMyM6AKPpxFcRNDgjhzUPhH1qW+L7OsGD41E5mQ22DTzKQM0MfFa6Qc/uTSBtrKe0qUcsCeAlclA==
X-Received: by 2002:a17:902:c943:b0:187:1572:282b with SMTP id i3-20020a170902c94300b001871572282bmr31510836pla.126.1667579891162;
        Fri, 04 Nov 2022 09:38:11 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b0056e15b7138esm2904741pff.157.2022.11.04.09.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:38:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/6] doc: document AP properties PairwiseCiphers/GroupCipher
Date: Fri,  4 Nov 2022 09:38:00 -0700
Message-Id: <20221104163800.451867-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221104163800.451867-1-prestwoj@gmail.com>
References: <20221104163800.451867-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/access-point-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 63e61d49..839feb26 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -71,3 +71,15 @@ Properties	boolean Started [readonly]
 		uint32 Frequency [readonly, optional]
 
 			The frequency that the Access Point is operating on.
+
+		array{string} PairwiseCiphers [readonly, optional]
+
+			List of pairwise ciphers the access point supports.
+			The same format as setting a list of ciphers for an AP
+			profile, i.e. TKIP, CCMP-128, GCMP-128, CCMP-256 etc.
+
+		string GroupCipher [readonly, optional]
+
+			The group cipher suite the access point is using.
+			Possible values are the same as what could be included
+			in the PairwiseCiphers list.
-- 
2.34.3

