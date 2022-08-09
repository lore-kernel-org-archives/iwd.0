Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A54403
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 21:04:51 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id d20so11887356pfq.5
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kYN+Bt6ubs5UZ8VJ7OI/SJmuCj8HLQ/+k/GoGL/o8Ho=;
        b=UgJaC/YttuSpx7IuYowEUG/NEl6A/kP6uLCshpV5D7Fx/+xwP0ri+F2SNOQGCPTWth
         i0/BIsMHsoqPGhjgGrg9ObeMiKo6MONGhul2wol8aRYfc5O3SS5IJPGwEU7hYU3fv5/M
         nPxMzPMMRyDW/Ox5kLU6I0sufFK/Nkrylm/7YiYHnzWa2/VfEMjhsvaztdcdc5mqfch3
         ss8MH2B1GFNwW4TV+pBlhDAGfu+tbwZdyW8ny99K4cXPsvKci8CTVABLJt+74iQjJJLW
         GHlpYAjIF7vHDaTBKxG73yFVcIlFOaYHmce7a4DiZON1CJHFqVj2Eb0zRQDCVcx/+IFt
         Xkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kYN+Bt6ubs5UZ8VJ7OI/SJmuCj8HLQ/+k/GoGL/o8Ho=;
        b=ThVhjT4fHXdYUfLKBCrUQmNuzJ1W7TBVnVqJWwu4oX8B7kzjDKrdfI4aXW2+hNfnqI
         NNzYy+XPwI9Yx4N4ME8NX883PStuH844uDf0pwAqHflnsvQqraF7+MBs0Ttox1+H5LLa
         QpuumTgLDowaRxlzIAd4k2fp7oeZkWdbCsUYtQywkpZiUX+83awmnbhVCty4Phc3OPy7
         B1vfcrUQgOxLUW2qOYkGN9AY4FvC9IlwhOZrE762dEquOtk+SPBfjvQMrEO+g0kb4A8m
         e1IhwYK8KT30SqqUHGaP1DBh1qoCAbDlv/tk1pL6hYbApMd9pktmsZ3mObmUyzGIndRS
         xQAg==
X-Gm-Message-State: ACgBeo0ifTGjtwmeEj8nXYpcPGqP1hY5dsYE+iz51zsXDhx6HzZHVqmJ
	QKz4B1dOT71LqDbpZWSNqdSEpBMsFeU=
X-Google-Smtp-Source: AA6agR4va5a/mGqWp8ASWahGX84GDSIO4A8Za1T7Xr9dIXgEMgDtkUGI3tTWB/42cAA8nwewQHK2AQ==
X-Received: by 2002:a05:6a00:aca:b0:52b:bd66:8c94 with SMTP id c10-20020a056a000aca00b0052bbd668c94mr24643495pfl.3.1660079090828;
        Tue, 09 Aug 2022 14:04:50 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902904800b0016d23e941f2sm11161706plz.258.2022.08.09.14.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:04:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] monitor: parse RNR element
Date: Tue,  9 Aug 2022 14:04:46 -0700
Message-Id: <20220809210449.158256-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 34c5eed6..54aaa465 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2278,6 +2278,121 @@ static void print_rsnx(unsigned int level, const char *label,
 		print_attr(level + 1, "SAE Hash-to-Element");
 }
 
