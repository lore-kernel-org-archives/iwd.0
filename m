Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01396127
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:41 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso2385076otb.6
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRY3Bs1CSYf0yZ4wCkjeenL3uaImyaSlDHmthDImn0M=;
        b=QBq3rC0+w5hZ6wQFbz0piKwQeUOu5dkjwj/aD/maQ6cnaGvm++P+dT6hTpHa04HoSI
         XSHU+nc5HPEFgjEMIO61Djf9HDXYvfhu3dJuHzl7ahrpHAumPIs07YZMJ+9ctNzyrjeO
         OSo+Vetyr25zN2qFNGprnkysQgbOV9hvLxgeVswG5sIgHud5FvLo+N8RbEQ1d746s6Tv
         s17jouGzeHCiShr8bxRMWV7OziakVjDc8M7EPqOGoJuHUn6t8P3dQiK0P92Xifzlx1qq
         pveov6+QJY+Tr3KLm9KbGdyin/QB0KrZ8XOwgYvCeLu+6IXqyiEH4TN6gz5fUI4oUnpE
         XteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRY3Bs1CSYf0yZ4wCkjeenL3uaImyaSlDHmthDImn0M=;
        b=P13UbesWsPlsXvBZQPEK/f2HdcwU6/MssWj8moLFKjYUSkEAQGmk8ipQXFwhEhn1ji
         /jcbPIVy8WH38iioBrk2JvxpghgmxaidV40yxJ6x3tnsV28hAskcEmjaA33AGGXaeSBi
         5mUJ0+LZOyAUvbvL1ADofuqnn9SFrR9blepjeQc7lrCoTDeGID+uFdf73f0+6WvpFe4k
         vrMgLx2G4yCBAa33n1s5dP0HOFchufGfC+Lx5lLMPmcqfUE5pvP/UQufs39ptUCHLAYH
         kvmfvC+3cWOWYcfxfvCcQzBiQHT/BpkXGbqp+epPEQhKzaLb49ocIbtnN4A2m8dlY2ow
         9MSQ==
X-Gm-Message-State: ACrzQf3irWpML3hOmB/tflM2XRUE8OuzWrC4Gcu14Gh8sQ4C7P2aTXUn
	rJsTnJrRV7fWDMiH5scEAJPQlpc/xaU=
X-Google-Smtp-Source: AMsMyM4OUmkyh8Q7Yfc9/LfiP7Aw13NwIRwtlepbPhrQQbnRArKYaVOkhfUfEm8LskQ/32eAI+dzJg==
X-Received: by 2002:a9d:6acb:0:b0:662:335f:ff17 with SMTP id m11-20020a9d6acb000000b00662335fff17mr1137611otq.96.1666379620359;
        Fri, 21 Oct 2022 12:13:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/26] ie: Add support for GCMP cipher suite
Date: Fri, 21 Oct 2022 14:12:50 -0500
Message-Id: <20221021191307.31492-9-denkenz@gmail.com>
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
 src/ie.c | 11 +++++++++++
 src/ie.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 110b5b3ebdec..89f19b11a0fb 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -430,6 +430,8 @@ uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite)
 		return CRYPTO_CIPHER_WEP104;
 	case IE_RSN_CIPHER_SUITE_BIP_CMAC:
 		return CRYPTO_CIPHER_BIP_CMAC;
+	case IE_RSN_CIPHER_SUITE_GCMP:
+		return CRYPTO_CIPHER_GCMP;
 	default:
 		return 0;
 	}
@@ -467,6 +469,9 @@ static bool ie_parse_cipher_suite(const uint8_t *data,
 		case 7:
 			*out = IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC;
 			return true;
+		case 8:
+			*out = IE_RSN_CIPHER_SUITE_GCMP;
+			return true;
 		default:
 			return false;
 		}
@@ -580,6 +585,7 @@ static bool ie_parse_group_cipher(const uint8_t *data,
 	case IE_RSN_CIPHER_SUITE_WEP104:
 	case IE_RSN_CIPHER_SUITE_WEP40:
 	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
+	case IE_RSN_CIPHER_SUITE_GCMP:
 		break;
 	default:
 		return false;
@@ -604,6 +610,7 @@ static int ie_parse_pairwise_cipher(const uint8_t *data,
 	case IE_RSN_CIPHER_SUITE_WEP104:
 	case IE_RSN_CIPHER_SUITE_WEP40:
 	case IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER:
+	case IE_RSN_CIPHER_SUITE_GCMP:
 		break;
 	default:
 		return -ERANGE;
@@ -911,6 +918,9 @@ static bool ie_build_cipher_suite(uint8_t *data, const uint8_t *oui,
 	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
 		selector = 7;
 		goto done;
+	case IE_RSN_CIPHER_SUITE_GCMP:
+		selector = 8;
+		goto done;
 	}
 
 	return false;
@@ -999,6 +1009,7 @@ static int build_ciphers_common(const struct ie_rsn_info *info, uint8_t *to,
 		IE_RSN_CIPHER_SUITE_WEP104,
 		IE_RSN_CIPHER_SUITE_WEP40,
 		IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER,
+		IE_RSN_CIPHER_SUITE_GCMP,
 	};
 	unsigned int pos = 0;
 	unsigned int i;
diff --git a/src/ie.h b/src/ie.h
index e7ffaa63f74d..2cbe35f2bdcc 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -331,6 +331,7 @@ enum ie_rsn_cipher_suite {
 	IE_RSN_CIPHER_SUITE_WEP104		= 0x0010,
 	IE_RSN_CIPHER_SUITE_BIP_CMAC		= 0x0020,
 	IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC	= 0x0040,
+	IE_RSN_CIPHER_SUITE_GCMP		= 0x0080,
 };
 
 enum ie_rsn_akm_suite {
-- 
2.35.1

