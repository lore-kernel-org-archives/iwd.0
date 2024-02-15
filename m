Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF14132C24
	for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005209; cv=none; b=eFGJ3In7HqxyS258aarYAEY/PsBgZog4URnXUdQXo/b2HuLS69FOXvTa7vj+jQ7Ohsf8C0O0pRsuW7l+Y2N7MeP2Wyx8O/LziO6xpUyB48KTb2rKTYf1+bFculKWo4kSDzYqsrcFeXHbRHy/AjXhy6Qkmefn/NXaBtkrBTPGOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005209; c=relaxed/simple;
	bh=GtkWb3cifPeyEywJy+2bGBeVj0O+vhSVTbbilMDePx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlkdiZ8xMb5sowCuMnb4hreQWPUdFRYf4irZ/wqFA/LJLlhaTyZ+25M2tX5qJAtxU3l0E460i4Kk1u4K0A51BxUWZ33pQGxG6vGJSAcU0+8azMHOpDCtzLD/OIT5rawKGxGm2biLoeSj4jsMzrHg202bbRW0aq+ciGz9KguhPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7CTcAVH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7CTcAVH"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d73066880eso7729025ad.3
        for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005207; x=1708610007; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YoQSgYGctnC+Lwnqy8uNsIX+5DbpRRsjsJh8WlxRD0=;
        b=h7CTcAVH8jvraBDB28opTaTheS8pBuZ/YgYxTPQBFsRW6RsJp4Rf92QCCDrYIZVf0w
         TOBTJCzyOAwFmA3zKB5aecLg8fHItgq3E1yOcG4AU++7y+JByj4g5FLJbx6Ur9CLWAxo
         XRchNBvKUVh117Jbb3PW2EU/QGPqoIFU/ThfUnd4sfgar7fTnV+ru8ukNJ+S2Bx0XDEz
         1Dl7tJI+3aGSHwxyiitAhAcevcbW+5wADrVVBPFu+4GNcgtdknGWlxxA0MmV1niVeTMF
         PJCOkga9nc7x1/dhQ9lMbJO4tiLwJ/BVAgVnim41nACuZ4VA7OkkmIEuQ6CIwHbalCZb
         O+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005207; x=1708610007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YoQSgYGctnC+Lwnqy8uNsIX+5DbpRRsjsJh8WlxRD0=;
        b=fqdauwYFCB5W5cn60Xgu8ZVZkgOlXgveMCm9IcLHkOK6Bk6mlShaEe3zLZQWcVPxxa
         3JuDsCGv6dQgIbfCBVYR7yK3V5NBIMWhD0ikdF+A/rd0jOfedygUkIVRu6hBf4OA1htJ
         svNVM2jjjyw2CGq7Fh0K4j6+y2sSxeb8X8XfscWTv1Y25q1z0hNz724/AHo0OG8wB47a
         lauv7alQ4P2MvvIRcMfsRcn5whSblUtxEdcR1uWjI/mUlLQrpAKEBsIVf0HVqeSd6L+l
         i2AWzMrxppYOz8/gmvLp1eqXTn7jU1ze3wAJ07hK8A2GgiDMWdG6QuSJkvCeFbkeV4N5
         72mg==
X-Gm-Message-State: AOJu0Yyqx5lPy5xtgGI9SGwrugm2CGBinLKdQhA9LlCERFqxCByP/VF3
	2W42yO2kCdjZvXwylVKupekFXcJreVVmNkgrc0swIRNLqped9CV3GzerdktAvpI=
X-Google-Smtp-Source: AGHT+IG0SU6eij5zw3TwbZhVnW0BfrOUfppPHUquRuVvcGadb4gblu6X9ORcO6i5pIrRDO7jjMe/9g==
X-Received: by 2002:a17:903:1104:b0:1db:37b1:b1a3 with SMTP id n4-20020a170903110400b001db37b1b1a3mr1851727plh.17.1708005206819;
        Thu, 15 Feb 2024 05:53:26 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001db55d2e1e1sm1284787plq.63.2024.02.15.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:53:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFCv2 2/5] iwd: add iwd_notice for special event/state type of logging
Date: Thu, 15 Feb 2024 05:53:11 -0800
Message-Id: <20240215135314.1017081-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215135314.1017081-1-prestwoj@gmail.com>
References: <20240215135314.1017081-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iwd_notice is being added so modules can communicate internal
state or event information via the NOTICE log level. This log
level will be reserved in IWD for only these type of messages.

The iwd_notice macro aims to help enforce some formatting
requirements for these type of log messages. The messages
should be one or more comma-separated "key: value" pairs starting
with "event: <name>" and followed by any additional info that
pertains to that event.

iwd_notice only enforces the initial event key/value format and
additional arguments are left to the caller to be formatted
correctly.
---
 src/iwd.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/iwd.h b/src/iwd.h
index 1be20df3..e25b4c03 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -42,3 +42,16 @@ const char *iwd_get_iface_blacklist(void);
 const char *iwd_get_phy_whitelist(void);
 const char *iwd_get_phy_blacklist(void);
 bool iwd_is_developer_mode(void);
+
+#define IWD_NOTICE_STATE		"state"
+#define IWD_NOTICE_CONNECT_INFO		"connect-info"
+#define IWD_NOTICE_ROAM_INFO		"roam-info"
+#define IWD_NOTICE_DISCONNECT_INFO	"disconnect-info"
+#define IWD_NOTICE_FT_ROAM_FAILED	"ft-roam-failed"
+#define IWD_NOTICE_CONNECT_FAILED	"connect-failed"
+#define IWD_NOTICE_AUTH_TIMEOUT		"authentication-timeout"
+#define IWD_NOTICE_ASSOC_TIMEOUT	"association-timeout"
+#define IWD_NOTICE_CONNECT_TIMEOUT	"connect-timeout"
+
+#define iwd_notice(event, ...) \
+	l_notice("event: " event ", " __VA_ARGS__)
-- 
2.34.1

