Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6CD2E4
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 22:57:58 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f9083d8849so33104165e9.0
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687215477; x=1689807477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjiAf1ogG1XoOQLG7t0A3h4MTRmYKSBcLCckxVd0mk4=;
        b=boyY/9IRKH9vbkHLkGjZP+jQVBB/fX2Co++XnC3XwQbjXFx+4UZBUvF68zOAliWnUe
         DM6pDbv288WSA40Z7SNDAzcDf73PWgIihEdKB+n+d/IwdbpbgdRhBSh5PkU+WyYNjATi
         Id8cxO+ndFYtgg/mVvilrlKw6ig+1EPJjetLF+Z39ly1swxu6LtfDxFNQUW7fBlggneK
         G8HTe2qlglVK/hwW9bkFEdOzokpG3mEpU86yQvAK8njUgq8x/fls3wXSXlZ8VjxLPl/p
         hPE1hFHceYs9jQ8ENHlg+yMLdL9/b2++uF3vsV42xzobvJo4HcY8p9r/1HcjZ/f6lT58
         rkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687215477; x=1689807477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjiAf1ogG1XoOQLG7t0A3h4MTRmYKSBcLCckxVd0mk4=;
        b=a1yySOcvsv2UROblHc0Ei0hGZFrCogs7I5ws8Dg7UAumJJZeCF7HEyHw1Pz+wMWkrc
         BwBr4WLZH8D4dt5ZZ9FFVmgWRirm+K42JKVjWDXLtegmEQotYbZJycihaIiH+BX0GYHV
         kavpQQjjwNoT6t1tshzKMTpj6qQ8VmRhPTsGYvxqqeTwaxLi8y9frJsxb0yB01omALQb
         cUX/jk1RRNcM2+5PXIS7i5/w+C+FBDuETKgIXSe0ts3VB2mN5vzYZKWsQHmcKzosGDll
         HLhcBtHL88ZFTOHalZR9PLAkxeMN8ZAFHFHCNzhN7RDPQRPfLZk2YdKQwrlgGM0tZV6b
         fMyA==
X-Gm-Message-State: AC+VfDxErjM9IGAO6jPeIODeEIKoIAWd5IaUJN3MSsWyA1OS0lQaHdVb
	tpxowa/vO1sa+wbXoVUJYj0SLfFodMjEtA==
X-Google-Smtp-Source: ACHHUZ7uPCBatwen48Qpp7SfjuKOPDdf5bLTR17dh3T9m0wWwX8MFlKMcjVcZy7lNG6hsfQDvcRw3g==
X-Received: by 2002:a7b:cbd7:0:b0:3f9:ab2:dd91 with SMTP id n23-20020a7bcbd7000000b003f90ab2dd91mr5763985wmi.27.1687215476452;
        Mon, 19 Jun 2023 15:57:56 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b0030c4d8930b1sm571946wrs.91.2023.06.19.15.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:57:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] handshake: add handshake_state_pmkid_matches
Date: Mon, 19 Jun 2023 15:57:43 -0700
Message-Id: <20230619225746.462791-3-prestwoj@gmail.com>
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

This will check if the given PMKID matches the derived PMKID. This
has been exposed as its own API in order to handle the case of the
PMKID being derived using the 'legacy' spec derivation, specifically
with the FT-8021X AKM. The spec was updated to be more clear on what
hash algorithm to use but older hostapd version use the old
derivation. This handles both and will allow EAPoL to accept the
PMKID in either case.
---
 src/handshake.c | 26 ++++++++++++++++++++++++++
 src/handshake.h |  3 ++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/src/handshake.c b/src/handshake.c
index bbab5ab6..7438c85a 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -767,6 +767,32 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
 					use_sha256);
 }
 
+bool handshake_state_pmkid_matches(struct handshake_state *s,
+					const uint8_t *check)
+{
+	uint8_t own_pmkid[16];
+
+	if (!handshake_state_get_pmkid(s, own_pmkid, false))
+		return false;
+
+	if (l_secure_memcmp(own_pmkid, check, 16)) {
+		if (s->akm_suite != IE_RSN_AKM_SUITE_FT_OVER_8021X)
+			return false;
+		/*
+		 * Recent hostapd versions (commit b6d3fd05e3) changed the PMKID
+		 * derivation for the FT-8021x AKM to use SHA256. This may be
+		 * the issue here so try the SHA1 derivation before giving up.
+		 */
+
+		if (!handshake_state_get_pmkid(s, own_pmkid, true))
+			return false;
+
+		return l_secure_memcmp(own_pmkid, check, 16) == 0;
+	}
+
+	return true;
+}
+
 void handshake_state_set_gtk(struct handshake_state *s, const uint8_t *key,
 				unsigned int key_index, const uint8_t *rsc)
 {
diff --git a/src/handshake.h b/src/handshake.h
index d9505593..3e3841bf 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -271,7 +271,8 @@ void handshake_state_override_pairwise_cipher(struct handshake_state *s,
 
 bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
 				bool force_sha1);
-
+bool handshake_state_pmkid_matches(struct handshake_state *s,
+					const uint8_t *check);
 bool handshake_decode_fte_key(struct handshake_state *s, const uint8_t *wrapped,
 				size_t key_len, uint8_t *key_out);
 
-- 
2.25.1

