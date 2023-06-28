Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DE10944
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 20:20:41 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76728ae3162so11748285a.3
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687983640; x=1690575640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7WxOu4wYHLJynf3/A8tn2f/MjX2cfJb431wLlrXQnA=;
        b=YRt7DJnTGsxycWdFRLYXTc1TUorGcLacpp3P8p+bAW7N47IgLlketQr4y/6kPWi8jL
         eryvCtDdAtSC2VeG6PMd/sEUskCF0D4wxekfinJuX+Yq0VLzH1EZOYt6rhr9lDsTv+9S
         L2ByUm8mMdBbI2bwseQB3wZw+Zjq+kSTsydhK2uQgsK3fu8Njh4bPpRUQet32KEYhQJ0
         KCCp196imc0VjE2xLE/beDUnwCoCWsNshxomFWkrJoAMNgbbWhxvhWlvdrGXXMzHSidL
         c6xPuMTYzcEjgG5zisH0lN+SvhXB22M7ANefMWEWwkhkrnmIFjEvqdDFwkY8z5mpBc5x
         fCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983640; x=1690575640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7WxOu4wYHLJynf3/A8tn2f/MjX2cfJb431wLlrXQnA=;
        b=XMV1ZjAqOtnG4vecYx1MHT7QgOJen/IVBkVlYBg1OR1iUkplAsTgl3w3PK2dUmvA/I
         f876aItLeoupgYV61vL1t4lx6XXrDl8AHFdV3CI7pt3LE+OscxC9WxXtbOx2BAug5Dth
         B/zZ6Wdh2beGPOl27f+frXj9J3fTSxP0eDTdq1eY0tWOAYIfc8XwBlGN0jlpiwj2rEQb
         Rm6mqmjbgPIsXy8eKIP+dunsdh7WZNtr2Tsqm8cWn8mlVF8ptU/8k34sdy6PiH+AdfeG
         d5I9WgB5vgLOs/v0aHMfg1oxICzdf88M9BwIqd6reTPaZ1WS4aRoiQ6SrybUPoyoQRWU
         QLwQ==
X-Gm-Message-State: AC+VfDxfbGpoVmIiZaZkb6x2hocA8OhMvxsUcVn5jSzNcbI9eaBxiDe9
	pM/KrE4YallfLdTzgqyCGgWfnCbQVJc=
X-Google-Smtp-Source: ACHHUZ6AA/W8HOE3wMYmfjHFltKv7/7TBb9MwW9BsQ/HUmmpGoCUeMUYNqdo7lsWvfHtuDMYSedC4w==
X-Received: by 2002:a05:620a:4884:b0:767:160c:5990 with SMTP id ea4-20020a05620a488400b00767160c5990mr4770181qkb.53.1687983640411;
        Wed, 28 Jun 2023 13:20:40 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a144400b0076728319575sm672557qkl.27.2023.06.28.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:20:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] hwsim: move frame processing into a separate function
Date: Wed, 28 Jun 2023 13:20:32 -0700
Message-Id: <20230628202033.2320994-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628202033.2320994-1-prestwoj@gmail.com>
References: <20230628202033.2320994-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADD/DEL_MAC_ADDR events come through the unicast handler so
move the frame processing to a separate function so these other
events can be handled.
---
 tools/hwsim.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index ecee0a0a..2fee9b19 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1572,7 +1572,9 @@ static void process_frame(struct hwsim_frame *frame)
 	hwsim_frame_unref(frame);
 }
 
-static void unicast_handler(struct l_genl_msg *msg, void *user_data)
+
+
+static void hwsim_frame_event(struct l_genl_msg *msg)
 {
 	struct hwsim_frame *frame;
 	const struct mmpdu_header *mpdu;
@@ -1581,9 +1583,6 @@ static void unicast_handler(struct l_genl_msg *msg, void *user_data)
 	const void *data;
 	const uint8_t *transmitter = NULL, *freq = NULL, *flags = NULL;
 
-	if (l_genl_msg_get_command(msg) != HWSIM_CMD_FRAME)
-		return;
-
 	if (!l_genl_attr_init(&attr, msg))
 		return;
 
@@ -1683,6 +1682,24 @@ static void unicast_handler(struct l_genl_msg *msg, void *user_data)
 	process_frame(frame);
 }
 
+static void hwsim_unicast_handler(struct l_genl_msg *msg, void *user_data)
+{
+	uint8_t cmd;
+
+	if (l_genl_msg_get_error(msg) < 0)
+		return;
+
+	cmd = l_genl_msg_get_command(msg);
+
+	switch (cmd) {
+	case HWSIM_CMD_FRAME:
+		hwsim_frame_event(msg);
+		break;
+	default:
+		break;
+	}
+}
+
 static void radio_manager_create_callback(struct l_genl_msg *msg,
 						void *user_data)
 {
@@ -2939,8 +2956,9 @@ static void hwsim_ready(void)
 		}
 
 		if (!l_genl_add_unicast_watch(genl, "MAC80211_HWSIM",
-						unicast_handler, NULL, NULL)) {
-			l_error("Failed to set unicast handler");
+						hwsim_unicast_handler,
+						NULL, NULL)) {
+			l_error("Failed to set hwsim unicast handler");
 			goto error;
 		}
 
-- 
2.25.1

