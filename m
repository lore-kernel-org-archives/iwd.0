Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC48D2E4
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 22:57:56 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-311275efaf8so2676235f8f.3
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687215474; x=1689807474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQfxvlD3gUCUznP/r83BfpPTdjYni+gQnWezYrWXOTA=;
        b=oxR2ak5/eKwk0CNa838Je5xUFBVQA1lxPvJyk+NjiCnTDODjZAxCFUQpv2QQYrv/UB
         k8+f0njh+uIQVu8R+zbBgSnWXI6He3N7pjjxYMbFoeF1rcgxovV7bRAUnsfSD0yTcc8c
         s7DPCBlvVt+nXq6gCWSod994AX/cdvf4M9N8YsOPUJrlnAWqrpvcf5raTModMGmCdvIw
         t4kaMprVHbaWmd48f6fVC37ROWLLv3Fzu30ZKU8G5dEGvqXq1TzaFc9Zt8B+M6KU1cv3
         UAEiHH5ktm1MvJT3B7kqdBZkYi3HnOK+vIgzHfuIX0PSW1DnVyH2Aru0pzIzSr/lcNGO
         4kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687215474; x=1689807474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQfxvlD3gUCUznP/r83BfpPTdjYni+gQnWezYrWXOTA=;
        b=El1NsT/5nv24OMK3b3IyvUuqffiYuHmZ9bV4lzoKr/wH6CgDg7EFOt0C/E77vs3vrB
         QQgkttp9gXeOCld+2mfTP8/TTphTGJj6VmEqrsiIFUNrJP9IPKRfyXHLPB8XpMfcmxJn
         Z2HlHky8fJrciXg1Wrbg0OFWpMhkPxKbLWgYG0EKgITq1MbVHm8glccIt80wR+j0TkdH
         iOTlc8dKxZ02qyyc1PNE0xIvtKA8htNILpBcmzKUSO3UiwJIk2uyz9YHOj823iJPK2LO
         aWXZUoC1k5Rbo1zD3OwJhtrzpexlCXLgCpYQprTdo3IOqtUHk7BAefHvqHI6XJ58sfi2
         313Q==
X-Gm-Message-State: AC+VfDzA8Rl+nK9VRZJNRMuGwuyLEyqnnMb6h9pXYTMUfUoHNrbuJPIS
	OmPdcutOSqrBk2Vos1DDnQLWiurcEoQKhA==
X-Google-Smtp-Source: ACHHUZ5Gzq3N2wUHxMS8kdfdyQ9CVJMZGkKivDtbKue8CNFkXBLlkhVgBUYhUlMB5K9r9rnjjhU5Eg==
X-Received: by 2002:a5d:6e42:0:b0:306:31fb:1c3e with SMTP id j2-20020a5d6e42000000b0030631fb1c3emr6420327wrz.26.1687215474694;
        Mon, 19 Jun 2023 15:57:54 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b0030c4d8930b1sm571946wrs.91.2023.06.19.15.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:57:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] handshake: add FT_OVER_8021X AKM for SHA256 PMKID derivation
Date: Mon, 19 Jun 2023 15:57:42 -0700
Message-Id: <20230619225746.462791-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619225746.462791-1-prestwoj@gmail.com>
References: <20230619225746.462791-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hostapd commit b6d3fd05e3 changed the PMKID derivation in accordance
with 802.11-2020 which then breaks PMKID validation in IWD. This
breaks the FT-8021x AKM in IWD if the AP uses this hostapd version
since the PMKID doesn't validate during EAPoL.

This updates the PMKID derivation to use the correct SHA hash for
this AKM, and following patches will address backwards compatibility
with older hostapd versions.
---
 src/handshake.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/handshake.c b/src/handshake.c
index 7f749632..bbab5ab6 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -757,7 +757,8 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
 	 */
 
 	if (!force_sha1 && (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
-			IE_RSN_AKM_SUITE_PSK_SHA256)))
+			IE_RSN_AKM_SUITE_PSK_SHA256 |
+			IE_RSN_AKM_SUITE_FT_OVER_8021X)))
 		use_sha256 = true;
 	else
 		use_sha256 = false;
-- 
2.25.1

