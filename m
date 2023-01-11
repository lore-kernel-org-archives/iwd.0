Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9150A92A
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:51 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id 200so6099545pfx.7
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/5PfonUEwLvry0avI55HtYv4B5pUTSVS8msxgmwlNs=;
        b=E/FlAStB9cH9tkARYrjsQK759y3FN6z9lXAiG5GOl4TmuO5ItoDfOoSoSlzbA/iPFo
         vuHtlksujRyfz+al9KimbLemjFTNajv15mXwoq4yrCUgpyBl/O9FmVaA+GP0pJyZ4rfG
         r0XWSRjrPJHt1Tcu/A45I99yzHNl5HssOBAtG/y10wJ807t0JGwh06GuheGwvchgslff
         7pMe+UXznb+QC5s2ZtczTjSP3Sto8elgEeGl+T9BbXTofJvAxZnXY7fnkKmUSc4mFSPi
         G9gNDbQJ3NNBPIWR2iSdk2aw07srqMD4mkMTcECwA2ywP46HV7FYEEXjvJHbYjjF0Caf
         4nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/5PfonUEwLvry0avI55HtYv4B5pUTSVS8msxgmwlNs=;
        b=bZrMZlR6LhR/PUeaujHMMt7XIr7tGv21SJtwpLmvEmmSiBwZqDY5HKtjlKMUupfEzi
         96oi/XDSrc9Ij3iIaRQJpBCwfAFsGczr+OCKghZhwyyFK4FnZ0r4Pf6ojAedosmNA0S1
         xxp4Brbtqka0k0mSfDTry6xu8bNm1mf4Z4J/4LHTIovuyLWfhl1vpmRKCgqKChNiXmIt
         n3fITWWZRWdaJSr8ykeQsFS4W5Idzhhe3BmB6JV9tYK3oFrx8kRgdcXT48hSZl1va666
         6XwhZk71ZG0d3KzvVIKRZvTvrLw5buRkann+EU2M5neiRirW+a/CySikN8UpyygLBhDi
         vg/w==
X-Gm-Message-State: AFqh2kr7uBikH9vVnfAqsMp6wIFZ+XznJRcld0ZgAMtNxE8KkfZcjk9H
	ldmlkqQ3JOCdZ20vedsWSSWXgxfc2/M=
X-Google-Smtp-Source: AMrXdXscmRiPaagDjwP5vGCj4dJS1W0Sr+WqKeBHEvrzP1jH8fSEL0hf30RdcuhAp+4+44Q6Smn9uw==
X-Received: by 2002:a05:6a00:27a5:b0:583:63eb:581e with SMTP id bd37-20020a056a0027a500b0058363eb581emr18766429pfb.18.1673468151072;
        Wed, 11 Jan 2023 12:15:51 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:50 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] eapol: implement rekey support for authenticator
Date: Wed, 11 Jan 2023 12:15:37 -0800
Message-Id: <20230111201543.397692-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230111201543.397692-1-prestwoj@gmail.com>
References: <20230111201543.397692-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only changes required was to set the secure bit for message 1,
reset the frame retry counter, and don't explicitly set ptk_complete
to false

Initiating a rekey can now be done by simply calling eapol_start().
---
 src/eapol.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 593daf41..d31116b6 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1087,8 +1087,6 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 
 	handshake_state_new_anonce(sm->handshake);
 
-	sm->handshake->ptk_complete = false;
-
 	sm->replay_counter++;
 
 	memset(ek, 0, EAPOL_FRAME_LEN(sm->mic_len));
@@ -1112,6 +1110,11 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 
 	eapol_key_data_append(ek, sm->mic_len, HANDSHAKE_KDE_PMKID, pmkid, 16);
 
+	if (sm->handshake->ptk_complete) {
+		ek->secure = true;
+		sm->rekey = true;
+	}
+
 	ek->header.packet_len = L_CPU_TO_BE16(EAPOL_FRAME_LEN(sm->mic_len) +
 				EAPOL_KEY_DATA_LEN(ek, sm->mic_len) - 4);
 
@@ -2129,7 +2132,8 @@ static void eapol_handle_ptk_4_of_4(struct eapol_sm *sm,
 	 * This might be a retransmission, so accept but don't install
 	 * the keys again.
 	 */
-	if (!sm->handshake->ptk_complete)
+	if (!sm->handshake->ptk_complete ||
+				(sm->handshake->ptk_complete && sm->rekey))
 		handshake_state_install_ptk(sm->handshake);
 
 	sm->handshake->ptk_complete = true;
@@ -2483,6 +2487,8 @@ static void eapol_eap_complete_cb(enum eap_result result, void *user_data)
 
 		/* sm->mic_len will have been set in eapol_eap_results_cb */
 
+		sm->frame_retry = 0;
+
 		/* Kick off 4-Way Handshake */
 		eapol_ptk_1_of_4_retry(NULL, sm);
 	}
@@ -2874,6 +2880,8 @@ bool eapol_start(struct eapol_sm *sm)
 			if (L_WARN_ON(!sm->handshake->have_pmk))
 				return false;
 
+			sm->frame_retry = 0;
+
 			/* Kick off handshake */
 			eapol_ptk_1_of_4_retry(NULL, sm);
 		}
-- 
2.34.3

