Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA66EB53
	for <iwd@lists.linux.dev>; Wed, 15 May 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775748; cv=none; b=XJdhW0ECM6arBNGNS8PcFPZKs4UYfnw4YrASxq/YPFUcdtNlrifMDA0swERAfm2w6sl7knh+FVkWq0VAAWJeu65MNWtwSGk59qIECzd12MutKW9l2vhlbTsxWYHx9hyACg5bCAPlG6xhiwTsFPJmy6457Bq6oTE5B0QPWRzcrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775748; c=relaxed/simple;
	bh=pgbCuaJSS9JWFrQpAd/Ot034FCwNFC+fNRkYN6kwFPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CpQLSklLtO/+bi8S2t1UuLxl5taEruMfdSc4vUEZDIPBRBhgcW6dSxqpQKi/5wXpCe17eRA9vxmBlzrfhX6FlUrR4u/jRkMH1StcydTS+0I7SqH2+ozqRUTasJ1CDtAKaOjjjRDUYFasw0VdUIKw5jy1txaAt4M1L9VDrgOOqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyeIZwaE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyeIZwaE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792bae4137bso646949285a.3
        for <iwd@lists.linux.dev>; Wed, 15 May 2024 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715775746; x=1716380546; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQCG5OoDiAsKEOEh7vmRafPWObVvz/Xdd+/fPbFqSVc=;
        b=AyeIZwaEPvBvk+GQxz3CN2ME6o87XACm5vz9AtR7OjkQnZEKIJOjQIrmA6RGtTgzBv
         oUSJDqPS6wUGhcgSzxgPs5SpH4t5P7LDkW89NnLIoyKPlmXEtCD9BpkZsFNXo1CS68qJ
         9nA48YmJeeeoJVOCxOR6QpVC9/LpsCltMvHCkqb2S9Wz5Sijz5jWauFbWSlpetdJq8Q1
         1+tffca8bJWmATlTkDUPOk8/Y+NL0CTTCdkNJTM6/0EhDs/6ZaSv+fn3wZj/Dl6J1FcW
         NIV/6TsQM0Wub/XBwGfPdcnlSj9bV7ibRUJeBaRsdW8RcjedPVOWJZV4sXIBQrTpTt3x
         Q33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775746; x=1716380546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQCG5OoDiAsKEOEh7vmRafPWObVvz/Xdd+/fPbFqSVc=;
        b=QWIt6Ph3/OIdc1YZf7ayrgpl/sN3vMGGXuXyt88XfKp8+/WxW3zi2KBk3k4ZDy5zFm
         YVnSXu9RhDrixWDP7X66TRHruy3TBcg5ZwxVYldrU9a+QWEtFsrHnfMGx/zrKapVAjQO
         25Z1WbyhA/EFp2pWEzVa+pjeugaRCSn8ZOqH/1XCr0NzbEGLC8Vz0XOntVToafPC/quc
         NNc1U57w2XryEPlvnQTR2mQ2gg9Gtbg7M16QwgVEZpSyTJVMp56PNbBnC9p2vN1iTyNd
         8KxNXCCP6pAJrjAHfv0w/UZ3jhz8XqCUyYuDYTK3+IxHEb0q/b8P89dcpw1HO6DXZNfJ
         DdDw==
X-Gm-Message-State: AOJu0YwCIKASqEDf57r4LPCvzxaA6kK1vC+LZVoBu5D7HuFVK8qPoTP7
	psQrLKeNCTIAOSqMZuI6pnlk6dNQbLT3EZr7Zo6sXP9NBXtKaExeQ3v/0Lzh
X-Google-Smtp-Source: AGHT+IEa0on9Rd+TtIZ+4bue+qulkoBaqROW+KLQXv4Y2zMo2CFyfWYLIzQ6T0Jxfp/3sUA6tu64Xw==
X-Received: by 2002:a05:620a:200d:b0:792:bf4d:6e8b with SMTP id af79cd13be357-792c7577408mr1536465185a.14.1715775745674;
        Wed, 15 May 2024 05:22:25 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a11e8sm669380085a.58.2024.05.15.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:22:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] nl80211util: add ATTR_SURVEY_INFO to parse_attrs
Date: Wed, 15 May 2024 05:22:18 -0700
Message-Id: <20240515122221.333230-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 3f9a43ac..15968d7d 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -181,6 +181,7 @@ static attr_handler handler_for_type(enum nl80211_attrs type)
 	case NL80211_ATTR_FRAME:
 		return extract_iovec;
 	case NL80211_ATTR_WIPHY_BANDS:
+	case NL80211_ATTR_SURVEY_INFO:
 		return extract_nested;
 	case NL80211_ATTR_KEY_IDX:
 		return extract_u8;
-- 
2.34.1