+static void print_bss_parameters(unsigned int level, uint8_t parameters)
+{
+	print_attr(level, "BSS Parameters");
+
+	if (test_bit(&parameters, 0))
+		print_attr(level + 1, "OCT Recommended");
+
+	if (test_bit(&parameters, 1))
+		print_attr(level + 1, "Same SSID");
+
+	if (test_bit(&parameters, 2))
+		print_attr(level + 1, "Multiple BSSID");
+
+	if (test_bit(&parameters, 3))
+		print_attr(level + 1, "Transmitted BSSID");
+
+	if (test_bit(&parameters, 4))
+		print_attr(level + 1, "2.4/5GHz Co-Located ESS member");
+
+	if (test_bit(&parameters, 5))
+		print_attr(level + 1, "Unsolicited Probe Responses Active");
+
+	if (test_bit(&parameters, 6))
+		print_attr(level + 1, "Co-Located AP");
+}
+
+static void print_reduced_neighbor_report(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const uint8_t *ptr = data;
+	unsigned int field_count = 0;
+
+	print_attr(level, "%s", label);
+
+	if (size < 5) {
+		print_attr(level + 1, "error parsing");
+		return;
+	}
+
+	level++;
+
+	while (ptr < (uint8_t *)data + size) {
+		uint16_t hdr = l_get_le16(ptr);
+		uint8_t oper = l_get_u8(ptr + 2);
+		uint8_t chan = l_get_u8(ptr + 3);
+		uint8_t count = bit_field((uint8_t)(hdr & 0xff), 4, 4);
+		uint8_t type = bit_field((uint8_t)(hdr & 0xff), 0, 2);
+		uint8_t filtered = test_bit(&hdr, 2);
+		uint8_t info_size = (hdr & 0xff00) >> 8;
+		uint8_t i;
+
+		ptr += 4;
+
+		print_attr(level, "Field #%u", field_count);
+
+		/* TBTT Information Header */
+		print_attr(level + 1, "Info Field Type: %u", type);
+		print_attr(level + 1, "Filtered Neighbor AP: %u", filtered);
+		print_attr(level + 1, "Information Count: %u", count);
+		print_attr(level + 1, "Information Length: %u", info_size);
+
+		print_attr(level + 1, "Operating Class: %u", oper);
+		print_attr(level + 1, "Channel: %u", chan);
+
+		level++;
+
+		/* Information Set(s) */
+		for (i = 0; i <= count; i++) {
+			const uint8_t *info = ptr;
+
+			if (info + info_size > (uint8_t *)data + size ||
+					info_size == 0 || info_size == 3 ||
+					info_size == 4 || info_size == 10) {
+				print_attr(level + 1, "error parsing");
+				return;
+			}
+
+			print_attr(level, "Information Set #%u", i);
+
+			if (info_size >= 1)
+				print_attr(level + 1,
+						"Neighbor TBTT Offset: %u TU's",
+						l_get_u8(info++));
+
+			if (info_size >= 7) {
+				print_attr(level + 1, "BSSID: "MAC,
+						MAC_STR(info));
+				info += 6;
+			}
+
+			if (info_size == 5 || info_size == 6 ||
+					info_size >= 11) {
+				print_attr(level + 1, "Short SSID: %08x",
+						l_get_u32(info));
+				info += 4;
+			}
+
+			if (info_size == 2 || info_size == 6 ||
+					info_size == 8 || info_size == 9 ||
+					info_size >= 12)
+				print_bss_parameters(level + 1, *info++);
+
+			if (info_size == 9 || info_size >= 13)
+				print_attr(level + 1, "20 MHz PSD: %d",
+						(int8_t)*info++);
+
+			ptr += info_size;
+		}
+
+		level--;
+
+		field_count++;
+	}
+}
+
 static struct attr_entry ie_entry[] = {
 	{ IE_TYPE_SSID,				"SSID",
 		ATTR_CUSTOM,	{ .function = print_ie_ssid } },
@@ -2340,6 +2455,8 @@ static struct attr_entry ie_entry[] = {
 		ATTR_CUSTOM,	{ .function = print_fast_bss_transition } },
 	{ IE_TYPE_MOBILITY_DOMAIN,		"Mobility Domain",
 		ATTR_CUSTOM,	{ .function = print_mobility_domain } },
+	{ IE_TYPE_REDUCED_NEIGHBOR_REPORT,	"Reduced Neighbor Report",
+		ATTR_CUSTOM,	{ .function = print_reduced_neighbor_report } },
 	{ IE_TYPE_RSNX,				"RSNX",
 		ATTR_CUSTOM,	{ .function = print_rsnx } },
 	{ },
-- 
2.34.3

