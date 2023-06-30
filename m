Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8B174CA
	for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 19:18:27 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-635f48814b4so13808996d6.1
        for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688152706; x=1690744706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcgZEqUv9bu3djTQjDS6eCRCdy+QwDdD4tI4FZnDq24=;
        b=cj58m9i7XnLDk8wzm1V7x3VkrRevy70SfmHFY70J2W+UMSTVlI5sO5K3ndF31HijpM
         dnhaoGj8IyvNeXzV4D6FxfkeaUnu65DDiPO8W2iSHwQhVKx1eC0AorTggSAnT1JOz+JF
         LtNfx7b+bYMh/EMowHgeubn9A1r48/p3LOcE53IM8o4CQIycZ5x7GsYZ6T2kWeiTCiyJ
         /EpWNR3QSHoPgvxG1+aQrrh1d8771enui/7Mn5KtcRPguuu4tBUYDa+SfB6KQZHRmI0M
         6sMhGXCoymnBsLpHJF38R5GGO1O2obVebZbgAsuO5whC4yxB+NJrZSFexZojD2hszcCR
         IANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152706; x=1690744706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcgZEqUv9bu3djTQjDS6eCRCdy+QwDdD4tI4FZnDq24=;
        b=eE5ijUQGSx5DYi40BbsuqlAigNGR0+TOfVHR3xfw4OiPybmaB7hc/HlL3s3+wUGXvN
         sjBHJ1WUZOgEtO4FtuFUbKT0MpzemYFtK5Wglk4ZExmDvbqoUpFNV2878B5lDGSjWu9Y
         mzK4vHVG360g/Tsyxg0hYPunpfu+k9qdv3PrbsUqxyT13vB8vCfZUVxil2zVxUEQJnKZ
         3UGjvSovpzCYyjG1Wpp2CWl7rnl4L2+Qptx2xEd/1evnHyCy7aei3y1ONXqLtF0UEdeS
         CJYIpgL40k77GmSNKb7xjgZtWCTe/ZR8hEIA74v3bJlVIV8RQVpVB5bfLgRGHeCIPxPR
         /XgA==
X-Gm-Message-State: ABy/qLaQbWfRillNTzYB4fydWdpmyeiUaXCrianH/bIZnQpA2vZECWJK
	OAjTBnSxsySvxQNxCYWq84E6ifVCI6Y=
X-Google-Smtp-Source: ACHHUZ5kcJFspatPnPVesRGotFWObVFKsy2Hhct+iFsyj7zZUiBB5nl2jyNfjYNTsR+7ILJzUub9Qw==
X-Received: by 2002:a05:6214:1c4f:b0:630:20d8:7576 with SMTP id if15-20020a0562141c4f00b0063020d87576mr4572138qvb.59.1688152706032;
        Fri, 30 Jun 2023 12:18:26 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dr16-20020a05621408f000b00632209f7157sm8056605qvb.143.2023.06.30.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:18:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/5] dbus: remove dependency on agent
Date: Fri, 30 Jun 2023 12:18:08 -0700
Message-Id: <20230630191812.2884637-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630191812.2884637-1-prestwoj@gmail.com>
References: <20230630191812.2884637-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dbus module is general purpose enough that it can be reworked
to allow apps such as hwsim to use it. First, remove the agent
dependency and instead use a setter API to register the shutdown
callback.
---
 src/agent.c | 12 +++++++-----
 src/agent.h |  2 --
 src/dbus.c  | 10 ++++++++--
 src/dbus.h  |  4 ++++
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 0f718b87..eff0df3f 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -678,6 +678,11 @@ static bool release_agent(void *data, void *user_data)
 	return true;
 }
 
+static void agent_shutdown(void)
+{
+	l_queue_foreach_remove(agents, release_agent, NULL);
+}
+
 static int agent_init(void)
 {
 	struct l_dbus *dbus = dbus_get_bus();
@@ -701,6 +706,8 @@ static int agent_init(void)
 		return -EIO;
 	}
 
+	__dbus_set_agent_shutdown_func(agent_shutdown);
+
 	return 0;
 }
 
@@ -714,9 +721,4 @@ static void agent_exit(void)
 	agents = NULL;
 }
 
-void agent_shutdown(void)
-{
-	l_queue_foreach_remove(agents, release_agent, NULL);
-}
-
 IWD_MODULE(agent, agent_init, agent_exit);
diff --git a/src/agent.h b/src/agent.h
index eb08c6b6..cd9f75d7 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -37,8 +37,6 @@ typedef void (*agent_request_user_name_passwd_func_t) (enum agent_result result,
 					void *user_data);
 typedef void (*agent_request_destroy_func_t)(void *user_data);
 
-void agent_shutdown(void);
-
 unsigned int agent_request_passphrase(const char *path,
 				agent_request_passphrase_func_t callback,
 				struct l_dbus_message *message,
diff --git a/src/dbus.c b/src/dbus.c
index 32de1e1a..1e0021f2 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -30,11 +30,11 @@
 
 #include <ell/ell.h>
 
-#include "src/agent.h"
 #include "src/iwd.h"
 #include "src/dbus.h"
 
 static struct l_dbus *g_dbus = NULL;
+static dbus_agent_shutdown_func_t agent_shutdown;
 
 struct l_dbus_message *dbus_error_busy(struct l_dbus_message *msg)
 {
@@ -220,8 +220,14 @@ void dbus_exit(void)
 	g_dbus = NULL;
 }
 
+void __dbus_set_agent_shutdown_func(dbus_agent_shutdown_func_t agent_shutdown)
+{
+	agent_shutdown = agent_shutdown;
+}
+
 void dbus_shutdown(void)
 {
 	/* Allow AgentManager to send a Release call before disconnecting */
-	agent_shutdown();
+	if (agent_shutdown)
+		agent_shutdown();
 }
diff --git a/src/dbus.h b/src/dbus.h
index 00c2df57..a5b667a7 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -51,10 +51,14 @@
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
 #define IWD_P2P_SERVICE_MANAGER_PATH IWD_BASE_PATH
 
+typedef void (*dbus_agent_shutdown_func_t)(void);
+
 struct l_dbus;
 
 struct l_dbus *dbus_get_bus(void);
 
+void __dbus_set_agent_shutdown_func(dbus_agent_shutdown_func_t agent_shutdown);
+
 void dbus_pending_reply(struct l_dbus_message **msg,
 				struct l_dbus_message *reply);
 bool dbus_append_dict_basic(struct l_dbus_message_builder *builder,
-- 
2.25.1

