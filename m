Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89D7FBD0
	for <iwd@lists.linux.dev>; Wed,  8 May 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195279; cv=none; b=e1iCAp8axptJaOFEOrTQJKkFo4ePQKsyyraUkqWny7R4Sm59v2N924Va0EaDspllVoVdHLbPu1mBaISIZcnMarEiTI/Fmowms3/u6q8vcKRKihmqVpYtK2AhNKudNcKOEe7Sc4KypDp+LoH5N+HDGi20/cLgMkD2dWb7GLzNgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195279; c=relaxed/simple;
	bh=7e9o/raK56n5fQKQJapZFUsIKQkLj18b4r+N+cfIcCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKXmRu44vWGYdsLGPdDt9GIZ2TySW4g5XoK6AXCMQnN9ob8nXfqdzV0cClozsRRT5K+VGAOevpy0GWzuhztxDeDBo8krj8zYM/GBlW/xWnZpvQdrB3fBf360FhUI/NxY6l+s/ZVP0ZmhMi+ILPzys8BT/prT77Jh5MU+Spd02bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLtKjvGD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLtKjvGD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41fc53252ceso467275e9.0
        for <iwd@lists.linux.dev>; Wed, 08 May 2024 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715195276; x=1715800076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LkjOnC0VB5wshXdbD1i65xi0Wnu8UaoXQqh+1anwI5w=;
        b=WLtKjvGDbNULuHS/X8dwqyHHM0ANKxhUuMOFun9BAnmYkWCYKyJlauRvDz479kHKUz
         Ij7WKoo1kqR7XaxvLMnvx6Z0sITosAROD/Ife1PizGY7lC6FuYkXonMe13qXOHMNEB/z
         t445l08HBsnnjVAypj8hcuRamkNjt70ULsTLaQdzixEfHC7oqV0vquk7Gs5rhbqA2KbC
         XGag4HjpQNiPr1I/2dZn2PcPIgZcANsH+aFgqjb/24jtYq2gKOKewQ4CTAIsWOfH23bi
         dKm8TFdMpyL3s42gvNj2oF0qkRKqnIfutww2Yb59TjtzTQO4htwivKW5anmADmJY9tnP
         OyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715195276; x=1715800076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkjOnC0VB5wshXdbD1i65xi0Wnu8UaoXQqh+1anwI5w=;
        b=GOtqgEH0rI6T2XOG6QWuzej9ccu7Ipo9xmj6rzHVBC+Rfgu1itYrxXrWREmWB5YX1J
         boXlIbiDm4c6cE7SMCPEjgVM2DH7SRADXJZAtySMzFgCb6tqSI6P52eEM2nqJ/F1UsON
         qGh7kZwZ8EUHR2maxbJw8ebCS2TddUIDoPYzfihzGwbfD0ujDJkjqWe3ZJftaC5lmvN9
         k6TMnlJ1w3Uysi7/TBIECmURNxIwOPSccbI2k7xnAtm+qCCGps6rc2YUDjv2xytBed+5
         IeEWHRVLkG+v2xQskhu2C0bLkLkvUUhlzdRZiqoDpIlnTf8p69GXxPMepZh8aWh+uFdE
         52NA==
X-Gm-Message-State: AOJu0YzgDW+0Csl/9rK1hsDecl3VgJor2KtJ4a8eCTl60nfWFhOT1azy
	foHURyWIGsYHa3thjRY95OUCoajBJYBVTiLuk4lrjYwLFfAyeATimF2xPVq4
X-Google-Smtp-Source: AGHT+IHZs6IicLLqFeKbkCcYKJcJISRYB9ju2k7+he4cTfxfn+ucphmGhOhHapZR1Gv03hnSI9eqIQ==
X-Received: by 2002:a05:600c:4e45:b0:41a:9fc2:a6b1 with SMTP id 5b1f17b1804b1-41f71ec27f7mr27825505e9.22.1715195275951;
        Wed, 08 May 2024 12:07:55 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882087eesm32404095e9.44.2024.05.08.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:07:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] nlmon: parse/print neighbor reports
