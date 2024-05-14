Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B24139589
	for <iwd@lists.linux.dev>; Tue, 14 May 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696373; cv=none; b=IqRxOQFC4hS71eAT0QDf8KAB1OOrS7nwADvn+/QY1BGcLFMn83j9RpzGJwrh3zOzXoKeRYB5XzijK9YkIG1BcFvf1f/K6MR2bSDapdOLeMm31XDRmvfE3DkV+twB3uPwmz3ktiOpQm1/8S4Olt1yv4ucewIoWI9ReBwuJOHEIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696373; c=relaxed/simple;
	bh=LQTK71j74/BzISZNk9MAR2Jasf7z9BFxfLCQpRl9QxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qCqSvuUuaYyMF3nRAEV/yHbUTfWwjWqdzLq4dYDDGeCzArT9vG2yV7GigMLwgEK/eEJqwkbG+SuwX4VVY5UVk3KVi8jOAHsF6QnjrKEV3C544bZIfpIfsXZNSOoDFswbE7L66KXdYbRPcvHzRUc90LKkxfa5MRDcMrYsGW9uKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO2XFv08; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO2XFv08"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so36103425e9.2
        for <iwd@lists.linux.dev>; Tue, 14 May 2024 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715696369; x=1716301169; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4519cry0Iw6LkbE+i6nxT0awlm0XMxXWFbxF1HDBDk=;
        b=SO2XFv08qEJD8yKFDVxSs/gXT5FJlreaxBiNs3s+OUrCOW1IPrMjejp0garLW+gMD5
         jgn3nCmWSMfWYQKfSlxS/Zi6DJLvkPEVkQ9tcmA9J1lzZ3osK7R0W9UicOzW37BCVrGV
         vqFeQKbAvcdZ00BK9pEPVaBzL3N0vsFQ2lwNxRuOrOt7Z1BhXw5iub1drO6M10dR4lBJ
         GC+0635+svz7owdZQIwvJP5D4cW4HfTqqXmPUd5GUV/uJKArUxdbfCHpDaipalGCkOoi
         vQ/spC73btb4FCEUiszE9fvOcUY28ay2iJnqqIOOLhxGBBqlTqBwOuBz6b7/eD5fgOwJ
         TL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715696369; x=1716301169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4519cry0Iw6LkbE+i6nxT0awlm0XMxXWFbxF1HDBDk=;
        b=TGmzOSez95LcLJOPTM1OCktiOElQVtSMuRtAbX+BqTP9rlGHyLG64OzvsqlCDMfJz8
         IpshBpc5ZxZlcChMAmimjO6IpYWoNuiZLhQVrEmkA9yHSwdH385zPeilkR+S5NK3+Rhp
         QNNEfh8xhJxiZHZwS19zWpDTE4SsKcGtaZ5NwLjfLX4JddcHsA6eqX9WSbVo/0hx5yvv
         9Da49Kx8++TajIkTR9o2v4cKMhzol7HzPuc5AxNmBTDs7KlEniJxCqvVktFsK3h7QcH/
         2X0yBZ/+VpgH7hI1VEjn2atO0KeEZVSTV2gYZB/f0FpX5YKCCvzQcOGoXQ4n6+DecjwS
         1sbw==
X-Gm-Message-State: AOJu0YzNzSUtSFbBh0mgsA1hUt3ZeGmI82V/4xArOffUa2OBla9MXfak
	07D/iSxt9NpqeRGS74XdaEniIExuayint3h/qLNTvEkleiXvXpp9IeRNrY3D
X-Google-Smtp-Source: AGHT+IHsvEv/KSPY+PbeiDEt+PncJDQsZEYWxCE405f9gDFc2uggvg0NJJpmKDenf5mpcI9c18utRA==
X-Received: by 2002:a05:600c:4e0b:b0:420:12af:c759 with SMTP id 5b1f17b1804b1-42012afc9bfmr58172715e9.9.1715696369273;
        Tue, 14 May 2024 07:19:29 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f9ffe26acsm153448085e9.1.2024.05.14.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:19:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] band: support band lookup fallback for buggy APs
