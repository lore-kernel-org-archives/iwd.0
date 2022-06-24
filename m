Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1583D9D
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:09:59 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id k127so3739459pfd.10
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHQnhPHKIpKt6hHT6rxlnQpXZIaF7nIGw0kXZLa8d9I=;
        b=QCmvrwuVB+DbCjSE6K62NqDb598LoDruYFv7KAuHRm/BeuFI1fJ3jpmuqijulcvcFG
         LAnaMk4/h+vk4jxjB9PcZ5QwH+0PGQB43aHlgWeUUs6NOQDegh3UyhEQo/8+IdVRwkKh
         duZUiqHSQ2oqMRmQylqduMvHbeDGySe1BDYQJ06kXwa7xo1QIdwaiZOglVRpqJ9Ny7Zk
         E0NQgEPM1yFsO9bIus562GDdZdwyRnUzXJ8PfAvCy2wuDid6O+lunnFCx8dWF7PavMYl
         LARmPZfrnqAizBTywDeNVdo/uq0N8eIoH04WzowfDCMomKlv7917sNGqmlYCL9XbCNyy
         lcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHQnhPHKIpKt6hHT6rxlnQpXZIaF7nIGw0kXZLa8d9I=;
        b=r/kzvO/YksipSEOZsXnJdUjxtVFCXsPYglm2kCGXWDu45vMEEFJhmRN9XMBOj6In8r
         PUO/HpnaAdwaoFAxRmV6G6FTbXBA1IZAKiekhCSX7O+O54EPfDXj9iaV/FsYC0rt9mdN
         QzDxVvPlNNmev2j2nczaRzgR+ZUQgySr0+/USRyuRtsyoy3IWoMK9z357WSsHSgBGb7m
         qQtLt4LSswp5Il4ACrGltzqXkAVborZ9HMbBg3xYCZ6vo8jbfyA1pLnA6omTdvG3GFMA
         L+k15+MZlD3jSCfCGB3xFn4GwEDBbEkDjb9pEb+vo78sWUTgt/omdSBZmK4/FhLPhmx4
         Oe0w==
X-Gm-Message-State: AJIora+EyFu+uBYwojsFwWoLT87ZObwNmRBhEsspOOIDFpayzYyVib4f
	S9OY0ZuYzriAIzoh3VXq3WHKwwyH5OY=
X-Google-Smtp-Source: AGRyM1vHa2J2bIpatQI21TbU5KNN/AsO51+cfTmEHAZFHvhF2VRK7Gj+QNu4PqOzLP9fRZQrnLKB5w==
X-Received: by 2002:a05:6a00:139b:b0:525:3e1b:f630 with SMTP id t27-20020a056a00139b00b005253e1bf630mr1270748pfg.54.1656112199039;
        Fri, 24 Jun 2022 16:09:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] eapol: allow 'secure' to be set on rekeys
Date: Fri, 24 Jun 2022 16:07:40 -0700
Message-Id: <20220624230741.1957863-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624230741.1957863-1-prestwoj@gmail.com>
References: <20220624230741.1957863-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

About a month ago hostapd was changed to set the secure bit on
eapol frames during rekeys (bc36991791). The spec is ambiguous
about this and has conflicting info depending on the sections you
read (12.7.2 vs 12.7.6). According to the hostapd commit log TGme
is trying to clarify this and wants to set secure=1 in the case
of rekeys. Because of this, IWD is completely broken with rekeys
since its disallows secure=1 on PTK 1/4 and 2/4.

Now, a bool is passed to the verify functions which signifies if
the PTK has been negotiated already. If secure differs from this
the key frame is not verified.
---
 src/eapol.c | 14 ++++++++------
 src/eapol.h |  5 +++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 9f885d02..e8bd5cdb 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -443,7 +443,8 @@ static void eapol_key_data_append(struct eapol_key *ek,
 	if (ek->error)		\
 		return false	\
 
-bool eapol_verify_ptk_1_of_4(const struct eapol_key *ek, size_t mic_len)
+bool eapol_verify_ptk_1_of_4(const struct eapol_key *ek, size_t mic_len,
+				bool ptk_complete)
 {
 	/* Verify according to 802.11, Section 11.6.6.2 */
 	VERIFY_PTK_COMMON(ek);
@@ -457,7 +458,7 @@ bool eapol_verify_ptk_1_of_4(const struct eapol_key *ek, size_t mic_len)
 	if (ek->key_mic)
 		return false;
 
-	if (ek->secure)
+	if (ek->secure != ptk_complete)
 		return false;
 
 	if (ek->encrypted_key_data)
@@ -475,7 +476,7 @@ bool eapol_verify_ptk_1_of_4(const struct eapol_key *ek, size_t mic_len)
 	return true;
 }
 
-bool eapol_verify_ptk_2_of_4(const struct eapol_key *ek)
+bool eapol_verify_ptk_2_of_4(const struct eapol_key *ek, bool ptk_complete)
 {
 	uint16_t key_len;
 
@@ -491,7 +492,7 @@ bool eapol_verify_ptk_2_of_4(const struct eapol_key *ek)
 	if (!ek->key_mic)
 		return false;
 
-	if (ek->secure)
+	if (ek->secure != ptk_complete)
 		return false;
 
 	if (ek->encrypted_key_data)
@@ -1151,7 +1152,8 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 
 	l_debug("ifindex=%u", sm->handshake->ifindex);
 
-	if (!eapol_verify_ptk_1_of_4(ek, sm->mic_len))
+	if (!eapol_verify_ptk_1_of_4(ek, sm->mic_len,
+					sm->handshake->ptk_complete))
 		return;
 
 	if (sm->handshake->ptk_complete && unencrypted) {
@@ -1523,7 +1525,7 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm *sm,
 
 	l_debug("ifindex=%u", sm->handshake->ifindex);
 
-	if (!eapol_verify_ptk_2_of_4(ek))
+	if (!eapol_verify_ptk_2_of_4(ek, sm->handshake->ptk_complete))
 		return;
 
 	if (L_BE64_TO_CPU(ek->key_replay_counter) != sm->replay_counter)
diff --git a/src/eapol.h b/src/eapol.h
index 53ae6e8f..8d8d5252 100644
--- a/src/eapol.h
+++ b/src/eapol.h
@@ -65,8 +65,9 @@ uint8_t *eapol_decrypt_key_data(enum ie_rsn_akm_suite akm, const uint8_t *kek,
 				const struct eapol_key *frame,
 				size_t *decrypted_size, size_t mic_len);
 
-bool eapol_verify_ptk_1_of_4(const struct eapol_key *ek, size_t mic_len);
-bool eapol_verify_ptk_2_of_4(const struct eapol_key *ek);
+bool eapol_verify_ptk_1_of_4(const struct eapol_key *ek, size_t mic_len,
+				bool ptk_complete);
+bool eapol_verify_ptk_2_of_4(const struct eapol_key *ek, bool ptk_complete);
 bool eapol_verify_ptk_3_of_4(const struct eapol_key *ek, bool is_wpa,
 				size_t mic_len);
 bool eapol_verify_ptk_4_of_4(const struct eapol_key *ek, bool is_wpa);
-- 
2.34.1

