Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221074C8C
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 20:55:58 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id e5so19260144pfl.2
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+JzW7VnwR/FW2qLFYt6b6aIFvnLxLEYb3/54IE2kMFk=;
        b=IKc6PysC9tlk5zRm9B+0tf3Og39uuQJilvaD6lT2tOn8MLOr7q3l2QnKQY3IHJnC4j
         lSdWU49k8oyPuvO1s0jVoLiVFlokL6VNezGHt16yUdwIZFvJ1Y7wwRAeB9CIuS7A8N+n
         O7CHLGGZbGGn0AZmd9FsdrZ4YVU/8LZ/UCi1BOhyUdhnLGHbeoYW7gAtge+iLk55u2R/
         nv/jeTYyIzjZpQ9tp0gQ3TOD/hIrnrRCDB6UogP+gEP6+1XMdPbgjWF5eZcacv0xNQS/
         LClvW8sI2K1DT7jLTi0N8PvVzDHjTogbzcDxhxCDYf2CM9Er1PgNOz4uKe1llZclr3zr
         ogIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+JzW7VnwR/FW2qLFYt6b6aIFvnLxLEYb3/54IE2kMFk=;
        b=bf7jEwi6NId3SzrF4naLi8i7EK5aW7B0te7rF3KpDkd7cH1Jq+GAWnriaSUrcWRxkg
         pxTeI809CbNTKJmA/zUqBFFth/NLJK4uiZeRAwuYJoNGfGBmkKnajFJvBhcJ2CPja7Be
         EiSA6lgvNR6dmeHMzbVN9489MT6B5h1KQxlazoysp1eT5JbwCPfuz6kBcZ5FlWSTBF/5
         uwveq0ojsjP+Fowesa4bk+wUMT3zwFkyarC/JAZ6qIxsS9i0yOFzhz4qKZDZY/IY6Kay
         mTDUoi+izWsA02AiAGLzLQNxgGtf6RZfSEM3wzhUs93PYg6S8kZlDOQ4MFSfOFodCdq8
         JqlA==
X-Gm-Message-State: ACrzQf39wszee+nJac3OLz5Fg3ihkvesTQ2CSsu5Ve07JNxEeRKV/6dI
	ERAXsnWbMrNekfxFZgWbbqzmm4PrA8A=
X-Google-Smtp-Source: AMsMyM5fUSgEGavG/alF7Sqp8O4PXMmWamSxuXodM2Zxum354eu3FP0DLlpWQ3M2FOjkmjOQZfEtgg==
X-Received: by 2002:a63:77c4:0:b0:435:4224:98b6 with SMTP id s187-20020a6377c4000000b00435422498b6mr1537057pgc.94.1663275357494;
        Thu, 15 Sep 2022 13:55:57 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id e19-20020a656bd3000000b004351358f056sm11923834pgw.85.2022.09.15.13.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:55:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] monitor: parse probe response frames
Date: Thu, 15 Sep 2022 13:55:54 -0700
Message-Id: <20220915205554.1061014-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915205554.1061014-1-prestwoj@gmail.com>
References: <20220915205554.1061014-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 15f4c828..5ae014e4 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5018,6 +5018,16 @@ static void print_action_mgmt_frame(unsigned int level,
 	print_mmpdu_header(level + 1, mmpdu);
 }
 
+static void print_probe_response(unsigned int level,
+				const struct mmpdu_header *mmpdu, size_t len)
+{
+	const struct mmpdu_probe_response *resp = mmpdu_body(mmpdu);
+
+	print_attr(level, "Subtype: Probe Response");
+	print_ie(level + 1, "Probe Response IEs", resp->ies,
+			(const uint8_t *) mmpdu + len - resp->ies);
+}
+
 static void print_frame_type(unsigned int level, const char *label,
 					const void *data, uint16_t size)
 {
@@ -5063,7 +5073,10 @@ static void print_frame_type(unsigned int level, const char *label,
 		str = "Probe request";
 		break;
 	case 0x05:
-		str = "Probe response";
+		if (mpdu)
+			print_probe_response(level + 1, mpdu, size);
+		else
+			str = "Probe response";
 		break;
 	case 0x06:
 		str = "Timing Advertisement";
-- 
2.34.3

