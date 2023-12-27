Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874146BF
	for <iwd@lists.linux.dev>; Wed, 27 Dec 2023 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OANzXDy/"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-204500454fcso1719439fac.3
        for <iwd@lists.linux.dev>; Tue, 26 Dec 2023 22:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703657441; x=1704262241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TyUB8iLFP2aBxVFbLQDQBKLgvthr3mcDBpUWMEG+KFs=;
        b=OANzXDy/FUzTKw7Y5CJE8NYtCrv0/dEm2On/xWftB4LX5ICtGomdUoMvz1qTmKde8d
         42jrZ7D1SSm+uCXwJT1qesfmxKofvPRBJ6HhkZdd1OECDzg/1i3qu/U0Q+bbRozvobGP
         AbavWesZo09qOZfqM8K3USFwj8vuE/yCb2L7qCEyN8RW/seCfA8DvYYxCZazxVB0XvbO
         mq9d0seMlheZZ54/JnoGhiH+7DWtSAK+kZExSGovyTrA8XDC+q0mMCNcCtC453iwg67F
         nzQqdep9rXyY2kaVtCFBxpBsYnqPPtWNCKj66st/qqyxIrzuyb/FWc0dzWSS0K3Ne3BP
         bM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703657441; x=1704262241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyUB8iLFP2aBxVFbLQDQBKLgvthr3mcDBpUWMEG+KFs=;
        b=iKik54dN1XKIhyFZemRQnGOiRMNr4I0O0Srh/XMQZ0XrVvCufEXnIHvEQASgZq1IMl
         /BnE3IEsmSy7iDrOyRvYuLf7jNwyp7yxA4a8t1Lfm41imky37GWv2fJ+BhjIrkA8Hy89
         qE/3emyJma2GnAfkM7pymfrA6/tOOT99VTJXDcjYnLhT9ViNIISEBbLCR2uEN9uuR7Pp
         HxVQICReHvyUlIL3mJCyZ1AA5hSO+oYIXAkzNd4wSVJWjA+Wn/+b9DOc+kcZJvkX+dcK
         9VJkrJ+t8O+96iHZcH3kE9tFU34bGL+ukNuiK/Fb4SPWXCA/w7OuBne6GWPRj5jwy8QZ
         3Htg==
X-Gm-Message-State: AOJu0Yzg7XQfngfLXY7FEYQ8QiG8NfnLw8blyHIq7hP/2gsuKXq9hHv6
	+T11tyGAgC0uq9p3BO1eFjNwUUZXmR0=
X-Google-Smtp-Source: AGHT+IGw4U9g4qW4QBdB90rA/ib0GVWpJociP/fvwFlg+B6YVv3EJVVHO8GkhvQfFWs7uTkcB8kx0A==
X-Received: by 2002:a05:6870:818d:b0:203:5afb:4b06 with SMTP id k13-20020a056870818d00b002035afb4b06mr5025447oae.5.1703657441001;
        Tue, 26 Dec 2023 22:10:41 -0800 (PST)
Received: from localhost.localdomain (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.gmail.com with ESMTPSA id vs7-20020a056871a10700b002032bb7895fsm3048841oab.55.2023.12.26.22.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 22:10:40 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/5] monitor: Remove unused code path
Date: Wed, 27 Dec 2023 00:09:46 -0600
Message-ID: <20231227060954.103572-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nlmon_print_genl invokes genl_ctrl when a generic netlink control
message is encountered.  genl_ctrl() tries to filter nl80211 family
appearance messages and setup nlmon->id with the extracted family id.
However, the id is already provided inside main.c by using nlmon_open,
and no control messages are processed by nlmon in 'capture' mode (-r
command line argument not passed) since all genl messages go through
nlmon_message() path instead.
---
 monitor/nlmon.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index ed40264bacd6..7f8ecdaa1996 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7359,35 +7359,6 @@ void nlmon_destroy(struct nlmon *nlmon)
 	l_free(nlmon);
 }
 
-static void genl_ctrl(struct nlmon *nlmon, const void *data, uint32_t len)
-{
-	const struct genlmsghdr *genlmsg = data;
-	const struct nlattr *nla;
-	char name[GENL_NAMSIZ];
-	uint16_t id = 0;
-
-	if (genlmsg->cmd != CTRL_CMD_NEWFAMILY)
-		return;
-
-	for (nla = data + GENL_HDRLEN; NLA_OK(nla, len);
-						nla = NLA_NEXT(nla, len)) {
-		switch (nla->nla_type & NLA_TYPE_MASK) {
-		case CTRL_ATTR_FAMILY_ID:
-			id = *((uint16_t *) NLA_DATA(nla));
-			break;
-		case CTRL_ATTR_FAMILY_NAME:
-			strncpy(name, NLA_DATA(nla), GENL_NAMSIZ - 1);
-			break;
-		}
-	}
-
-	if (id == 0)
-		return;
-
-	if (!strcmp(name, NL80211_GENL_NAME))
-		nlmon->id = id;
-}
-
 static const char *scope_to_string(uint8_t scope)
 {
 	switch (scope) {
@@ -8208,10 +8179,9 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 	for (nlmsg = data; NLMSG_OK(nlmsg, size);
 				nlmsg = NLMSG_NEXT(nlmsg, size)) {
 		if (nlmsg->nlmsg_type == GENL_ID_CTRL)
-			genl_ctrl(nlmon, NLMSG_DATA(nlmsg),
-						NLMSG_PAYLOAD(nlmsg, 0));
-		else
-			nlmon_message(nlmon, tv, NULL, nlmsg);
+			continue;
+
+		nlmon_message(nlmon, tv, NULL, nlmsg);
 	}
 }
 
-- 
2.43.0

