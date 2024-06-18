Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458713A400
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729945; cv=none; b=QGnXQFdmMRXGQ9vimTuYQF5eP9Dg1WKhZz7Gxenb05/VmmYQY9yrSipK3H+5mAgpwGpmWghjMoAwNqUMcTRKoHep1WtnaA2PgdmxJtMpgjRb3fm6tv9YfKLAKNX1fD/ftAbCkLNeMUPGqcS7IWy+Pki0nNc3cmI+lFSG98GE6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729945; c=relaxed/simple;
	bh=6s4rvgofKsDSmjnNfuDWJpl4Px6C6YYOBUQeQmTkgkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBVvJxuUw6rJkS6WySPQCGqDl2ZO/I+++CslzbCDYeq35Ve157/soxqOlizZ+lAFCz2eYck/P4Xtijdrs1hRarRZzjRnai9lFeOKieFkYfDpc2aSBhlISNvTLbFRzq5QU2J2rDXGmuuRVrD4/gF/r57qQ7DgEPEnzY4VZ8MZY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHbP1v+4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHbP1v+4"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-795a4fde8bfso341079985a.2
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729943; x=1719334743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3cOci0lJOT3IlWP5eruS0De6L1xgUbgkNwRvi8idU8=;
        b=SHbP1v+4ht5d3x79icPAnbPV/kw0MTtvqmaoXo95G7ombjATBwZub35tDP1iympgOW
         uUHI4w4rzPuWIq+yr0D63hD0Ii/ZEd/zONE7anrc2ZQD67s+g6cONWcvz8VRfhKLlWbK
         +OgnbD/HjW1eU2ZkGqMt25+MeqdgOBB3p2I5MswoY8AOkiFmwa5hlW/wXcmfrk4JrIXi
         7zkqpDNR46zKBUvb8p+todou16Wiq7hLj+Y3LKYFz0cQ45/XtwG6Q3tlx+RzRrNUcDuY
         7e337wvLC/O1Foo9ZMnW7BYRaZtP9Ni4vr9Vp/2D6uk2bvs2vlRgU4CZxBMHAXs7ffKT
         SL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729943; x=1719334743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3cOci0lJOT3IlWP5eruS0De6L1xgUbgkNwRvi8idU8=;
        b=ESaUnyDcrDYB3G5qlVln23miOUBocLydMs7HKHpH+4JFgsg3lBv9npGUSbLwDcQnPP
         rg377fkPBCBzg/eu6QCL+wW0vKFVRy/N7bqaz8uqBqSrRULe2f9uXsmYk4aHtrY2dee0
         mYVZGot8AR6qpbVKxFU0Ccu0qTX5vPuauzsTIxskD1ImoYhl7lXXfRAIaMwB5troraYB
         votfpV0ZKjhxM7ioehl9PyNTE69lrVui0/3Y4i/SUcCqBhjzYJQopOABX4WKZk/VQ4fk
         nDyjwn1WdrGTz86fC1fEiGz4XMiftqIFfm4r5pJSX71XpECuEZ219/3w9gDSFk/DEMvk
         uvsw==
X-Gm-Message-State: AOJu0YwJTt1ZqDZcuPfntIRPiSJAsCznN/xZXcZbSBmPCuDXDTFl7BgR
	3eU0LdMbeAEs/0yB8w3+r07Bopwye62hgN1aQm+4KP2xud2JR3/WeB4xZQ==
X-Google-Smtp-Source: AGHT+IE0bgwZ30QA3zuFO/m86SBhd0EWGo6Ou4iHRmqzSKf6YfuaWP089LPh5h44ATGvSn6B6L7nEw==
X-Received: by 2002:a05:620a:170f:b0:795:4cde:3b26 with SMTP id af79cd13be357-79bb3e1261fmr32740785a.1.1718729942721;
        Tue, 18 Jun 2024 09:59:02 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/10] nl80211util: add nl80211_parse_nested
Date: Tue, 18 Jun 2024 09:58:48 -0700
Message-Id: <20240618165854.113598-4-prestwoj@gmail.com>
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

Add a nested attribute parser. For the first supported attribute
add NL80211_ATTR_SURVEY_INFO.

This allows parsing of nested attributes in the same convenient
way as nl80211_parse_attrs but allows for support of any level of
nested attributes provided that a handler is added for each.
---
 src/nl80211util.c | 37 +++++++++++++++++++++++++++++++++++++
 src/nl80211util.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 4a402e2f..0076aa51 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -193,6 +193,20 @@ static attr_handler handler_for_nl80211(int type)
 	return NULL;
 }
 
+static attr_handler handler_for_survey_info(int type)
+{
+	switch (type) {
+	case NL80211_SURVEY_INFO_NOISE:
+		return extract_u8;
+	case NL80211_SURVEY_INFO_FREQUENCY:
+		return extract_uint32;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 struct attr_entry {
 	uint16_t type;
 	void *data;
@@ -297,6 +311,29 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
 	return ret;
 }
 
+int nl80211_parse_nested(struct l_genl_attr *attr, int type, int tag, ...)
+{
+	handler_for_type handler;
+	va_list args;
+	int ret;
+
+	switch (type) {
+	case NL80211_ATTR_SURVEY_INFO:
+		handler = handler_for_survey_info;
+		break;
+	default:
+		return -ENOTSUP;
+	}
+
+	va_start(args, tag);
+
+	ret = parse_attrs(attr, handler, tag, args);
+
+	va_end(args);
+
+	return ret;
+}
+
 struct l_genl_msg *nl80211_build_deauthenticate(uint32_t ifindex,
 						const uint8_t addr[static 6],
 						uint16_t reason_code)
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 6f7b9eab..d966e049 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -28,6 +28,7 @@ struct band_freq_attrs;
 struct handshake_state;
 
 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
+int nl80211_parse_nested(struct l_genl_attr *attr, int type, int tag, ...);
 
 struct l_genl_msg *nl80211_build_deauthenticate(uint32_t ifindex,
 						const uint8_t addr[static 6],
-- 
2.34.1

