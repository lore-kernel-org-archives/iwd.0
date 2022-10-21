Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6308E3D60
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:36 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13af2d12469so4696254fac.13
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81riFLEbUob6TnesX42fOPrvVm+YpjomFui7FxvVdUk=;
        b=gugD9fPaGt1zd04ciMrQYqMv71ZrccqyyUsUIFbhgm/bVA7jFarRUf1Ev+1FSv0YF8
         r7QRoZHlHnYsdvYzQt8qNKvqerEYsdHUCi8ZjmVlm1qv+lEpudrk6cpwFWBEq7GRhYOJ
         FkNlrrJqprnuj02n99ALGVEsbPP/dcZIk2d3mIF3Y5H1uPqU/JLDUK1n7x8aCzQaAded
         1eVUiYOyo0m6PNAKpcfdA/s42j3Awp46Odi3QxXRQI4ia6qcmTA0tkeunBAo9F/nJ8D5
         7ZEFG6p6pNDnfAXupfdhcYvcvma8sGs6wiHRloX7XrvuSTmcntONMNl7jbrTEIlfMtdF
         C/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81riFLEbUob6TnesX42fOPrvVm+YpjomFui7FxvVdUk=;
        b=clRthbe4QdClYU3oy7WNgPWFM4p8RZwH7etxTyowj6Xshlm57/ROeGyhvs+K0+II4l
         D0On60T+fDnyhj56FL8vk8DQyco5iJQFWayog3M70iGBvrx3RwkFBLcdslHHTkCAmIqQ
         JoWWfSO3MrXc1rD+jdHK+kxp6k/oiF1zy0qN861HQAnVAR8ZsGwkJD2fREKOicB0eJzQ
         S42ULXS5FkMbugN7w/PNWKueRqqFmfqcdjRC9nT8n6yHD3mZiQf4pe+sxwlX0unNm32O
         V8Bc5MgZG1AjMlfchpxuGXjQPRRfcNaj1KDC5Rjl6OwKtJgEWKb36l9RQzt/SpcjN/L5
         TfxA==
X-Gm-Message-State: ACrzQf3SK2X/xMU6qiD11id4XHmmWzh6fZunXFMueDvLh24+zopAGy50
	Uz+nxPPQs52X4XvHZ8WXvEpFlrWunwE=
X-Google-Smtp-Source: AMsMyM5Ykt7j7l6eh6/eKCUFmtN35oY3rXcIWSmI0VOfSfwMtriq06XA76OMAzj/VFWxOqPRKjjIQA==
X-Received: by 2002:a05:6870:6025:b0:132:6b0b:abc2 with SMTP id t37-20020a056870602500b001326b0babc2mr27963298oaa.177.1666379614835;
        Fri, 21 Oct 2022 12:13:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:34 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/26] ie: Skip unknown pairwise ciphers
Date: Fri, 21 Oct 2022 14:12:47 -0500
Message-Id: <20221021191307.31492-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/ie.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 8ceefc643615..110b5b3ebdec 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -589,15 +589,14 @@ static bool ie_parse_group_cipher(const uint8_t *data,
 	return true;
 }
 
-static bool ie_parse_pairwise_cipher(const uint8_t *data,
+static int ie_parse_pairwise_cipher(const uint8_t *data,
 					enum ie_rsn_cipher_suite *out)
 {
 	enum ie_rsn_cipher_suite tmp;
-
 	bool r = ie_parse_cipher_suite(data, &tmp);
 
 	if (!r)
-		return r;
+		return -ENOENT;
 
 	switch (tmp) {
 	case IE_RSN_CIPHER_SUITE_CCMP:
@@ -607,11 +606,11 @@ static bool ie_parse_pairwise_cipher(const uint8_t *data,
 	case IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER:
 		break;
 	default:
-		return false;
+		return -ERANGE;
 	}
 
 	*out = tmp;
-	return true;
+	return 0;
 }
 
 static bool ie_parse_group_management_cipher(const uint8_t *data,
@@ -682,9 +681,12 @@ static int parse_ciphers(const uint8_t *data, size_t len,
 	/* Parse Pairwise Cipher Suite List field */
 	for (i = 0, out_info->pairwise_ciphers = 0; i < count; i++) {
 		enum ie_rsn_cipher_suite suite;
+		int r = ie_parse_pairwise_cipher(data + i * 4, &suite);
 
-		if (!ie_parse_pairwise_cipher(data + i * 4, &suite))
-			return -ERANGE;
+		if (r == -ENOENT) /* Skip unknown */
+			continue;
+		else if (r < 0)
+			return r;
 
 		out_info->pairwise_ciphers |= suite;
 	}
-- 
2.35.1

