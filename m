Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591018B48B
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429936; cv=none; b=c3MvdAGYW2uVnQvTz38Jd5f43CEwVtValV62vbszxIFKdPcdZlC8+WnRAxgY/sHbtVyGTTYS5Py9fFXu94DQwVI/GjXd1WkZm+JY9SH6jjsPAX8zxMBE5+/zGTzPZ7pt4xrROMjLPmnC4/ZDPKhyWsKsfPnLJryfngo6xnsqWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429936; c=relaxed/simple;
	bh=TnFBnC6JW5XNKr3dIDga1stJFWwrWTgGay6+3pfKYTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn2nxwJ8IozH58Tgs/VYTYrXLm10GnBMniHWx5XcH6QYgZhy22DZTG9HJcraL5LDWciHQtfFxX1DA/DtYMwiN+DuSNkOqNISPqfBOqX7CwJzUCj9zxq+pyekROlFZoYobqbch0kHXt1RFt0KDCrjFpGmZbqwS4HWQ52oOGyVqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8roGn2S; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8roGn2S"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7094641d4e6so1130392a34.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429933; x=1725034733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3OCMrURtXx4pgY9lNgxDG5feWxitvjNiBazB79y9Mc=;
        b=H8roGn2SByyL3+9HeAqxEzHhADR5EQccPqOtskjq5KjjN4j3MoxxK1PVCtleMD8JFW
         SkTIE8L2x6wyHpMHoyoNCx/ruiFKnivsXS1ObE8a+fJz/zKYmD9Z5pzYZK8Nj5Ln1/vm
         +Rdxs9fI/DS+l3dKxLRmwMw0P+A6G/IYdmue1CtBLJozleSsbmSLTAA31iJ7z7/By3WO
         odcbQx92BE119XNIcp4xDqCLamSgUvdcsDUwR66DXGhSSY3HIsFH3jUVifCz/EzKKiu7
         XH5pTpy+bIOJlSy6ha6nG1ctEmA2Z+QN39IyQ59JFmWA5nxOUZ3xGlzbN/NM7E4zI+l4
         hdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429933; x=1725034733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3OCMrURtXx4pgY9lNgxDG5feWxitvjNiBazB79y9Mc=;
        b=p5tBugkz+Kz+WU4lJUCRpVhKMd/76uer7XCMMas2WYAX/VjtZJr9YVejhGBK4LHO+O
         A10FoVZqNfUIgiNq8nTVtP0txu80jz8QcK88ChmCmTiaO+ngh1WOkx+E04dYeAoXClE4
         Luawt/ggZMq+zr5ZnQBdu62rYNkeLz39JghWTJFoH96P23Vbr4h1jqBxLZJZpopTOpHP
         M0jTZNyN8cbgZCaNFh8me6i4RIMnSjPZd6jJVMcudOFylGGMMmWdQFC+b5NRj23Zd+Iu
         sHevUnZh7liiquniWZW5L69v5Av2BHRdrIxL5qn0FgefDIvuBp7/2FRPY1+IK6ZdZqcQ
         CK/Q==
X-Gm-Message-State: AOJu0YxUEQBC7afacxmDlRFgiVPQETqLGENaDDhQq0/TWPtpzWipRLiA
	IIUfI624KRXgvHUxmm1uYhIzxewr/Yo8dfc8bR/ZonFHWNOinuVl/NiRUg==
X-Google-Smtp-Source: AGHT+IEC9E9Gz2ppvpF7U7+oQJ0bICIHAqf9hamG8NcGOL/pHjpmdcVRR1+vlh+G0modczVTNs4Vfw==
X-Received: by 2002:a05:6808:1704:b0:3d9:2e2e:1ace with SMTP id 5614622812f47-3de2a90117emr3030559b6e.42.1724429933584;
        Fri, 23 Aug 2024 09:18:53 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2256f44asm764507b6e.31.2024.08.23.09.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:18:53 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/5] nl80211util: Add builder for CMD_EXTERNAL_AUTH
Date: Fri, 23 Aug 2024 11:18:33 -0500
Message-ID: <20240823161848.485685-5-denkenz@gmail.com>
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

This is for sending status from the STA to the driver
---
 src/nl80211util.c | 15 +++++++++++++++
 src/nl80211util.h |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index c1218c21fcd2..fcf70b9f1740 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -654,6 +654,21 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 	return msg;
 }
 
+struct l_genl_msg *nl80211_build_external_auth(uint32_t ifindex,
+					uint16_t status_code,
+					const uint8_t *ssid, size_t ssid_len,
+					const uint8_t bssid[static 6])
+{
+	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_EXTERNAL_AUTH);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_STATUS_CODE, 2, &status_code);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, ssid_len, ssid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_BSSID, 6, bssid);
+
+	return msg;
+}
+
 int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out)
 {
 	struct band_chandef t;
diff --git a/src/nl80211util.h b/src/nl80211util.h
index d966e04978c9..67fd7d7bdaa6 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -87,6 +87,11 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 						struct iovec *iov,
 						size_t iov_len);
 
+struct l_genl_msg *nl80211_build_external_auth(uint32_t ifindex,
+					uint16_t status_code,
+					const uint8_t *ssid, size_t ssid_len,
+					const uint8_t bssid[static 6]);
+
 int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out);
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 					struct scan_freq_set *supported_list,
-- 
2.45.2

