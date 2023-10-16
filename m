Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911E28E0E
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I69h7jPH"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3af609c3e74so3082984b6e.2
        for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697467381; x=1698072181; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GkdJPaOqkbndebiczz6y3IJ8wQgs5/AeJVEHq4FEbCI=;
        b=I69h7jPHbCkqCDYsC8dQ0mFAwPDqbaFPyi5uvuMDZMKB033f5DcvlO8vbS0Z7n+eW1
         KhBrjcmqSuIilSbjkTVCehxySIDy6sCUty8mXTDFu4IXJ6j+A4FyY4A3krc/lK2WhiFg
         v1WqEVC0Y8tr5/ZDVfzUwsPMQWGOoQU7PbnHIp2Q1cf4DHnYl8XhxH2TnEEfCcj4S5Eb
         xTNo1ZPi+fwc66bu0veFpZD0Wx32+G0jBPIwSvHK9CIgJq6ZEOI5TIQamNy0BEvIrcqG
         XugxFr6cjAuCnol/pnTBC7XGyVeqoX33MngVyrrChd3dKtagYr07On9tjBGC7Ts7Rm41
         mEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467381; x=1698072181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkdJPaOqkbndebiczz6y3IJ8wQgs5/AeJVEHq4FEbCI=;
        b=laIwVgXx5qwh1687kK0cSJgCiKxUuc/pH9nP81caMI1Uc/O6xUhAsG9SxK73wzBRLi
         2dfgEqoH25hq81Ts5/r+f0MozNR3rcm6RABJgCUhVonztOJNNKcTRF3rDd46AGbFa5yv
         mqiuquFYwraMi+qQL8DEPBtWDfI/psNjoQ2iHz3B4MIegbpTJmrsI64lH7QEz3Jix5ct
         9PT4KZO/F954WfMj271JMutGbLHHAX4rwxJM0Elbn2K5wov5h5H+qea6+Y9ezPIVimKN
         WUXQBHKcJac+0CAJkuBJg78PnTCu0Qqh+u+NReaeBcgrH0pnlbCGjhQ7ecCWdIYXHs8k
         /lNA==
X-Gm-Message-State: AOJu0YwQQFFmMRr/+SETekhe9X337Q9Ylp4EzC42BWv19ZILOXU4yfFg
	SNPN0j8YGrSUFd5Gvn1Fg7DRfA34jLk=
X-Google-Smtp-Source: AGHT+IFOqpsDBCXKevTzVo3FRfynU0Ybm+AayyyM7Zo6L8UKFF0T2weBUip6zv6xqcQjffho9nrh3Q==
X-Received: by 2002:a05:6808:1829:b0:3ab:84f0:b49d with SMTP id bh41-20020a056808182900b003ab84f0b49dmr48672777oib.3.1697467381420;
        Mon, 16 Oct 2023 07:43:01 -0700 (PDT)
Received: from LOCLAP699.vf-brampton.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id jt39-20020a05622aa02700b0041abcc69050sm3060363qtb.95.2023.10.16.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:43:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] iwmon: print HE capabilities element
Date: Mon, 16 Oct 2023 07:42:48 -0700
Message-Id: <20231016144248.33462-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a handler for the HE capabilities element and reworks the way
the MCS/NSS support bits are printed.

