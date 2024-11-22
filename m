Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE621DF99E
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288574; cv=none; b=UOSLKKjNQSL4zPlxNQMLJXRHEM8Vv0aaOTcEz/A17bous/cBGVQiATbdwAyVqcMl+ZQi4To+/PcV2qRf2ZpSoRrYCSYi1AtB3BNuztFMtmIKnUwtdfJdHyT7AmM5wjQ83+rhvkrzGXJzvC1ryYP6v0Uo/AnZ6MKUHuG99zs+3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288574; c=relaxed/simple;
	bh=r4P8q139hjoAa4Omu3oa5TeH/RnzK6yAGa+FRHnh1Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGeLPWFZELUs4UrkZq3Jjkp1w0IAnn2ttb38rB9EoVBxoSJ+T7XIB/nqHxdouOEQwWSFJ5pHEZJWGmZaQlL11f556eQgGwQgfVeZPZkW8jsXNcqX1Q/Z0uGLYui5Xw+pEgynarexmCVW67RCRddjPWWRUIPCEO36f4ufKax2H1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI4yJIG4; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI4yJIG4"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d4241457b7so12728716d6.2
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288572; x=1732893372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1op6WaQ6eSX7k/vlLsIm129sQQqpo51cEuN6bTvB8s=;
        b=CI4yJIG4jD0MgSFnpAvnEwWUJh+oB2hZTMBRMjt1Jw3mADwGQn+f73dys5YYFPCkRx
         VoxHmfCMXf47JU08TtMjYS7fvmG3Fo+pY9YbP/1yvQiPxa2d8mGbB69Or9MTq7BnHSbA
         PoTQPTrY4mSTjnUiq5UPpG+/RqRQD5KkTY+U4klrP0JkFk30NOWyN9gDunJx1s4M1K8F
         otulJ0QXOPdw7LgtxvHz3UpaqW0jN24GaRZIP2g4zWYGNJiP/OSY+x8hom8Yvgf40Czk
         hhlFksLNljnQK/4iJ6CJF/4h6gRHtcIzP5quYp0QER0pBxnJG0eFHca9KiIFfLCrw6YL
         t5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288572; x=1732893372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1op6WaQ6eSX7k/vlLsIm129sQQqpo51cEuN6bTvB8s=;
        b=exMuNxPk64A/UGxPEB4y4/S3jvXQPOIIFSa+vLIid5wyZ38WE//iGhTtnw7oW3hR37
         LuYLa9M40YDvVA4fvvT5uspV51P1fcyMZDjAbfKNqG6VrjigeifzONbbadooYa62wXt8
         RLheyCyaAYhW1Voz0qI5LhV95WQbPaJ1vn9rd+i0GzSzGO6GVG93wk8PkqHpE/wcdER0
         Q5aKWLKJgnGMhW8ZJWAb5XR+2UI8CViQiaqsMzURpx7sRXMmr/8qtaQkJ3mQJUQEE0jq
         6iMfzcj4C0OgG+JUtpW2gNgKjEg0cjh8MR801XGL3Mo9VlqxuyBPGMZeWectcx3IMDqv
         pgmA==
X-Gm-Message-State: AOJu0YzHl+EsRP3RdzT/FFaJAxmi9vGFE2KihmhRb3EWP3XkkZOqNcZ0
	il8EEAaUmw7W4nQfTQFAJ/Hjh/3LOuqAtFK+MqsQ8YODl2CG6JljoTN0fA==
X-Gm-Gg: ASbGncuJ/1PPaWiNa3frxVJutfbVaxR4X9EaBYB3usZMRtnSIBzJpx8T+DnY5giw+8e
	31KqTqrApNAg1cyJzptJ9T/v5zk4cA0LVp+wRCyv6SSOCTWWQIUZsZT14BYAxmypY9VWKYsEZhw
	Cul7fuz5tBB98O1lshY6Lp3neuT1AeNnnUp9sq7Qlwu6YkHUe4VC3hh0aw99gIJPUlBykVp3Gpv
	JxMqRpxP3xqFu3q6jySHGZp5MeLhNy6U4xuAaoCB/2qVhjwlqNjQyYEjMdg
X-Google-Smtp-Source: AGHT+IHIv0rnOwSkHitp1/WmOxqr4CAzwu4SO4nAQhyjQABn+uFmUZ5Do61kQukuLJK5uU6P4kRYug==
X-Received: by 2002:ad4:5ba9:0:b0:6d4:20fa:83f0 with SMTP id 6a1803df08f44-6d451358550mr44185146d6.41.1732288570466;
        Fri, 22 Nov 2024 07:16:10 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/15] handshake: add handshake_state_remove_pmksa
Date: Fri, 22 Nov 2024 07:15:46 -0800
Message-Id: <20241122151551.286355-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in order to clear the PMKSA from the handshake state
without actually putting it back into the cache. This is something
that will be needed in case the AP rejects the association due to
an expired (or forgotten) PMKSA.
---
 src/handshake.c | 16 ++++++++++++++++
 src/handshake.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index a93143d1..f73f91d1 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1280,3 +1280,19 @@ void handshake_state_cache_pmksa(struct handshake_state *s)
 	if (L_WARN_ON(pmksa_cache_put(pmksa) < 0))
 		l_free(pmksa);
 }
+
+bool handshake_state_remove_pmksa(struct handshake_state *s)
+{
+	struct pmksa *pmksa;
+
+	if (!s->have_pmksa)
+		return false;
+
+	pmksa = handshake_state_steal_pmksa(s);
+	if (!pmksa)
+		return false;
+
+	l_free(pmksa);
+
+	return true;
+}
diff --git a/src/handshake.h b/src/handshake.h
index cf7dc48c..e4a00531 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -310,6 +310,7 @@ int handshake_state_verify_oci(struct handshake_state *s, const uint8_t *oci,
 
 bool handshake_state_set_pmksa(struct handshake_state *s, struct pmksa *pmksa);
 void handshake_state_cache_pmksa(struct handshake_state *s);
+bool handshake_state_remove_pmksa(struct handshake_state *s);
 
 bool handshake_util_ap_ie_matches(const struct ie_rsn_info *msg_info,
 					const uint8_t *scan_ie, bool is_wpa);
-- 
2.34.1

