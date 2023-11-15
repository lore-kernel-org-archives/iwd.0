Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138428E6
	for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqGrpBZi"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e98e97c824so172824fac.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 16:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700006800; x=1700611600; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0v60YZ7b6Sd1B13M5XWy/VqJzabCw3poKyadAxbGkg=;
        b=MqGrpBZiSY4tQBR1nNB1hvi2ONz+BFpEO2f1HjSFjNkUd0VdR29VFdXMjP3G0+u+Is
         uFZGmYEHnV+kRcKF4H8U1uI9XjGMQWHg/YDkO/011h3UOFkj0XhzTWJ+tAxcbWPCKCUo
         BMXRpVp1nXFt7mZQvqEHydWbFUXE8VLLTaDGUD6WTnZVIxc68x6rjs4NAgygYCOLj8yg
         S1JKXbwUviORacIMhdGS57CzgMqkzib6m2IwKpa/iCUrxySAGHTkfauA+IC8aIuYMkZ4
         fIMndDt5mOOLWdgFEMB3KrxHh7oHjxQ7rbiv0zeWb/h59ahT3rpDKASz8ommnOcD87U0
         8DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700006800; x=1700611600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0v60YZ7b6Sd1B13M5XWy/VqJzabCw3poKyadAxbGkg=;
        b=oOrQhet2PRrQjCKClAj236/s1gg7OGiS6/yYIBDg5QgNX2vtQ5wmRUF5zP7JxnaG4T
         DEZtiDjPTrAYIDuqGz2Ob64ZWd2GHyTl4oTs2bexvyOLuvG3T2CmjCe/kswJJtdJkNbC
         us9+OfR8yJ4v55DH2pwgtUiptbG4lrS4Dfj8BdGjQGBnQxxfNxcfttE7hM4TyoZCXcQi
         SuluuFgG2xDjMCb4cOwF2PucE+dVV5XXXmw+Rtml8ro5S8m69geTgIENSGrPsZ4fWt4g
         OWJTv+O4PCfdzb4Q4wDLpRIqGI5BX/bHXo6Kf5c2AAppME5mblIqibbg1hiki5hi29ER
         YlzA==
X-Gm-Message-State: AOJu0Yz0vPSCwH1GarXbhfYmHF6qHK/VgQmx9CmFEDdNYkdvcKgeCeFr
	lYc6MIUqAHlihkJhb2cYoAzY9R2piGw=
X-Google-Smtp-Source: AGHT+IEmuxA2kbJ9tZm5CZ7WddmJs+9fkRJkgaGQENEF+0pTEoQ9Hg2ZMKtO9wvw1qjepeM5QypjAg==
X-Received: by 2002:a05:6870:3d93:b0:1e9:d3bd:3ec with SMTP id lm19-20020a0568703d9300b001e9d3bd03ecmr2329359oab.22.1700006799877;
        Tue, 14 Nov 2023 16:06:39 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id pi5-20020a056871d10500b001e578de89cesm1607468oac.37.2023.11.14.16.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 16:06:39 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/3] netdev: Separate connect_failed and disconnected paths
Date: Tue, 14 Nov 2023 18:05:33 -0600
Message-ID: <20231115000547.1139157-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115000547.1139157-1-denkenz@gmail.com>
References: <20231115000547.1139157-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c59669a366c5 ("netdev: disambiguate between disconnection types")
introduced different paths for different types of disconnection
notifications from netdev.  Formalize this further by having
netdev_connect_failed only invoke connect_cb.

Disconnections that could be triggered outside of connection
related events are now handled on a different code path.  For this
purpose, netdev_disconnected() is introduced.
---
 src/netdev.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 327be768d3d9..e31a51617671 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -839,7 +839,6 @@ static void netdev_connect_failed(struct netdev *netdev,
 					uint16_t status_or_reason)
 {
 	netdev_connect_cb_t connect_cb = netdev->connect_cb;
-	netdev_event_func_t event_filter = netdev->event_filter;
 	void *connect_data = netdev->user_data;
 
 	/* Done this way to allow re-entrant netdev_connect calls */
@@ -847,15 +846,6 @@ static void netdev_connect_failed(struct netdev *netdev,
 
 	if (connect_cb)
 		connect_cb(netdev, result, &status_or_reason, connect_data);
-	else if (event_filter) {
-		/* NETDEV_EVENT_DISCONNECT_BY_SME expects a reason code */
-		if (result != NETDEV_RESULT_HANDSHAKE_FAILED)
-			status_or_reason = MMPDU_REASON_CODE_UNSPECIFIED;
-
-		event_filter(netdev, NETDEV_EVENT_DISCONNECT_BY_SME,
-				&status_or_reason,
-				connect_data);
-	}
 }
 
 static void netdev_connect_failed_cb(struct l_genl_msg *msg, void *user_data)
@@ -900,12 +890,42 @@ static void netdev_deauth_and_fail_connection(struct netdev *netdev,
 	netdev_send_and_fail_connection(netdev, result, status_code, msg);
 }
 
+/*
+ * If we have a connection callback pending, either through netdev_connect
+ * or netdev_reassociate, then invoke that callback with the @result and
+ * @status_or_reason.  Otherwise, invoke the event callback with the @event
+ * and @status_or_reason.
+ *
+ * This is useful for situations where handshaking or setting keys somehow
+ * fails (perhaps due to rekeying), or if the device is removed / brought
+ * down when keys are being set as a result of a rekey
+ */
+static void netdev_disconnected(struct netdev *netdev,
+					enum netdev_result result,
+					enum netdev_event event,
+					uint16_t status_or_reason)
+{
+	netdev_event_func_t event_filter = netdev->event_filter;
+	void *event_data = netdev->user_data;
+
+	if (netdev->connect_cb) {
+		netdev_connect_failed(netdev, result, status_or_reason);
+		return;
+	}
+
+	netdev_connect_free(netdev);
+
+	if (event_filter)
+		event_filter(netdev, event, &status_or_reason, event_data);
+}
+
 static void netdev_disconnect_by_sme_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev = user_data;
 
 	netdev->disconnect_cmd_id = 0;
-	netdev_connect_failed(netdev, netdev->result, netdev->last_code);
+	netdev_disconnected(netdev, netdev->result,
+			NETDEV_EVENT_DISCONNECT_BY_SME, netdev->last_code);
 }
 
 static void netdev_disconnect_by_sme(struct netdev *netdev,
@@ -1440,7 +1460,8 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 		 * CMD_DISCONNECT
 		 */
 		if (err == -ENETDOWN) {
-			netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+			netdev_disconnected(netdev, NETDEV_RESULT_ABORTED,
+					NETDEV_EVENT_DISCONNECT_BY_SME,
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 			return;
 		}
-- 
2.42.0

