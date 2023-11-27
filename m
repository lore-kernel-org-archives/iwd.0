Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFE2105
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtJvr2HN"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fa289a35e7so604629fac.1
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 20:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701060015; x=1701664815; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f1jMX0lZlEOnRQYzptaMmMzdCkeL/i+ATY5nPyEl4k=;
        b=EtJvr2HNRkqF278ce/buUkRNebTeVN6gdHfikSxLEaIuznM0pa7NYTdRWTEc2KMh81
         wCccswJnAYR/siGFw6RrtMftzRoQGuHzi4mi4Mg+188HYZ0mw83u19lr5C1fFEVDy2Hi
         GntscSUslmjRTsTRRrROxSTauB8AhLHuYIJs0pMBad/AIllrU/s6WRpGRMIxM02GJIQQ
         vPLSFQshYC5aZt9kBDW5fM52Q7DUqGK+2rAdoRlURULBDXNclzqaRzuB8C9jdqW0sfVI
         4xZ8Eohs41caIkcY56LT0bG2m+k5nbwTbjc6DwYbLuAvScEIOafGBG6xJlsKHSxLTyC6
         bseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701060015; x=1701664815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f1jMX0lZlEOnRQYzptaMmMzdCkeL/i+ATY5nPyEl4k=;
        b=SapCa5Krc7Hyzldt9O6408b21nEojk4WpBlZ6VMJ/oxuA+hreGIHlpz64x/XaF2y3C
         YtbtcL0E9d4HCOKN/6hClNHbspv4SeR2ahwh+W6oDeei2MFbbPdPo3Lptuql61+ktyp/
         4U0+qpgj86Kba/JJq06Ccp9TmE22/Tt1Tewp8zcqZ2uh8NveFc42gBjiJZWByuA2LTkY
         TBmjLYUEpPshnessf/O8kxXjuME+d2QPMyAklnwwMNOlDIg1/k9O//5/ngfEncN7Vymu
         pDN/13N1sJIvZ8f7g0mn2SVqvEmqad6xAtsX9XuI9FKlasvoqliwO63JxSWuRPa0pXqk
         x2zg==
X-Gm-Message-State: AOJu0YwxplmjJ69Xq2THfSmE65mlqOSy7smAyRTm2fEfUE00mAZcunZT
	e+PDhUd+1ePyjK2s84kFSBLJ0aA5F5M=
X-Google-Smtp-Source: AGHT+IHXOiOKJiGQBxnQdF/0tpKmwCTxQNXsUWs3pQSOWZ/Q3KI14TQgzynC00o0L0DmnoRjPw0R+g==
X-Received: by 2002:a05:6871:3a2c:b0:1fa:3685:1cae with SMTP id pu44-20020a0568713a2c00b001fa36851caemr4109332oac.6.1701060014905;
        Sun, 26 Nov 2023 20:40:14 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nq6-20020a056871378600b001f5d5930e85sm2110558oac.33.2023.11.26.20.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:40:14 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 5/6] netdev: Fix buffer overflow with 32 character ssids
Date: Sun, 26 Nov 2023 22:38:45 -0600
Message-ID: <20231127043924.1328538-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127043924.1328538-1-denkenz@gmail.com>
References: <20231127043924.1328538-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ssid is declared as a 32 byte field in handshake_state, hence using it
as a string which is assumed to be nul-terminated will fail for SSIDs
that are 32 bytes long.

Fixes: 1f1478285725 ("wiphy: add _generate_address_from_ssid")
Fixes: 5a1b1184fca6 ("netdev: support per-network MAC addresses")
---
 src/netdev.c | 3 ++-
 src/wiphy.c  | 5 +++--
 src/wiphy.h  | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 901a41900350..208a15b94507 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3526,7 +3526,8 @@ static int netdev_start_powered_mac_change(struct netdev *netdev)
 	/* No address set in handshake, use per-network MAC generation */
 	if (l_memeqzero(netdev->handshake->spa, ETH_ALEN))
 		wiphy_generate_address_from_ssid(netdev->wiphy,
-					(const char *)netdev->handshake->ssid,
+					netdev->handshake->ssid,
+					netdev->handshake->ssid_len,
 					new_addr);
 	else
 		memcpy(new_addr, netdev->handshake->spa, ETH_ALEN);
diff --git a/src/wiphy.c b/src/wiphy.c
index 570f54155717..766df348754f 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -796,12 +796,13 @@ void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[static 6])
 	wiphy_address_constrain(wiphy, addr);
 }
 
-void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssid,
+void wiphy_generate_address_from_ssid(struct wiphy *wiphy,
+					const uint8_t *ssid, size_t ssid_len,
 					uint8_t addr[static 6])
 {
 	struct l_checksum *sha = l_checksum_new(L_CHECKSUM_SHA256);
 
-	l_checksum_update(sha, ssid, strlen(ssid));
+	l_checksum_update(sha, ssid, ssid_len);
 	l_checksum_update(sha, wiphy->permanent_addr,
 				sizeof(wiphy->permanent_addr));
 	l_checksum_get_digest(sha, addr, mac_randomize_bytes);
diff --git a/src/wiphy.h b/src/wiphy.h
index 999d0c57a926..bc82a00721e7 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -146,7 +146,8 @@ const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
 						size_t *size);
 void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[static 6]);
-void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssid,
+void wiphy_generate_address_from_ssid(struct wiphy *wiphy,
+					const uint8_t *ssid, size_t ssid_len,
 					uint8_t addr[static 6]);
 
 int wiphy_estimate_data_rate(struct wiphy *wiphy,
-- 
2.42.0