Date: Wed,  8 May 2024 12:07:49 -0700
Message-Id: <20240508190749.80219-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds an IE parser for neighbor report elements
---
 monitor/nlmon.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 9fee5bde..a900f7cc 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2452,6 +2452,86 @@ static void print_reduced_neighbor_report(unsigned int level, const char *label,
 	}
 }
 
+static void print_neighbor_report(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	struct ie_tlv_iter iter;
+	struct ie_neighbor_report_info info;
+
+	const char *phy_type_table[] = {
+		[0] = NULL,
+		[1] = NULL,
+		[2] = "DSSS",
+		[3] = NULL,
+		[4] = "OFDM",
+		[5] = "HDRSSS",
+		[6] = "ERP",
+		[7] = "HT",
+		[8] = "DMG",
+		[9] = "VHT",
+		[10] = "TVHT",
+		[11] = "S1G",
+		[12] = "CDMG",
+		[13] = "CMMG",
+		[14] = "HE"
+	};
+
+	ie_tlv_iter_init(&iter, data - 2, size + 2);
+
+	if (!ie_tlv_iter_next(&iter))
+		return;
+
+	if (ie_parse_neighbor_report(&iter, &info) < 0) {
+		print_attr(level, "Invalid Neighbor report");
+		return;
+	}
+
+	print_attr(level, "Neighbor Report for "MAC, MAC_STR(info.addr));
+	print_attr(level + 1, "Operating Class: %u", info.oper_class);
+	print_attr(level + 1, "Channel Number: %u", info.channel_num);
+
+	if (info.phy_type <= 14 && phy_type_table[info.phy_type])
+		print_attr(level + 1, "Phy Type: %s",
+				phy_type_table[info.phy_type]);
+	else
+		print_attr(level + 1, "Phy Type: Unknown (%u)", info.phy_type);
+
+	if (info.bss_transition_pref_present)
+		print_attr(level + 1, "BSS Transition Preference: %u",
+				info.bss_transition_pref);
+
+	switch (info.reachable) {
+	case 1:
+		print_attr(level + 1, "Reachability: Not Reachable");
+		break;
+	case 2:
+		print_attr(level + 1, "Reachability: Unknown");
+		break;
+	case 3:
+		print_attr(level + 1, "Reachability: Reachable");
+		break;
+	default:
+		break;
+	}
+
+	print_attr(level + 1, "BSSID Information");
+
+	if (info.security)
+		print_attr(level + 2, "Security bit set");
+	if (info.key_scope)
+		print_attr(level + 2, "Key scope bit set");
+	if (info.spectrum_mgmt)
+		print_attr(level + 2, "Spectrum Mgmt bit set");
+	if (info.qos)
+		print_attr(level + 2, "QoS bit set");
+	if (info.apsd)
+		print_attr(level + 2, "APSD bit set");
+	if (info.md)
+		print_attr(level + 2, "MD bit set");
+	if (info.ht)
+		print_attr(level + 2, "HT bit set");
+}
+
 static struct attr_entry ie_entry[] = {
 	{ IE_TYPE_SSID,				"SSID",
 		ATTR_CUSTOM,	{ .function = print_ie_ssid } },
@@ -2520,6 +2600,8 @@ static struct attr_entry ie_entry[] = {
 		ATTR_CUSTOM,	{ .function = print_reduced_neighbor_report } },
 	{ IE_TYPE_RSNX,				"RSNX",
 		ATTR_CUSTOM,	{ .function = print_rsnx } },
+	{ IE_TYPE_NEIGHBOR_REPORT,		"Neighbor Report",
+		ATTR_CUSTOM,	{ .function = print_neighbor_report } },
 	{ },
 };
 
@@ -4979,6 +5061,7 @@ static void print_rm_action_frame(unsigned int level, const uint8_t *body,
 		print_rm_request(level + 1, body + 1, body_len - 1);
 		break;
 	case 1:
+	case 5:
 		print_rm_report(level + 1, body + 1, body_len - 1);
 		break;
 	}
-- 
2.34.1

