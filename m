Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621425;
	b=AxUXHYxvCD8qjq7JzmU337wS7FBl4yKGbBR83OMiwtF6XDQ11ydvYQ4tL16nw18Cy5oI
	 BxHvTH8c8RLxdzmSITsC8nQ4bYxmR4Os0ulUpnEYXPWQ1Qk440KGKI/ctTd/Sv9TwkbVK
	 xcMwkKPGHb36l4zPp770V6CypHbU/oz6+Z4VD/wXJNreOYUmky/bEEuAcQEPJHbsmIDJF
	 znfgGEjnA9xknAjI5sMDRQ8fosn/FxiYBQE//gd021mqO2Uqhc9DTvxStvGbyJWAN6VNi
	 QdXZnDCqKvqVb9g+tD91W3OzGo1AyyeeLPPibmd4A3D7Sk97Lrv6Ll3JGHhda1V3VKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=94eGL8YcbOD74GTvLEcM6uZ9hYr75YXgDFNbaSqOkBA=;
	b=3+hRXBUlF/5eJMvR3Dfdr5bCT06VIBG2OFJ44QsGsFwJUYZkneCOwevgOnNDoPGNj83w
	 3fq1IGJn768H1uPlG1b16vBGXOgDnzwsob9RfZNQzEuDjPof5xh0fFkX0SJ34lchfwUXy
	 nbR0mUJXoAZgx49xVB8ZXS3avuwlkkZ00+kPX/L9shRsDj0/oOWx1+rY5nxABf8kzgjBP
	 GCPM2KGBmalGe8D+1N627Y2tw2xplUs42f3WPLSGKG4qpbME3Fjh7qWeyh3J0RXFSfdxc
	 +J986TNny1eifcyGKIHR3jfSVBHOvP+xPUTF0AXL6iZ+do+VCrKIUyX4P2DpR8k1pjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blender.org;
	spf=pass smtp.mailfrom=blender.org;
	dkim=pass header.d=blender.org header.i=@blender.org header.a=rsa-sha256 header.s=google header.b=ec73ppcA;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94B606A319
	for <iwd@lists.linux.dev>; Wed, 21 Oct 2026 22:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE94B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blender.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blender.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blender.org header.i=@blender.org header.a=rsa-sha256 header.s=google header.b=ec73ppcA
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8439fe796ebso808163a34.3
        for <iwd@lists.linux.dev>; Wed, 21 Oct 2026 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blender.org; s=google; t=1792621424; x=1793226224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=94eGL8YcbOD74GTvLEcM6uZ9hYr75YXgDFNbaSqOkBA=;
        b=ec73ppcAvVT4eyLBZvHdUsDT6NgAq/XdyqalKBH+gozBKv671SUpvY4meVsx85DpY2
         NiqWFkHZUviy5+gok5tCdwS2meP70fbHtrd4O7ubaie9bWcphnohGWUN8yjUwV/qt2FT
         Leo/dcXMqrRlUvc+2Ug9u+F3vnTv8ZJjkPV5UkzDG9UGp7o5+hmwHDQUEM8UmgT5UZer
         XVHBO//kOM558gddfDfsTEkK2d2MkRSVAbhVwmEyAGb8vczijoC5PqEa4ovNhbAfLA9Q
         QbmNnvvnugMQaL1wvsoCRL26Zh7WaUVu/Ebvz5RiDforNaG6KYnzoVQsNUr27i9Xl8pI
         Aa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792621424; x=1793226224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=94eGL8YcbOD74GTvLEcM6uZ9hYr75YXgDFNbaSqOkBA=;
        b=zPhMT+J8PHWJgraNEwNBrkopAuAm5QURqneyesKxnTbgHRlVhAI0FXnYWmsi8dYQTH
         XoTy0q93R4Fvqo1w9NqT4jjepSm9SO4xZGvzuy6a1mskz3T7ihtQNYi8KZ3vBCw+QXS/
         sBkTlglREmunRpVjNDemfsvCC2kfbwvJH5kWkGDjdYW3qiK/uD3iQACJm8y7O9VkmOC5
         SGmRLaG+oD0qKgq8/7qnoxAAmik4PbMUrSSqQipAEzs/LMzYYfZwQ4vHvB9vmvQQ3SIe
         IvT7JMs1rE7yRPFfSHqbyZccchWULD0kfnp+H3GvPHhQ9vcLGzVntiqsYDRZ/saAHkYf
         PzUg==
