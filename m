Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70118593A
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429345; cv=none; b=f/+7UvNWWLOidIpzQMvJkPHFahZyWi2x/A2K6Jcawta79j88upjbl0jRIwTRfAFXwsUv2Qujq75vjOD0ch//7gj/urffX7Ol5itknYz2mWKkEqKrWuT8jCHZaECCpjWFmZY1LXo1eFKSgNctbTvsdPLQkuY3mv43MF9ghUxSD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429345; c=relaxed/simple;
	bh=4jpHMWzGBI290rcbQ5ImOXYnSJUoFg2NKaX2QC6N4yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4mkfWYaT1QYlvTnfZckVDyGSsRa7IWGhYg3DKngGVdC1qyUdGs/0I9ZuySxJZKYv8eAnc/b2G0r7tpbZ50+Ta4NFh4fFiPvaswbZrV6OHtG3dkUkaki7a91vp5UlEjjcr2mH2X3K6WKm5N/PjZiL1f9QCyJP4oMUZap00xfC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT+9cgQr; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT+9cgQr"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-270420e231aso1436058fac.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429343; x=1725034143; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XP9KeFwtjHU6wlD3XjFZLpdG9NSs4YavtLDZyR9Dh1c=;
        b=NT+9cgQrYBW2TRLL+8ZfVzOr9vjaxmTx3kTw2ERy62uB0sagnM44KE9vH6yp7cWrdk
         k7mVBtZYLGAkjaYBwnfm1vcaAtULJ3l6LZgp8RhQmFlc5eBwLHP4AJ9odQt9Z/bgzP5g
         IPFhKoaP3n96iw7b2xc+P1dDA2898kz1psziomn8JWQY7NDE3J9Z9SealnisIm1P9PO8
         b2nU6s58L+RY/578GdBGwqqY+kKFI/LXlXGJF8sV/Nj80Da1hPzDlBw+udr/at2RmekX
         9NWkPzbYimJ9e0elMERprfos2BqxL9/RIR8UzctDqd4wcHy178a/kqLAP3L5vyptC5fH
         7PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429343; x=1725034143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XP9KeFwtjHU6wlD3XjFZLpdG9NSs4YavtLDZyR9Dh1c=;
        b=OqS//MuWy3ItY5idMEVERNRNfWh95s5/C8Fh/7orbdwxqp4X3mJbKY0nTHxTfidw0L
         z8zZDfy6ZP5QEBDMVH/LldGyeFJf5tcBQ21DTqgE7cKEd95qmYJtLhw9yjOreBkwgUj+
         axnQkz6sFdSgp3+mFT8l+K+NlmIgkhL7Dq/gpfdbFpYncJvdUO6eChZChUxdFKi1UFA9
         xVzwK3XuQLvj8bSTqXWlwJgUhIEErGfK0AVtw2wefFGl9+UDgCZSc5DUef39yMnFGjhW
         Mj19wWXqK6zEvIvSxN6ohhtFlsaRaGAeD2vkPYa4y8p5dlOeXeNh0rJ/t00l1leAzGaH
         D9Fg==
X-Gm-Message-State: AOJu0YyY8lwIP7vEGD93lIdjQW39Vs8yvigfSrVIvNQ3syo/uL3qpf+c
	Pa58GTVWwgKLHjLmk/o1+sjAFWaGZqGbgw1HUPibmxBekdHwCDojE+CAcQ==
X-Google-Smtp-Source: AGHT+IEUbjttjMFwarYDqQj8PeXUvUbV8uSdGloUFaNlLP7ksFT6oi1m5uIa4MQiUKPgOVh0zYxVrA==
X-Received: by 2002:a05:6870:2182:b0:25e:c013:a7fb with SMTP id 586e51a60fabf-273e669b009mr2770429fac.43.1724429342879;
        Fri, 23 Aug 2024 09:09:02 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273ce9e0952sm932755fac.13.2024.08.23.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:09:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] monitor: Print rmnet flags
Date: Fri, 23 Aug 2024 11:08:48 -0500
Message-ID: <20240823160901.474421-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 214246ea72c2..fdf16fbe7a04 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -37,6 +37,7 @@
 #include <linux/if.h>
 #include <linux/if_packet.h>
 #include <linux/if_ether.h>
+#include <linux/if_link.h>
 #include <linux/netlink.h>
 #include <linux/genetlink.h>
 #include <linux/rtnetlink.h>
@@ -7597,8 +7598,43 @@ static void flags_str(const struct flag_names *table,
 	pos += sprintf(str + pos, "]");
 }
 
+static void print_rmnet_flags(unsigned int indent,
+					const char *label, uint32_t flags)
+{
+	if (flags & RMNET_FLAGS_INGRESS_DEAGGREGATION)
+		print_attr(indent, "%s:%s", label, "deaggregation");
+	if (flags & RMNET_FLAGS_INGRESS_MAP_COMMANDS)
+		print_attr(indent, "%s:%s", label, "map commands");
+	if (flags & RMNET_FLAGS_INGRESS_MAP_CKSUMV4)
+		print_attr(indent, "%s:%s", label, "ingress_mapv4");
+	if (flags & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
+		print_attr(indent, "%s:%s", label, "egress_mapv4");
+	if (flags & RMNET_FLAGS_INGRESS_MAP_CKSUMV5)
+		print_attr(indent, "%s:%s", label, "ingress_mapv5");
+	if (flags & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
+		print_attr(indent, "%s:%s", label, "egress_mapv5");
+}
+
+static void print_ifla_rmnet_flags(unsigned int indent, const char *str,
+						const void *buf, uint16_t size)
+{
+	struct ifla_rmnet_flags flags;
+
+	if (size != 8) {
+		printf("malformed packet\n");
+		return;
+	}
+
+	memcpy(&flags, buf, size);
+
+	print_rmnet_flags(indent + 1, "Flags", flags.flags);
+	print_rmnet_flags(indent + 1, "Mask", flags.mask);
+}
+
 static struct attr_entry link_info_data_entry[] = {
 	{ IFLA_RMNET_MUX_ID,	"RMNet Mux Id",		ATTR_U16 },
+	{ IFLA_RMNET_FLAGS,	"RMNet Flags",		ATTR_CUSTOM,
+					{ .function = print_ifla_rmnet_flags } },
 	{ },
 };
 
-- 
2.45.2

