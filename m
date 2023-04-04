Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E0323B
	for <iwd@lists.linux.dev>; Tue,  4 Apr 2023 20:38:28 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id x15so31862640pjk.2
        for <iwd@lists.linux.dev>; Tue, 04 Apr 2023 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680640708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRhiP0/BQ7wL9Z+MlCileSobMwYpkaVpr4UXSVoVO50=;
        b=f/cif/ceyOF14eyE2rIpjISOJ8yBZVWk2zGbaInQJTp7J6QCOMzR8PxozBfsDR0P/n
         14cakYXqmWHjDcCE4vhnguUcnRQ/mXH46ClGeD4L0bv4hB7BrHHCCH+NqlOIGHm4mIc8
         BmjfsQNosuFnEdHcDFZXF2h3kLlquzu4/T5o5jQgtq/L8OaxDhAenHn4JxM+ec8kNbLz
         bHrRkOKPLRQj//s5dx2u0iwzJlq+4lnbSH9z2+bBkpUp3FihhFEGCsbcIJarBuO00zkI
         0CUgeH19wuIiLsrj7aWE/AmprmScmfKFVY72bPuW8juv0cuCrNdnj9pVdJWeBw4mo1Cd
         RA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRhiP0/BQ7wL9Z+MlCileSobMwYpkaVpr4UXSVoVO50=;
        b=NPqCe0uAKdwkiaNq6bzimX5A71cITdr0oZalKv7yfAO8qWmtKoghEB5gDX+XUh3CpM
         uYzmV/mr2y1xrB134s4ec6YfLXLwCw40r/4OJckKDBRyJJ9yxKjs42gWvDv/2Mm0E9N5
         e//cZeZW0Glx3Rszn17GRkJSvEKvTuOhtFqrI1Q5KBEm+JX7XxEq36cn3nMz8ZJwil8+
         eicTZrYK9700Pq8z3JnOn5hesthr9fz2/H0wlyfNgefcUa8paPp/ZfFNDCFdDxb3Ff2b
         Oeju771I0kFWt3EmDiQwdSNgyFmy6Z3ZSACrnrFy9kfcV6lzHqSnI7YLoiTmt8vyI01E
         9s7Q==
X-Gm-Message-State: AAQBX9f8c/jft7SqctrJH/NebA6zApYhRUdF3232TfcpFMh7PfLALwLM
	vTmC2zYb4SBjdMyNak8wci3X9zY3g0wVrg==
X-Google-Smtp-Source: AKy350Y1Dq6nWVsbc6FIq3zIc4kiy2hJjoL1Q8gSoebI9uL/vkZWJ5juiqGw7+uQBvfL/F5ltO8mSw==
X-Received: by 2002:a17:90b:4ac7:b0:237:8417:d9e3 with SMTP id mh7-20020a17090b4ac700b002378417d9e3mr4166680pjb.15.1680640707837;
        Tue, 04 Apr 2023 13:38:27 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001a21cde3458sm8755417plr.90.2023.04.04.13.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:38:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID generation
Date: Tue,  4 Apr 2023 13:38:22 -0700
Message-Id: <20230404203823.384260-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 802.11 spec defines what AKMs should use sha256 to derive the
PMKID. Hostapd commit b6d3fd05e3 changed the PMKID derivation in
accordance with 802.11-2020 which then breaks PMKID validation in
IWD. This breaks FT-PSK/8021x AKMs in IWD if the AP uses this
hostapd version.

Updating IWD to use sha256 in these cases will now break backwards
compatibility with *older* APs, but this will be worked around in
future commits.
---
 src/handshake.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/handshake.c b/src/handshake.c
index 734e997c..e4c856bb 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -753,10 +753,23 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 	 * preauthentication, the AKM has not yet been negotiated. In this
 	 * case, the HMAC-SHA1-128 based derivation is used for the PMKID
 	 * calculation."
+	 *
+	 * 802.11-2020 Table 9-151 defines the hashing algorithm to use
+	 * for various AKM's. SHA256 should be used for the following
+	 * AKM's (for this API context):
+	 *
+	 * 00-0F-AC:3 (FT-8021X)
+	 * 00-0F-AC:4 (FT-PSK)
+	 * 00-0F-AC:5 (8021X-SHA256)
+	 * 00-0F-AC:6 (PSK-SHA256)
+	 *
+	 * (Note SAE/FILS were left out as they generate their own PMKID)
 	 */
 
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
-			IE_RSN_AKM_SUITE_PSK_SHA256))
+			IE_RSN_AKM_SUITE_PSK_SHA256 |
+			IE_RSN_AKM_SUITE_FT_OVER_8021X |
+			IE_RSN_AKM_SUITE_FT_USING_PSK))
 		use_sha256 = true;
 	else
 		use_sha256 = false;
-- 
2.25.1

