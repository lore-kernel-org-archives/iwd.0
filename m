Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DAA92A
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:49 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id y5so12272280pfe.2
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PhbWZIfEvWzt7cyzIxARUzjXNgE5uSqiPKpq6EG0s4=;
        b=K478G6n8sEjzbS3q4wHPSWlAMDa6icTJlXwxKvRfuzKN3CgNS1rjaUoukPnd/sayQJ
         SxwtmCAg6OUrAH/KD9hA1yqnJpuPQOW0DTWfo8Zvktoty+ueX8T2eBJ4paexu7/GAnFd
         +YRIGBQKBtHoHGsfS3wOKrB2U51htXoAP409sQG35/HkFX/eLhlHdd1e7OtWWefH9G/O
         U2uQQDvZc0s5EzSedWW5lSbxypCFbVFiCzz32H+IeduyUyTmNMkC7M8y1Fsd4lJUZEfH
         DhSSFG5pRHvWabWLit13fA4r4+EjqgqFVDLe0b4OAq05XouSooABNn04KQW2TACzpKEW
         aG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PhbWZIfEvWzt7cyzIxARUzjXNgE5uSqiPKpq6EG0s4=;
        b=1NtvNUp8FeBJcWDvamrS18/lzgaHZQdwCQ8pNk/b/+9aQwJQiEqn76czZF79RmG3QH
         55n//eyGUDGtDVDhyNinKRfx4gGZ3xF414E828/Riu/fRmnaSzl24AmGXcyxjHU9nand
         sZm/Z/3Ub5VoKkfvoyvLkHzhaTowjw3++1akPXGgO9Dbm+jtX/o7r7eAqeohbUGHuE3M
         h7OvHKx80cwqac/hCECzpVNAzbWUGl4YX9DwLUJIkkBK/wIO2pxa2CY7rtklhnEBvb9G
         D7oDKRStYBToQfGzT4AsBkA2vvWJNRlIJBgjKmZCad6dwZuGhYFbKf3+G83OANlJcjlH
         /4FQ==
X-Gm-Message-State: AFqh2krGAa/HiBZvJIZxgzoQ1zE3skZuFtmmb+QeP5VobjEfE3hDPp3b
	bDKGl5VrdED+R4dHds4wF61hgocu+UY=
X-Google-Smtp-Source: AMrXdXuBKyDueaukBUbcQFHc3T21rEURBF8eOdx/ZBajAoc3+bwDwa1agMlFrucX7aIbER+5YCjMZw==
X-Received: by 2002:a62:1b42:0:b0:581:eca3:fd05 with SMTP id b63-20020a621b42000000b00581eca3fd05mr43377754pfb.16.1673468149265;
        Wed, 11 Jan 2023 12:15:49 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:48 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] eapol: set secure on message 2/4 properly
Date: Wed, 11 Jan 2023 12:15:35 -0800
Message-Id: <20230111201543.397692-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second handshake message was hard coded with the secure bit as
zero but for rekeys the secure bit should be set to 1. Fix this by
changing the 2/4 builder to take a boolean which will set the bit
properly.

It should be noted that hostapd doesn't check this bit so EAPoL
worked just fine, but IWD's checks are more strict.
---
 src/eapol.c | 12 +++++++-----
 src/eapol.h |  3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index c7480c11..593daf41 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -766,11 +766,12 @@ struct eapol_key *eapol_create_ptk_2_of_4(
 				size_t extra_len,
 				const uint8_t *extra_data,
 				bool is_wpa,
-				size_t mic_len)
+				size_t mic_len,
+				bool secure)
 {
-	return eapol_create_common(protocol, version, false, key_replay_counter,
-					snonce, extra_len, extra_data, 1,
-					is_wpa, mic_len);
+	return eapol_create_common(protocol, version, secure,
+					key_replay_counter, snonce, extra_len,
+					extra_data, 1, is_wpa, mic_len);
 }
 
 struct eapol_key *eapol_create_ptk_4_of_4(
@@ -1326,7 +1327,8 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 					ek->key_descriptor_version,
 					L_BE64_TO_CPU(ek->key_replay_counter),
 					sm->handshake->snonce, ies_len, ies,
-					sm->handshake->wpa_ie, sm->mic_len);
+					sm->handshake->wpa_ie, sm->mic_len,
+					sm->rekey);
 
 	kck = handshake_state_get_kck(sm->handshake);
 
diff --git a/src/eapol.h b/src/eapol.h
index 8d8d5252..43dc224d 100644
--- a/src/eapol.h
+++ b/src/eapol.h
@@ -83,7 +83,8 @@ struct eapol_key *eapol_create_ptk_2_of_4(
 				size_t extra_len,
 				const uint8_t *extra_data,
 				bool is_wpa,
-				size_t mic_len);
+				size_t mic_len,
+				bool secure);
 
 struct eapol_key *eapol_create_ptk_4_of_4(
 				enum eapol_protocol_version protocol,
-- 
2.34.3

