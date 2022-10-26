Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC582F2F
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 18:57:00 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id n7so15087786plp.1
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5Byeswg/sasT2hhH7+K9otAJoZ6kEgEw2Fb4hP8osU=;
        b=l2EKJV5r52HEQ9Vx0EiMc1FaRX6UrEAJrVhdgITBowdiBLDEtF8yyofqOgxokfZEgZ
         xd6DpRjnrfkHcyhaLmT4ZNtH9UXWs7/B6Npc9umARS8f6JeDCGlZFmbALAKjOJMo9p2X
         8YSdARomNWevdPPbbOg/Qz1AxEBdIx/rAqkBqz/qBZRX1ZU2VzZcjzgT6taqPxad/v/o
         iXmO34mtTn+5fsSkfpzhs0bP6K+hFiDYNAgL+Lu6lcpgIOIChZouzn+xfdJh6ET3KzWb
         xGOFiRN2lKcw37Q6vbkyJ1v+Bg8s9N0vxT0gzkb2QcapozJRNoRrJPnp9crSDEq99VJK
         lFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5Byeswg/sasT2hhH7+K9otAJoZ6kEgEw2Fb4hP8osU=;
        b=xxWEyMMp/4jAjX/G2kDcjCcw3lEK9WaNLUHYB3VEguzovTuqMnK7ki9t7a31wKs4l2
         KGI2+sblItDSqHPKG0Vpxv5P/BdVaKnO2fQgCPT0TdNjBU+J25ijsDPCJoNWO/7i4i7z
         6jExVN0tAZfXWHRpMbhbNmuygcm5n6Pp+g8UZ7w61Ii31hTmSiwuFd93JtJhynR38DGy
         g5/qCunW0YGVIwstZW+NluzVXG7SHiVqdS5tnDS7jE2k5Rm2kXfvHCqvq72V+RittugC
         mAlNPRVqzhnX1nkkSS1lSyGF6BmV7DSpY5Fy/FPr8OuJ3NJAps4B8uBYVmw3Gi/0EYq1
         +hDw==
X-Gm-Message-State: ACrzQf379qnTAJT7ifwdPgHaHhYq44nmpjD5EZrhwunTdpWq4eJcdlLO
	MmVvdUWp+w6O3u82o6OlPbf4bkqtS3E=
X-Google-Smtp-Source: AMsMyM7OKFL0sxOoUiuvGykOdL6cysIBqfp/acXJk0S2T1uonKbAmsXiBuRsi0NspKnOiFmRR5WGLg==
X-Received: by 2002:a17:90b:1b4c:b0:20d:70d8:1491 with SMTP id nv12-20020a17090b1b4c00b0020d70d81491mr5768831pjb.3.1666810619553;
        Wed, 26 Oct 2022 11:56:59 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001869efb722csm3209420plw.215.2022.10.26.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:56:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] eapol: choose key descriptor version in AP mode
Date: Wed, 26 Oct 2022 11:56:52 -0700
Message-Id: <20221026185656.489888-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The key descriptor version was hard coded to HMAC_SHA1_AES which
is correct when using IE_RSN_AKM_SUITE_PSK + CCMP. ap.c hard
codes the PSK AKM but still uses wiphy to select the cipher. In
theory there could be hardware that only supports TKIP which
would then make IWD non-compliant since a different key descriptor
version should be used with PSK + TKIP (HMAC_MD5_ARC4).

Now use a helper to sort out which key descriptor should be used
given the AKM and cipher suite.
---
 src/eapol.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index c6439bb1..44ffb220 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1062,6 +1062,7 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 	enum crypto_cipher cipher = ie_rsn_cipher_suite_to_cipher(
 				sm->handshake->pairwise_cipher);
 	uint8_t pmkid[16];
+	uint8_t key_descriptor_version;
 
 	handshake_state_new_anonce(sm->handshake);
 
@@ -1073,8 +1074,11 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 	ek->header.protocol_version = sm->protocol_version;
 	ek->header.packet_type = 0x3;
 	ek->descriptor_type = EAPOL_DESCRIPTOR_TYPE_80211;
-	/* Must be HMAC-SHA1-128 + AES when using CCMP with PSK or 8021X */
-	ek->key_descriptor_version = EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_SHA1_AES;
+	L_WARN_ON(eapol_key_descriptor_version_from_akm(
+				sm->handshake->akm_suite,
+				sm->handshake->pairwise_cipher,
+				&key_descriptor_version) < 0);
+	ek->key_descriptor_version = key_descriptor_version;
 	ek->key_type = true;
 	ek->key_ack = true;
 	ek->key_length = L_CPU_TO_BE16(crypto_cipher_key_len(cipher));
@@ -1358,6 +1362,7 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 				sm->handshake->group_cipher);
 	const uint8_t *kck;
 	const uint8_t *kek;
+	uint8_t key_descriptor_version;
 
 	sm->replay_counter++;
 
@@ -1365,8 +1370,11 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 	ek->header.protocol_version = sm->protocol_version;
 	ek->header.packet_type = 0x3;
 	ek->descriptor_type = EAPOL_DESCRIPTOR_TYPE_80211;
-	/* Must be HMAC-SHA1-128 + AES when using CCMP with PSK or 8021X */
-	ek->key_descriptor_version = EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_SHA1_AES;
+	L_WARN_ON(eapol_key_descriptor_version_from_akm(
+				sm->handshake->akm_suite,
+				sm->handshake->pairwise_cipher,
+				&key_descriptor_version) < 0);
+	ek->key_descriptor_version = key_descriptor_version;
 	ek->key_type = true;
 	ek->install = true;
 	ek->key_ack = true;
-- 
2.34.3

