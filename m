Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB0C8DE
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703947; cv=none; b=izAFIXkL5OdLFFtSbZQ9AY+BpRLi/IGYNlQDgAFzsfD3EV3z1F3D0bgpY2+TPTHmQ5JpgWNEZ6iuai9aMuDQQPoasF4A4em0FhwuK0RkJsLuRa1kbx07cBGwAxE1v9f8fPHwHFGTbE7V+ddl8meCyZfrjZEfzYNUFBLCAhOyG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703947; c=relaxed/simple;
	bh=w3TKeFM1KimJ4aJWJglCBsRkmLbYuLakaPCjm8K13+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw9+x02WkaMJTuFqX1IYoBL1lI61JsyN3SOLTUPVwxjGeBqzGpWc8pvKVPvi2Fn2ciIO/uPQ0VJ7igL6IGbBO2cKU7a8XnreQMzMweGjeaGGxRMWjrW0WnH/0FcaLPp4regFdPcL8jS1NZ6NzqGSij1keIM7r2fDJKMxOg0K/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdbsUIoe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdbsUIoe"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso1674899b3a.1
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713703946; x=1714308746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0w0cZSMYhki2e5Ps51YDWTfICjiJNw9DXP+Y8XATlU=;
        b=FdbsUIoe5S3DIjM36gCk11nlwRoroSuHOI6L7OUuMtOOvoZJpBEKbVvd8cTFUEjs76
         tFAbirnBloq2Y6xwAmoSJtWsnhZM4gxog8O3c9Q95dg7En5DuYb4sBLx8TEQvXFbL2BF
         ILM2lZTTtY47uvN4y7u0pUYqxsbU5gNI0IY1M6VAmUZnyZQdUohIvoFAjibsqdeT/iex
         8hxNtSo8L+NsZkdT4Wv4DfS49DbUHnXeao7elLNcroNq7Anw4epsvnFQOJmD1183YKcZ
         taTdjCjN3Bif/Kwm7cG/0O+bOpmCwQOzkv/GeQYP+OGgzSW+bHy6HHx1jSgQ+RorICx0
         HEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703946; x=1714308746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0w0cZSMYhki2e5Ps51YDWTfICjiJNw9DXP+Y8XATlU=;
        b=wCVOiEbrenPprYv4S/bYJLRfPbpJpTziJlaUJTxVHbRais3QwQxXcJlkAs/cxrbdF9
         2abqBzA4UbA1xGd4rLWj1EGWbbXfEuDdiiWTRmINZ9ybRu7IA0sAvy+OGa/5FOdLMUde
         C20hV7/NHsSoXQ7d68Uy36i+d1nb4pnIWHUVcZN0W/iFabCOoyksL2FxLYy32XE6IwXx
         v9mqpOC7UrIY/yUKiRIzkRbKl/PmqifGC1PS5Ab68B6242DXHxoWvhXILerRTacFC/YJ
         Dm/mScBi5HLDmU7OdKGJInKehHFobB6sc/10iLbh0zCzeuY7mKZSgqHuDbZTllO8Lmrq
         jfaQ==
X-Gm-Message-State: AOJu0YzAzNzLIAJpAgoXJ9fRrdKQCiKWCVYNKiIDG0Hld7Hr2kbnbFc4
	VQEvHCW3r82FCVLnzP9Cv3n7MsImAo3lKFKc7iLPryxXcQIlUNUaTD+pWHvWsSo=
X-Google-Smtp-Source: AGHT+IEFUs6mlsuA/naGlylsBRThPGL6ssZA2VDLpGKNmtgSIIOvs4zBpojm4wZDpKxGXWTU7EJyyQ==
X-Received: by 2002:a05:6a00:189b:b0:6ea:f05c:5c16 with SMTP id x27-20020a056a00189b00b006eaf05c5c16mr11076255pfh.5.1713703945742;
        Sun, 21 Apr 2024 05:52:25 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id fh9-20020a056a00390900b006ecf1922df7sm6102706pfb.36.2024.04.21.05.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:52:25 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 01/11] ap: ability to advertise PSK and SAE
Date: Sun, 21 Apr 2024 05:50:31 -0700
Message-ID: <20240421125050.6649-2-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the configuration option AKMSuites under Security so it becomes
possible to support both PSK and SAE. This influences the advertised
AKMs in the beacon.
---
 src/ap.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index b4e7593e..d50f9e4f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -80,6 +80,7 @@ struct ap_state {
 
 	unsigned int ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
+	unsigned int akm_suites;
 	uint32_t beacon_interval;
 	struct l_uintset *rates;
 	uint32_t start_stop_cmd_id;
@@ -631,7 +632,7 @@ static void ap_drop_rsna(struct sta_state *sta)
 static void ap_set_rsn_info(struct ap_state *ap, struct ie_rsn_info *rsn)
 {
 	memset(rsn, 0, sizeof(*rsn));
-	rsn->akm_suites = IE_RSN_AKM_SUITE_PSK;
+	rsn->akm_suites = ap->akm_suites;
 	rsn->pairwise_ciphers = ap->ciphers;
 	rsn->group_cipher = ap->group_cipher;
 }
@@ -3620,6 +3621,7 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 	size_t len;
 	L_AUTO_FREE_VAR(char *, strval) = NULL;
 	_auto_(l_strv_free) char **ciphers_str = NULL;
+	_auto_(l_strv_free) char **akms_str = NULL;
 	uint16_t cipher_mask;
 	int err;
 	int i;
@@ -3838,6 +3840,28 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		ap->ciphers |= cipher;
 	}
 
+	akms_str = l_settings_get_string_list(config, "Security",
+						"AKMSuites", ',');
+	for (i = 0; akms_str && akms_str[i]; i++) {
+		if (!strcmp(akms_str[i], "PSK"))
+			ap->akm_suites |= IE_RSN_AKM_SUITE_PSK;
+		else if (!strcmp(akms_str[i], "SAE"))
+			ap->akm_suites |= IE_RSN_AKM_SUITE_SAE_SHA256;
+		else {
+			l_warn("Unsupported or unknown AKM suite %s",
+					akms_str[i]);
+			return -ENOTSUP;
+		}
+	}
+
+	if (ap->akm_suites == 0) {
+		/*
+		 * Default behavior if no AKMs are specified but a passphrase
+		 * is to only enable PSK == WPA2.
+		 */
+		 ap->akm_suites |= IE_RSN_AKM_SUITE_PSK;
+	}
+
 	if (!ap->ciphers) {
 		/*
 		 * Default behavior if no ciphers are specified, disable TKIP
-- 
2.44.0

