Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC115B97A
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069126; cv=none; b=NtxKPDPlvBU9BtO+xl3njaP7IxjX1xpXQXAmomMr8iUImijAzPUalva3vtVW96IdzO1C8axQYGJyUrKG9clwNW1fojZh8iUoDi9QLWgNTh6cMU7C8oN+1G/MnltTOHcidyhRlgSohXoWJACzHSdkJORDph+FFd+7jPQYVU+k4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069126; c=relaxed/simple;
	bh=MHb2/5vD2WU5DWcz3JL3Vqwq3igioNFn/4EKiVVxNzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7wnrK/OSNAK9/S/aFpRydk9L6KrIYjw2fx0gQ0FI0BgObBld2AkXQ+2dzez3LZhWZfzICEvA02eqshUTAK4aMZ9ciY1xtnl5u4AExmSLmhVm/JSD5KQ5MapiG8ZF/bYqo9QtJpBURdYQKUiAqeAYvZ9RtlBfnMdNx0EYUA01LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjfYgl9S; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjfYgl9S"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4953d801bso1681418a34.2
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 13:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709069124; x=1709673924; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/MogJCdughUFOB9l8KumeZe5wM94Xq7hIajX/FrmFBQ=;
        b=YjfYgl9SOpCQXmVmaBxqX0rthaWN98O9sVTOAHKO1Th/8PTC5H4RiJiqThqJGsNKFN
         m4a8YUbsF758Y6pJfB5BIX5IzOxbZ1TBXDP9pJ2SLGeCt72COrUE7QpIBtWI8HlmXa2p
         P8KskcyXdt2btm2j8jL4zwJ9RsfAJ+EEeB5/5n14pwmrNX3JrT3b77s4J2cP+xQ4f1vW
         nzOuqKTINqxv1cgnYfVLu064AbETPsZwzvkVXmduQwRuAtEJXkYzqbo2KkEzVXzpcWqZ
         29cC+cGwel/I27AdNjbQK+GE1Wlyz4uJR0QW0TPpP6GRSf0ogMD8RstEpYMxvZwtLf7f
         tbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069124; x=1709673924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MogJCdughUFOB9l8KumeZe5wM94Xq7hIajX/FrmFBQ=;
        b=mw84diherz+sINETpgLkIZVl61d/HrRZcKVT/eCP6yGUdylduSQWpL3uMI8pnPa2yz
         rH/aAihnnnoIhb66Cuj93dnpU03c3nu5naTDasrvmp7BpQLxvVMbuYa+K2ttQnA/Xy1u
         MAI4w9P39XwDzdySgu3P073qxLwF0glvkgEKfztL/96uCnCjnFtIJk8DDcBskBhp6p23
         mnOmcE11u/G2XXbZ10Q9zTwyVo3ToL1Wd0WM3VTx/151Fxh6QReln1bt45jsamzUNjz0
         485/rQlZ9ptk+DQOPOxuuMdlTaThGXGaLN0weX/WgLBrvzZgTb+/RYyjm4b7MwNXk/Pl
         8Tqg==
X-Gm-Message-State: AOJu0YzdWeAvZLBC9ERQxgSJz3sYT8lu0/gDlWcIYZ4xWJuE/tOtMrVF
	KjOLNFdp6OF8qj90w7Kt8Whlu4Uz8gQOmm/fW1gQSvAsrFnFbBooNKhl14SB
X-Google-Smtp-Source: AGHT+IHROJTaBvUJ+tt4pkDt/XLRhXBT9IzHys1ZNC4YaGQdDCNxGD82O5QiUfNnmplwTkKopT19hw==
X-Received: by 2002:a9d:6d17:0:b0:6e4:81c2:a729 with SMTP id o23-20020a9d6d17000000b006e481c2a729mr12378591otp.4.1709069123782;
        Tue, 27 Feb 2024 13:25:23 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l28-20020a0568301d7c00b006e4539f3af4sm1648052oti.71.2024.02.27.13.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:25:23 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] eap-wsc: Silence static analysis
Date: Tue, 27 Feb 2024 15:25:12 -0600
Message-ID: <20240227212521.1510693-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

