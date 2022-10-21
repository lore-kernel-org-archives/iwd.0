Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B676AA0
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:14:07 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1324e7a1284so4714090fac.10
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j65mOG+qaztQKHrnBzciwpQiF/Uq0W5eKoVH0mT3nh4=;
        b=T8Tz0lR+HmoUubUTc/xgdukPOCAkd6vcel+CKtmQemwdlFZCf2RgBZxt5Y5+Vu5wSu
         XQ+Dlaqbmi6fCK9nGACd6zeTEYPmGY03Floi7AHCHr1cRIuDICd9vmZXTwhr0FvdHpjT
         Oo4KReqBRL7810pNBnEyjUO0D3MPts266AHfRZgiz9vc9adZCzXAjs50JPu4xPlce23F
         qhqP3UFTSRBfRK1aQa/kCMEk68iEQNzkZxPJhv7kh18RMvdWtlU7cI0cK9cH9bbGzRRi
         9Vf1ZpOv0bQ42OGhMZL7drvU2dGvyEkqj17DJY1RUnJBDIvnrfkjVrTXAyJ9XamWccG8
         K9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j65mOG+qaztQKHrnBzciwpQiF/Uq0W5eKoVH0mT3nh4=;
        b=WUzxaOyswWpXogTAZws1B8yFKhbjcI8Fw2JWUaICh66VkuDRjcBVDmtZj+OOyF/jBJ
         IjwhH3Q7LScho+2WTqxaDFN8NN0uCU3HxvA1yLE3DHpivdiQSVNVegO47LUvJdiMTh3z
         PthcpnjOW57s82TB0waefX+jGdY/W5EIGJet0Bk4iKCrrWFoOaZCLlG/0WXf85EEwUdl
         sqiVVubfdqKGvbLxmGliVFsqJBT4hjHNFiZ1iZ1Q6w9shLzWlkZvb5Xoa2UgBWSQFAgD
         OCD+77YywntermXFphzrVVDXrh3UZJYt/VVUPwr2MhMQ0lWsqPjx8WUAmAdYs7ZFC/Ry
         p32w==
X-Gm-Message-State: ACrzQf3P6RQEfpI/QXFT3NkamBqqCyiQToqfw+YyTOm6WlGvmc8Y4DUn
	CGAT9yO3PN4viQQqtcO+uppyVR6bSVk=
X-Google-Smtp-Source: AMsMyM4i2iwNYH2qEYry3JARUgsRMXaom3GVHoLbNWerbop3xAsFIdHlRmyPWKF752/NV11/c1JtCA==
X-Received: by 2002:a05:6870:c092:b0:132:a01f:7c31 with SMTP id c18-20020a056870c09200b00132a01f7c31mr13685642oad.56.1666379646748;
        Fri, 21 Oct 2022 12:14:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:14:06 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 25/26] wiphy: Support more group management cipher suites
Date: Fri, 21 Oct 2022 14:13:06 -0500
Message-Id: <20221021191307.31492-25-denkenz@gmail.com>
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
 src/wiphy.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 76f1ba7cfc04..bb83f814aa69 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -165,6 +165,15 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy *wiphy, uint16_t mask)
 	if (mask & IE_RSN_CIPHER_SUITE_TKIP)
 		return IE_RSN_CIPHER_SUITE_TKIP;
 
+	if (mask & IE_RSN_CIPHER_SUITE_BIP_GMAC_256)
+		return IE_RSN_CIPHER_SUITE_BIP_GMAC_256;
+
+	if (mask & IE_RSN_CIPHER_SUITE_BIP_CMAC_256)
+		return IE_RSN_CIPHER_SUITE_BIP_CMAC_256;
+
+	if (mask & IE_RSN_CIPHER_SUITE_BIP_GMAC)
+		return IE_RSN_CIPHER_SUITE_BIP_GMAC;
+
 	if (mask & IE_RSN_CIPHER_SUITE_BIP_CMAC)
 		return IE_RSN_CIPHER_SUITE_BIP_CMAC;
 
@@ -1253,6 +1262,18 @@ static void parse_supported_ciphers(struct wiphy *wiphy, const void *data,
 			wiphy->supported_ciphers |=
 				IE_RSN_CIPHER_SUITE_CCMP_256;
 			break;
+		case CRYPTO_CIPHER_BIP_GMAC:
+			wiphy->supported_ciphers |=
+				IE_RSN_CIPHER_SUITE_BIP_GMAC;
+			break;
+		case CRYPTO_CIPHER_BIP_GMAC_256:
+			wiphy->supported_ciphers |=
+				IE_RSN_CIPHER_SUITE_BIP_GMAC_256;
+			break;
+		case CRYPTO_CIPHER_BIP_CMAC_256:
+			wiphy->supported_ciphers |=
+				IE_RSN_CIPHER_SUITE_BIP_CMAC_256;
+			break;
 		default:	/* TODO: Support other ciphers */
 			break;
 		}
-- 
2.35.1

