Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9C3217
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 17:12:34 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so10456996pjb.5
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iG7YVwZXm2r+2ij5Ld6cYqf7GvKGPxiACjn+l56m/To=;
        b=oWrhUz+H6Q0De4Ka8KLP8GvykW+Gtb0/1OF48BuDtv9t9Pd7vDTtSv8SV69tuYYyQq
         /O5alxVPG3RAbnjWiPvQbnVSnQKD7NI4MBhUG1rzPjdaLI9QVOEBqtEr1W75rfP65i4f
         NsHv1UZWzbyi2cy6emx0Qq6K1F1vpOTPtofSLBoz6K7vqdRpJVuV2euLa6OwSAl5yghc
         7Waz++qaI6dMq4BTRH4sPqxeAvUEPPYkTemMky95GYOt+vWdtUKu/crbb2rR8K1rCfTe
         jLz3aZuPV9mZiDqFRo202icqov+wYOafKWz78x4N+sSp8iml3V1jZduspfaQzrfqDsSh
         9SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iG7YVwZXm2r+2ij5Ld6cYqf7GvKGPxiACjn+l56m/To=;
        b=G+X0hdWBhutlI5/AJW05TBGnGOLPWYqKIUSyxPvWPpG4KlhLAZkFZA7eDw0Pg8lnGt
         dSI3anSwwxAY3+7pMVvg4n8nzth5u0mXx3MNNgpbiuQ+SZ09qsTgKbXe4lWqOyrCIveI
         xrpQqizPVLMtH5foBRxX8PKUYYtsqBcpcqXw71kxLjUI8FFm6wT7TiXhtOyoJT08/FNQ
         EOd9kPEBROtURdYoB4vvD+ZSubq+WBSGlEG7EUGUkYaCCPsyjYuaC2IVG9It/QzcjS+T
         0qx8IUWX08KLVt0DtGghor7JLOZE8K5SY+7i5Kz7YZnwsEEZEJICQBUKn+PjQWvf7pUa
         wiLw==
X-Gm-Message-State: AAQBX9dMaYjYp4E+fN+d1jWhtuuPheX2nI9v1NQuIcwuxzrZTF4IO7ch
	yP0/4emt1qYMHUAGiakK5rbpTRf+uFr6+Q==
X-Google-Smtp-Source: AKy350bL44co7OrbsI98rBoqWrSyfP47xbJ/s5zExwbZfJEdLvWHUYhgyG+MnAZaExQiQeAoVYZ8Cw==
X-Received: by 2002:a17:902:da8a:b0:1a0:5524:eb8e with SMTP id j10-20020a170902da8a00b001a05524eb8emr16633097plx.68.1681146753932;
        Mon, 10 Apr 2023 10:12:33 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902b08400b001a634e79af0sm3057928plr.283.2023.04.10.10.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:12:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] hwsim: properly cleanup rules queue
Date: Mon, 10 Apr 2023 10:12:32 -0700
Message-Id: <20230410171232.32739-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After adding prefix matching the rule structure contained allocated
memory which was not being cleaned up on exit if rules still
remained in the list (removing the rule via DBus was done correctly)
---
 tools/hwsim.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 7afbe4e7..47352ad4 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -2092,6 +2092,19 @@ static void setup_rule_manager_interface(struct l_dbus_interface *interface)
 				rule_add, "o", "", "path");
 }
 
+static void destroy_rule(void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+
+	if (rule->prefix)
+		l_free(rule->prefix);
+
+	if (rule->match)
+		l_free(rule->match);
+
+	l_free(rule);
+}
+
 static struct l_dbus_message *rule_remove(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -2102,13 +2115,8 @@ static struct l_dbus_message *rule_remove(struct l_dbus *dbus,
 	path = rule_get_path(rule);
 	l_queue_remove(rules, rule);
 
-	if (rule->prefix)
-		l_free(rule->prefix);
+	destroy_rule(rule);
 
-	if (rule->match)
-		l_free(rule->match);
-
-	l_free(rule);
 	l_dbus_unregister_object(dbus, path);
 
 	return l_dbus_message_new_method_return(message);
@@ -3131,7 +3139,7 @@ int main(int argc, char *argv[])
 
 	l_dbus_destroy(dbus);
 	hwsim_radio_cache_cleanup();
-	l_queue_destroy(rules, l_free);
+	l_queue_destroy(rules, destroy_rule);
 
 	l_netlink_destroy(rtnl);
 
-- 
2.25.1

