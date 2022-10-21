Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A96135
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:53 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13aeccf12fbso4701705fac.11
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp8WG5OsRkytD8tMWyVETT6orbxjHY/Dh+Z3zcDf7E8=;
        b=qD7Ndw86Fa/AAVb5EQiT0vidtj08H+3ldOiFsvNMWRMx81YXlY6n6cjA8H6CQe9i1w
         ZAgAGsvjlPuemOsDp1Z2qkOqy4ccSHEG+KufwYj+uNUKtI6rqOKcdpod76pHa0Rwt2le
         TnE7n4s5pYheqr4z4MK9nT9CX6ZkWuulYkrwDbd8hjsyJm7oEASAoqdvfNvhI8Mft9EM
         1t76T7rXly9JNEzlYNJn/e+Ywk/lddARONpxvJp1ZbpKZ49lbVaMdj4NzXfKzv+IysJJ
         N83GZI/CA+tF7rwe8eV3qCh6MDMzRhz/h3dAzeEwg3+RT941GPRbqYmhZPYqcJURduHZ
         MR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp8WG5OsRkytD8tMWyVETT6orbxjHY/Dh+Z3zcDf7E8=;
        b=4bKKuGX0xedXI7hqXuhE5k6eujdW6/QgdIpvg2WEoh+jV8f5JfbcVCN1I31IJC9g2V
         VFxEDANe2dpywIHSdeTTia94fWSgfwIUIiPyziYt0Hl9gOcgsvykl0623sthEH+t0Jsf
         oAi0bxKgl724Fye3pu2JzmgDSqfqmy+fzqJoxoSoZzkmPf2aXPYJiNThV/1zBLH2eatT
         hi9NaWHdEUimcBiqIKeH0beVqZzVkZBGAUD33vNQM8h2HCppSevc0PeC7LS1RJqYswpT
         xfrTbseqUgxrDn9R+H9g5+5sDxBD+qlkaOh1XQOdkZTDdo7nuFArUadXD6EdM746pPDS
         rcaw==
X-Gm-Message-State: ACrzQf1aQ3Jqvq2K+Y0erXKu2Sr5lPKuqwE3Zb+RTHgiNOyIyYpCNfuI
	jBBX9hDqc6EgCwAUsEfrA6cyRs+NgTs=
X-Google-Smtp-Source: AMsMyM6Y/GyGdD1HNJkuwXGmVjfGhspzBoeuOjtzvxSgRYdKbzTD5r1uf1dvSCZDXImRo/FWMWkqjw==
X-Received: by 2002:a05:6871:90:b0:136:b9e8:a024 with SMTP id u16-20020a056871009000b00136b9e8a024mr29178444oaa.60.1666379632383;
        Fri, 21 Oct 2022 12:13:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 16/26] ie: Add support for GCMP|CCMP-256
Date: Fri, 21 Oct 2022 14:12:57 -0500
Message-Id: <20221021191307.31492-16-denkenz@gmail.com>
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
 src/ie.c | 26 ++++++++++++++++++++++++++
 src/ie.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index a424af275634..4a3e02e11cac 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -432,6 +432,10 @@ uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite)
 		return CRYPTO_CIPHER_BIP_CMAC;
 	case IE_RSN_CIPHER_SUITE_GCMP:
 		return CRYPTO_CIPHER_GCMP;
+	case IE_RSN_CIPHER_SUITE_GCMP_256:
+		return CRYPTO_CIPHER_GCMP_256;
+	case IE_RSN_CIPHER_SUITE_CCMP_256:
+		return CRYPTO_CIPHER_CCMP_256;
 	default:
 		return 0;
 	}
@@ -452,6 +456,10 @@ const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite)
 		return "BIP-CMAC-128";
 	case IE_RSN_CIPHER_SUITE_GCMP:
 		return "GCMP-128";
+	case IE_RSN_CIPHER_SUITE_GCMP_256:
+		return "GCMP-256";
+	case IE_RSN_CIPHER_SUITE_CCMP_256:
+		return "CCMP-256";
 	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
 		return "NO-TRAFFIC";
 	case IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER:
@@ -496,6 +504,12 @@ static bool ie_parse_cipher_suite(const uint8_t *data,
 		case 8:
 			*out = IE_RSN_CIPHER_SUITE_GCMP;
 			return true;
+		case 9:
+			*out = IE_RSN_CIPHER_SUITE_GCMP_256;
+			return true;
+		case 10:
+			*out = IE_RSN_CIPHER_SUITE_CCMP_256;
+			return true;
 		default:
 			return false;
 		}
@@ -610,6 +624,8 @@ static bool ie_parse_group_cipher(const uint8_t *data,
 	case IE_RSN_CIPHER_SUITE_WEP40:
 	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
 	case IE_RSN_CIPHER_SUITE_GCMP:
+	case IE_RSN_CIPHER_SUITE_GCMP_256:
+	case IE_RSN_CIPHER_SUITE_CCMP_256:
 		break;
 	default:
 		return false;
@@ -635,6 +651,8 @@ static int ie_parse_pairwise_cipher(const uint8_t *data,
 	case IE_RSN_CIPHER_SUITE_WEP40:
 	case IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER:
 	case IE_RSN_CIPHER_SUITE_GCMP:
+	case IE_RSN_CIPHER_SUITE_GCMP_256:
+	case IE_RSN_CIPHER_SUITE_CCMP_256:
 		break;
 	default:
 		return -ERANGE;
@@ -945,6 +963,12 @@ static bool ie_build_cipher_suite(uint8_t *data, const uint8_t *oui,
 	case IE_RSN_CIPHER_SUITE_GCMP:
 		selector = 8;
 		goto done;
+	case IE_RSN_CIPHER_SUITE_GCMP_256:
+		selector = 9;
+		goto done;
+	case IE_RSN_CIPHER_SUITE_CCMP_256:
+		selector = 10;
+		goto done;
 	}
 
 	return false;
@@ -1034,6 +1058,8 @@ static int build_ciphers_common(const struct ie_rsn_info *info, uint8_t *to,
 		IE_RSN_CIPHER_SUITE_WEP40,
 		IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER,
 		IE_RSN_CIPHER_SUITE_GCMP,
+		IE_RSN_CIPHER_SUITE_GCMP_256,
+		IE_RSN_CIPHER_SUITE_CCMP_256,
 	};
 	unsigned int pos = 0;
 	unsigned int i;
diff --git a/src/ie.h b/src/ie.h
index 1dadcb6be718..f447a4f98d81 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -332,6 +332,8 @@ enum ie_rsn_cipher_suite {
 	IE_RSN_CIPHER_SUITE_BIP_CMAC		= 0x0020,
 	IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC	= 0x0040,
 	IE_RSN_CIPHER_SUITE_GCMP		= 0x0080,
+	IE_RSN_CIPHER_SUITE_GCMP_256		= 0x0100,
+	IE_RSN_CIPHER_SUITE_CCMP_256		= 0x0200,
 };
 
 enum ie_rsn_akm_suite {
-- 
2.35.1

