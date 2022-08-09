Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1D33C4
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 18:48:10 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so11719904pjm.3
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kYN+Bt6ubs5UZ8VJ7OI/SJmuCj8HLQ/+k/GoGL/o8Ho=;
        b=L6RwZ3KYwVzIYXH+XtIO41Zj+ommRNpIWreDE+LOCb8Te4s8pQcjGcRjzUfje9ruYN
         iX5dWBK6VT46+xWkSOsSIb2DaFyxU466JX3sDGcztwL+8wc+vQ/113NzdjrR+yL2qNf+
         eHtnNtmhYdHuRdnKcCGO+mtD4oTVUlcckzKu91Wx8U8Rftt3Vb0eRL3NphgYOv2qxZ0B
         kcV/LnLr5OxyVGyIoVd3Nk83cxbiO7Sq+p/pzhQTqvHRTE0AyeBvdYAduwgMSm2bRQXY
         gsEL72wr0xXPhl4o2+Zw35xMwp9HEQU8iXmCgnjjOnQ6tQ5rwTWrAIi46pnebnGIpvSd
         dLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kYN+Bt6ubs5UZ8VJ7OI/SJmuCj8HLQ/+k/GoGL/o8Ho=;
        b=i9+ZPBqXhyOwFEvWn2ekA+61/b3lzPB6SUEuLLprEZCOBXcKaPLgfbsFQjfCxzUvkY
         yVwVE/aFb1jUssNIwryEAqV9WTEvjcTONsGTcnJB7uKcHV5hoyvFHLnFGKhH7is0Vt51
         rzEoig3zNayd+r9F2xJM1K1vA+s0TGRTISwl2U84dcQ1ajne4GMEU3dQeNg3JQ6Cvoz0
         tRlhSYbMV8FaGycXWUX+pH36fipB6yWTxoUtgVk4fB8v3VHg64+14+aLoR00s9c5E/zh
         l947Kp46La3V04oQ7xCe3VP9yxi+tPFxqUc5RO5PISu05VE+vThBzPsGn0Vyr5OOVrgN
         nbxQ==
X-Gm-Message-State: ACgBeo1xx1xnLGTAo7zkI8M0+yJbwm/9qF+mlYfqPS4Fi0dDh7dvekmU
	5GstHWzfIKDFbV19GU6QRBK7EVOUeYs=
X-Google-Smtp-Source: AA6agR6ERo2MrFsp2J4yNrpZ52aaVpYDt8+MeKOLpFwcJKKg4kadp1vcOysIjjzL9LfAJeDVIkG5RA==
X-Received: by 2002:a17:902:ec8f:b0:16e:d8d8:c317 with SMTP id x15-20020a170902ec8f00b0016ed8d8c317mr24215482plg.12.1660070889435;
        Tue, 09 Aug 2022 11:48:09 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016a0bf0ce32sm11403157plg.70.2022.08.09.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:48:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] monitor: parse RNR element
Date: Tue,  9 Aug 2022 11:48:04 -0700
Message-Id: <20220809184807.147780-1-prestwoj@gmail.com>
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

