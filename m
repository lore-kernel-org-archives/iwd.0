Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BBCEADD
	for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 19:24:26 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f8cc04c287so22169535e9.0
        for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857064; x=1689449064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPDc8LA4GJO2DBtnVUJ5IxKGVLHeuelJLE5azTwo03A=;
        b=q35YQvyNeoNPNa04M26bQU0Bebz+liJ5zdhv2TLJksszNsjnoj6tVnKt5lUtb+glwq
         ceuzWSubudm64RSFYswffV3WXBcplFfIB9IvwWVtScxxNVi4SIB/+ILcDxMHcbRNn8ec
         GEvy6BjfjIL382JMZ5xI4RcxBxlVHop4mNB8i8JC1bSsgAn+YqS8BeNDT7XJzy8UdxbP
         GtK4m0Q5eDyBAYauLT57r76u6n3Xtfycb1L/gyPOoAX+SrpNKcnA6bxsK//J8qNozBuM
         DRO7qaSH+wUXbEHU86gaALfkk5M1m8wG/4CSXCHY/ZzOJ5SRrx3Z3Vc23Pp/LKR60+8O
         6x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857064; x=1689449064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPDc8LA4GJO2DBtnVUJ5IxKGVLHeuelJLE5azTwo03A=;
        b=Sdli5Di/C6RhV6nRQoQefhceOanINv35P/73bHtgcTa46jdfCnNm2ZFYKwdWWhF7rR
         LSvJlK+8MzzpZIjROhKNWYVgaDBDRhdJiUoKzxLRN5qJMcyiq4cyB5JszN9p47IvHRtA
         HsaYr6W42FAvnnMRwnvFVhdyUkUfmCPDnwcKZULvqxKoCmjb+4V4qMMOf0n7k7Hg1OP/
         +Nzv9aOTR1o69+s2Bx0LEzJEA+wqhBufBcV+r63DeFC1cUcvhal7Ly/2cY5KwDKl9/5Q
         qwkOYn9fhG8LkQyDPdvDD1xbuopb06BRZwX67taQVtezrn08O6Yows9DwtbNnhDCINhB
         IEzQ==
X-Gm-Message-State: AC+VfDx/tQblx5KPyATuCFJC2etO8nBUgfuc+W6OhId41kJJ3HvSRZ+w
	/mk8pTSzZ50OBJq/yyfNC/QdUjYLyJN5aQ==
X-Google-Smtp-Source: ACHHUZ7aVJ+y0iOeFGO+a/Rxf2mMDkaazZw+hye2PwMXMicjiblYN30uKX3kWDarCxukj/xC2BhHRA==
X-Received: by 2002:a1c:4b19:0:b0:3f4:23b9:eed2 with SMTP id y25-20020a1c4b19000000b003f423b9eed2mr96011wma.38.1686857064141;
        Thu, 15 Jun 2023 12:24:24 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003f6028a4c85sm28241wmi.16.2023.06.15.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:24:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] wiphy: allow for user-defined driver flags
Date: Thu, 15 Jun 2023 12:24:10 -0700
Message-Id: <20230615192415.1718516-2-prestwoj@gmail.com>
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

The driver_infos list in wiphy.c is hard coded and, naturally,
not configurable from a user perspective. As drivers are updated
or added users may be left with their system being broken until the
driver is added, IWD released, and packaged.

This adds the ability to define driver flags inside main.conf under
the "DriverFlags" group. Keys in this group correspond to values in
enum driver_flag and values are a list of glob matches for specific
drivers:

[DriverFlags]
DefaultInterface=rtl81*,rtl87*,rtl88*,rtw_*,brcmfmac,bcmsdh_sdmmc
ForcePae=buggy_pae_*
---
 src/wiphy.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index ca8a4958..6f8f6826 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -73,6 +73,11 @@ enum driver_flag {
 	FORCE_PAE = 0x2,
 };
 
+struct driver_flag_name {
+	const char *name;
+	enum driver_flag flag;
+};
+
 struct driver_info {
 	const char *prefix;
 	unsigned int flags;
@@ -93,6 +98,11 @@ static const struct driver_info driver_infos[] = {
 	{ "bcmsdh_sdmmc",    DEFAULT_IF },
 };
 
+static const struct driver_flag_name driver_flag_names[] = {
+	{ "DefaultInterface", DEFAULT_IF },
+	{ "ForcePae",         FORCE_PAE },
+};
+
 struct wiphy {
 	uint32_t id;
 	char name[20];
@@ -1868,6 +1878,9 @@ static bool wiphy_get_driver_name(struct wiphy *wiphy)
 	char driver_path[256];
 	ssize_t len;
 	unsigned int i;
+	unsigned int j;
+	const struct l_settings *config = iwd_get_config();
+	char **flag_list;
 
 	driver_link = l_strdup_printf("/sys/class/ieee80211/%s/device/driver",
 					wiphy->name);
@@ -1885,6 +1898,24 @@ static bool wiphy_get_driver_name(struct wiphy *wiphy)
 		if (!fnmatch(driver_infos[i].prefix, wiphy->driver_str, 0))
 			wiphy->driver_flags |= driver_infos[i].flags;
 
+	/* Check for any user-defined driver flags */
+	if (!l_settings_has_group(config, "DriverFlags"))
+		return true;
+
+	for (i = 0; i < L_ARRAY_SIZE(driver_flag_names); i++) {
+		flag_list = l_settings_get_string_list(config, "DriverFlags",
+						driver_flag_names[i].name, ',');
+		if (!flag_list)
+			continue;
+
+		for (j = 0; flag_list[j]; j++)
+			if (!fnmatch(flag_list[j], wiphy->driver_str, 0))
+				wiphy->driver_flags |=
+						driver_flag_names[i].flag;
+
+		l_strv_free(flag_list);
+	}
+
 	return true;
 }
 
-- 
2.25.1

