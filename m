Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A76612D
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:14:05 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1364357a691so4734938fac.7
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG3b5opKNODbFYwDTToCH1ywAIZ5n+rhAvvsMbcLFRk=;
        b=VMutkPvMY7RYgAaIqHInp+JiKbT0IARyLfws7giEkuZx0ceFcU+5dBMSy58H+ii8Se
         5pjVfjE4OSuz8rpJmLiJ2DPl6bZHCOy6BT4aYuT8YZMA5Pn3TTgiqaiwVkjA59bHFePg
         lanME73+Qk/9nAVHqlo+F9BbMw3+1DkFp2np1Re+bux7hj5ToiYk4zFXd+sZ2aCt8ZaB
         DJ0nn3BdwC5C54eKP143QVf82ROHU30AwvhQHpVGWdPAiyNxHQSBImaW0suZaiuzzrci
         WmDVUoFljxqWe5vBHXZ+T9SD/dbfc41SDj2eI2Seo5IXg7X/l7N5cjXSgpgiGLNihD9E
         3hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG3b5opKNODbFYwDTToCH1ywAIZ5n+rhAvvsMbcLFRk=;
        b=NNgKUkpq9pbKhlccOn9MaY+aDENxIFb8DqTMs023GEj8ct4L9IlkKdFTUJjxw8RU6P
         Ug7SOtDo2bgERSU29sSYHvju96XXZg4wn4WtRKhkFHvJtJBQjx8pZ52YrWBaeWZHxb11
         COK6GtEr95yyAlpbgoafwPsnXUPH1Tr9d21aCbMzW6W2cj37R1d0HdY82W3JXQLvG9Fi
         f9fTfnyYsTIEIE1pLCRfwx7oM5W+kTz4uQPJ6jkqOq7LQtzxu19pykwzjjHMVYAwncfI
         BZLw0Itws7NWA488PFiJFNvQals46lyCjMYt5LFGExjRSNMVBvdtD0wnNVBuBo8SL4kW
         u6Lg==
X-Gm-Message-State: ACrzQf2QKZizlZoKp+2zE9nwRA4SQH6+uPrX+E/Mx/fzUmGzYZ8NchAJ
	hBTuRnv0aNpBZ4LjZs36Tn5AJRI2qas=
X-Google-Smtp-Source: AMsMyM5DOIDsJGHpWH4A+LT88A/DlbKJh/KeflWLOSQclykvB9YnWKAOTMzeX4A2z70bVT4emttWZg==
X-Received: by 2002:a05:6870:2487:b0:131:4fee:7c0c with SMTP id s7-20020a056870248700b001314fee7c0cmr13052178oaq.71.1666379643686;
        Fri, 21 Oct 2022 12:14:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:14:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 23/26] ie: Support more group management cipher suites
Date: Fri, 21 Oct 2022 14:13:04 -0500
Message-Id: <20221021191307.31492-23-denkenz@gmail.com>
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
 src/ie.c | 33 +++++++++++++++++++++++++++++++++
 src/ie.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 4a3e02e11cac..6b08ce180a87 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -436,6 +436,12 @@ uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite)
 		return CRYPTO_CIPHER_GCMP_256;
 	case IE_RSN_CIPHER_SUITE_CCMP_256:
 		return CRYPTO_CIPHER_CCMP_256;
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC:
+		return CRYPTO_CIPHER_BIP_GMAC;
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC_256:
+		return CRYPTO_CIPHER_BIP_GMAC_256;
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC_256:
+		return CRYPTO_CIPHER_BIP_CMAC_256;
 	default:
 		return 0;
 	}
@@ -464,6 +470,12 @@ const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite)
 		return "NO-TRAFFIC";
 	case IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER:
 		break;
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC:
+		return "BIP-GMAC-128";
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC_256:
+		return "BIP-GMAC-256";
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC_256:
+		return "BIP-CMAC-256";
 	}
 
 	return NULL;
@@ -510,6 +522,15 @@ static bool ie_parse_cipher_suite(const uint8_t *data,
 		case 10:
 			*out = IE_RSN_CIPHER_SUITE_CCMP_256;
 			return true;
+		case 11:
+			*out = IE_RSN_CIPHER_SUITE_BIP_GMAC;
+			return true;
+		case 12:
+			*out = IE_RSN_CIPHER_SUITE_BIP_GMAC_256;
+			return true;
+		case 13:
+			*out = IE_RSN_CIPHER_SUITE_BIP_CMAC_256;
+			return true;
 		default:
 			return false;
 		}
@@ -675,6 +696,9 @@ static bool ie_parse_group_management_cipher(const uint8_t *data,
 	switch (tmp) {
 	case IE_RSN_CIPHER_SUITE_BIP_CMAC:
 	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC:
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC_256:
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC_256:
 		break;
 	default:
 		return false;
@@ -969,6 +993,15 @@ static bool ie_build_cipher_suite(uint8_t *data, const uint8_t *oui,
 	case IE_RSN_CIPHER_SUITE_CCMP_256:
 		selector = 10;
 		goto done;
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC:
+		selector = 11;
+		goto done;
+	case IE_RSN_CIPHER_SUITE_BIP_GMAC_256:
+		selector = 12;
+		goto done;
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC_256:
+		selector = 13;
+		goto done;
 	}
 
 	return false;
diff --git a/src/ie.h b/src/ie.h
index e69175635908..533118541d6c 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -334,6 +334,9 @@ enum ie_rsn_cipher_suite {
 	IE_RSN_CIPHER_SUITE_GCMP		= 0x0080,
 	IE_RSN_CIPHER_SUITE_GCMP_256		= 0x0100,
 	IE_RSN_CIPHER_SUITE_CCMP_256		= 0x0200,
+	IE_RSN_CIPHER_SUITE_BIP_GMAC		= 0x0400,
+	IE_RSN_CIPHER_SUITE_BIP_GMAC_256	= 0x0800,
+	IE_RSN_CIPHER_SUITE_BIP_CMAC_256	= 0x1000,
 };
 
 enum ie_rsn_akm_suite {
-- 
2.35.1

