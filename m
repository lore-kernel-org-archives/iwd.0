Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E83217
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 18:00:53 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2467761dfabso176484a91.3
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681149652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLcYeNDiuJ4CVO9yrvqDI7idie0wj88CRhJKY7BIMPs=;
        b=mV1E7vXrUX1+hTbf6jshZIG4hDipl0rsk7RUYzCsqRWW5zfIZ1xQpbajn3Q4uBsxlC
         G6XkcAxHEv6b06H8BdgNtkTbJM7p6wSJw/P2p747lOflOxJtk2GF3i32UPpCcOksc4N7
         hzAVwgbFaOze6v/ailEPp1ZFa7fVOUs7C8mIO96gMObqAQIMADYdsoWNY3fXJabwqspp
         iYJM3Ni6gu55/PsR4w+kt5+bllYHbX8T9+tcWsavzZxwr5myMqbkx4musXnq6j9gWdkQ
         MNLhk4nBqAxcgyNoVy18yxXxVmhDnPTGfTLN12YbdJ+6AU+HzTt807A0YxbVNgNTcvEb
         WuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681149652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLcYeNDiuJ4CVO9yrvqDI7idie0wj88CRhJKY7BIMPs=;
        b=iYAh7rYsebKh6OG74g26lPSce56TD2AnpFI/QJ9fdJY4m9RbXAAkVdVpLB4dL4Az81
         OlTIHntUVZ4qhVihl/qnZfiT8dwNMMk/FNILQL1LATkSl/RVnKb7j4Pk0qkJLu+D7YEE
         I6YW/7mGYyDBKZx59HHhpNJT0hmQNP/oZnq9/2pymlstrrSWRKRsC6gd8lvwiIS1R8o9
         /4x4fUO4U8NzwfCohvrSs4jEhG0fPYDcbDsQzD8b6ChZLM0ggNWYYwXdgJWTRedBU9Wf
         /MRFZle2dKLARX63emx+OeJKSrCErE1ixrxWpco1ytNeHdvMweDdecmYo1Z/nVteE7Mi
         RN9w==
X-Gm-Message-State: AAQBX9fSzT3HpD6gUlfZoDkmVGqTwH+cv2LIggIQnmgGHfUWFXcRYfll
	U94ELj9/1nmclMlenCaNc2XwW2JGeG3hRQ==
X-Google-Smtp-Source: AKy350biqSlTAkR8YqAU+0TeyA0ghqa+aU3N7YMN7fMuxdT9tgRmq0QydD9kCzekSBKV1PB3jTYkpQ==
X-Received: by 2002:a62:798c:0:b0:63a:8f4c:8be1 with SMTP id u134-20020a62798c000000b0063a8f4c8be1mr1193218pfc.10.1681149652567;
        Mon, 10 Apr 2023 11:00:52 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id p25-20020a62ab19000000b00638c9a2ba5csm1794637pff.62.2023.04.10.11.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 11:00:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] eapol: relax (but warn) on secure bit check in handshake 1/4
Date: Mon, 10 Apr 2023 11:00:49 -0700
Message-Id: <20230410180049.180133-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hostapd commit bc36991791 now properly sets the secure bit on
message 1/4. This was addressed in an earlier IWD commit but
neglected to allow for backwards compatibility. The check is
fatal which now breaks earlier hostapd version (older than 2.10).

Instead warn on this condition rather than reject the rekey.

Fixes: 7fad6590bd ("eapol: allow 'secure' to be set on rekeys")
---
 src/eapol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 3d7d33e0..9471d13e 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -478,8 +478,7 @@ bool eapol_verify_ptk_1_of_4(const struct eapol_key *ek, size_t mic_len,
 	if (ek->key_mic)
 		return false;
 
-	if (ek->secure != ptk_complete)
-		return false;
+	L_WARN_ON(ek->secure != ptk_complete);
 
 	if (ek->encrypted_key_data)
 		return false;
-- 
2.25.1

