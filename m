Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE63D60
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:28 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso4734271fac.6
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvKparpnqvtlI4sRbU8mDai6LxgQBlWgu6knBjgz+jc=;
        b=Jb898tm3NGAkBvkNp2fwWHODgh2GcxMO6Szb6NxNdXmN/JdOYl7fn+kIHRg0gkHwuX
         uKvKiR8UNbzMXfjZKSICsNBlFTdp48UwFOynL7C4z9F7/gkZ7358SHygovImPpZB3PMO
         cq5i62EJiBmUEl8qNxNLWTGHeGb7/nblNtR7TTvAJPum0NSehDsNL3Z7tSQiePK7VR2l
         7RoZfq423PlzW44TYRJRhFnECjKpfzSWp3H34OIR+b7p6xPnUiL8iEhBqT35f8T6FZ87
         BKsgUZb54iH22b19gd9IHblWAV0NTZFxPw2+CZAOnRYbB4rdtOSmmu6tO3WH309NoRc6
         qYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvKparpnqvtlI4sRbU8mDai6LxgQBlWgu6knBjgz+jc=;
        b=4pQxm9bWzAKmynca0BaoRe7AMvvUEf5ErS0Gq3CHkwKCHmoMc3gE/2A7f2BAXoDtlc
         lRAVszeuv7gIw3GAUIvve2pmqkDcp7h15vjK5v83DQI6ZSo+n+45oosD/eRR0au50nOl
         lwtLAJCIoNBzvZ1SbVe64CWAVLRwRLIB6ER3BGZC/1CJyqD2L8CSDsm3pkMn6J8ntCQ1
         HnGI/sVoM79NiSVhNB4+6tLTDJW/VAPqjvZJ/qh/3pF0Gc83IPgmU5rFJaWRzuQ5/D9O
         /EP/VU5m++lHNeFZ92HwM+9HfKXElFVyTwRwIH05c+OBokRULI9y59TCpqFKQCa+7+At
         w37w==
X-Gm-Message-State: ACrzQf1GdcFAxCd5AhYGGsbiqifBYTeLqrH9VRJ7f13p9QDnFKhJzvav
	C6/ahnT3PvpsLLYJ4ck2HIIj+kL4uts=
X-Google-Smtp-Source: AMsMyM53TBli8Ytt1SnWa3NFExtJZe7Uzw8FClWdjfRXcLjh40T6varh6szHF9LKM5PbYpSJNmmJrw==
X-Received: by 2002:a05:6871:1d5:b0:12b:239:ef00 with SMTP id q21-20020a05687101d500b0012b0239ef00mr13548617oad.85.1666379607185;
        Fri, 21 Oct 2022 12:13:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:26 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/26] eapol: More strictly validate key_descriptor_version