static analysis complains that authenticator is used uninitialized.
This isn't strictly true as memory region is reserved for the
authenticator using the contents of the passed in structure.  This
region is then overwritten once the authenticator is actually computed
by authenticator_put().  Silence this warning by explicitly setting
authenticator bytes to 0.
---
 src/eap-wsc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 65a97da4ee5e..789a20f032b9 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -695,6 +695,8 @@ static void eap_wsc_send_m5(struct eap_state *eap,
 	size_t encrypted_len;
 	bool r;
 
+	memset(m5.authenticator, 0, sizeof(m5.authenticator));
+
 	memcpy(m5es.e_snonce1, wsc->local_snonce1, sizeof(wsc->local_snonce1));
 	pdu = wsc_build_m5_encrypted_settings(&m5es, &pdu_len);
 	explicit_bzero(m5es.e_snonce1, sizeof(wsc->local_snonce1));
@@ -797,6 +799,8 @@ static void eap_wsc_send_m3(struct eap_state *eap,
 	uint8_t *pdu;
 	size_t pdu_len;
 
+	memset(m3.authenticator, 0, sizeof(m3.authenticator));
+
 	len = strlen(wsc->device_password);
 
 	/* WSC 2.0.5, Section 7.4:
@@ -975,6 +979,8 @@ static void eap_wsc_r_send_m8(struct eap_state *eap,
 	unsigned int auth_types =
 		wsc->m1->auth_type_flags & wsc->m2->auth_type_flags;
 
+	memset(m8.authenticator, 0, sizeof(m8.authenticator));
+
 	if (auth_types & WSC_AUTHENTICATION_TYPE_OPEN)
 		memcpy(&creds[creds_cnt++], &wsc->open_cred,
 			sizeof(struct wsc_credential));
@@ -1022,6 +1028,9 @@ static void eap_wsc_r_handle_m7(struct eap_state *eap,
 	struct wsc_m7_encrypted_settings m7es;
 	enum wsc_configuration_error error = WSC_CONFIGURATION_ERROR_NO_ERROR;
 
+	memset(m7es.authenticator, 0, sizeof(m7es.authenticator));
+	memset(m7.authenticator, 0, sizeof(m7.authenticator));
+
 	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
 	if (wsc_parse_m7(pdu, len, &m7, &encrypted) != 0)
 		goto send_nack;
@@ -1084,6 +1093,9 @@ static void eap_wsc_r_send_m6(struct eap_state *eap,
 	size_t encrypted_len;
 	bool r;
 
+	memset(m6es.authenticator, 0, sizeof(m6es.authenticator));
+	memset(m6.authenticator, 0, sizeof(m6.authenticator));
+
 	memcpy(m6es.r_snonce2, wsc->local_snonce2, sizeof(wsc->local_snonce2));
 	pdu = wsc_build_m6_encrypted_settings(&m6es, &pdu_len);
 	explicit_bzero(m6es.r_snonce2, sizeof(wsc->local_snonce2));
@@ -1123,6 +1135,8 @@ static void eap_wsc_r_handle_m5(struct eap_state *eap,
 	struct wsc_m5_encrypted_settings m5es;
 	enum wsc_configuration_error error = WSC_CONFIGURATION_ERROR_NO_ERROR;
 
+	memset(m5es.authenticator, 0, sizeof(m5es.authenticator));
+
 	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
 	if (wsc_parse_m5(pdu, len, &m5, &encrypted) != 0)
 		goto send_nack;
@@ -1188,6 +1202,9 @@ static void eap_wsc_r_send_m4(struct eap_state *eap,
 	size_t len_half1;
 	struct iovec iov[4];
 
+	memset(m4es.authenticator, 0, sizeof(m4es.authenticator));
+	memset(m4.authenticator, 0, sizeof(m4.authenticator));
+
 	memcpy(m4es.r_snonce1, wsc->local_snonce1, sizeof(wsc->local_snonce1));
 	pdu = wsc_build_m4_encrypted_settings(&m4es, &pdu_len);
 	explicit_bzero(m4es.r_snonce1, sizeof(wsc->local_snonce1));
-- 
2.43.0

