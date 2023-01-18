Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671D8BF4
	for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 21:18:05 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso3809674pjg.2
        for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJKJHpCoebCaAPlUv59msNXwvAf3ssI+DbFAah/avU8=;
        b=hDmiJufdRQ9HTb2SrOrO7M3zuJYH5iBSk8RpFWe/oHep1p2y/c3TRH+hcVlc9EDDjm
         OEIA0Lmt6lSM1sCGMtw5vIj6vHkm0k4P/mRAKgKQAdB3eh685RI58i/M0NhZXeRj+vVj
         5iCWaaKmhW+HP7GY5BoWrbPSR2WMrOFT0s62Zwn58dalmV4IIn9ttQ9ilE7QIDX2pkeu
         sDwfAMp+3/sTez3mDBMsaCXr7uVAmyV4Ywpyu58slBfICEC3sLnf1wweEIN7Tsm41ai5
         d+5P3WVc9Jv9iJPFcS5aoNHLfu3fhyscaOGh3739O/LkBS5Sj4OP0sh0tX35PqLEmoL6
         eILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJKJHpCoebCaAPlUv59msNXwvAf3ssI+DbFAah/avU8=;
        b=JdFGfwb6n9DVgLklZGk+VqLvlXl6/MjDQ5zP1xltmLK/BJgENwn1qUXQuwDi9MxgSc
         /4gI2Ago7MadggGDfyioLzh8ducIpXsHSDW6hjKCOU8oBHKaYmZzu09/R6Bz9dYjwptX
         DvAgSDxCgpIt13AE3HKdbQLB9F+7eFCr3MEQzYfGk9/X9qHpEdhSlm5DL/qExgJI/DiW
         V0cRoWHquObuFX/Ny+f1nyjAMywAz13eky0fNtDBgSEylWLBBfxzYlos86KjyqVb920C
         pDhS3W07+OB1L04BT0+3F/wp5volYvW+7JJJA2D4YLbnuO40FJSBwPZ16hdTUQMZVjoS
         tbgQ==
X-Gm-Message-State: AFqh2kqJDuh4Ck0ZeiCkTDiQ8Gfh2NHg4NkHZDLKLuChT04xwEZe4UD4
	iuT/7cZ2A++qhc05OUdwNZhET/Gpo6s=
X-Google-Smtp-Source: AMrXdXuM4MSpmkhid/ret1lFA5z0GKfOMGG7wjEMhE6lwkjIhKYYcGDIvKQXcckhH6999dKBPJuGTQ==
X-Received: by 2002:a05:6a20:42a0:b0:ad:e914:5523 with SMTP id o32-20020a056a2042a000b000ade9145523mr11346630pzj.53.1674076684534;
        Wed, 18 Jan 2023 13:18:04 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090a5d0700b0022335f1dae2sm1784802pji.22.2023.01.18.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:18:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] eapol: implement rekey support for authenticator
Date: Wed, 18 Jan 2023 13:17:59 -0800
Message-Id: <20230118211801.1636194-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only changes required was to set the secure bit for message 1,
reset the frame retry counter, and change the 2/4 verifier to use
the rekey flag rather than ptk_complete. This is because we must
set ptk_complete false in order to detect retransmissions of the
4/4 frame.

Initiating a rekey can now be done by simply calling eapol_start().
---
 src/eapol.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

v3:
 * Set ek->secure to sm->rekey always to ensure retransmissions get
   the secure bit set.

diff --git a/src/eapol.c b/src/eapol.c
index c7128aeb..26974848 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1086,8 +1086,6 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 
 	handshake_state_new_anonce(sm->handshake);
 
-	sm->handshake->ptk_complete = false;
-
 	sm->replay_counter++;
 
 	memset(ek, 0, EAPOL_FRAME_LEN(sm->mic_len));
@@ -1111,6 +1109,13 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 
 	eapol_key_data_append(ek, sm->mic_len, HANDSHAKE_KDE_PMKID, pmkid, 16);
 
+	if (sm->handshake->ptk_complete) {
+		sm->rekey = true;
+		sm->handshake->ptk_complete = false;
+	}
+
+	ek->secure = sm->rekey;
+
 	ek->header.packet_len = L_CPU_TO_BE16(EAPOL_FRAME_LEN(sm->mic_len) +
 				EAPOL_KEY_DATA_LEN(ek, sm->mic_len) - 4);
 
@@ -1589,7 +1594,7 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm *sm,
 
 	l_debug("ifindex=%u", sm->handshake->ifindex);
 
-	if (!eapol_verify_ptk_2_of_4(ek, sm->handshake->ptk_complete))
+	if (!eapol_verify_ptk_2_of_4(ek, sm->rekey))
 		return;
 
 	if (L_BE64_TO_CPU(ek->key_replay_counter) != sm->replay_counter)
@@ -2488,6 +2493,8 @@ static void eapol_eap_complete_cb(enum eap_result result, void *user_data)
 
 		/* sm->mic_len will have been set in eapol_eap_results_cb */
 
+		sm->frame_retry = 0;
+
 		/* Kick off 4-Way Handshake */
 		eapol_ptk_1_of_4_retry(NULL, sm);
 	}
@@ -2879,6 +2886,8 @@ bool eapol_start(struct eapol_sm *sm)
 			if (L_WARN_ON(!sm->handshake->have_pmk))
 				return false;
 
+			sm->frame_retry = 0;
+
 			/* Kick off handshake */
 			eapol_ptk_1_of_4_retry(NULL, sm);
 		}
-- 
2.34.3

