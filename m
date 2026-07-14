Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C413168E6
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061526; cv=pass; b=T/hD9EtpsluLFDMPcXpOhXEU3raqsoFISGvNNYsr4u1TSJsjwHh0VOPmdL4dzrMvEf2DuNi0cJZMuS3alLIPpadhqUScB/mMd5GL1PyUodveDwOwk1nVkhes469vTn/q08V6h/ximxBBe3iwON/E1F4AxB/byNN2Jd0dUOx2kZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061526; c=relaxed/simple;
	bh=Cezo/4qUBvO3CBkh4VqIaujafDJywl+S99UExg81jyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Id8Eq350GzqmEoJ6b77AfquJhaRSY+rQ0uVf+Q/+b49GEwjGIUSSlH3fxfN5hZJGs6J6juUo58lwg/3LfhT7ogTKai3OpjBLrmE3i9D7JV6IfINx00zb9GwLNfeGHfPqjAn2uuegX+ukHBr/MLpV+H9NaE3441Pc2sr0orPQqyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOJXzww2; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOJXzww2"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2cce930cso12982591cf.0
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 13:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784061524; cv=none;
        d=google.com; s=arc-20260327;
        b=EtIgItOuskvfe44aHUH90GmR734U+/otUgGhbj/dwK+GIm2wxZ8SVKZmceJNl+tyNr
         TGvxIZv/qNuw9xhGJAI1qcr5htlyTdSENC4o0a+0RiL1OX7e6seIYWDq6WLo52fVB9DP
         UWxzzQjMHGoAuZxAfAvsMXt+tGXC5nQ9A4hPbw62yi+kpJGWn1Nf3XzG+1SrgMt9TLMY
         b6sMtdecqbsSTKW9XyEM9WmowH1IjJDlSdMspTXYUkrsxqQn9ym03Vlk1W7jm53ZEzZp
         nrub3VCpuf8+L0tSNGwsEwNU/Nht/R82kLD90N7RtVyEipl7Eo4tVUUOmdkQoDJhp4Bj
         t8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xabRNS2BQJEG5BD6WSGNjR56n5s9fuV1/G3DJ/GNMyA=;
        fh=lOB+NE21i+DlK11xqGcqr6uTCV2U6X/qbNGHyNqUyZk=;
        b=YmSUeopTGdvjTW658fUn+Ct91tomw/M7HZX5ey7KHZp37Po61OkeZyemqC5lh/uQnl
         of7mJazXi7vpahJWQOf6wKpwjTghlUYm9cVJ9yRUk632k8K6dAap9k1NdcrCr6Qla7R8
         ZG7NhYtF7VdnicBC8tSjw1H75Qr5GMR9oQaWgQ8mUQFOShJoNH8AikzoB9O8SMSInM+M
         3HbrxT6nTAhlz6mqXIhycgOABorvyewLDgSo3nOHfuZZKSiw285jqvXTJ2RPc0Y9PS2h
         hj9gglZvb53WUyj+aHU4hH2qfRky19sRmtIskFjitypZAK9cmr7irgzWG2k8lO7gN0TH
         HCpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061524; x=1784666324; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xabRNS2BQJEG5BD6WSGNjR56n5s9fuV1/G3DJ/GNMyA=;
        b=FOJXzww2FWxTRoqsKx71QMTQuCJIV84nucXm3exi9Lgr88QCOKC3Jkp02hYvCu9W6q
         e7Zw3vmt53lwDTjtnGtD03M0BSTp804/cX91xO+vjFaKhrYU7QwQrmzfJJ8EEIvSjwv0
         d8MDeORnUVjSHm+Mlx3AGn/yXXMLZDBU+8CN9/SmCWsVBy8Q2zU8YbFB9qp+65FPe0jt
         7UC5rktJDAqjcbkhOYz8tZoB97U9+tdoXkB0YWxt6VDymlJVqYW2OcHKmllsun6QHoOd
         oMianXcnyFnEPZWib8u1qoVmhFenBFw0Dv2UyWOf63hmgkZXAhPg7XU8Hoq9ioGGsW6b
         uiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061524; x=1784666324;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xabRNS2BQJEG5BD6WSGNjR56n5s9fuV1/G3DJ/GNMyA=;
        b=lpa0ukt/XJtJPrznwzfzkq2IFXE8wB5Ni+ptFypvjY7Qyaw+ycDVZeyLZGbkLLthZy
         O9fahn+gV1DMV3BFj4krUfaI82BOo8AzUKishzTZZX0IF9cI5NcrR8UYuVjSOI9p7bms
         fWmiwd9wh5GnClbB38hblAJgg+65IFLS/zS98RFyzsivJ13y0ys1R1t5Ni/xQnKH5xoW
         63awkxD2Z7LsnlLLTsah6QLzjt8wEMP6BeL8ymNfJ7vG8jn+YwL1j4eXjz9bEtGhZ9bW
         hLestRECpUwR/yfZtbR1nxSh7Y2Cu6i1ZssySbCDKSqZdZVYU/7ASkTf1bx7BqZfdPBD
         MDFg==