X-Gm-Message-State: AFq9FYJ2sj/cTQ6jrbaf5Crax2jCyCqjpqpcgvZwOd4ntRu8aTpj/lAH
	1cGzPPd6L/xYKTq0Bn3lR3Er199CT+tKWxOMXRYVva6PckTK0sQZbviQu8b3y3A7RDC6xLoY6pu
	SPUcZ
X-Gm-Gg: AYBFou3TumYK6C6DW8STDmNtLWFYyaclIZ5RUlWddwsfQqhCp7mRkwGM3J/h9wvP7hz
	vBUL7BYpa+KzRSLtTxCrwvo/Ax1X9KaV3bGn3+Vro2MFwlqfv4xm3brmAVmw6JK1qC32SbH92kf
	jciNaDxtTabpJtZR8bpNhX2jsbxZLoXAnF1COJEXRINApHo30jFxf+P0PDRf8uJp2ki2Hw4hX6G
	EM/0D+0FXMit5nHbCwMwxE2NNq3lX0KgUd4iu2vuYA2V42UfG/TNL0+BZDHlIHtPbgOuRFgEzJl
	IINK0IQapyJ9EtWgHdHFm+aJOE8vypO/QbMhUObmu1EA9TfG1Pa5rQ6i2oxUuUxt7c6luyt6/ah
	u+0C3tgFr/uuFB6EeAHuUOlPlL9elJO7cu7NFDyjrxveRSNnR5Fqr8tAYpzw8K0FwY9sydeHfje
	Qpf8WxvvjzXqB8s6g5aOVw92HDpXQy8IgMAhYSCn4ckrJaPBIR+GMqXIclWIHOfvtzhhNX+PMKl
	vpeHMZSq8bAH95RulBdKjqdITucwKdVc3Ig5+KbgnvnpRHSTzKSgFZEJtwC/PkMpCIS0VIJF9s1
	phqaSuJ2UcsXfFbrUhQum4ph
X-Received: by 2002:a05:6830:917:b0:81b:9d18:75a with SMTP id 46e09a7af769-84d08d01f5amr2657461a34.21.1792621423895;
        Wed, 21 Oct 2026 15:23:43 -0700 (PDT)
Received: from kii.uchicago.edu ([192.5.85.175])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cba7d46fbsm3504882a34.3.2026.10.21.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:23:43 -0700 (PDT)
From: John Kiril Swenson <john@blender.org>
To: iwd@lists.linux.dev
Cc: John Kiril Swenson <john@blender.org>
Subject: [PATCH] eap-peap: Fix misdetection of EAP-Extensions
Date: Wed, 21 Oct 2026 17:22:38 -0500
Message-ID: <20261021222238.10363-1-john@blender.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In PEAPv0, only EAP-Extensions requests carry a full header, the rest
are headerless. This code only detected EAP-Extensions by checking
pkt[4] which did not consider some headerless cases.

For instance, a headerless MSCHAPv2 Challenge has the low byte of
MS-Length at this byte. With a 12 character Name field MS-Length ends up
being exactly 33 = 0x21, the same as EAP_TYPE_EXTENSIONS, so this code
is fooled and drops the packet when it sees there is no matching
EAP_CODE_REQUEST.

To fix, _only_ treat the packet as EAP-Extensions if ALL code, length
and type match. This happens to do the same thing that wpa_supplicant
does (which works correctly).
---
Ran into this connecting to eduroam at UChicago with my alma mater's
(UMN) account where wpa_supplicant worked but iwd didn't. 

 src/eap-peap.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 4559066..8d71bc1 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -507,17 +507,14 @@ static bool eap_peap_tunnel_handle_request(struct eap_state *eap,
 	struct peap_state *peap_state;
 	uint8_t id;
 
-	if (len > 4 && pkt[4] == EAP_TYPE_EXTENSIONS) {
-		uint16_t pkt_len;
-		uint8_t code = pkt[0];
-
-		if (code != EAP_CODE_REQUEST)
-			return false;
-
-		pkt_len = l_get_be16(pkt + 2);
-		if (pkt_len != len)
-			return false;
-
+	/*
+	 * A headerless PEAPv0 packet, e.g. an MSCHAPv2 Challenge, can also
+	 * have EAP_TYPE_EXTENSIONS at offset 4 by sheer coincidence,
+	 * so check the whole header.
+	 */
+	if (len > 4 && pkt[4] == EAP_TYPE_EXTENSIONS &&
+			pkt[0] == EAP_CODE_REQUEST &&
+			l_get_be16(pkt + 2) == len) {
 		id = pkt[1];
 
 		eap_extensions_handle_request(eap, id,
-- 
2.55.0