Now if the MCS support is 3 (unsupported) it won't be printed. This
makes the logs a bit shorter to read.
---
 monitor/nlmon.c | 112 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 26 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index a7ce2412..a4115a5b 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1394,31 +1394,22 @@ static void print_ie_ht_operation(unsigned int level, const char *label,
 }
 
 static void print_spatial_stream_map(unsigned int level, const char *label,
-					const uint8_t *map)
+					const uint8_t *map,
+					const char **stream_map)
 {
-	static const char *spatial_streams[] = {
-		"0 - MCS 0-7 supported",
-		"1 - MCS 0-8 supported",
-		"2 - MCS 0-9 supported",
-		"3 - No MCS support",
-	};
+	unsigned int i;
+	unsigned int j = 0;
 
-	print_attr(level + 1, "%s 1 Streams: %s", label,
-				spatial_streams[bit_field(map[0], 0, 2)]);
-	print_attr(level + 1, "%s 2 Streams: %s", label,
-				spatial_streams[bit_field(map[0], 2, 2)]);
-	print_attr(level + 1, "%s 3 Streams: %s", label,
-				spatial_streams[bit_field(map[0], 4, 2)]);
-	print_attr(level + 1, "%s 4 Streams: %s", label,
-				spatial_streams[bit_field(map[0], 6, 2)]);
-	print_attr(level + 1, "%s 5 Streams: %s", label,
-				spatial_streams[bit_field(map[1], 0, 2)]);
-	print_attr(level + 1, "%s 6 Streams: %s", label,
-				spatial_streams[bit_field(map[1], 2, 2)]);
-	print_attr(level + 1, "%s 7 Streams: %s", label,
-				spatial_streams[bit_field(map[1], 4, 2)]);
-	print_attr(level + 1, "%s 8 Streams: %s", label,
-				spatial_streams[bit_field(map[1], 6, 2)]);
+	for (i = 0; i < 8; i++, j += 2) {
+		unsigned int byte = (i < 4) ? 0 : 1;
+		uint8_t field = bit_field(map[byte], j % 8, 2);
+
+		if (field == 3)
+			continue;
+
+		print_attr(level + 1, "%s %u Streams: %s", label, i + 1,
+				stream_map[field]);
+	}
 }
 
 static void print_ie_vht_operation(unsigned int level, const char *label,
@@ -1430,6 +1421,13 @@ static void print_ie_vht_operation(unsigned int level, const char *label,
 		"2 - 160 Mhz",
 		"3 - 80+80 Mhz",
 	};
+
+	static const char *spatial_streams[] = {
+		"MCS 0-7 supported",
+		"MCS 0-8 supported",
+		"MCS 0-9 supported",
+	};
+
 	uint8_t *bytes = (uint8_t *) data;
 
 	if (size < 5) {
@@ -1443,7 +1441,8 @@ static void print_ie_vht_operation(unsigned int level, const char *label,
 	print_attr(level + 1, "Channel Center Frequency 1: %d", bytes[1]);
 	print_attr(level + 1, "Channel Center Frequency 2: %d", bytes[2]);
 
-	print_spatial_stream_map(level + 1, "Basic VHT-MCS", bytes + 3);
+	print_spatial_stream_map(level + 1, "Basic VHT-MCS", bytes + 3,
+					spatial_streams);
 }
 
 static const char *extended_capabilities_bitfield[80] = {
@@ -1656,6 +1655,13 @@ static void print_ie_vht_capabilities(unsigned int level,
 		[29] = "TX Antenna Pattern Consistency",
 		[30 ... 31] = "Extended NSS BW Support",
 	};
+
+	static const char *spatial_streams[] = {
+		"MCS 0-7 supported",
+		"MCS 0-8 supported",
+		"MCS 0-9 supported",
+	};
+
 	uint8_t info_mask[] = { 0xf0, 0x18, 0x78, 0x30 };
 
 	print_attr(level, "%s: len %u", label, size);
@@ -1666,16 +1672,68 @@ static void print_ie_vht_capabilities(unsigned int level,
 	print_ie_bitfield(level + 1, "VHT Capabilities Info", data, info_mask,
 				4, vht_capabilities_info_bitfield);
 
-	print_spatial_stream_map(level + 1, "RxVHT-MCS", data + 4);
+	print_spatial_stream_map(level + 1, "RxVHT-MCS", data + 4,
+					spatial_streams);
 	print_attr(level + 1, "Rx Highest Supported Long GI Data Rate: %d",
 			l_get_le16(data + 6) & 0x1f);
-	print_spatial_stream_map(level + 1, "TxVHT-MCS", data + 8);
+	print_spatial_stream_map(level + 1, "TxVHT-MCS", data + 8,
+					spatial_streams);
 	print_attr(level + 1, "Tx Highest Supported Long GI Data Rate: %d",
 			l_get_le16(data + 10) & 0x1f);
 	if (test_bit(data + 4, 61))
 		print_attr(level + 1, "VHT Extended NSS BW Capable");
 }
 
+static void print_ie_he_capabilities(unsigned int level,
+					const char *label,
+					const void *data, uint16_t size)
+{
+	const uint8_t *ptr = data;
+	uint8_t width_set = bit_field((ptr + 6)[0], 1, 7);
+	uint8_t mask = 0xff;
+
+	const char *he_channel_width_bitfield[] = {
+		[0] = "40MHz supported (2.4GHz)",
+		[1] = "40MHz/80MHz supported (5GHz/6GHz)",
+		[2] = "160MHz supported (5GHz/6GHz)",
+		[3] = "160MHz/80+80MHz supported (5GHz/6GHz)",
+		[4] = "242-tone RUs (2.4GHz)",
+		[5] = "242-tone RUs (5GHz/6GHz)",
+	};
+
+	static const char *spatial_streams[] = {
+		"MCS 0-7 supported",
+		"MCS 0-9 supported",
+		"MCS 0-11 supported",
+	};
+
+	print_attr(level, "%s: len %u", label, size);
+
+	print_ie_bitfield(level + 1, "HE supported channel width set",
+			&width_set, &mask, 1, he_channel_width_bitfield);
+
+	if (test_bit(&width_set, 1) || test_bit(&width_set, 0)) {
+		print_spatial_stream_map(level + 1, "Rx HE-MCS Map <= 80MHz",
+						data + 17, spatial_streams);
+		print_spatial_stream_map(level + 1, "Tx HE-MCS Map <= 80MHz",
+						data + 19, spatial_streams);
+	}
+
+	if (test_bit(&width_set, 2)) {
+		print_spatial_stream_map(level + 1, "Rx HE-MCS Map 160MHz",
+						data + 21, spatial_streams);
+		print_spatial_stream_map(level + 1, "Tx HE-MCS Map 160MHz",
+						data + 23, spatial_streams);
+	}
+
+	if (test_bit(&width_set, 3)) {
+		print_spatial_stream_map(level + 1, "Rx HE-MCS Map 80+80MHz",
+						data + 25, spatial_streams);
+		print_spatial_stream_map(level + 1, "Tx HE-MCS Map 80+80MHz",
+						data + 27, spatial_streams);
+	}
+}
+
 static void print_ie_rm_enabled_caps(unsigned int level,
 					const char *label,
 					const void *data, uint16_t size)
@@ -2430,6 +2488,8 @@ static struct attr_entry ie_entry[] = {
 		ATTR_CUSTOM,	{ .function = print_ie_ht_capabilities } },
 	{ IE_TYPE_VHT_CAPABILITIES,		"VHT Capabilities",
 		ATTR_CUSTOM,	{ .function = print_ie_vht_capabilities } },
+	{ IE_TYPE_HE_CAPABILITIES, 		"HE Capabilities",
+		ATTR_CUSTOM,	{ .function = print_ie_he_capabilities } },
 	{ IE_TYPE_RM_ENABLED_CAPABILITIES,	"RM Enabled Capabilities",
 		ATTR_CUSTOM,	{ .function = print_ie_rm_enabled_caps } },
 	{ IE_TYPE_INTERWORKING,			"Interworking",
-- 
2.25.1

