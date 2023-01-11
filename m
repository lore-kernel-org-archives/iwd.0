Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C5BD06
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:54 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id a184so12263144pfa.9
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22kTbGaMDJhajhzHzyU9XKZVfETLpPxDyUmUv4lMAxI=;
        b=FufYQAdLBK5h/Lobot140en0wF3DGmj77Bxp5Z+Cceubp/H4iZUnAr2Vm3sTT9Nneq
         FZLDHTyxDNfzt/wKthBBhRspCZYRtcNzO1GVfRJqu8lKCTDZXF1jB9xOSCICMq7xAuS9
         9TzBkF21YhnVHXdiJd/W52YhpBNSh3Obp25uk3rYSiU4lk1tX8wq1R13TYTuRTugHP9A
         jrrXmPxArVjbioDWcAJZ8GjPIapZzZypEsBWIsbKvfJ19zIB+9UkPzOnZNV8Bo1meC5+
         mVJ+wr5nUv1Gt4Bh6R7WNbVc8+LSprAMq4bg9+Vok6i4/kRjmBRe4XbFQGvySQ2u+tLQ
         xyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22kTbGaMDJhajhzHzyU9XKZVfETLpPxDyUmUv4lMAxI=;
        b=DOhVQLodmussAc1q8w/NGLKOIFrvkh6ow9mFRqB/E7Qkqp+FPoklRzd3O8lS/R33g9
         hWASCjftLi8iQ5Pt/lQeP807+Vt0ybaM+NpEOuUvA+99g8H8pBPz9vXPo6iNc+EnNKTv
         sgrlSvznyevTq6C9h0dgOUlrW3NToV0DOmN9f3RwWTxPNc301mhRnM6QGYMm6Jt3Icw4
         Hkg8wC0DGlAviaR8Ym8xhrmjb1JcaWUc5wkHe6Mq8ds3j2wrCdcaGO8OkV5VI9d2dihv
         pked3UjxL5CRBgjgI7jZO6OtXI5HYDaUwbFTkMkiQ7DVl5q4WNyf45RQfz0IQDrKCByq
         1/oA==
X-Gm-Message-State: AFqh2kqQOtfI7qGkJOMf69sOyIkJM5dXHqtc5Ot1LOc7NhL8kbRdSvvi
	2+jsYhPEvUut77QY2IkKB5orrjFwExA=
X-Google-Smtp-Source: AMrXdXvjH/xkYSY7NeqEDhT5pSqglhm9Es9ztxj76lgwKKqGh50xkyjbG5yRBNSR2OV7EY+ZNKHQJQ==
X-Received: by 2002:a05:6a00:1d99:b0:588:4e84:5b67 with SMTP id z25-20020a056a001d9900b005884e845b67mr3765054pfw.30.1673468153887;
        Wed, 11 Jan 2023 12:15:53 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:53 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] netdev: support HANDSHAKE_EVENT_REKEY_COMPLETE
Date: Wed, 11 Jan 2023 12:15:40 -0800
Message-Id: <20230111201543.397692-6-prestwoj@gmail.com>
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

In try_handshake_complete() we return early if all the keys had
been installed before (initial associations). For rekeys we can
now emit the REKEY_COMPLETE event which lets AP mode reset the
rekey timer for that station.
---
 src/netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index fc8a2afa..035dbd00 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1469,8 +1469,13 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 
 static void try_handshake_complete(struct netdev_handshake_state *nhs)
 {
-	if (nhs->ptk_installed && nhs->gtk_installed && nhs->igtk_installed &&
-			!nhs->complete) {
+	if (nhs->ptk_installed && nhs->gtk_installed && nhs->igtk_installed) {
+		if (nhs->complete) {
+			handshake_event(&nhs->super,
+					HANDSHAKE_EVENT_REKEY_COMPLETE);
+			return;
+		}
+
 		nhs->complete = true;
 
 		if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
-- 
2.34.3