X-Gm-Message-State: AOJu0Yw88Xl7L1PrFehw5sOgoYP9eYZS8FrJyD5+wa5hPpuCbNvGzy6q
	29RZfExRKyNic28UkjGEZ85zzOX5/B6S3lddXyidFCGI2iZ6AWc3TGRz32bnnE1AOj+R0wHK11o
	r5WG88sxa9IGBv0eeXYGAgVloJHuemNelpBtpTufxCA==
X-Gm-Gg: AfdE7cm22hhuEhXgOSgscx0nXw98TDEx9oLg8/uP8I6TUd+Jt/iErx9E6geZjmcmBWb
	4EuJUuMmBnAf/iZ4CHG/34wPOpMJHC4UwA91A+G9sZj9ILW1mZ6woz/QkcCdfVkC9KuoFp2CuDt
	QzGDQho5iXaE7aUCgfC0zDw74d7s/cFG/erZFTp0bdCVcBIxexI2tm9B8n+Gvlt1fl5Id2kiuzi
	ObU3kojHIiATroCv76g5kNED6KdsNWvid9F7s46SoNXTxOLVQGnFqKLmPUZ+OD5cwdq/JwFoQ==
X-Received: by 2002:a05:622a:8c3:b0:51c:1ec5:d11 with SMTP id
 d75a77b69052e-51cbf130085mr155321621cf.19.1784061524281; Tue, 14 Jul 2026
 13:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC+RaJKsKz0sUivGAQHXA@mail.gmail.com>
 <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com> <CAMq8zou2PAgGRp4xZsEQ0TBz7ScANnVxUJ8t-qrJ4pMe86zyQw@mail.gmail.com>
In-Reply-To: <CAMq8zou2PAgGRp4xZsEQ0TBz7ScANnVxUJ8t-qrJ4pMe86zyQw@mail.gmail.com>
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <aleksman4o@gmail.com>
Date: Tue, 14 Jul 2026 23:38:33 +0300
X-Gm-Features: AUfX_mw8Ckvrb-N9bWEjWfdosMlPPb_kkMAdEz2ieq3KFMRndF4taZ20BizE2lM
Message-ID: <CAMq8zovjF6zZfdB6UFzedEUNA6Yc_-0EhmmRjOYgVoLMFUG4-w@mail.gmail.com>
Subject: [PATCH 2/3] doc: document BasicServiceSet RSN property
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Describe the optional RSN dictionary and its KeyMgmt, Pairwise, and
Group entries.
---
 doc/basic-service-set.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
index f827ca02..b4f2486f 100644
--- a/doc/basic-service-set.txt
+++ b/doc/basic-service-set.txt
@@ -8,3 +8,26 @@ Object path /net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
 Properties string Address [readonly]

  MAC address of BSS
+
+ dict RSN [readonly, optional]
+
+ Security capabilities advertised in the RSN information
+ element. The dictionary contains the following entries:
+
+ array(string) KeyMgmt
+
+ Key management suites. Values use the same names as
+ the wpa_supplicant D-Bus BSS.RSN property, such as
+ "wpa-psk", "wpa-ft-psk", "sae", "ft-sae",
+ "wpa-eap", and "owe".
+
+ array(string) Pairwise
+
+ Pairwise ciphers. Possible values are "tkip",
+ "ccmp", "gcmp", "ccmp-256", and "gcmp-256".
+
+ string Group
+
+ Group cipher. Possible values are "wep40", "wep104",
+ "tkip", "ccmp", "gcmp", "ccmp-256", and
+ "gcmp-256".
-- 
2.55.0
