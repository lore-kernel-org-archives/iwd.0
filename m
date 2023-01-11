Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0689A93F
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:50 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id e10so11318677pgc.9
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiJQKoVId5PRibCpM16GPW2xF6/XdPVnxc6Vsf+XtHo=;
        b=XjnmiNwnIeqspFa1Rie/PZGAk79mWSuUxFhiMsIJj4qVFFQMEQoq0syxLXMSJVkL1i
         bxtE/K31YER3XnCKJh3bbiXCn4mM83ln9syGWcWM8Qk5vwEVoUv/Ajcp6zR69tvCseR/
         /2chHcA6/8SvGt2JbHjtRyNrDZI34AxGenZ0q4OZ2cZs1mScXqfqndWN7MnDN0EoTXYt
         IKLzhZp37mTq7jgjQPf/24KE6u/wJkskVf2H3RnV89mn7cCs+UZQ/+GNqns3QDV+Js+e
         MRBSNRZPxaylqt/+CA/rPCv4FItadNHdNc7KTLSE6hfEqmjzlP+Da6j7iIBb6m5J8bPz
         0VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiJQKoVId5PRibCpM16GPW2xF6/XdPVnxc6Vsf+XtHo=;
        b=f0D8Sz4/HpIo8nzWcYaZmqsNkmviFSlgp9+f6pMqUd5+/9vgWzR3UGF0C8CWNcmKRH
         rN+jeko5iYIZRstk63ICyxy4B76aPxY0CtlgKVD6B/C/wD2nBh2frYQ5X+RktI9K3fuu
         hqYNeoXqVkAJL2kuNNXnbzAM69e9FM9gg/9oUOaPbnohWz/tUBt7ErggdKhmKCGrBCdJ
         ozLI/Z7lKcY2Bl1zX00e7Rj4N6JdgNm0Ww/gpGinSshstGcYK7ZkhnyK6DA2leHC5Mwc
         eqGVX5v4q6p2Bh4PlrOgJgXjJKpTIuc6uBAzFATk8F8K0wWhpDai4pir0vxloxM5Eaw+
         71Vg==
X-Gm-Message-State: AFqh2krvmGXz/2IO22lMJbHo2mi8psjtWcZVV/VFf9aALoLaDABC0SWo
	n3TWxy50Fvp+lIIhTWgCjsOvadB6Z9I=
X-Google-Smtp-Source: AMrXdXsfFMEgdky+8RD0tOMzbNZ3iFTtH3ePoNKhl5iGLL86MuOugcOCRUr7NoRO/maRKX9gdQx9Eg==
X-Received: by 2002:a05:6a00:2165:b0:575:fd73:fc94 with SMTP id r5-20020a056a00216500b00575fd73fc94mr69746391pff.23.1673468150074;
        Wed, 11 Jan 2023 12:15:50 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:49 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] unit: update test-eapol with API change
Date: Wed, 11 Jan 2023 12:15:36 -0800
Message-Id: <20230111201543.397692-2-prestwoj@gmail.com>
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

---
 unit/test-eapol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 227e485f..563541f5 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -1793,7 +1793,7 @@ static void eapol_4way_test(const void *data)
 				eapol_key_test_4.key_replay_counter,
 				snonce, eapol_key_test_4.key_data_len,
 				eapol_key_data_4 + EAPOL_FRAME_LEN(16),
-				false, 16);
+				false, 16, false);
 	assert(frame);
 	assert(eapol_calculate_mic(IE_RSN_AKM_SUITE_PSK, ptk, frame,
 					mic, 16));
@@ -1878,7 +1878,7 @@ static void eapol_wpa2_handshake_test(const void *data)
 				eapol_key_test_8.key_replay_counter,
 				snonce, eapol_key_test_8.key_data_len,
 				eapol_key_data_8 + EAPOL_FRAME_LEN(16),
-				false, 16);
+				false, 16, false);
 	assert(frame);
 	assert(eapol_calculate_mic(IE_RSN_AKM_SUITE_PSK, ptk, frame,
 					mic, 16));
@@ -2008,7 +2008,7 @@ static void eapol_wpa_handshake_test(const void *data)
 				eapol_key_test_14.key_replay_counter,
 				snonce, eapol_key_test_14.key_data_len,
 				eapol_key_data_14 + EAPOL_FRAME_LEN(16),
-				true, 16);
+				true, 16, false);
 	assert(frame);
 	assert(eapol_calculate_mic(IE_RSN_AKM_SUITE_PSK, ptk, frame,
 					mic, 16));
-- 
2.34.3

