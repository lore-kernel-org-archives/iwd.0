Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072D2F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:06 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id p9so4548051plr.11
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmMZpc14Ab1wbx04tHduSMqXwFCtXithIXdMgoNEut8=;
        b=hn3kSewZ6UF1o6hRDnnV/8T0ZlOjb8BTdFmOqcJgfeAzvSrIhBv3fem8jVcL6kHZeM
         2AtZqZBZ1j2NXwlhv2E0IPxzKd2gi5k+UxeZDGsijMMMd7AQzhQb7zow9uiNcN3fIQp5
         cKR9U+6IGJm1C8s5blNtIIRvKNxnPsKPeaRFjpKv1toIebdH2ulN+aQcigJac3kmJK+8
         Wn6dbWFZyh2Tk0wrU6JjM2Cor9CZy0KkipY21ZwvC5xNBwQTUzSbnAI3maUDpwTKTFYG
         fpLGp1aIUV5P8JZ3oxQJXQ/dJX8arlRwv3D4bOy8o4lp8Mv5H9IRZha+XTWzS1i8N+O5
         YAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmMZpc14Ab1wbx04tHduSMqXwFCtXithIXdMgoNEut8=;
        b=7tHNDI6PoDuLMg3cQHFYuOclc4bHTHZHXVdS/+Bx5C306cg+ApyMp2c5mAumMXgrY8
         CoX7rOvZcj4wU1EKq+Cwd2FL8xTY8OqJeJRF3NNsTkccLOvho8Ng4xuYdcR7P9C8EvEi
         3DV8pCIeiUG2DOQN4OzxK1uA2DOepCLIZkY9nh1TjX4Ad7hUtPCUddZMZyUS4RMlKrvD
         m0+9UUiB1I/4dtjk+nhi2nC1XMoRu5hZvdhTgCFUM8LVxbV9Er/OwT4Ak5r6N73zubYm
         XrR82aKERfAa/84VwXWI3CF8ZLwEJRAlN+ELgmGlXdxIfhjAVHWMOMR1lMS5B67gkxbM
         Y5DQ==
X-Gm-Message-State: AJIora8/x9xLiArhQjm8vVjxS1Fwpl2c/8I1YuSfr3Yz5Ba3cr/TIlri
	FeQpDn696RJ5rVTuKBqztZgM+whrag4=
X-Google-Smtp-Source: AGRyM1vpeQvjTo53JsaX4gWVW+beC65gwtYJL/0YYR9J7h+aDANWsxkk1WUlwfXtNDiqug4oK4kF1A==
X-Received: by 2002:a17:90a:e7c1:b0:1ed:3b8c:7ced with SMTP id kb1-20020a17090ae7c100b001ed3b8c7cedmr854904pjb.77.1657143065455;
        Wed, 06 Jul 2022 14:31:05 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/14] client: update CLEAR_SCREEN to be consistent with others
Date: Wed,  6 Jul 2022 14:28:44 -0700
Message-Id: <20220706212851.92685-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706212851.92685-1-prestwoj@gmail.com>
References: <20220706212851.92685-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear screen used a \033 escape sequence while others used a \x
---
 client/display.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/display.h b/client/display.h
index c34cab9c..8e597bb5 100644
--- a/client/display.h
+++ b/client/display.h
@@ -30,7 +30,7 @@ struct command_family;
 #define COLOR_BLUE	"\x1B[94m"
 #define COLOR_YELLOW	"\x1b[33m"
 #define COLOR_OFF	"\x1B[0m"
-#define CLEAR_SCREEN	"\033[2J"
+#define CLEAR_SCREEN	"\x1b[2J"
 #define MARGIN		"  "
 
 void display(const char *format, ...)
-- 
2.34.1

