Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F12D5C9F
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892294; cv=none; b=nETXroWKbrv0kavAP1sxFi1fKJvxZseC/Smw2efSsQh16UUShStMcJd/4WaYW2mizlg51NrrNBCegE+TWvPOjyRtN1kPMHoko5cIx9l+XGtrBr7nWcMUaZwMmc3jqTyQ3owNEJAPN6QLiFN4aVOYofS+LMnqwTW65o34iUDcvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892294; c=relaxed/simple;
	bh=LrSgY8sOr3kKqOJLuSm+TeIA7CYhRSdAVmXGINoh9LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4C/DdVs6T0mBz8hBiREg5f9Y0OO7PRGMZWp46YdX4FgiOR9rqKnlwF2J6d4ppRoKRz2aYbEqFramHXrO7L8yLV9RZrnc9Ca++7Qwa1aJg0eveV44+swMRfb4HzJ28eypOfVqIMpbgLRcsHhoAR5ASnNRobuXgbZBB6lkZHbYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laEOY/PE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laEOY/PE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109919a09so30652961cf.0
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892291; x=1756497091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRJqIhXFuK13gkU+BfSsuPdeFTVOKoEHKVHH9qXUtYk=;
        b=laEOY/PEekzjbBMOdRcFaBYXrYfBLEYkEaFlCZLviYZOjqxs4o7zz3HgC5Dr+i3UNm
         dddM7DNcnp2ypMLGqlzNWalDytqeJzdhWyaTk9of2V0RI9zueGKcQozCPKRuQhvxFRDc
         d7d+JGfZx0k5/ujGZiBqvKIMzZZr5PFWeOevv/Q2VaE/Y2ZOi/JsboiYSNy65HK7sDG5
         pBaXdR2k/fZg9OEHHJWibYmsomIlIqreQ74iwWjHgpH2mKRyRVoZKRz5P1kP81C7DGwa
         sEmf1xlqGm0dG585Rwko5wke0pM36X2XxVj5XsegvxYkWDmQCf+qV4tZmPAX/jEBa3f5
         rsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892291; x=1756497091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRJqIhXFuK13gkU+BfSsuPdeFTVOKoEHKVHH9qXUtYk=;
        b=JZUsrvYPR/0cvO4CuOPaEUyhZCbIJg3Rv1p7IDaPXDLla1734+f6lZP/skqXaMOitB
         o2/VuDt85LCFYZStY4ZIq4iqs3hi+AkX5psyjSS610eqhHtAEObLyAhmqpCRHb9DFclP
         7WVin5FHpMbvAmh6Z/iYyGnPXVn3C2uE6eeGAoqDt2W0KK0p3sHEf8KPb1I7A5z0tgg+
         zopE8ysHAlepF+0J/zBrBULRAmP2p0l3oQbUb08Hl6fy1JArKjPOII4ob9jzp0PHI1mA
         M8LKedzkeR96ajZpyVQBOkLPq5gdfANI1YdyXlJjj9q6JtsweG+cVxDBIBoUZvMT4nd9
         ZMNg==
X-Gm-Message-State: AOJu0Ywu9Kwj7pOmCwLJKUfE0yApPPkAtgj8xTRegMm9MS2cAe/Sgyr9
	hIlKA9EmS7Ogu757yU/G2pp4VBfldrCuDGJ6TO9GLusFPEhx2zHBx9OHHmy9zA==
X-Gm-Gg: ASbGncuNG+uKKYoqdNy/IEiH4bMwRs/0EFBBlS1rKVssHio2PHEC3gtzpdp5u/R9MBh
	HG/F0QLuYsHBPGgsHkkh1g/Ey5MU4QAviEy+stbqPV4x0NzLr2OG8+rO7tKkNqvZlVVO3I5cg6e
	Sqrwsq7ZpMMltfG5+MBUW3qmExIWykCRxD68Q+rfRgDVeBaT+lDbC8uHzKFhq9GkNXIlW9TWGKQ
	tiFi6crZDUgouWXecNi0LiaWiJFJoJvfCEyPI7K/PRiU0pWPsEgkajUcvPQqXVhNVqN0PBu2ybl
	uCyDIPhTFIRTGzEwdG0aDpt84qsFKIEvkWjGClFsveU+Owh0XLeFki5hSayBIXvaThKnLxEMiE4
	7z8gDY7roTvMuCujSGVmilMUIpRksg3GB
