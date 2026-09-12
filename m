Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4A274B46
	for <iwd@lists.linux.dev>; Sat, 12 Sep 2026 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225080; cv=none; b=uvJgl4S8r3ABZOYPAJqvFCyy576/RcC1En2iKGHQU4KC6JaRyMs83XDJOayXx6B8tQIP2d1tS87By5VkRvMYyloxZyvJVnDMWG3C2J6/zT8vPcLTYyQn7Sa5luv4B7r7TgAbmkWWNWgClwDkkMFItM/W63kQHY8ra4wnYm8wsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225080; c=relaxed/simple;
	bh=biC+Q/ocH3vDfQ8O2DpAYCkZumWzzjKlNfYYXFm4zB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnRpRZpnpu0maW2FFKb5VfRvnmgLRSLZOnZAMAYLsXkZa8CG9sO5AanIZHkrNED3rLWyJDbrMACodTCiKA+QvCzlfZM3RuCDudC0MLs4jBYfEC5cQwDKGdYM49MGTFhgiBOyv8d1lXhBBlxpGmz+Y/EN/CcYznl+xQ2lHttCGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethzero.com; spf=pass smtp.mailfrom=ethzero.com; dkim=pass (2048-bit key) header.d=ethzero.com header.i=@ethzero.com header.b=ZQkWS+oZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethzero.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethzero.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethzero.com header.i=@ethzero.com header.b="ZQkWS+oZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-486e70f2457so880707f8f.2
        for <iwd@lists.linux.dev>; Sat, 12 Sep 2026 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ethzero.com; s=google; t=1789225073; x=1789829873; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDi7VhkQsxSQnJ5j21Mw6WSBklzdOYy46hj7f6eMRjI=;
        b=ZQkWS+oZB6abpVYbosenmUN4P7pG9j/NTU0L440d/Q/9gLkngWdRmyPJZSblPVpO8H
         0zDt/8ygpfJUe96J0l+q6GzwKlk3A91qZUc0zMhaDvxf24BBm5lDU8IFkUQBnFAnlChR
         DSy2gDfeCY3TNjGSFpL+OAGXIlESj4Zfv4d1kGGoHp9T/KHcAdVVQLFC0CfSVEQwUQHN
         rHX3ALD1S7Adl4kRIvbp6DaUnEdZ9G+YWGXGocIOxw6ZK3blRo5JxWV7dW8UNXH9/jRF
         DZTNj5GIlR1Nv++FiCHaNXiLYtFAiUmQf7HMo1D+uVBUM1YsOXSjNRIEAlMpiRROb0sc
         01pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789225073; x=1789829873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDi7VhkQsxSQnJ5j21Mw6WSBklzdOYy46hj7f6eMRjI=;
        b=IcbOXdaSm0IHE2qESoeGk5puBhJELd1smQ+qwQjgMOy03JkJbjEXzU/eb1pgISGRe+
         /ZKtkSsN6m7vgb4Mvf71m4W45hOCQLBgm0OBEyi+eJ5dtALZMXCKin7Buyrd3NpfUmgd
         Z1il/YyCZzCpv+LDQwKKqXaZihsGfRGR0b+2WGGsOv7VLgO6RHl8Df4ys4qsSYp0jqvg
         lvmjENsYHDxGaSJrk6Jk7oMhnWWt4YWW4rbt84U2MQP8WM6/8zlAftQl7G7OLD8UA0Mi
         dhRWI5JtqftGqpP1h2V75Xl2j4DGw/Er2HcDl16GXCR4K1hnnIf9wbFFAAbPSeehRKif
         It8g==
X-Gm-Message-State: AFuF++lgEE58UY2b7gR5jUZzal3/9NYYv+tbWQpUxbaZq+e1C23b6AZ4
	FFlKK/tcWYT0iIlBX7/5IYpaQyfKRvS/1y4/Sdy+oU+Jty9IHt76NBPVY5S2kmUUDM+JRh3j/zW
	0Q2e1adY=
X-Gm-Gg: AYBFou2LOZbF76TsdaXdRgtnfNyLc3bsJIONorXeilAr0ENDLsIANaWO/5DUB9nXEaM
	xPdgBVxynHxgOMGg/Mj7qnyy2B/FjW8+X4lWgB0Eg50jNvKpJ2cVQi42qJa9Ger0P9rHFSCpNEk
	77HRxUNTJfBQQANkNAxLvOF7++IL0kR/Dqa3yJko4boAS+CWTij3H1CazRfchGAI5pvA1/H8iZl
	jg0AmY67BuZ29NPVx6Pepsplqa5gOO0x+sIKkoHFYJbSrhGPkHlNyUaX92oFHyWHnkLhYZ097Nj
	w79+MX2hqv0cHfBmQzs31VqTTgN3a7Q0ECRn1Du7RvAgcqG4Wr4XMUbnJA2NXwvKRGc8qZ0ghQp
	V9rhKYN6QIN1NZS3d0E5IZq0MM/sAmd8gzeTxxXqsy5DZ/bhBNeOi5gNDOAzvxSrNEq5E6gZjoZ
	FBSKahKQVVFttHVjSwIQabRYpFBpoHmKux0soy6kLgC/CyHt6Bh7WVZorDt/2BXMFi+QPRele9X
	y+Z/RX75oQ2h6QPZQUH7r8fUIciEQ==
X-Received: by 2002:adf:e00f:0:10b0:486:e2e8:bda0 with SMTP id ffacd0b85a97d-486eb3568a2mr6976940f8f.46.1789225073397;
        Sat, 12 Sep 2026 07:57:53 -0700 (PDT)
Received: from oya.ethzero.com (mobiledyn-62-240-135-28.mrsn.it. [62.240.135.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb36e4a6sm14088487f8f.37.2026.09.12.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 07:57:53 -0700 (PDT)
From: Alessandro Di Marco <dmr@ethzero.com>
To: iwd@lists.linux.dev
Cc: Alessandro Di Marco <dmr@ethzero.com>
Subject: [PATCH] netdev: initialize RSSI polling station info
Date: Sat, 12 Sep 2026 16:57:31 +0200
Message-ID: <20260912145731.234249-1-dmr@ethzero.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_rssi_poll_cb() uses netdev_parse_sta_info() and then checks
have_cur_rssi. If NL80211_STA_INFO_SIGNAL is not present in the
response, the parser leaves this field untouched.

Initialize the diagnostic station info before parsing, matching
netdev_get_station_cb().

Fixes: 08de8186c6f2 ("netdev: update RSSI polling to use station info parser")
---
 src/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index e639a1f8..a4cb06d4 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -735,6 +735,8 @@ static void netdev_rssi_poll_cb(struct l_genl_msg *msg, void *user_data)
 	if (!l_genl_attr_init(&attr, msg))
 		goto done;
 
+	memset(&info, 0, sizeof(info));
+
 	found = false;
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		if (type != NL80211_ATTR_STA_INFO)
-- 
2.55.0

