Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C91A7079
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179512; cv=none; b=tQM++W1WXVmlHT+sF6RCte0SJwRIrR20jLbFTO0PCPXNL4vEbrIJEBW9fdVSOfNVb30I19OeJueAih/hQxglZw3TiOttmGVSxrKVJ3a514r4bxmuku8GJ9A/C1GEXZgNJDD55OEsxK1IUujYFSazlCmZVn50fyPNUuEnA7EGSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179512; c=relaxed/simple;
	bh=2JhI08P+zLYT3hOvvS7aWYftpTpekdhMaNBNh9PbhnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i61E7hlDg5xR8itV2+IGQKWf3p9ssh4sumjjJW2bmFxS795vJuau0dHMeHs7HG7oRMV2izv43sAfY6h6LBEsMYBZG88ZLECZ1e3mA1so/1V4j/4C/+ZFJajjfKv38txIKi70heePsGX3HOEzIGHfQqTQ7/6slLH2h5vs6iR2UDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKhIqivC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKhIqivC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9ab8e5f96so91853685a.1
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179509; x=1727784309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm5fjf5QqtpMS5z1VGpk7shoL8IDoIhH6mMTqGyKoE0=;
        b=TKhIqivCL96GHKEkCDylylrR+ldE9HLihjpnBcKXsVcVcfHzOHlqiyT8XjQpfV3slo
         qpKaGvAAoJE3cF9XO0dZ60+5Gn/X0CjgjyfkQKCxMmQsC66ydQTF85otoCzsWmd3iKB+
         IV7Qa9ABTJ/fNi04pi5w6ZO5CdoYy4A8LJPVWTimqP216ipugJfMC4Wy7Jbkmiu3IHQI
         Xd0Imhs2YuMsSYedCP97XNGN/pV66zt7Qpx1hqdxjXiTHUqzTVk3FGEslCB+nmXw0nQG
         7NZbqHK9IPVI/DfEYbi9c+yzA1dwOQ1khEbw+CygE3ckIZUSS+M5qzvky76IYSVQ0XvP
         Ym2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179509; x=1727784309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm5fjf5QqtpMS5z1VGpk7shoL8IDoIhH6mMTqGyKoE0=;
        b=a0s9ZJrth8IRzmrSrfqUPPOG0ovoW7hFUm+63MlSt5O0025vz90L6nO/UK8SQCYxKi
         n8MqAFwXlszf6GEGIkxZy9y/RuXVf87eDpTmaGqWW2R6IJjRao0X+SsX4hhu9nZLNl2K
         1t6JqvhbXZ8u5mQ5rm/S6xCjaHcJ/6KQcgC5c1fbVleQujIqO4dqjDYVfzjlqhrdniI8
         QJtIzlPtjv5kpoQCrs1AQTIzcLDgOuU/KhZ1XgAXbbYr8UA0RtoEASIDA+1bNKyHbGeo
         aX+uws9klP9yx6pe9hER4KIXo5qJgmYNi5iKbSa4Pxg53EoprEgKUzUt3IkeB2xn2vW2
         z8vw==
X-Gm-Message-State: AOJu0YyMnvDERASIMr9YxL/ZIveCDiWoNoQ0abpaI+H09FpiDDlU4ty+
	e4GryFwlD3pB7CAlLgvQGyadRQDGnpipZdbSsLdYDrLR6Cf5lykCxjsYmw==
X-Google-Smtp-Source: AGHT+IHtBurul/8zvn6HVp2d+jATqd+5Vx8320LEVcPcJ/7ync9RuZxBufg6br37SX5q8CHO9U0hKA==
X-Received: by 2002:a05:6214:460f:b0:6c7:cc6b:f0f5 with SMTP id 6a1803df08f44-6c7cc6bf13emr191948286d6.13.1727179509554;
        Tue, 24 Sep 2024 05:05:09 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/16] agent: add APIs for DeviceProvisioningAgent
Date: Tue, 24 Sep 2024 05:04:42 -0700
Message-Id: <20240924120447.251761-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds {Register,Unregister}DeviceProvisioningAgent to the
AgentManager interface. These are simple wrappers which just call
into DPP.
---
 src/agent.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index 0f718b87..bf0a88ea 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -32,6 +32,7 @@
 #include "src/agent.h"
 #include "src/iwd.h"
 #include "src/module.h"
+#include "src/dpp.h"
 
 static unsigned int next_request_id = 0;
 
@@ -639,6 +640,54 @@ static struct l_dbus_message *netconfig_agent_unregister(struct l_dbus *dbus,
 	return reply;
 }
 
+static struct l_dbus_message *device_provisioning_agent_register(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+	const char *path;
+	int r;
+
+	l_debug("");
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	r = dpp_register_agent(l_dbus_message_get_sender(message), path);
+	if (r)
+		return dbus_error_from_errno(r, message);
+
+	l_debug("device provisioning agent %s path %s",
+		l_dbus_message_get_sender(message), path);
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+	return reply;
+}
+
+static struct l_dbus_message *device_provisioning_agent_unregister(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+					void *user_data)
+{
+	struct l_dbus_message *reply;
+	const char *path;
+	int r;
+
+	l_debug("");
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	r = dpp_unregister_agent(l_dbus_message_get_sender(message), path);
+	if (r)
+		return dbus_error_from_errno(r, message);
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+	return reply;
+}
+
 static void setup_agent_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "RegisterAgent", 0,
@@ -654,6 +703,15 @@ static void setup_agent_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_method(interface,
 				"UnregisterNetworkConfigurationAgent", 0,
 				netconfig_agent_unregister, "", "o", "path");
+
+	l_dbus_interface_method(interface,
+				"RegisterDeviceProvisioningAgent", 0,
+				device_provisioning_agent_register,
+				"", "o", "path");
+	l_dbus_interface_method(interface,
+				"UnregisterDeviceProvisioningAgent", 0,
+				device_provisioning_agent_unregister,
+				"", "o", "path");
 }
 
 static bool release_agent(void *data, void *user_data)
-- 
2.34.1

