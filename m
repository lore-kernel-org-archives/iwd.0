Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040C2AB3F
	for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 17:25:43 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3ff32b8e748so2304471cf.1
        for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281942; x=1689873942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60shYAOTm0ZbeM2jDyypPAEU/LmdO7p7T11CsEnc3WE=;
        b=riLU08Hpw+R1XS2aCiNCvwoCior3ic2ATfIS+0rrZcVjbrJIw/GyYiShV8Yeg3141j
         3qmAPhKsdlte4cD4TJaZboC479iISfPGzW3vDwZo4B7Rpg/50bk8KQb/N2qRM3z6BCQh
         uTg/sqNoxj7JhBdBc1l11f45szMWbn+EdbENPjD2orxNNQYYEBrOAa5VA5s6vCGAinbv
         ToNOr9Kq6m6wTmZlDneOCVS1ATHKN90LlbbPivFV2Qnqc1ZsaNs4PgjOZIQD1fKsaYej
         gtz7C0wDqBLcD0FEjY4EYpAwu3mq7QM7JbRAg3RIehdcxB/blIowhuKjAHs6rl3vtXp0
         SfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281942; x=1689873942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60shYAOTm0ZbeM2jDyypPAEU/LmdO7p7T11CsEnc3WE=;
        b=VtvTK+pzywjkQtLG/p9uyFAfVcQ1JGPdUBkb1q3MUOQ+OPAbQdpeHL09dT7UMS6gJq
         MxCbj89N0+4rzFkWthLtfUK+3DQAlrianj40cV58xbWek2H4sTZNSTgi46lINjM2Z9cg
         6R6xNI0ee0O+5AO2j9YX83XE5T9xANEeqerpm7NrdVqIXAnfKTVbEliJtxL8w3UQxXvQ
         WfZvzC7b6YOqfQ3hf3N/6BmcI2OWVpSMmrCwrjEjrF1B5nHo3U73zDKELMEt3MFqd7Ik
         LWQRWHnKBSSJQCL+WPZjPnjvtZMZRN1Y3Y9mh/ptbSycD6IHWtoRlHLc3UpSBS/pNCcx
         Hoog==
X-Gm-Message-State: AC+VfDx8BuZtIFIb6P/apxBN58piQSBgb3u5HxyB/TgCDj9HcJ4GQz4J
	3QuAmlsk4T956/RdqxsPbfSuvaVsi/JSxg==
X-Google-Smtp-Source: ACHHUZ4FCX8GStDg+HJnDxUy5VdhYszIaoZlTwzD2waRjN/OK+eCYFgc48r+70/bkKlEvy2/9aQ7gw==
X-Received: by 2002:a05:6214:21ec:b0:62f:f276:39fe with SMTP id p12-20020a05621421ec00b0062ff27639femr15839603qvj.15.1687281942157;
        Tue, 20 Jun 2023 10:25:42 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g8-20020a0cf088000000b006261e6a88c7sm1475913qvk.36.2023.06.20.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:25:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3 v2] handshake: split handshake_state_get_pmkid into separate APIs
Date: Tue, 20 Jun 2023 10:25:32 -0700
Message-Id: <20230620172533.727504-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620172533.727504-1-prestwoj@gmail.com>
References: <20230620172533.727504-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMKID derivation has gotten messy due to the spec
updating/clarifying the hash size for the FT-8021X AKM. This
has led to hostapd updating the derivation which leaves older
hostapd versions using SHA1 and newer versions using SHA256.

To support this the checksum type is being fed to
handshake_state_get_pmkid so the caller can decide what sha to
use. In addition handshake_state_pmkid_matches is being added
which uses get_pmkid() but handles sorting out the hash type
automatically.

