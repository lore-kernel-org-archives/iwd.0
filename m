Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74B13790B
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729944; cv=none; b=XlFDwz0WjQUR4DrDFzj22c1RAknSOB+T0qsMgcnS12F6ZmyvXBQ4idSWoIHCF9f4H5Fe38PzonMOKGOb37Idhuf4yM4pzv0w+npyZW7N7iZLkdkhlbgMN1eBv2Rcvpqkc4vajFJoiiDKTInqTOWeFGubRZoaWyfdYHTdrW780ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729944; c=relaxed/simple;
	bh=kUlFaFk8bdOrk2QQqJZbMa7YJh6YVIpJQGjAcx++SnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DT/NsnfT5SdMtv6yj2V/AzRSB2088hSEROL0RHDq3HpiU3P6Ubxi1+EcC3I1h9D5p5b4EvKYEqxxIx1B9B6XV3p30aTQ6J76Zto+Sv4WHutW4dXxavIezgeX86oEMsHSqyKLGAe21l8zDtxGCcBnMtXwl5ob4pRfCe382T1S3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjjleSJk; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjjleSJk"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4ecfbf16c77so1637493e0c.3
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729941; x=1719334741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o80ybhoymnMckPDGCG9HVqYQVnI6ilk8pqgTtBYW3ZU=;
        b=fjjleSJkOUo67P82fHLY0GoJfAijKs78ZfF7RPsvN6cpxd8aAbjwqXrH8h0VgnTQQF
         7g3spKRlrmqhxfjhzV5YaGxQS4fU3m2YsL+v8L4ZDr44yS0ZpK/8cUO55SSvhLJevuNO
         +w2SYwS6/LZV17gXwP1gSmgfDIJ96TQi+Mix9N3sIipHByhe82h7XBqG5Ohlt5aHAUO9
         cUjWppojmkL08VLJqMMppH4hpb9OkfM2HQ4/nxXDWQqFCrbcJuTtqyy62Sani4ec6Heq
         HZzrPKiNxmAeA8ekcz3iHvp+1k2DXcrj6NQgc+GRlF9oS0a+ng1OSOwey7+1oDUFMscI
         Z1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729941; x=1719334741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o80ybhoymnMckPDGCG9HVqYQVnI6ilk8pqgTtBYW3ZU=;
        b=a7kE2lfhgohHqs0I9FzCUaXZKjLgQkl5hw4GLbRx7HtZsqffIgBAlcAWljtWTBqeZe
         TftSCx/Kp7zAlZhz5/xhKTihSHThciJY5wIXvJ6glwyCwlZTefs5lKk3NIAbr6LDSk5f
         aKpddzQV0dzcQb283XfZ/A4CJsMiix90u/ai/LN64Unb6VeeRjcBy1BgtqbKtEdqrst+
         gQFbboNOBzYFv6msFYac52qB1B7zR+N0iGqQlYJu8OWLAnJd+XpIEstJ2+rRWCNHbTkh
         kD1mPQ9Gvp8VnTPqN00bDK/2liM4DOYg4Px2Adkh3LlNoyASDAakcxzn2+4uWv9H5Zg1
         /RWA==
X-Gm-Message-State: AOJu0YycZgcThzldiPzdQhmpk6FT8Zi+2jQTBT8BgMU7AK4AO8A7In10
	FMAsWgpNiSGQiqZBrZqJTp/O2mTsABHNASnktTDedgkSIFfUhkEmhXPkWw==
X-Google-Smtp-Source: AGHT+IHrQwp0J2o6VTcGqXdPbu573eHhzyX12bwPgvPk+1JBA4U+aB07UH+RSZCA2TwdDMqYzr9FrQ==
X-Received: by 2002:a05:6122:3c8a:b0:4ec:f4a2:389c with SMTP id 71dfb90a1353d-4ef276f7cc3mr558348e0c.6.1718729941580;
        Tue, 18 Jun 2024 09:59:01 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/10] nl80211util: refactor nl80211_parse_attrs for nested variant
Date: Tue, 18 Jun 2024 09:58:47 -0700
Message-Id: <20240618165854.113598-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618165854.113598-1-prestwoj@gmail.com>
References: <20240618165854.113598-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prep for adding a _nested() variant of this function refactor
this to act on an l_genl_attr object rather than the message itself.
In addition a handler specific to the attribute being parsed is
now passed in, with the current "handler_for_type" being renamed to
"handler_for_nl80211" that corresponds to root level attributes.
---
 src/nl80211util.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 15968d7d..4a402e2f 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -37,6 +37,7 @@
 #include "src/util.h"
 
 typedef bool (*attr_handler)(const void *data, uint16_t len, void *o);
+typedef attr_handler (*handler_for_type)(int type);
 
 static bool extract_ifindex(const void *data, uint16_t len, void *o)
 {
@@ -150,7 +151,7 @@ static bool extract_u8(const void *data, uint16_t len, void *o)
 	return true;
 }
 
-static attr_handler handler_for_type(enum nl80211_attrs type)
+static attr_handler handler_for_nl80211(int type)
 {
 	switch (type) {
 	case NL80211_ATTR_IFINDEX:
@@ -199,10 +200,9 @@ struct attr_entry {
 	bool present : 1;
 };
 
-int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
+static int parse_attrs(struct l_genl_attr *attr, handler_for_type handler,
+			int tag, va_list args)
 {
-	struct l_genl_attr attr;
-	va_list args;
 	struct l_queue *entries;
 	const struct l_queue_entry *e;
 	struct attr_entry *entry;
@@ -211,10 +211,6 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
 	const void *data;
 	int ret;
 
-	if (!l_genl_attr_init(&attr, msg))
-		return -EINVAL;
-
-	va_start(args, tag);
 	entries = l_queue_new();
 	ret = -ENOSYS;
 
@@ -223,7 +219,7 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
 
 		entry->type = tag;
 		entry->data = va_arg(args, void *);
-		entry->handler = handler_for_type(tag);
+		entry->handler = handler(tag);
 		l_queue_push_tail(entries, entry);
 
 		if (!entry->handler)
@@ -232,9 +228,7 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
 		tag = va_arg(args, enum nl80211_attrs);
 	}
 
-	va_end(args);
-
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		for (e = l_queue_get_entries(entries); e; e = e->next) {
 			entry = e->data;
 
@@ -252,7 +246,7 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
 
 		/* For nested attributes use the outer attribute as data */
 		if (entry->handler == extract_nested)
-			data = &attr;
+			data = attr;
 
 		if (!entry->handler(data, len, entry->data)) {
 			ret = -EINVAL;
@@ -285,6 +279,24 @@ done:
 	return ret;
 }
 
+int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
+{
+	struct l_genl_attr attr;
+	va_list args;
+	int ret;
+
+	if (!l_genl_attr_init(&attr, msg))
+		return -EINVAL;
+
+	va_start(args, tag);
+
+	ret = parse_attrs(&attr, handler_for_nl80211, tag, args);
+
+	va_end(args);
+
+	return ret;
+}
+
 struct l_genl_msg *nl80211_build_deauthenticate(uint32_t ifindex,
 						const uint8_t addr[static 6],
 						uint16_t reason_code)
-- 
2.34.1

