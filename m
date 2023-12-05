Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2B5F1D8
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/tM+3+z"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67a9b393f53so15366646d6.0
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791214; x=1702396014; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8m+HV8zJEKGuNGrOene7oRzTO4rBmRSywZwjO7i4ppk=;
        b=I/tM+3+zFTzD2Ly4hdTh0CJeBad/KsdsGSW+ANjhO9vZuNitnDZESKMqXvuZthWJ5/
         Apt7qNzNmofimyp/vNXvlnyZSQbGLWi/z+v1RXIcM9j+DH93FDnIH7Jz5JqJp8Ha5WyS
         lGZovxlPm1RHHnnAdZiuG8Ho5IaYDw/5pV/Y4BomzWSYfvskAo7sjF7XDU4IRynX12xx
         IUgskszcqkipgYGJnAAxFjgxgYu/iMCG8Caa1QKCbmpqFJ46d1/wazufFkhyRqGy5lr8
         e24PGhb88YUdWdEkUQA4AR2Toi7mPaFV00Z0+iDTBBOZ0tZ8tNlDsJB4vsTVRf7aS8uw
         r3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791214; x=1702396014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m+HV8zJEKGuNGrOene7oRzTO4rBmRSywZwjO7i4ppk=;
        b=PbfYtb0dAnEVWe3HxEPVEPfIDTXngCXWki4kAet6vPU3uzbLXuwY9q0L7tWyJUmLNX
         IK7/IwPNCddpbnueMW37EVXXdYajpOCEjkWzo0MFXA7N5S+klNu6CWbm/nMtSrns4Bi0
         r4sOCfggP11tWUhYfg/ZTm1J+8rQCFyS5dCZgOlClyc1sN/brYwzjkygz+I/UtZCTzFN
         wwoSUc6pldt9daeMxSXZTa2ynJ+Zufqi9ZQgYA4+Q92cIOu4vLXVHZJfPYe7u4QSU68Z
         9zWD1l+fTgcExdX1046qEYyUhazdIE5mc1h5LI+rdhsdgD0ryvgokTaQliWB3onRBP8F
         MVkA==
X-Gm-Message-State: AOJu0YyUqWMhPQALz8tECx9yiFkPyEXx7gHySRiMfRQ4e3mWvTfyyBYw
	okqb+4uz18++alYFylfcicM64ERjw+o=
X-Google-Smtp-Source: AGHT+IGjOtVPh4Bj1KhqJWMAuATirBflDkDV5E7K/wSkkFkwTJ1o8bUotCwr4bfzhuoW8tRpWRNqLQ==
X-Received: by 2002:a05:6214:584a:b0:67a:a721:ec06 with SMTP id ml10-20020a056214584a00b0067aa721ec06mr1219894qvb.74.1701791214401;
        Tue, 05 Dec 2023 07:46:54 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:46:54 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/10] scan: parse password identifier/exclusive bits
Date: Tue,  5 Dec 2023 07:46:38 -0800
Message-Id: <20231205154647.1778389-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These bits are used to communicate to the station that SAE password
identifiers are used or required.
---
 src/scan.c | 20 +++++++++++++++++---
 src/scan.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 5aa92a90..f48ffdef 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1404,10 +1404,24 @@ static bool scan_parse_bss_information_elements(struct scan_bss *bss,
 			 * Currently only Proxy ARP bit (12) is checked, and if
 			 * not found, this is not a fatal error.
 			 */
-			if (iter.len < 2)
-				break;
+			if (iter.len >= 2)
+				bss->proxy_arp = test_bit(iter.data, 12);
+
+			/*
+			 * 802.11-2020 Table 9-153
+			 *
+			 * The spec merely mentions the "exclusive" bit and
+			 * doesn't enforce a requirement to check it anywhere.
+			 * But if set it would indicate the AP will only accept
+			 * auths when a password ID is used so store this in
+			 * order to fail early if no ID is set.
+			 */
+			if (iter.len >= 11) {
+				bss->sae_pw_id_used = test_bit(iter.data, 81);
+				bss->sae_pw_id_exclusive =
+							test_bit(iter.data, 82);
+			}
 
-			bss->proxy_arp = test_bit(iter.data, 12);
 		}
 	}
 
diff --git a/src/scan.h b/src/scan.h
index 0db7752d..65caf41c 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -88,6 +88,8 @@ struct scan_bss {
 	uint8_t cost_level : 3;
 	uint8_t cost_flags : 4;
 	bool dpp_configurator : 1;
+	bool sae_pw_id_used : 1;
+	bool sae_pw_id_exclusive : 1;
 };
 
 struct scan_parameters {
-- 
2.34.1

