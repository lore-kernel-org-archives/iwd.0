Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2371C34
	for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 14:05:20 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id z2so4037748edi.1
        for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 07:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=xhaTK1P7R7swiKIojlIx4B/VOmt7XqvmJU5qFBqmW8c=;
        b=E1xyQiMO0O9DKT+aivYhqu7kyP374LvbrU+cSiL78SZH0sjtNXgPhVDv8bXtBZDWz3
         5uzCWJWIlecsrsLVJp3Vh9BjjF3KfVqcL0zt5jvM+Q/HcR0nmaynOqxIsiew17tXw6RV
         u04HCdNZE7HdLqDmfrOjEcoRyA/1MErqeHGAuTfJ83e7I3/NL0fJyZGc7GC3QO+WmIGP
         MyN1brfveb6clNN4YhYILkjunVBJzbD38b9RIRZE4KSGMKMwZTCJLPM2nHVV1szk0H2z
         V8bnXIRAJeRtIKdFs/M6csTiDTlc3UeHUMcyGOcFfpBpOv6pbxntlvxodRXA9RgSmaje
         rGlQ==
X-Gm-Message-State: ACrzQf19ia1iXzB1yuk5u4IhoK6yvDkGB3zuudcb+bMRzjxqcRoaPFa1
	SeuBdgHRIxKkbX74uMCjs6WyGe5ZUxdL0iFw
X-Google-Smtp-Source: AMsMyM7hDhmrZFSfTM465lcXlaJQ6hHlUKH1dbPV4d61I1Gm1xM9GlQw1rpn9L/S2Sci+Eeu6Xl6Rg==
X-Received: by 2002:aa7:d453:0:b0:44e:4b1d:28a with SMTP id q19-20020aa7d453000000b0044e4b1d028amr19661597edr.112.1663682718465;
        Tue, 20 Sep 2022 07:05:18 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906300800b0077d37a5d401sm947561ejz.33.2022.09.20.07.05.13
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:05:14 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/3] netconfig: Drop D-Bus path from debug message
Date: Tue, 20 Sep 2022 16:05:07 +0200
Message-Id: <20220920140509.3304422-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l_dbus_message_get_path(reply) is normally NULL in this callback so
don't bother printing it.
---
 src/netconfig-commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index 9894ace2..96436c1c 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -373,8 +373,7 @@ static void netconfig_agent_receive_reply(struct l_dbus_message *reply,
 	const char *error, *text;
 	bool success = true;
 
-	l_debug("agent reply from %s %s", l_dbus_message_get_sender(reply),
-		l_dbus_message_get_path(reply));
+	l_debug("agent reply from %s", l_dbus_message_get_sender(reply));
 
 	data->pending_id[INDEX_FOR_AF(cd->family)] = 0;
 
-- 
2.34.1

