Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27ED20F7
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9G+reqI"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1fa2b8f7f27so750647fac.0
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 18:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701053652; x=1701658452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz4VnnTexZBkuMES1PABrkFOftLFTnXgT69sxsL4e0I=;
        b=X9G+reqI8Ntgy50p/s6nxuuSJYQhsDbxHHjcvwHk5VA5V6nk4BodcrD4mKbCsq3vBj
         FC0FoNuSVTeguEKfXVBM56ubXXHKNgTBYmkI3GO8x9tIAqM06MLSFC1/hbXqNLTxTk+O
         c2/8Jpa0SjejEd9xYjHhKA7Y9gLiF2PTFctk34b/Ol+USD1FBR8N9zjrVWP5uDZCSPnW
         3DSiNI67pWYzvFeudNrSJ+HNS2LbkL9GqWtGTpScv9Y7L4342Qoj7tFPKV03BQm9l7gi
         xfgM/hTphpSVHXEUtNznrJp7coGf3kvm5M7xHIHSFMhtFkfm2ACK+FskW+UkTRjw+gG+
         h1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701053652; x=1701658452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz4VnnTexZBkuMES1PABrkFOftLFTnXgT69sxsL4e0I=;
        b=Tc8ntd1yDPHLfAwHEpSJVYd7mVhk8jNyXGSJJhA8XLlCGVrnhVT9+AT4VZ7XE/K5D9
         +nFD6LAq4iuoGLblqbvTTDQ5A2lbPgtnAkC4PCNrX/wP1K25SMgC0AjlNEcb95CndaRn
         3ocNBlMYZpFflbJ9HMKMyCVZPFpfSEMkBjnmV0gtSbLjrSNCehvnPV7RfPybgHi6V53K
         uaWXVZ624i6GQ4aKQeRrJJWwTAlE8Yjo4WFEGGMrrVFv7TDE+ec42mlINZ0jG+mmhoTx
         X/Tb0lml7u+DoGVO+woHvE/3RECMaTbzWYkh9sc5A54fF/NN/xeeLlGoZSt/n23IJVOO
         eBlQ==
X-Gm-Message-State: AOJu0YzSRAb0WrvvB7am5CrVqsmgeODzxPgoMoGzJh64bcCvKkS/6DRn
	BteXafdWjMkF7SBtq73HeIDOXmkZdLs=
X-Google-Smtp-Source: AGHT+IGA2x/GecXQE1GsjP7sa2EX7glN8FtMQzPetJclnkMRT2XKSrReSnVe7vQ4JZ9gOj/XYaBlfA==
X-Received: by 2002:a05:6870:46a7:b0:1fa:1355:da45 with SMTP id a39-20020a05687046a700b001fa1355da45mr11391864oap.11.1701053651788;
        Sun, 26 Nov 2023 18:54:11 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm1818846oab.11.2023.11.26.18.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 18:54:11 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] netdev: Fix buffer overflow with 32 character ssids
Date: Sun, 26 Nov 2023 20:53:02 -0600
Message-ID: <20231127025320.1310543-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127025320.1310543-1-denkenz@gmail.com>
References: <20231127025320.1310543-1-denkenz@gmail.com>
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
index 03f9a77324db..9e6e1c6fb82e 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3527,7 +3527,8 @@ static int netdev_start_powered_mac_change(struct netdev *netdev)
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

