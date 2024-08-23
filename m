Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48D18BC2C
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429935; cv=none; b=Cp9X7lrxOxwn+VdaLq4ISIymz3VQgYOiIhaf+ymxeHbvkAg209K8GnszEWaMQONZGgeIQzC3FOLt/RKMDdrWtE6lTrKmyUJSyW3r0TwYWgrdNHTHwU3uisshu6Q3RLt/YZtbuSSp6XLGBzEOLIwhYPjaz6b4zth/MgOb/6z8XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429935; c=relaxed/simple;
	bh=U92AUM62hUgerDyg6jMPmHUva2dTtjgjU9ht4417tNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxnKfbMa7dokcGEbESksuPFb+Tf4LP0Nq6HkdYxk4JSNMc8UFX3krKBKjv43QshTxIZJFforZgnww9mOBCqcsrC4MUXG3pw1cDrJuF1eVCM3lr6nzXSQfaF4ddsZs4fTS/FluuoYvZ/lzWrJkN3V4DLv0R6hJEe1acAaT51RJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSyY5zI8; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSyY5zI8"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5af7ae388so1734440eaf.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429933; x=1725034733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVx44lvNE2f11u250ZB26TQ6LFaGj1zgcLZ55GJstOQ=;
        b=jSyY5zI8UjCTILOZA+OVXZ750N2yrP5yh0JZZDp8/aDPhxBBL5tfWeHJazTFpDQio+
         zS0Ib6a+HotIwTEgf8XZuq75Vw+OrBYuoE2tS3YhFEaEty+5KY02rCgHybxvZtxeIzKb
         2rE7ZApGKiCCQG3H+FS4ICUdLx62azPGfp2EFlyCaBcb4ArmqHuUwJegFiAUIr4FLkKf
         IPT67Yw3J+dDoezft0UN6/4bCLdmHU7B+nojUGGIzugUB70AmpESCSAjDZVHiYcvng0X
         qHveFnHnwAnr/GswbPunru37C57rYXw1+RB8dAwCrK3Wre7rfP4h/u4zuUXQE9AclX9X
         EdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429933; x=1725034733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVx44lvNE2f11u250ZB26TQ6LFaGj1zgcLZ55GJstOQ=;
        b=MTFnkLoPqrlYPGziLZmgJ5VbnLEZUe3OGgL4Az3EtnoFLlaW741lrIkJF/xsOvLcsH
         hZGfb2gDG8yfeEiwLcXquNvf3afd7VdWXMpRnZw5Vak6j5EtnvxgX8hnSdvZe3i1syzZ
         DB5lHU17SDa0hr/S3asZNQPM+FqXtL2rAXVNSqtvXOXPZa62wMlKykHzzisxj2CJayzY
         tbmPeZFTz4rG388e73J3rfMQfMutepayO48emiWDky9CWQgEvclUCnEpznrh3mmIjU5c
         Q3mq2IfSsEVYJ+gmI4IU8KXac0Bi6KpXX7ou2fpNr4jtSXrQ68yMNmnufZkl9oY/jdA/
         Z+4g==
X-Gm-Message-State: AOJu0YzkosieVOSfhjdgeDSee+kin2+CVEqS/c1W/jhFt5P+kmL/TKy1
	PxhsnNjdHM7L6fHdvz/o0cshtAKcWc2MrMk+fgjmBJzRw8Uoyhu3/4hvuQ==
X-Google-Smtp-Source: AGHT+IGbclyB23CwgnYjIDNxew3tBRXj8o+Owj2J5E9KUOJkZGe7R08Ywkp/9u0RCGEQhnCx77EP0Q==
X-Received: by 2002:a05:6808:1206:b0:3db:199e:bdf2 with SMTP id 5614622812f47-3de20f9b694mr2399020b6e.17.1724429932848;
        Fri, 23 Aug 2024 09:18:52 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2256f44asm764507b6e.31.2024.08.23.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:18:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/5] nl80211util: support attributes in CMD_EXTERNAL_AUTH
Date: Fri, 23 Aug 2024 11:18:32 -0500
Message-ID: <20240823161848.485685-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823161848.485685-1-denkenz@gmail.com>
References: <20240823161848.485685-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211util.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index eaf9f610fc5f..c1218c21fcd2 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -132,6 +132,14 @@ static bool extract_iovec(const void *data, uint16_t len, void *o)
 	return true;
 }
 
+static bool extract_ssid(const void *data, uint16_t len, void *o)
+{
+	if (!len || len > SSID_MAX_SIZE)
+		return false;
+
+	return extract_iovec(data, len, o);
+}
+
 static bool extract_nested(const void *data, uint16_t len, void *o)
 {
 	const struct l_genl_attr *outer = data;
@@ -170,6 +178,7 @@ static attr_handler handler_for_nl80211(int type)
 	case NL80211_ATTR_REG_ALPHA2:
 		return extract_2_chars;
 	case NL80211_ATTR_MAC:
+	case NL80211_ATTR_BSSID:
 		return extract_mac;
 	case NL80211_ATTR_ACK:
 		return extract_flag;
@@ -179,9 +188,13 @@ static attr_handler handler_for_nl80211(int type)
 	case NL80211_ATTR_CHANNEL_WIDTH:
 	case NL80211_ATTR_CENTER_FREQ1:
 	case NL80211_ATTR_CENTER_FREQ2:
+	case NL80211_ATTR_AKM_SUITES:
+	case NL80211_ATTR_EXTERNAL_AUTH_ACTION:
 		return extract_uint32;
 	case NL80211_ATTR_FRAME:
 		return extract_iovec;
+	case NL80211_ATTR_SSID:
+		return extract_ssid;
 	case NL80211_ATTR_WIPHY_BANDS:
 	case NL80211_ATTR_SURVEY_INFO:
 	case NL80211_ATTR_KEY:
-- 
2.45.2

