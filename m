Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83458848B
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:45 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id g3so7145434pja.2
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzyAvla2h/PtWpg1As1BMSo4N4qFyW32W/KmbcinQ6E=;
        b=hyD7n0Fc5m4EDo094fPJca8QfhmXcSvIPkmGQHnwYZFdLQThjiasj2BqCx57Mh20Di
         pd2GN/0bB7y+cxddN2/Etk+Tq/QX/UUV+Luk8d7VzBjI2ZMmRmv4yB1lJj+ybB70CWkG
         EBz3vMpYBxGxjqq5jpxQZ7/NuyKSfGIpc0lCdpGSurYMVzme7WV/g0PCEzcUW7CN5yHQ
         DbOh+iDo8fJmZbAHOq28KS22KVTosSsnQD4NA869oDHjZHDK8QLsHeCu8hSnKo6JC5uf
         MaB4McNd5p0BdYx68jKfdgY0JN0BTYHvazRpukBCNm8aRnJFE2aDeF/ExbtejtjykN1g
         Wdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzyAvla2h/PtWpg1As1BMSo4N4qFyW32W/KmbcinQ6E=;
        b=hyidJHwIb8pGoMi8SG/D+ZJ0OAb0w4miMvpJlnpZbaYfH1xLGSaYoTZ1GPBUCI0Hj8
         nombHrYO6pwYeuCcYfL57z+ZLkPm8DiXd80VsopFq/Bn3D1M3v1416ItlvMQo3Ctp5og
         3yipW2XcC44JpGtzuYoe71QvteYw0tl8ewlHox4gxXjKknb5kX2oY1XWmo6j2QZ2SbEE
         4S8o3/zPu0LruDQJV4H179MJvul08P8cSHSUrPL6kTX2ZhgV7qIr2bS3ZM3VvSC7X+Qt
         6Jq+O5IKkoDjw6PudgEflUO/iIZcTp1hihmJkNKPMnwee1jglwZ3jk+oRnCMN/RteFFn
         YbQg==
X-Gm-Message-State: AAQBX9fTiUHtbNYNB56ZMxShKHO+pTUC2aTJrUx8myhkP3mJGE+UUlJ5
	uM6qnRI0ADCRRTwKVzAhu+nq1x+vLfNVyA==
X-Google-Smtp-Source: AKy350addaaIJMGNdr4oEm+3y5RAkDhyPmE9KdHHQOdbw0EZuyMLDmFYu+Z0jV5Bwg10xQjtDZvGEw==
X-Received: by 2002:a17:903:234c:b0:1a1:9787:507d with SMTP id c12-20020a170903234c00b001a19787507dmr14748189plh.3.1681164104828;
        Mon, 10 Apr 2023 15:01:44 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:44 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] handshake: remove hardcoded kek_len for FTE decode
Date: Mon, 10 Apr 2023 15:01:32 -0700
Message-Id: <20230410220135.373872-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410220135.373872-1-prestwoj@gmail.com>
References: <20230410220135.373872-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KEK length should be obtained with the getter to ensure the
AKM is taken into account
---
 src/handshake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/handshake.c b/src/handshake.c
index 362ff58a..70aeda37 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1035,7 +1035,7 @@ bool handshake_decode_fte_key(struct handshake_state *s, const uint8_t *wrapped,
 				size_t key_len, uint8_t *key_out)
 {
 	const uint8_t *kek;
-	size_t kek_len = 16;
+	size_t kek_len = handshake_state_get_kek_len(s);
 	size_t padded_len = key_len < 16 ? 16 : align_len(key_len, 8);
 
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
-- 
2.25.1

