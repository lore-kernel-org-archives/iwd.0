Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EDC8476
	for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 19:32:19 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so24683720pjj.2
        for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 11:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pk14Sm7rZWGqpTZdA3m4nIsIAFhlLNnm9DOjpAkMPco=;
        b=GOTq3Iei1WrINqMjX8mkrsceJaziTAlIjmyELOb2gdbPC8AllunXksAe6TqyQ28L0h
         rpBajycHzYFl2749W4zKM3jw/2pLz2Fj0YlAfIJcfZ3qrLiIWWVcHyB0umOSBpbzGA7x
         Npgxhxcu2CkP+kKXsBPRWdwG+Rrt6TCPDzus/rvWrM8yhfwtRW2vTFNOybjR4s4QarYp
         1OxYrDzA5W7ShVS7i0TgipaEhl8J4bZWj6/NM7hGNzSwwyjIE81KvhluPhpGneWVi7t0
         2ByzhvpKCbnCc2edX1C5et+2iG+MYxpNy+8vyomDtQm1WGHSBvgvOPF8/GqXnyjQ0WhS
         ciUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk14Sm7rZWGqpTZdA3m4nIsIAFhlLNnm9DOjpAkMPco=;
        b=Ws9u1aqVP6odjFvREwKmCLHDdvOooIPCojJljjA9vGymv9tYOmHnb/qornuWTpR5Q7
         Y5X+GG6SCeogC84ONTm4u6gHVUsOll3X5uQRhPow6XNTHHBN1gANzV0ZnhEkMxadshkR
         Q5EsgYcpZWiNVsz9ul/U6O70UOoAsfgDlVP0S7OjTk14gCNcKn0eI280hGsovexW7D+F
         e/4jJ46AL8mG/cCOGaO1jMZmiwJMFLPkRFq3AsoDDzABTvZYupCw7PI9hxPA7OME/Hal
         jsqWvrl6evfIozx1M7/ONWy4J+F9x7K0/xULf7ndRxohkOgci4/V7dtNXTF2COOU6oDP
         pbpw==
X-Gm-Message-State: AFqh2kotDgXJEMoo4FHqH9HVGapkT0IoteCmrHi5gK3L2gZ1sNfDMUNJ
	YYWLwbntUJm5gUDXcT5O25OEQQMKr/g=
X-Google-Smtp-Source: AMrXdXtqC8JNL5yF7OnFZBwaYo/XtYaqibSE4psLmbGan7tOdpVmiCZS2vmUQbkXgoCI8e4LdYvmLw==
X-Received: by 2002:a17:90a:7891:b0:228:f21b:a3ff with SMTP id x17-20020a17090a789100b00228f21ba3ffmr5514556pjk.42.1673551938604;
        Thu, 12 Jan 2023 11:32:18 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id qe12-20020a17090b4f8c00b00218fba260e2sm12732147pjb.43.2023.01.12.11.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 11:32:18 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] eapol: implement rekey support for authenticator
Date: Thu, 12 Jan 2023 11:32:09 -0800
Message-Id: <20230112193212.568476-1-prestwoj@gmail.com>
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
 src/eapol.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 22b2d5d1..2048a87d 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1086,8 +1086,6 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 
 	handshake_state_new_anonce(sm->handshake);
 
-	sm->handshake->ptk_complete = false;
-
 	sm->replay_counter++;
 
 	memset(ek, 0, EAPOL_FRAME_LEN(sm->mic_len));
@@ -1111,6 +1109,12 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 
 	eapol_key_data_append(ek, sm->mic_len, HANDSHAKE_KDE_PMKID, pmkid, 16);
 
+	if (sm->handshake->ptk_complete) {
+		ek->secure = true;
+		sm->rekey = true;
+		sm->handshake->ptk_complete = false;
+	}
+
 	ek->header.packet_len = L_CPU_TO_BE16(EAPOL_FRAME_LEN(sm->mic_len) +
 				EAPOL_KEY_DATA_LEN(ek, sm->mic_len) - 4);
 
@@ -1589,7 +1593,7 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm *sm,
 
 	l_debug("ifindex=%u", sm->handshake->ifindex);
 
-	if (!eapol_verify_ptk_2_of_4(ek, sm->handshake->ptk_complete))
+	if (!eapol_verify_ptk_2_of_4(ek, sm->rekey))
 		return;
 
 	if (L_BE64_TO_CPU(ek->key_replay_counter) != sm->replay_counter)
@@ -2482,6 +2486,8 @@ static void eapol_eap_complete_cb(enum eap_result result, void *user_data)
 
 		/* sm->mic_len will have been set in eapol_eap_results_cb */
 
+		sm->frame_retry = 0;
+
 		/* Kick off 4-Way Handshake */
 		eapol_ptk_1_of_4_retry(NULL, sm);
 	}
@@ -2873,6 +2879,8 @@ bool eapol_start(struct eapol_sm *sm)
 			if (L_WARN_ON(!sm->handshake->have_pmk))
 				return false;
 
+			sm->frame_retry = 0;
+
 			/* Kick off handshake */
 			eapol_ptk_1_of_4_retry(NULL, sm);
 		}
-- 
2.34.3