This lets preauthentication use handshake_state_get_pmkid where
there is the potential that a new PMKID is derived and eapol
can use handshake_state_pmkid_matches which only derives the
PMKID to compare against the peers.
---
 src/eapol.c     |  7 +------
 src/handshake.c | 26 +++++++++++++++-----------
 src/handshake.h |  6 ++++--
 src/station.c   | 10 +++++++++-
 4 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index f290f40a..6fb2f306 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1234,12 +1234,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 		if (!found)
 			goto error_unspecified;
 	} else if (pmkid) {
-		uint8_t own_pmkid[16];
-
-		if (!handshake_state_get_pmkid(sm->handshake, own_pmkid))
-			goto error_unspecified;
-
-		if (l_secure_memcmp(pmkid, own_pmkid, 16)) {
+		if (!handshake_state_pmkid_matches(sm->handshake, pmkid)) {
 			l_debug("Authenticator sent a PMKID that didn't match");
 
 			/*
diff --git a/src/handshake.c b/src/handshake.c
index ac5bda51..46755841 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -734,10 +734,9 @@ void handshake_state_set_pmkid(struct handshake_state *s, const uint8_t *pmkid)
 	s->have_pmkid = true;
 }
 
-bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
+bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
+				enum l_checksum_type sha)
 {
-	enum l_checksum_type sha;
-
 	/* SAE exports pmkid */
 	if (s->have_pmkid) {
 		memcpy(out_pmkid, s->pmkid, 16);
@@ -747,13 +746,15 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 	if (!s->have_pmk)
 		return false;
 
-	/*
-	 * Note 802.11 section 11.6.1.3:
-	 * "When the PMKID is calculated for the PMKSA as part of RSN
-	 * preauthentication, the AKM has not yet been negotiated. In this
-	 * case, the HMAC-SHA1-128 based derivation is used for the PMKID
-	 * calculation."
-	 */
+	return crypto_derive_pmkid(s->pmk, 32, s->spa, s->aa, out_pmkid,
+					sha);
+}
+
+bool handshake_state_pmkid_matches(struct handshake_state *s,
+					const uint8_t *check)
+{
+	uint8_t own_pmkid[16];
+	enum l_checksum_type sha;
 
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
 			IE_RSN_AKM_SUITE_PSK_SHA256))
@@ -761,7 +762,10 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 	else
 		sha = L_CHECKSUM_SHA1;
 
-	return crypto_derive_pmkid(s->pmk, 32, s->spa, s->aa, out_pmkid, sha);
+	if (!handshake_state_get_pmkid(s, own_pmkid, sha))
+		return false;
+
+	return l_secure_memcmp(own_pmkid, check, 16) == 0;
 }
 
 void handshake_state_set_gtk(struct handshake_state *s, const uint8_t *key,
diff --git a/src/handshake.h b/src/handshake.h
index 863ffac7..7200c361 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -269,8 +269,10 @@ void handshake_state_install_igtk(struct handshake_state *s,
 void handshake_state_override_pairwise_cipher(struct handshake_state *s,
 					enum ie_rsn_cipher_suite pairwise);
 
-bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid);
-
+bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
+				enum l_checksum_type sha);
+bool handshake_state_pmkid_matches(struct handshake_state *s,
+					const uint8_t *check);
 bool handshake_decode_fte_key(struct handshake_state *s, const uint8_t *wrapped,
 				size_t key_len, uint8_t *key_out);
 
diff --git a/src/station.c b/src/station.c
index f830ab7a..2473de2a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2236,7 +2236,15 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 					new_hs->supplicant_ie[1] + 2,
 					&rsn_info);
 
-		handshake_state_get_pmkid(new_hs, pmkid);
+		/*
+		 * IEEE 802.11 Section 12.7.1.3:
+		 *
+		 * "When the PMKID is calculated for the PMKSA as part of
+		 * preauthentication, the AKM has not yet been negotiated.
+		 * In this case, the HMAC-SHA-1 based derivation is used for
+		 * the PMKID calculation."
+		 */
+		handshake_state_get_pmkid(new_hs, pmkid, L_CHECKSUM_SHA1);
 
 		rsn_info.num_pmkids = 1;
 		rsn_info.pmkids = pmkid;
-- 
2.25.1

