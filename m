Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5046127
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:46 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id w74so4362095oie.0
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgUrKnJO1a7AwlPdQgQD5u3nwYf3oTBDHCB6aXaW0jc=;
        b=WDo8aTXzFHPv1/58DW3d7UZ32KDVbKtjm+UrDgKISlz2+SmnvQjphTs0cIZq0nWuDY
         1voACmYMI/HM6iTbMADpV5BKvtskpWIZSF6yEwJk5fTrI/I31EZ0lAKG7fFexel4+/A/
         YFf/ReCkgwQe0YPtj1iRquIC6Q6e+JRRZPxdbR3Zn4ALYw4IXbNMrk9blDgm50LNUL2h
         KCjkqsVIecER3rHwsDsebOqP/nl5g/wnocZzmPnD078CaNToJuTgghpmYLiWvIupokuC
         bTbg+4pYE1dSjQ/zdPIy8mre1FdHKanJav6Ieur56RpC0epX4UEDzfZkKknIjP19svy4
         hkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgUrKnJO1a7AwlPdQgQD5u3nwYf3oTBDHCB6aXaW0jc=;
        b=i8Ajt7tLl5MqkJTkghlAZeruG7VnKsPf4e4PBh88frvj/paKBDJODhgEG2KmlWwUK5
         cIPXJddhaOcooCIn4rVbtga3Nk/lTsL+AQfrCAWN42TGHVIzjzqPXbtVb6GjW/TL67Ei
         Lq4UDtcRVLpU7JB6df23/FM4H3NYstzc/ov1/I4IJNfmt7apHgCnFPUKyKvDm9AAJ7Tb
         gNc6MjPwOvWXbVAg1IC8exPSUDy9M40OUe07fLlrrmf9ge/AiY3+IqWWX28XdJm4qDYz
         tDt+qVY5qhHwrJRundNVHuvTvIIaLkFlHs6r/+CeqQtC/66TP4mx6NemFXtKCEuiYa6l
         N4NA==
X-Gm-Message-State: ACrzQf2U2QQ2R2oEZ76iJ3BE+LvkRcJ/H2NRqBwXlnfNYFZ4KeKtVcLq
	iCGrjOd7GyIkVX8YoF8ABUhCRea+Nig=
X-Google-Smtp-Source: AMsMyM6cYwlg99nLrAGOkG6g0XjXgzEvOhBcJr/pxnQbfGenLEW9auwzB992zuhZsr+U+guij08gdw==
X-Received: by 2002:aca:2207:0:b0:354:4cdb:72bf with SMTP id b7-20020aca2207000000b003544cdb72bfmr10569471oic.71.1666379625387;
        Fri, 21 Oct 2022 12:13:45 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:44 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/26] wiphy: Support GCMP cipher suite
Date: Fri, 21 Oct 2022 14:12:53 -0500
Message-Id: <20221021191307.31492-12-denkenz@gmail.com>
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
 src/station.c | 3 ++-
 src/wiphy.c   | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 294edd615107..e0c163fb7e44 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1167,7 +1167,8 @@ build_ie:
 	 * also indicates support.
 	 */
 	if (wiphy_supports_ext_key_id(wiphy) && bss_info.extended_key_id &&
-			info.pairwise_ciphers == IE_RSN_CIPHER_SUITE_CCMP)
+			(info.pairwise_ciphers & (IE_RSN_CIPHER_SUITE_CCMP |
+						  IE_RSN_CIPHER_SUITE_GCMP)))
 		info.extended_key_id = true;
 
 	/* RSN takes priority */
diff --git a/src/wiphy.c b/src/wiphy.c
index da4610d094d5..f0451b60416e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -150,7 +150,9 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy *wiphy, uint16_t mask)
 
 	mask &= wiphy->supported_ciphers;
 
-	/* CCMP is our first choice, TKIP second */
+	if (mask & IE_RSN_CIPHER_SUITE_GCMP)
+		return IE_RSN_CIPHER_SUITE_GCMP;
+
 	if (mask & IE_RSN_CIPHER_SUITE_CCMP)
 		return IE_RSN_CIPHER_SUITE_CCMP;
 
@@ -1234,6 +1236,9 @@ static void parse_supported_ciphers(struct wiphy *wiphy, const void *data,
 			wiphy->supported_ciphers |=
 				IE_RSN_CIPHER_SUITE_BIP_CMAC;
 			break;
+		case CRYPTO_CIPHER_GCMP:
+			wiphy->supported_ciphers |= IE_RSN_CIPHER_SUITE_GCMP;
+			break;
 		default:	/* TODO: Support other ciphers */
 			break;
 		}
-- 
2.35.1

