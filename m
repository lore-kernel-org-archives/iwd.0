Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CF13AD12
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729947; cv=none; b=UhhRVCvIQfym1PBeN1iw3YP82p2jyTLeW9cQ1Is3ETYPH+Ri9xU0THcwxgZ/6VHkjcAAld5Ca1dDKTJND/0/LYyvSnPGgJJMsZ4pYt8/c0vsNayVubGQIN3CeW9Tz+RGkfdz3MEQegqcB7L9EgWNjSwJbRL8njRqCJvtdc0yVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729947; c=relaxed/simple;
	bh=E6VJEGcoDypDNdJ7/6LEmaXOwPtzyEzcxk0LkzmsiCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAPP9fk8mptANH3DUqw4aATl4ELEtFvSdoX0OzUNUWOFHPDEOxTQFU98ru8r+geBHcjXrqQvFcSxcszfTioL8e/BoWSmNA40WRF8ScSLxJbfCIZxRwPGN68QdzGHWpP7MYxwJNqwrf2lFWkXqPy1uhAz3dWWkOLra47GfRUndGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYwNETzJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYwNETzJ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79776e3e351so416737585a.3
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729945; x=1719334745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx1DC9zlmmqSGmQdQNzX7sLJh32HVnFTeWUrU2KnRns=;
        b=CYwNETzJqVSdLgzHNbCWw6YHfbUfQhyiOQsljQo8/JhJjr02gwodB9WMvP5mpIUcBi
         Z7C2UovEK90MHs7ZPcEH1XclSnKz+hfA6EPR+yHqulLcAlAfU+IGhVWLFSPZA06u1VRj
         vkW67uZl0+PypMe3rl/u/oL8fV/LzQkUVgc/TJTzoKHSMRUO4zPgR6lo0Yjdy9VgWFuf
         luWs5m6vpntRutvPdqzdrGtB4Hu1WOxX2dlmJ1VJCxDpU+3pTVsKOOEgiyrBVDXCpQ+u
         T52wC3tyHGI/hwoSI2jVBB9QZHZpqeC50Hy/UYq8HV1BVoyF1DHNSx/5A6GBY/WYtjmh
         wOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729945; x=1719334745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx1DC9zlmmqSGmQdQNzX7sLJh32HVnFTeWUrU2KnRns=;
        b=ohPcw8jZrXnhyaXIB8yJZ7a/+H0W0dA48dQoS0WWRiVyyTJ2hOLBORJDTc8Bao8hyH
         PrWK2CIT0lp7a86Rmj4WxNnxGIQ/M2yviQ1bIGElPG3u7yhaTLXY5YXl5+XYhaBaXxGN
         koACvRa/35uJ9FWHB3fhpe+FGRyCCPCuJBi9EwvEy1+YC6gOKHZsM9QUX7+POIieRzNi
         SPM5Sal6Mkn9Q/S1JyeF/ocXJU393hxemMqP4ntBD2LVCGrgI651/BYTlj3rwuh/VA0b
         KBWeWVjWWGpplpbRXz/HMvY9h+0hcjyaA/knv5NiJDw9JxFWJZ1dxOaJddP3FRQ+oue2
         Ywbw==
X-Gm-Message-State: AOJu0YyXMUrm3g/3qs5iYPD57VJSJDOliaM36OIHnLbWBhykGJXi70ru
	db59pgOZ1J9BZGqi84DTQX0zlpqF+aetrhaphfmYuYDtaQ0M22W7sdoDmA==
X-Google-Smtp-Source: AGHT+IGP719tYP5DrlodxgPONDBYFjIhdluraS9731t6W62DOua9fv/xRYe+ACmrEA+EbsbmFzBsCA==
X-Received: by 2002:a05:620a:4153:b0:795:56aa:c8b with SMTP id af79cd13be357-79bb3e57dfemr26954885a.44.1718729945154;
        Tue, 18 Jun 2024 09:59:05 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/10] scan: fixed flush flag parsing
Date: Tue, 18 Jun 2024 09:58:50 -0700
Message-Id: <20240618165854.113598-6-prestwoj@gmail.com>
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

Parsing the flush flag for external scans was not done correctly
as it was not parsing the ATTR_SCAN_FLAGS but instead the flag
bitmap. Fix this by parsing the flags attribute, then checking if
the bit is set.
---
 src/scan.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index d3f0ad31..55d560d4 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2021,16 +2021,14 @@ static struct scan_context *scan_context_new(uint64_t wdev_id)
 
 static bool scan_parse_flush_flag_from_msg(struct l_genl_msg *msg)
 {
-	struct l_genl_attr attr;
-	uint16_t type, len;
-	const void *data;
+	uint32_t flags;
 
-	if (!l_genl_attr_init(&attr, msg))
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_SCAN_FLAGS, &flags,
+					NL80211_ATTR_UNSPEC) < 0)
 		return false;
 
-	while (l_genl_attr_next(&attr, &type, &len, &data))
-		if (type == NL80211_SCAN_FLAG_FLUSH)
-			return true;
+	if (flags & NL80211_SCAN_FLAG_FLUSH)
+		return true;
 
 	return false;
 }
-- 
2.34.1