Date: Tue, 14 May 2024 07:19:22 -0700
Message-Id: <20240514141923.291148-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its been seen that some vendors incorrectly set the 3rd byte of the
country code which causes the band lookup to fail with the provided
operating class. This isn't compliant with the spec, but its been
seen out in the wild and it causes IWD to behave poorly, specifically
with roaming since it cannot parse neighbor reports. This then
requires IWD to do a full scan on each roam.

Instead of a hard rejection, IWD can instead attempt to determine
the band by ignoring that 3rd byte and only use the alpha2 string.
This makes IWD slightly less strict but at the advantage of not being
crippled when exposed to poor AP configurations.
---
 src/band.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/src/band.c b/src/band.c
index 906d6197..6891d06c 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1485,15 +1485,48 @@ static const uint8_t oper_class_cn_to_global[] = {
 	/* 128 - 130 is a 1 to 1 mapping */
 };
 
-enum band_freq band_oper_class_to_band(const uint8_t *country,
-					uint8_t oper_class)
+/*
+ * Annex C describes the country string encoding.
+ *
+ * If it is a country, the first two octets of this string is the two character
+ * country code as described in document ISO 3166-1. The third octet is one of
+ * the following:
+ *  1. an ASCII space character, if the regulations under which the station is
+ *     operating encompass all environments for the current frequency band in
+ *     the country,
+ *  2. an ASCII 'O' character, if the regulations under which the station is
+ *     operating are for an outdoor environment only, or
+ *  3. an ASCII 'I' character, if the regulations under which the station is
+ *     operating are for an indoor environment only.
+ *  4. an ASCII 'X' character, if the station is operating under a noncountry
+ *     entity. The first two octets of the noncountry entity is two ASCII 'XX'
+ *     characters.
+ *  5. the hexadecimal representation of the Operating Class table number
+ *     currently in use, from the set of tables defined in Annex E, e.g.,
+ *     Table E-1 is represented as x'01'.
+ */
+static enum band_freq oper_class_to_band(const uint8_t *country,
+					uint8_t oper_class,
+					bool ignore_country3)
 {
 	unsigned int i;
 	int table = 0;
 
-	if (country && country[2] >= 1 && country[2] <= 5)
+	/*
+	 * If a country is set, and the 3rd byte maps to some E-* table in the
+	 * spec use that (case 5). Only caveat here is some APs erroneously set
+	 * this 3rd byte. To work around we can fall back to case 1, where only
+	 * the first two characters are used to lookup the table.
+	 */
+	if (!ignore_country3 && country && country[2] >= 1 && country[2] <= 5)
 		table = country[2];
 	else if (country) {
+		/*
+		 * Assuming case 1, although its unlikely you would handle
+		 * cases 2 (O) or 3 (I) any differently. Case 4 (X) is unlikely
+		 * and we really wouldn't have enough information to correctly
+		 * determine the band in some obscure non-country domain.
+		 */
 		for (i = 0; i < L_ARRAY_SIZE(oper_class_us_codes); i++)
 			if (!memcmp(oper_class_us_codes[i], country, 2)) {
 				/* Use table E-1 */
@@ -1542,6 +1575,25 @@ enum band_freq band_oper_class_to_band(const uint8_t *country,
 		return 0;
 }
 
+enum band_freq band_oper_class_to_band(const uint8_t *country,
+					uint8_t oper_class)
+{
+	enum band_freq band = oper_class_to_band(country, oper_class, false);
+	if (!band) {
+		/* Fallback with no country string won't change anything */
+		if (!country)
+			return 0;
+
+		l_warn("Failed to find band with country string '%c%c %u' and "
+			"oper class %u, trying fallback",
+			country[0], country[1], country[2], oper_class);
+
+		return oper_class_to_band(country, oper_class, true);
+	}
+
+	return band;
+}
+
 const char *band_chandef_width_to_string(enum band_chandef_width width)
 {
 	switch (width) {
-- 
2.34.1