X-Google-Smtp-Source: AGHT+IFmQ9oQlIG1AG6rE6Ks6kWhBhVQM1w8uVraN9IgC/QpCUZpRbGX/KmzdbgiHtC89su3lLrkxg==
X-Received: by 2002:a05:622a:1a0d:b0:4b0:7950:8ce8 with SMTP id d75a77b69052e-4b2aab3c2fbmr45862981cf.53.1755892291365;
        Fri, 22 Aug 2025 12:51:31 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/15] handshake: pass object to handshake_util_ap_ie_matches
Date: Fri, 22 Aug 2025 12:51:10 -0700
Message-Id: <20250822195118.271122-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare for supporting a vendor quirk, where we'll need
the handshake to lookup if the quirk to disable a specific check.
---
 src/eapol.c     |  2 +-
 src/ft.c        | 10 ++++++----
 src/handshake.c |  3 ++-
 src/handshake.h |  3 ++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 6e37a54a..ab77746f 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1810,7 +1810,7 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm *sm,
 
 	if ((rsne[1] != hs->authenticator_ie[1] ||
 			memcmp(rsne + 2, hs->authenticator_ie + 2, rsne[1])) &&
-			!handshake_util_ap_ie_matches(&rsn_info,
+			!handshake_util_ap_ie_matches(hs, &rsn_info,
 							hs->authenticator_ie,
 							hs->wpa_ie))
 		goto error_ie_different;
diff --git a/src/ft.c b/src/ft.c
index d8bee74c..0d6be4d4 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -223,7 +223,8 @@ static bool ft_parse_associate_resp_frame(const uint8_t *frame, size_t frame_len
 	return true;
 }
 
-static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
+static bool ft_verify_rsne(struct handshake_state *hs,
+				const uint8_t *rsne, const uint8_t *pmk_r0_name,
 				const uint8_t *authenticator_ie)
 {
 	/*
@@ -253,7 +254,7 @@ static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
 				memcmp(msg2_rsne.pmkids, pmk_r0_name, 16))
 		return false;
 
-	if (!handshake_util_ap_ie_matches(&msg2_rsne, authenticator_ie, false))
+	if (!handshake_util_ap_ie_matches(hs, &msg2_rsne, authenticator_ie, false))
 		return false;
 
 	return true;
@@ -301,7 +302,8 @@ static int parse_ies(struct handshake_state *hs,
 	is_rsn = hs->supplicant_ie != NULL;
 
 	if (is_rsn) {
-		if (!ft_verify_rsne(rsne, hs->pmk_r0_name, authenticator_ie))
+		if (!ft_verify_rsne(hs, rsne, hs->pmk_r0_name,
+					authenticator_ie))
 			goto ft_error;
 	} else if (rsne)
 		goto ft_error;
@@ -480,7 +482,7 @@ int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 				memcmp(msg4_rsne.pmkids, hs->pmk_r1_name, 16))
 			return -EBADMSG;
 
-		if (!handshake_util_ap_ie_matches(&msg4_rsne,
+		if (!handshake_util_ap_ie_matches(hs, &msg4_rsne,
 							hs->authenticator_ie,
 							false))
 			return -EBADMSG;
diff --git a/src/handshake.c b/src/handshake.c
index c469e6fa..92edac30 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -877,7 +877,8 @@ void handshake_state_set_igtk(struct handshake_state *s, const uint8_t *key,
  * results vs the RSN/WPA IE obtained as part of the 4-way handshake.  If they
  * don't match, the EAPoL packet must be silently discarded.
  */
-bool handshake_util_ap_ie_matches(const struct ie_rsn_info *msg_info,
+bool handshake_util_ap_ie_matches(struct handshake_state *s,
+					const struct ie_rsn_info *msg_info,
 					const uint8_t *scan_ie, bool is_wpa)
 {
 	struct ie_rsn_info scan_info;
diff --git a/src/handshake.h b/src/handshake.h
index c6e3c10b..b8891490 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -312,7 +312,8 @@ bool handshake_state_set_pmksa(struct handshake_state *s, struct pmksa *pmksa);
 void handshake_state_cache_pmksa(struct handshake_state *s);
 bool handshake_state_remove_pmksa(struct handshake_state *s);
 
-bool handshake_util_ap_ie_matches(const struct ie_rsn_info *msg_info,
+bool handshake_util_ap_ie_matches(struct handshake_state *s,
+					const struct ie_rsn_info *msg_info,
 					const uint8_t *scan_ie, bool is_wpa);
 
 const uint8_t *handshake_util_find_kde(enum handshake_kde selector,
-- 
2.34.1

