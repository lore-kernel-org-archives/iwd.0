Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A63BBF1
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016923; cv=none; b=P8egB7Fi3b6LtBtYPcH2CWMYiCXmeAuOScuQeccfSkVhzyBQnEUapV1O9EMeiwuz2ieKA+rD6ANRe25zf/gXxJKWY7iFfkdPYFGMJ9sYWPjm9l5t6plIYzVe+K6SoyfD9/tcaTltcIXpsFWTSVpIYXvSuPjpNFTMsHQpztm7lNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016923; c=relaxed/simple;
	bh=Bje7IpN4RQsxkAYgKI8HY0lZdJMcf+8NhsJlKcPa6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eaj0m0rz8wN0anKO9Z+I+Pw9yOE6x+DgRIRqNQmjfNEOHhNYostbfeJWVK2fhcNV50AXeZ8mjkc2k38aIhHaC6ihbP+tTKQp5REVBg7iW8tYpVY3Gkbs+OnReFRDbHY9Mm6EvQ63s1KYbDoCqxxLn0Cv/iJRpc9h2JrrZ0S6WTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxcIK9Ps; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxcIK9Ps"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db1d0fca58so546303b6e.3
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016921; x=1722621721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnNGwxQsolwbKc9YoX7E5tOP7IITbKC2WKS9xrdWB6w=;
        b=jxcIK9PsffDzm+lUHhJfjZ/8YG4DwP5cPfT9W4fKf6lBJJuwgHH/TO0yoRfY7UaprZ
         KRyX6EXaewsC+prvRKJ+6FUpfmhzqVYPynO7Dq94m+bq0YZtqdA1Hlv0WYmjT68L2y8A
         e1BhdU448/59yFT+PRMolsLyLq3w7rh3T5F/UbbWlOJOv0indi0Sth8FhCqFRlJ+92aC
         ceazFipYye5FzcBzZi5q7j7fRf+S1pTphEGQOFhvZIeqpGvXmGh5mcogaHz7bXJSef/S
         P1Ct88QlDU+DNFbcwZDJyKfwJUfMH5AwGJ8kQmMj3AmuMiE6Qm+ldKnYbsf7bQAN50tb
         VD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016921; x=1722621721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnNGwxQsolwbKc9YoX7E5tOP7IITbKC2WKS9xrdWB6w=;
        b=M+zlxk26IQMzGsiWpRcJPmYvUVm9hE3rZd7jVtUhzqT6f6sSHD3SWmttURQCswQvSH
         j+BsqPFaKiSHgnX/0duMDH4hdmN2Mid8Qwdza/eHC5H1YrMi9QxEWdaZdJDkPWZcCJsR
         vuJGNalFHRPNFJ1VtZ7MPIkM9Qhevra7gZIsXrHzL7sRjbIk1pjlHEt0cxf6AYz91MRa
         P6pRXYNg1Ue0XHZ9RK2COqPci/19qOM+e/Czet1NGGkBAhMTLxIA7zxfCdRcCZyd74qL
         FHSDHbo+/K5WyVUx6TyC/vymYLFuz4Y4P+y0ZLbAAyp3m9Sn7hu9A8EGG3vGeJhzwA/1
         eniQ==
X-Gm-Message-State: AOJu0YxHGneyzUZXS2UWqKo+LxOh6RAcY1D22AKvrmcFL9V9GtsPnItI
	FbUyzeRZmd0ThEsjrprRQtXDhAX2/oan5I1IIPU/STM1BDNSJR8nZZz/6A==
X-Google-Smtp-Source: AGHT+IF8yCvy3Zy3o7V71kqXGIP4v46G/N2BPvxXLYCS7/yvJKkhnI8/+xsXsk/CMKMGBCM5VUqe4w==
X-Received: by 2002:a05:6808:1416:b0:3db:153d:5552 with SMTP id 5614622812f47-3db23d2a72bmr566574b6e.30.1722016920911;
        Fri, 26 Jul 2024 11:02:00 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8fccc8sm18877166d6.46.2024.07.26.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:02:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] wiphy: add flag for supporting remain on channel
Date: Fri, 26 Jul 2024 11:01:55 -0700
Message-Id: <20240726180157.1654827-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/wiphy.c | 9 +++++++++
 src/wiphy.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index fb36ebb2..ad9bf59b 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -149,6 +149,7 @@ struct wiphy {
 	bool self_managed : 1;
 	bool ap_probe_resp_offload : 1;
 	bool supports_uapsd : 1;
+	bool supports_cmd_offchannel : 1;
 };
 
 static struct l_queue *wiphy_list = NULL;
@@ -938,6 +939,11 @@ bool wiphy_supports_uapsd(const struct wiphy *wiphy)
 	return wiphy->supports_uapsd;
 }
 
+bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy)
+{
+	return wiphy->supports_cmd_offchannel;
+}
+
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
 						size_t *size)
@@ -1384,6 +1390,9 @@ static void parse_supported_commands(struct wiphy *wiphy,
 		case NL80211_CMD_ASSOCIATE:
 			assoc = true;
 			break;
+		case NL80211_CMD_REMAIN_ON_CHANNEL:
+			wiphy->supports_cmd_offchannel = true;
+			break;
 		}
 	}
 
diff --git a/src/wiphy.h b/src/wiphy.h
index bc82a007..17e53075 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -141,6 +141,7 @@ bool wiphy_get_rsnxe(const struct wiphy *wiphy, uint8_t *buf, size_t len);
 void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
 bool wiphy_country_is_unknown(struct wiphy *wiphy);
 bool wiphy_supports_uapsd(const struct wiphy *wiphy);
+bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy);
 
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
-- 
2.34.1

