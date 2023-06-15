Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A18EADD
	for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 19:24:30 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso11005128e87.1
        for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857068; x=1689449068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpzGjz3SnXJ3mkGar/4yJDlsZpn6nugyqrpOCjaDC9Q=;
        b=Nlaf/EJfvZ5iqebqmVGNq20b8E/vaCCE+k6QtSmdoXBSmRs2+IxJpYz+9UE+ybitP/
         VJlgtndYixw6poizjkvQhoH5ZtiR3Q/RIgOtCxqlEx8GO7ieGVgfgYJt+aJwE9Zgbfbc
         0nPHbqEEt1E02ednfqagdqsGyzhmXMDSyDupFoGEyb1Cy0l43h407JW0IQwDy/c4u+OF
         0FTNZmoiareasmAZrNaQ4zqt3uUgObjlfiR21bxNJTFT7g+JA7UAgfev0PWt6OWXIOSL
         DJD5MCgaeWEO4idsht/nAXOCzYtuYw8OksRRvQ3G40k+JTrCJxnT4GAJkYj+CuDxwSrt
         IS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857068; x=1689449068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpzGjz3SnXJ3mkGar/4yJDlsZpn6nugyqrpOCjaDC9Q=;
        b=K035zxQ7sDCwjXd/7djMwKTq+g3Ugmy701BX12vxAaeUBRBdwsdwQuST6aK4DaVcJy
         dXTcT04RgQmmVnvx+dWUNjCRIfbCu9HsTin6ElNw43X5IeffpLt+5GXkgoH0EqDNQ01z
         tOJ24/ZLybI4idr3MmWQ3jxAJ6htKMueHUcjpcqGo9ZGZSIMFX4V36Ir3Z5tLjKCdXxa
         d/c3Bl7LMAlzvssmIA6ZxIPoGmVO8T93cEzu3sepcDPbiEE/QunL0K9LsR7vM8PGWmwz
         LvvYq0vsw9VH7NpCz2PB+azuxB/cDiLyNAITpcC8zKLSkuyV3o2by7u87lGQXhyC39Vg
         5wFQ==
X-Gm-Message-State: AC+VfDzVPvCX8s4rrnTCnvIJ8dsf1tuB0ykv5LabryHxlCVsjNIQ004C
	XYrpoavlXMptgKp8SmjSlQx/5oajrUJHCQ==
X-Google-Smtp-Source: ACHHUZ5DZ5z857ccmUtO2kmFiPEx5eyXj/ZFo6t0802WOxoDLGjO7khsojzKtWtRf+QcC2uh98jy2A==
X-Received: by 2002:a19:5e57:0:b0:4f6:29cf:c0dd with SMTP id z23-20020a195e57000000b004f629cfc0ddmr6779607lfi.8.1686857067742;
        Thu, 15 Jun 2023 12:24:27 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003f6028a4c85sm28241wmi.16.2023.06.15.12.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:24:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] wiphy: add [DriverFlags].PowerSaveDisable flag
Date: Thu, 15 Jun 2023 12:24:12 -0700
Message-Id: <20230615192415.1718516-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615192415.1718516-1-prestwoj@gmail.com>
References: <20230615192415.1718516-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain drivers do not handle power save very well resulting in
missed frames, firmware crashes, or other bad behavior. Its easy
enough to disable power save via iw, iwconfig, etc but since IWD
removes and creates the interface on startup it blows away any
previous power save setting. The setting must be done *after* IWD
creates the interface which can be done, but needs to be via some
external daemon monitoring IWD's state. For minimal systems,
e.g. without NetworkManager, it becomes difficult and annoying to
persistently disable power save.

For this reason a new driver flag POWER_SAVE_DISABLE is being
added. This can then be referenced when creating the interfaces
and if set, disable power save.
---
 src/wiphy.c | 13 +++++++++++++
 src/wiphy.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 6f8f6826..2c09d47a 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -71,6 +71,7 @@ static unsigned int wiphy_dump_id;
 enum driver_flag {
 	DEFAULT_IF = 0x1,
 	FORCE_PAE = 0x2,
+	POWER_SAVE_DISABLE = 0x4,
 };
 
 struct driver_flag_name {
@@ -101,6 +102,7 @@ static const struct driver_info driver_infos[] = {
 static const struct driver_flag_name driver_flag_names[] = {
 	{ "DefaultInterface", DEFAULT_IF },
 	{ "ForcePae",         FORCE_PAE },
+	{ "PowerSaveDisable", POWER_SAVE_DISABLE },
 };
 
 struct wiphy {
@@ -723,6 +725,17 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
 	return enabled;
 }
 
+bool wiphy_disable_power_save(struct wiphy *wiphy)
+{
+	if (wiphy->driver_flags & POWER_SAVE_DISABLE) {
+		l_info("Disabling power save due to driver quirks: %s",
+				wiphy_get_driver(wiphy));
+		return true;
+	}
+
+	return false;
+}
+
 const uint8_t *wiphy_get_permanent_address(struct wiphy *wiphy)
 {
 	return wiphy->permanent_addr;
diff --git a/src/wiphy.h b/src/wiphy.h
index f4f205ad..39837366 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -135,6 +135,7 @@ const char *wiphy_get_driver(struct wiphy *wiphy);
 const char *wiphy_get_name(struct wiphy *wiphy);
 bool wiphy_uses_default_if(struct wiphy *wiphy);
 bool wiphy_control_port_enabled(struct wiphy *wiphy);
+bool wiphy_disable_power_save(struct wiphy *wiphy);
 const uint8_t *wiphy_get_permanent_address(struct wiphy *wiphy);
 const uint8_t *wiphy_get_extended_capabilities(struct wiphy *wiphy,
 							uint32_t iftype);
-- 
2.25.1

