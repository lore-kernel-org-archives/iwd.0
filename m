Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDF1B21BC
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547191; cv=none; b=Ly7TIAu2bWKy9/99s/mJkbq37hEdtSeypuNrpSG2v4ayqKgLy1+7tr3JFNba2wj8gBgCLd+j7pKgWRxdN7k3MSiNkGWMrqCXuNc71G2BCu592yfbTeHJ9BWpf1CmJ6+gPJUsfXV4Un8baxwxHFAvM1O8M0kjiUZ7wx0RhQfhD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547191; c=relaxed/simple;
	bh=DfrU3IgV6JSycn+xN2hEBJdqlJUzv1JI/WU9r7SiYGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fiU47KP9IJsiYk/H7fm8SqzAdYXTEYueTtBaICHh8Yj2boT0rX1oaYewn5VmDmsxJz8n1HLqUcbwBOg96idx3wz+Tm+p4MZCCyfr9x/4wFK+B46pTxxxc3aatu96vTaIp4FgpGiy36h26pdLDtFTGu/RtpjQSUfDWT4L+Ihp0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXW9yEtS; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXW9yEtS"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d419832bf5so38920846d6.1
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732547189; x=1733151989; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzoR1qDtQwQmLvvY8PYn1ONcMFFuuUDwH6wa1cm/29w=;
        b=TXW9yEtSvfPKjsN+GY1GESTz31BqSpUe3JnyQZjPZIoiSonBHQBKWdD7nuq2zwqkmm
         AjH40vMDbLJfVKpurLxr6XSbtHG0XMGgUhIExJHZnx7XRZ4yPV2G5nTcXO+kzqlckypp
         Saag7oiV89tAXb2pxLNml7m4p9RcZIQ4uqn+VTOEjoPgZ2OIxpcsccS0kISTlEdLKS03
         G4ILY8pEQdqYn9/+eZxHPv3DQLweZuNHAhQRixXqxNMvvj3j0wL1J5D++0dBGKMrzbuB
         ULqumM8tSigRlfHxaUVfo1vjtmCUjS6KFIxZ2t3NYIdWc6mzbVtQFi5SA89DpGl0UT7S
         9KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547189; x=1733151989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzoR1qDtQwQmLvvY8PYn1ONcMFFuuUDwH6wa1cm/29w=;
        b=X0sHe+dl8oK++f8UVsby75p51xiBvxHGqQm/sJ0XFR+FDqay3CIvc2BFKSYpAsyhKT
         IEZyCVBFGrGpxj352MXTVObajjAN/ldrS7ClwzmP8oarvOgo2KxWGecls/FZ4b8OxZ5R
         hLQlq2ACWlhkNDkBrda0Rm5cWmbNhZ7p/NIdKBLrITLcqJPM/sn2PmvYm2X2pVHauzI4
         TZxHB9ePCKrNh7GLHFXVyv2vMc4sBYuFXdrUHMcEdXbUIfOsKOOTgvrVhSPIViH8fO+n
         2u9hLItCpKNsnwFxmDolRUOYWmWqwvgfIE5UGXcN/LYQTQ2DjX1hnFs2VyQVlQ+inttS
         aHzw==
X-Gm-Message-State: AOJu0Yw13lxkCfDwSgKhkkk/U4gbWewhqcIioseyv6nJ+z2nL3IK3sr+
	QqZMLwGb1RbUHF9kyAJdUV0uWZpa8hbsfoE1FnI3pibtWR/qWhiTXsMSyQ==
X-Gm-Gg: ASbGncszWl88ZQoVZdUGaEVSuUn8xbqmrF9wqV2MJQ/Co/LUueNnWg5553B9ArKmpUr
	KCcn1QVsACkmBHJDVFTK9A1O3IXaZ0UfHRhVPz95oG6VszX9ovlF5CYxtGU/P7m1Khq5htt6vKc
	iAvd3Im5My6YDUxvsdR4NW/pbq95CWCLq24B84xSwSuIlUn6Oo04QxDmCn4UaxGSwG54fHA3XMe
	Q2BBQcz7rkSO3ZKGj1zA9AArdt/1BARlO/J1MzBVEzro1lHsIcy9qUltUne
X-Google-Smtp-Source: AGHT+IH8QvgTd5nfvE4R46hQ2tngbQM3mC+ExRwcyjZqqQHG3p+c125UbRIACk3HSZRU8Xa6UU0ylg==
X-Received: by 2002:a05:6214:19ea:b0:6d4:1680:6132 with SMTP id 6a1803df08f44-6d45138de5fmr234476696d6.38.1732547188598;
        Mon, 25 Nov 2024 07:06:28 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab5cc3sm43569136d6.66.2024.11.25.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:06:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] wiphy: add driver quirk for disabling multicast rx (and helper)
Date: Mon, 25 Nov 2024 07:06:21 -0800
Message-Id: <20241125150623.1014890-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125150623.1014890-1-prestwoj@gmail.com>
References: <20241125150623.1014890-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver quirk and associated helper API lets other modules both
check if multicast RX is supported, and if its been disabled via
the driver quirk setting.
---
 src/wiphy.c | 17 +++++++++++++----
 src/wiphy.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index ecc345e9..5e958d65 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -73,6 +73,7 @@ enum driver_flag {
 	FORCE_PAE = 0x2,
 	POWER_SAVE_DISABLE = 0x4,
 	OWE_DISABLE = 0x8,
+	MULTICAST_RX_DISABLE = 0x10,
 };
 
 struct driver_flag_name {
@@ -101,10 +102,11 @@ static const struct driver_info driver_infos[] = {
 };
 
 static const struct driver_flag_name driver_flag_names[] = {
-	{ "DefaultInterface", DEFAULT_IF },
-	{ "ForcePae",         FORCE_PAE },
-	{ "PowerSaveDisable", POWER_SAVE_DISABLE },
-	{ "OweDisable",       OWE_DISABLE },
+	{ "DefaultInterface",   DEFAULT_IF },
+	{ "ForcePae",           FORCE_PAE },
+	{ "PowerSaveDisable",   POWER_SAVE_DISABLE },
+	{ "OweDisable",         OWE_DISABLE },
+	{ "MulticastRxDisable", MULTICAST_RX_DISABLE }
 };
 
 struct wiphy {
@@ -949,6 +951,13 @@ bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy)
 	return wiphy->supports_cmd_offchannel;
 }
 
+bool wiphy_supports_multicast_rx(const struct wiphy *wiphy)
+{
+	return wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS) &&
+				!(wiphy->driver_flags & MULTICAST_RX_DISABLE);
+}
+
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
 						size_t *size)
diff --git a/src/wiphy.h b/src/wiphy.h
index c527c79d..9fcbdcd2 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -143,6 +143,7 @@ void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
 bool wiphy_country_is_unknown(struct wiphy *wiphy);
 bool wiphy_supports_uapsd(const struct wiphy *wiphy);
 bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy);
+bool wiphy_supports_multicast_rx(const struct wiphy *wiphy);
 
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
-- 
2.34.1

