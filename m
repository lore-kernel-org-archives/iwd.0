Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAD347A2
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058866; cv=none; b=U0tVPJsUaThPITVI/YQF5f4FrFInGmdUVsaMPSYmjR49c17L/W4DFdi4eoVG4FdOOUwgqyBnGfQp8cwWaTLpOlpBtHJigICLVIZJvwIdgw/e9gs57OtNm0h7zEmO6YEbbWTFdrUANLPj1ErwEVhs45eM4BMUNOaxvpq46iVZ5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058866; c=relaxed/simple;
	bh=o2WNaPzck4pqs87X6Vtb2X56M1AZculVkJcBK6c0/Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hucE+1pYfE24vTBzkgKsm4B4LUlBuBG/RssSHl6FMVOG3mc+hJKnddGMjuo7EXGAEP5YR0Whs+KElLkwRzIqd1GrEMkEaiSWMgABsu53xgJRbpD6KxmjneS1272CwxhH55IW8+J8ZaJUsOcWW/iAbYmHoAhJxUg4HVXW3wkp2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMnRpGaA; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMnRpGaA"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4a0e80d14so1590424a34.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058863; x=1709663663; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbHRKyzdYm5SvdYRcF/nKX9DPDQckGXqLXSOZ+K1s5c=;
        b=iMnRpGaAigr2SFjmYzb4MH7qTQ40bUjAJ0w2/G/nP9wRV1X5jF0DbwdwyMEDFk552T
         NuOC228rlVBwJvuF90tVuf1vjsCEnG0wQcLQmEKaYReI5KbLamUQIPeVIHW27gsH91Cp
         w8KTeIyYFM7+A+GkB7aayYZQLq8YvxE9GDpDgQWJ2bQCRrq8ND2ujWH1Hvt3q61GlwXS
         79KFnra3hC4KFCfT24PGb907WBDpfZ/1ZIxh8LTVvRCMqw7oLGDOH6KlV4RTjXOzAaD4
         CKTIkgzVgmYbjhD52z+J8I4J0XYXoOa0m40jyePMHai7xfXVFSsx3yUfZs8LY06QPalM
         SQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058863; x=1709663663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbHRKyzdYm5SvdYRcF/nKX9DPDQckGXqLXSOZ+K1s5c=;
        b=xCLdFKJhjhyMMo2pHSKl3a2TC6j0W3EKrfMy+R4LuXWY9dd/VD0NkJC68BSvgBYnJM
         bC6wuihi4f0XzLZHE4SE78FsgQ0w+299CgkE7Ew6s/aMcWnC54mP1YxLMJkQL9RNPYQX
         YwTS9OijTma3Bi+/dmU7V95WBtJ2j07yyxIZ1thJl2zqHTQw/8zDnDimuJibGSOUsrh7
         kAL3VIv+61Yi4YJ0gBVCoDOt0vC5NPX9+cGElsU4lhVWBAP/h7y/LeBLkyf5JnHc9IlD
         nDyoKxrz5WKlRC92gbCTquWymyguPZDDOn+fcIb8uw2h+N/ARYXgCsF3GTupZiHjM3Ue
         nDog==
X-Gm-Message-State: AOJu0Yw0b14AujgqJQFd937yb4CIHUJub3CVc9U9/cjoHZFxGikBOeom
	uXZebN90FD0s3UGjcnss33Zer8Woy4Aw5h+TSFmcmBSSOFawFpkhhKUZAktJ
X-Google-Smtp-Source: AGHT+IEH5eB24UCzLvFO2iDvxDDg441kZLb7/B/dDEJ4NYFkEe6ApB8tSj5sNnD00sxjvtZaQmtKww==
X-Received: by 2002:a9d:6c43:0:b0:6e1:13a2:3948 with SMTP id g3-20020a9d6c43000000b006e113a23948mr11089154otq.5.1709058863383;
        Tue, 27 Feb 2024 10:34:23 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:22 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/11] knownnetworks: add option to force a default ECC group
Date: Tue, 27 Feb 2024 10:33:56 -0800
Message-Id: <20240227183405.257206-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the option [Settings].UseDefaultEccGroup which allows a
network profile to specify the behavior when using an ECC-based
protocol. If unset (default) IWD will learn the behavior of the
network for the lifetime of its process.

Many APs do not support group 20 which IWD tries first by default.
This leads to an initial failure followed by a retry using group 19.
This option will allow the user to configure IWD to use group 19
first or learn the network capabilities, if the authentication fails
with group 20 IWD will always use group 19 for the process lifetime.
---
 src/knownnetworks.c | 11 +++++++++++
 src/knownnetworks.h |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index fc810057..6f65d2b3 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -123,6 +123,17 @@ void __network_config_parse(const struct l_settings *settings,
 
 		l_strfreev(modes);
 	}
+
+	if (l_settings_has_key(settings, NET_USE_DEFAULT_ECC_GROUP)) {
+		if (l_settings_get_bool(settings,
+					NET_USE_DEFAULT_ECC_GROUP, &b)) {
+			config->ecc_group = b ? KNOWN_NETWORK_ECC_GROUP_DEFAULT
+					: KNOWN_NETWORK_ECC_GROUP_MOST_SECURE;
+		} else
+			l_warn("[%s].%s is not a boolean value",
+					NET_USE_DEFAULT_ECC_GROUP);
+	} else
+		config->ecc_group = KNOWN_NETWORK_ECC_GROUP_AUTO;
 }
 
 void __network_info_init(struct network_info *info,
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index 741d42ed..c81bd9aa 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -27,6 +27,7 @@
 #define NET_ADDRESS_OVERRIDE SETTINGS, "AddressOverride"
 #define NET_TRANSITION_DISABLE SETTINGS, "TransitionDisable"
 #define NET_TRANSITION_DISABLE_MODES SETTINGS, "DisabledTransitionModes"
+#define NET_USE_DEFAULT_ECC_GROUP SETTINGS, "UseDefaultEccGroup"
 
 enum security;
 struct scan_freq_set;
@@ -38,6 +39,12 @@ enum known_networks_event {
 	KNOWN_NETWORKS_EVENT_UPDATED,
 };
 
+enum known_network_ecc_group {
+	KNOWN_NETWORK_ECC_GROUP_AUTO = 0,
+	KNOWN_NETWORK_ECC_GROUP_DEFAULT,
+	KNOWN_NETWORK_ECC_GROUP_MOST_SECURE,
+};
+
 struct network_info_ops {
 	struct l_settings *(*open)(struct network_info *info);
 	int (*touch)(struct network_info *info);
@@ -72,6 +79,7 @@ struct network_config {
 	uint8_t sta_addr[6];
 	bool have_transition_disable : 1;
 	uint8_t transition_disable;
+	enum known_network_ecc_group ecc_group;
 };
 
 struct network_info {
-- 
2.34.1

