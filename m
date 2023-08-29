Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08828E7
	for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 14:51:31 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bdc19b782aso28155935ad.0
        for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320690; x=1693925490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKG6vAFL4C0RXP00zG82nAqI3IIW33AiU3eV7M1MeQs=;
        b=bME0tabCNlJWmYzUyYEmvqORVvi7rVDxh6bOcJNBUNOkwPjCZlX+f8AF9TlJXN7Z1Q
         LEHdYfEueFs9v9lyF8T2lpjTW7ImkVEUDTLYIUvxqPkc3dIdso8ZZtmdqVGG80CoBTsT
         iZ0KjQxYaFT8RgkGL8Eyy5OoWOIkz/o1MOncpCud0Pkti/MG8//zzGFzdhZOlfyHSOly
         xQqIXYqWau8iruRr6JL7ZKkqdJTE50pmFV+12X24FgcQ2zdKeaRep96DZGjjb8TkPopk
         lIidbYY+E81Lx8kOe5/NnTrhJM4Ni6rZYiALPOLxqxWQ/3YjBi6/KA9wHt0HLRtyQ+aN
         jmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320690; x=1693925490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKG6vAFL4C0RXP00zG82nAqI3IIW33AiU3eV7M1MeQs=;
        b=JFa43bvWaFJVMJscuHjgcs4lwTzRDi+1vdV2nC5vNJLgfbtfb4RKa1VMqJDJJCJeJC
         qX3iHopeGHteq68ZcCYQgO3qGqfL01bmyG01vWA8Z9vtzGR652nbJhEI6p5x/FyD58KE
         upefjT1dSJvQha0PsW7JajXxFD58avVVEIDKnE1XVDUE7ba+B7bUz8JJ+Wi+jDMHRCeO
         mlVia71xd2ldv0kDjhstrPFNp4k4Y2kXQbGwnX3fN3H5F9r3sQ5YNArrDDDi9Ica2CPP
         0GZU3N1BsFjBExD9vh9IIOuxiGrSTSELUDoyFwGKUgZIVSijp5+T56whFyT4BPAxy3rt
         bkPw==
X-Gm-Message-State: AOJu0YyeESi/in59T6Pgpsp519AJaEXzg8YYyfcjct0zgTY2Xbq9KiDn
	Se2mXVnYl+4y4cdb6amgioGdm87snoo=
X-Google-Smtp-Source: AGHT+IGjWYIeiDQL/2/RUm5qX17e8cXFbE4mPhEX/DCkPhHrtsI2oNPZlOlPj2jP+NAiglYb/RwMjg==
X-Received: by 2002:a17:902:e887:b0:1bd:e9de:ccc3 with SMTP id w7-20020a170902e88700b001bde9deccc3mr27529929plg.50.1693320690141;
        Tue, 29 Aug 2023 07:51:30 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bc445e249asm9661283pln.124.2023.08.29.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:51:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] ft: track FT auth/action response status
Date: Tue, 29 Aug 2023 07:51:14 -0700
Message-Id: <20230829145116.279949-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain return codes, though failures, can indicate that the AP is
just confused or booting up and treating it as a full failure may
not be the best route.

For example in some production deployments if an AP is rebooted it
may take some time for neighboring APs to exchange keys for
current associations. If a client roams during that time it will
reject saying the PMKID is invalid.

Use the ft_associate call return to communicate the status (if any)
that was in the auth/action response. If there was a parsing error
or no response -ENOENT is still returned.
---
 src/ft.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

v2:
 * Remove 'parsed' and use the status instead. Status is now
   initialized to -ENOENT and only set to zero if parsing the
   IEs succeeds. If a non zero status reply comes in this is
   returned by ft_associate.

diff --git a/src/ft.c b/src/ft.c
index c51a1288..a7655d91 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -58,13 +58,14 @@ struct ft_info {
 	uint32_t frequency;
 	uint32_t ds_frequency;
 	uint32_t offchannel_id;
+	/* Status of Authenticate/Action frame response, or error (< 0) */
+	int status;
 
 	struct l_timeout *timeout;
 	struct wiphy_radio_work_item work;
 
 	struct ie_ft_info ft_info;
 
-	bool parsed : 1;
 	bool onchannel : 1;
 };
 
@@ -527,8 +528,6 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
 		return -EINVAL;
 
 	status = l_get_le16(frame + 14);
-	if (status != 0)
-		return (int)status;
 
 	if (spa_out)
 		*spa_out = spa;
@@ -541,7 +540,7 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
 		*ies_len = frame_len - 16;
 	}
 
-	return 0;
+	return (int)status;
 }
 
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
@@ -825,7 +824,7 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 
 	ret = ft_over_ds_parse_action_response(frame, frame_len, &spa, &aa,
 						&ies, &ies_len);
-	if (ret != 0) {
+	if (ret < 0) {
 		l_debug("Could not parse action response");
 		return;
 	}
@@ -836,13 +835,22 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 		return;
 	}
 
+
+	if (ret != 0) {
+		l_debug("BSS "MAC" rejected FT action with status=%u",
+				MAC_STR(info->aa), ret);
+		info->status = ret;
+		goto done;
+	}
+
 	if (!ft_parse_ies(info, hs, ies, ies_len)) {
 		l_debug("Could not parse action response IEs");
 		goto ft_error;
 	}
 
-	info->parsed = true;
+	info->status = ret;
 
+done:
 	l_timeout_remove(info->timeout);
 	info->timeout = NULL;
 
@@ -872,6 +880,7 @@ static struct ft_info *ft_info_new(struct handshake_state *hs,
 						target_bss->rsne[1] + 2);
 
 	l_getrandom(info->snonce, 32);
+	info->status = -ENOENT;
 
 	return info;
 }
@@ -1016,6 +1025,7 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 	if (status != 0) {
 		l_debug("BSS "MAC" rejected FT auth with status=%u",
 				MAC_STR(info->aa), status);
+		info->status = status;
 		goto cancel;
 	}
 
@@ -1024,7 +1034,7 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 		goto cancel;
 	}
 
-	info->parsed = true;
+	info->status = status;
 
 cancel:
 	/*
@@ -1164,11 +1174,13 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
 	 * Either failed or no response. This may have been an FT-over-DS
 	 * attempt so clear out the entry so FT-over-Air can try again.
 	 */
-	if (!info->parsed) {
+	if (info->status != 0) {
+		int status = info->status;
+
 		l_queue_remove(info_list, info);
 		ft_info_destroy(info);
 
-		return -ENOENT;
+		return status;
 	}
 
 	ft_prepare_handshake(info, hs);
-- 
2.25.1

