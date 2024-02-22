Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0405148FE6
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615507; cv=none; b=q7ib2KtYVO5IDjYBdQnMifdlwnlj02RD6STjaVRHxoGRsJnjmGw12Y0X97djn9i+0plZWTB2pnfTe5jxnmsnfKszMrAkkrwjYmcvKB/il7EImQz194vZncenf07Zu+WZHuzVSY36ByCrDpjGCkKhGzZxXgjbpld+ZV1vO9gDvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615507; c=relaxed/simple;
	bh=KdCvINeZoAr2Zwl35mTBafBrnuR2weh56iNiFHBoiDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trekpmExMlDtqoy2uRJE1tEgripyisbxpJWFwb8Z1uYIdEbyPiycWAaJNto554rEtckLBaQ1zOzqF7tD79ectGa5461SU8r59/Zy3azZB33TTeQMDQI7RpZg/t1tulOwZyRfGDoGCbkpci+x8PVSNL439CsFB7/Kd+QCS1xN8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk4oe80J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk4oe80J"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d95d67ff45so16495395ad.2
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615505; x=1709220305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v97OWJaNaH4F9YTnXBZrm6rJVKScTDKLhWZsaDMjEg=;
        b=Bk4oe80JaktZMyZgoKIqmzuhhZu33F9X2IeJpbDtYGwrlBPMfqJI+qAVy2cbND9hZe
         2g+qfdA2oct/MIXsQ+TrHhPk7SxnK6pBXbHQvNRWq0W/d7VYM48Nir81Q6KNdTX9BVo8
         xJpr4OIizEaTlFRvAtN/F4BT9lF1iyJqyy9GE8qsCLi7YebQ1R87YJ5Fi/yw3JfddjQL
         43ErLCyxvMqB5/OGzLJy3PrpEAWqsO9rPSoIpwOHv/M2qqvQTVOtZtb284IWeRURP6X0
         lImuTsMFg5CmL1Io/sEA+FHTxyrNoaK66gCCR6QlDkk70PiGIpSk7PL/1NcU6Nkab+4q
         BLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615505; x=1709220305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v97OWJaNaH4F9YTnXBZrm6rJVKScTDKLhWZsaDMjEg=;
        b=n1rGi5QpzYUKykhWyEIhanZokRaZEs7aeU9ZJPaKdF3TUH8ejhaaJHWlvexRFvqJiy
         rQhj+4TgRdGs8Gu/5g/gyHfrMtupOeKLrV1ht3dq9iTdn7xUqGQvGn2moh9FwQjooIBz
         GyabjIjpp5EOMH2SqMM3XaAwW67ALzPma7FQuUvl6GVGPjntoRNaH9uAvD5kCUXmfvzb
         pPGqty5UUTVu2QG3zpmoG4xqJon5F4Z2+y2laook35bzGpFt+CE7x9pyU3n4+yEKudvU
         M545f4OFvn/SeB3f4ELnIQzGZ/+fQUZtCvQghIOC/CbIhY0YMZwvQ1yKtD9qERapqVp5
         O1pg==
X-Gm-Message-State: AOJu0YwODKpDqCF/WbeVXNzOJlLeGtkXVYplE4WesLwHeihnQzOWUn3E
	/vVmNwgylcPE+OC27faixcfi5qIlIVVhYYkQDQafgWOfFWF2pIGTjimNIeZQ
X-Google-Smtp-Source: AGHT+IF1Idf6vTQGEg5iEIyHq/7Kdjsrs7/za1bAbrMoQ+IHzhY3CAhC5zHpmfaRLn+EDWZe53RwHw==
X-Received: by 2002:a17:902:ec8b:b0:1dc:11f:d954 with SMTP id x11-20020a170902ec8b00b001dc011fd954mr11997088plg.54.1708615504675;
        Thu, 22 Feb 2024 07:25:04 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm10044873plb.184.2024.02.22.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:25:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] iwd: add iwd_notice for special event/state type of logging
Date: Thu, 22 Feb 2024 07:24:48 -0800
Message-Id: <20240222152451.1541682-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222152451.1541682-1-prestwoj@gmail.com>
References: <20240222152451.1541682-1-prestwoj@gmail.com>
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
 src/iwd.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/iwd.h b/src/iwd.h
index 1be20df3..a8e2c5db 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -42,3 +42,17 @@ const char *iwd_get_iface_blacklist(void);
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
+#define IWD_NOTICE_ROAM_SCAN		"roam-scan"
+
+#define iwd_notice(event, ...) \
+	l_notice("event: " event ", " __VA_ARGS__)
-- 
2.34.1