Date: Fri, 21 Oct 2022 14:12:42 -0500
Message-Id: <20221021191307.31492-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/eapol.c     | 38 +++++++++++++++++++++++---------------
 src/eapolutil.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 src/eapolutil.h |  6 ++++++
 3 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index e8bd5cdbf64b..c6439bb1302d 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2238,12 +2238,14 @@ static void eapol_key_handle(struct eapol_sm *sm,
 				const struct eapol_frame *frame,
 				bool unencrypted)
 {
+	struct handshake_state *hs = sm->handshake;
 	const struct eapol_key *ek;
 	const uint8_t *kck;
 	const uint8_t *kek;
 	uint8_t *decrypted_key_data = NULL;
 	size_t key_data_len = 0;
 	uint64_t replay_counter;
+	uint8_t expected_key_descriptor_version;
 
 	ek = eapol_key_validate((const uint8_t *) frame,
 				sizeof(struct eapol_header) +
@@ -2256,11 +2258,19 @@ static void eapol_key_handle(struct eapol_sm *sm,
 	if (!ek->key_ack)
 		return;
 
+	if (L_WARN_ON(eapol_key_descriptor_version_from_akm(hs->akm_suite,
+				hs->pairwise_cipher,
+				&expected_key_descriptor_version) < 0))
+		return;
+
+	if (L_WARN_ON(expected_key_descriptor_version !=
+				ek->key_descriptor_version))
+		return;
+
 	/* Further Descriptor Type check */
-	if (!sm->handshake->wpa_ie &&
-			ek->descriptor_type != EAPOL_DESCRIPTOR_TYPE_80211)
+	if (!hs->wpa_ie && ek->descriptor_type != EAPOL_DESCRIPTOR_TYPE_80211)
 		return;
-	else if (sm->handshake->wpa_ie &&
+	else if (hs->wpa_ie &&
 			ek->descriptor_type != EAPOL_DESCRIPTOR_TYPE_WPA)
 		return;
 
@@ -2293,31 +2303,30 @@ static void eapol_key_handle(struct eapol_sm *sm,
 	if (sm->have_replay && sm->replay_counter >= replay_counter)
 		return;
 
-	kck = handshake_state_get_kck(sm->handshake);
+	kck = handshake_state_get_kck(hs);
 
 	if (ek->key_mic) {
 		/* Haven't received step 1 yet, so no ptk */
-		if (!sm->handshake->have_snonce)
+		if (!hs->have_snonce)
 			return;
 
-		if (!eapol_verify_mic(sm->handshake->akm_suite, kck, ek,
-					sm->mic_len))
+		if (!eapol_verify_mic(hs->akm_suite, kck, ek, sm->mic_len))
 			return;
 	}
 
-	if ((ek->encrypted_key_data && !sm->handshake->wpa_ie) ||
-			(ek->key_type == 0 && sm->handshake->wpa_ie)) {
+	if ((ek->encrypted_key_data && !hs->wpa_ie) ||
+			(ek->key_type == 0 && hs->wpa_ie)) {
 		/*
 		 * If using a MIC (non-FILS) but haven't received step 1 yet
 		 * we disregard since there will be no ptk
 		 */
-		if (sm->mic_len && !sm->handshake->have_snonce)
+		if (sm->mic_len && !hs->have_snonce)
 			return;
 
-		kek = handshake_state_get_kek(sm->handshake);
+		kek = handshake_state_get_kek(hs);
 
 		decrypted_key_data = eapol_decrypt_key_data(
-					sm->handshake->akm_suite, kek,
+					hs->akm_suite, kek,
 					ek, &key_data_len, sm->mic_len);
 		if (!decrypted_key_data)
 			return;
@@ -2326,11 +2335,10 @@ static void eapol_key_handle(struct eapol_sm *sm,
 
 	if (ek->key_type == 0) {
 		/* GTK handshake allowed only after PTK handshake complete */
-		if (!sm->handshake->ptk_complete)
+		if (!hs->ptk_complete)
 			goto done;
 
-		if (sm->handshake->group_cipher ==
-				IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC)
+		if (hs->group_cipher == IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC)
 			goto done;
 
 		if (!decrypted_key_data)
diff --git a/src/eapolutil.c b/src/eapolutil.c
index e2a41c2e823f..3a0ef26e62bc 100644
--- a/src/eapolutil.c
+++ b/src/eapolutil.c
@@ -25,9 +25,11 @@
 #endif
 
 #include <stdio.h>
+#include <errno.h>
 #include <ell/ell.h>
 
 #include "src/eapolutil.h"
+#include "src/ie.h"
 
 const struct eapol_key *eapol_key_validate(const uint8_t *frame, size_t len,
 						size_t mic_len)
@@ -80,3 +82,45 @@ const struct eapol_key *eapol_key_validate(const uint8_t *frame, size_t len,
 
 	return ek;
 }
+
+int eapol_key_descriptor_version_from_akm(enum ie_rsn_akm_suite akm,
+					enum ie_rsn_cipher_suite pairwise,
+					uint8_t *outv)
+{
+	/* 802.11-2020 Section 12.7.2 */
+	switch (akm) {
+	case IE_RSN_AKM_SUITE_8021X:
+	case IE_RSN_AKM_SUITE_PSK:
+		if (pairwise == IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER ||
+				pairwise == IE_RSN_CIPHER_SUITE_TKIP)
+			*outv = EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_MD5_ARC4;
+		else
+			*outv = EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_SHA1_AES;
+
+		return 0;
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+	case IE_RSN_AKM_SUITE_8021X_SHA256:
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		*outv = EAPOL_KEY_DESCRIPTOR_VERSION_AES_128_CMAC_AES;
+		return 0;
+	case IE_RSN_AKM_SUITE_SAE_SHA256:
+	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+	case IE_RSN_AKM_SUITE_FILS_SHA256:
+	case IE_RSN_AKM_SUITE_FILS_SHA384:
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+	case IE_RSN_AKM_SUITE_OWE:
+	case IE_RSN_AKM_SUITE_OSEN:
+		*outv = EAPOL_KEY_DESCRIPTOR_VERSION_AKM_DEFINED;
+		return 0;
+	case IE_RSN_AKM_SUITE_TDLS:
+	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
+		break;
+	}
+
+	return -ENOTSUP;
+};
diff --git a/src/eapolutil.h b/src/eapolutil.h
index 1f15872eb2d7..7451f69bedd8 100644
--- a/src/eapolutil.h
+++ b/src/eapolutil.h
@@ -25,6 +25,9 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 
+enum ie_rsn_akm_suite;
+enum ie_rsn_cipher_suite;
+
 enum eapol_protocol_version {
 	EAPOL_PROTOCOL_VERSION_2001	= 1,
 	EAPOL_PROTOCOL_VERSION_2004	= 2,
@@ -116,3 +119,6 @@ struct eapol_key {
 
 const struct eapol_key *eapol_key_validate(const uint8_t *frame, size_t len,
 						size_t mic_len);
+int eapol_key_descriptor_version_from_akm(enum ie_rsn_akm_suite akm,
+					enum ie_rsn_cipher_suite pairwise,
+					uint8_t *out_version);
-- 
2.35.1

