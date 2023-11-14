Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30241774
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ61WrSD"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f0f94943d9so2849559fac.2
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982159; x=1700586959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JE9D/wJvfTFJClqf7iFSfHGDUGfkLxXL48h1pslhSE=;
        b=bZ61WrSD4D6SVDlFG2ZdRjDIEW6vb3XvY/3YMAH5X9nsJDOVCHyYAlk/4CRk+YFs9D
         2vqM9FPQSyjSRP3qjbhXQoNzgUe6cSRiMhM/f9QsBBJy6BdhpIPLXaOn5GdLu+Ng0mCj
         YEW7LKb6Tju4DF2WVegwHNr7eEsNmXatrkqjjA0qplAFBaNytEMCcGAte4Cv/zDu7M86
         ITnw83sdx8JHCsHW/7Kvn82IpArJsIx63kC7XOyfwNKXxY36VZtqrpDnwMeDHnrgbqeB
         HvvZmR1VQ4ARfpJ1G8WM1b9M/qJkJDVpCYZWhr7cQ955arvQYIB63JTm/wGtK9nZygkx
         U3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982159; x=1700586959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JE9D/wJvfTFJClqf7iFSfHGDUGfkLxXL48h1pslhSE=;
        b=uzZh1pdi6jDLsL746GH9tEhQuKk/48IOa+s+3uBMTeTX+Y8BJnnOPSKeU2L8Ftigq0
         FWEFL+fbpx8sMxektiR6UlskPs4ENDPHywLtUTZ9AdnIfHivijyfNeBr4HIpFa9m9BIF
         fxO/3Pw8SNUoHiNH9OhYZIoFr0ZNzKZ/4xAKiOFGns+MhchlOegIlvARpvMacLkCN8RK
         n5/aw17TjEJdUNUy42HSppZwdmY4f296DBCmmYgrO6KLfq1tI/d5PttS1rayHZYheRd0
         9S20YUQ6L5k0MoDxlozqGIfK8OxElWa7Hf90psbKB6XfpUu4a4uApSkre+ZN2QEtTxoj
         nRxQ==
X-Gm-Message-State: AOJu0YythXsxxA7lRALWw1lqXQiLnctMrFkQK/Zliz3W6BW03/5Kj0BA
	L9MyEMW1mtEEF5tMTJherB88Dpqb24A=
X-Google-Smtp-Source: AGHT+IGA3jfEBI2h2h2wFwKAwSRcNoF1oXlR/n3X/PJIW1TCP6Tj9rvG8YKBS4UPKSRIKOFUC+9quw==
X-Received: by 2002:a05:6870:eca1:b0:1e9:bc79:9fa6 with SMTP id eo33-20020a056870eca100b001e9bc799fa6mr10560461oab.50.1699982158761;
        Tue, 14 Nov 2023 09:15:58 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:58 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/11] netdev: disambiguate between disconnection types
Date: Tue, 14 Nov 2023 11:14:34 -0600
Message-ID: <20231114171455.1108856-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114171455.1108856-1-denkenz@gmail.com>
References: <20231114171455.1108856-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are generally three scenarios where iwd generates a disconnection
command to the kernel:
  1. Error conditions stemming from a connection related event.  For
     example if SAE/FT/FILS authentication fails during Authenticate or
     Associate steps and the kernel doesn't disconnect properly.
  2. Deauthentication after the connection has been established and not
     related to a connection attempt in progress.  For example, SA Query
     processing that triggers an disconnect.
  3. Disconnects that are triggered due to a handshake failure or if
     setting keys resulting from the handshake fails.  These disconnects
     can be triggered as a result of a pending connection or when a
     connection has been established (e.g. due to rekeying).

Distinguish between 1 and 2/3 by having the disconnect procedure take
different paths.  For now there are no functional changes since all
paths end up in netdev_connect_failed(), but this will change in the
future.
---
 src/netdev.c | 126 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 50 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 418626d72579..d0ce0aaad5e7 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -858,7 +858,7 @@ static void netdev_connect_failed(struct netdev *netdev,
 	}
 }
 
-static void netdev_disconnect_cb(struct l_genl_msg *msg, void *user_data)
+static void netdev_connect_failed_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev = user_data;
 
@@ -866,6 +866,63 @@ static void netdev_disconnect_cb(struct l_genl_msg *msg, void *user_data)
 	netdev_connect_failed(netdev, netdev->result, netdev->last_code);
 }
 
+static void netdev_send_and_fail_connection(struct netdev *netdev,
+						enum netdev_result result,
+						uint16_t status_code,
+						struct l_genl_msg *msg)
+{
+	netdev->result = result;
+	netdev->last_code = status_code;
+
+	netdev->disconnect_cmd_id =
+		l_genl_family_send(nl80211, msg, netdev_connect_failed_cb,
+					netdev, NULL);
+}
+
+static void netdev_disconnect_and_fail_connection(struct netdev *netdev,
+						enum netdev_result result,
+						uint16_t status_code)
+{
+	struct l_genl_msg *msg = nl80211_build_disconnect(netdev->index,
+						MMPDU_REASON_CODE_UNSPECIFIED);
+
+	netdev_send_and_fail_connection(netdev, result, status_code, msg);
+}
+
+static void netdev_deauth_and_fail_connection(struct netdev *netdev,
+						enum netdev_result result,
+						uint16_t status_code)
+{
+	struct l_genl_msg *msg = nl80211_build_deauthenticate(netdev->index,
+						netdev->handshake->aa,
+						MMPDU_REASON_CODE_UNSPECIFIED);
+
+	netdev_send_and_fail_connection(netdev, result, status_code, msg);
+}
+
+static void netdev_disconnect_sme_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev *netdev = user_data;
+
+	netdev->disconnect_cmd_id = 0;
+	netdev_connect_failed(netdev, netdev->result, netdev->last_code);
+}
+
+static void netdev_disconnect_by_sme(struct netdev *netdev,
+					enum netdev_result result,
+					uint16_t reason_code)
+{
+	struct l_genl_msg *msg = nl80211_build_disconnect(netdev->index,
+								reason_code);
+
+	netdev->result = result;
+	netdev->last_code = reason_code;
+
+	netdev->disconnect_cmd_id = l_genl_family_send(nl80211, msg,
+						netdev_disconnect_sme_cb,
+						netdev, NULL);
+}
+
 static void netdev_free(void *data)
 {
 	struct netdev *netdev = data;
@@ -1388,11 +1445,9 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 			return;
 		}
 
-		msg = nl80211_build_disconnect(netdev->index,
-						MMPDU_REASON_CODE_UNSPECIFIED);
-		netdev->disconnect_cmd_id = l_genl_family_send(nl80211, msg,
-							netdev_disconnect_cb,
-							netdev, NULL);
+		netdev_disconnect_by_sme(netdev,
+					NETDEV_RESULT_KEY_SETTING_FAILED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
 		break;
 	case NL80211_IFTYPE_AP:
 		if (err == -ENETDOWN)
@@ -1407,7 +1462,6 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 		break;
 	}
 
-	netdev->result = NETDEV_RESULT_KEY_SETTING_FAILED;
 	handshake_event(&nhs->super, HANDSHAKE_EVENT_SETTING_KEYS_FAILED, &err);
 }
 
@@ -2118,16 +2172,11 @@ void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_code)
 
 	netdev->sm = NULL;
 
-	netdev->result = NETDEV_RESULT_HANDSHAKE_FAILED;
-	netdev->last_code = reason_code;
-
 	switch (netdev->type) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		msg = nl80211_build_disconnect(netdev->index, reason_code);
-		netdev->disconnect_cmd_id = l_genl_family_send(nl80211, msg,
-							netdev_disconnect_cb,
-							netdev, NULL);
+		netdev_disconnect_by_sme(netdev, NETDEV_RESULT_HANDSHAKE_FAILED,
+						reason_code);
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
@@ -2842,14 +2891,9 @@ error:
 	return;
 
 deauth:
-	netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
-	netdev->last_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-	msg = nl80211_build_disconnect(netdev->index,
-						MMPDU_REASON_CODE_UNSPECIFIED);
-	netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
-							msg,
-							netdev_disconnect_cb,
-							netdev, NULL);
+	netdev_disconnect_and_fail_connection(netdev,
+					NETDEV_RESULT_ASSOCIATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
 static struct l_genl_msg *netdev_build_cmd_associate_common(
@@ -2890,19 +2934,12 @@ static void netdev_cmd_ft_reassociate_cb(struct l_genl_msg *msg,
 
 	netdev->connect_cmd_id = 0;
 
-	if (l_genl_msg_get_error(msg) < 0) {
-		struct l_genl_msg *cmd_deauth;
+	if (l_genl_msg_get_error(msg) >= 0)
+		return;
 
-		netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
-		netdev->last_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-		cmd_deauth = nl80211_build_deauthenticate(netdev->index,
-						netdev->handshake->aa,
-						MMPDU_REASON_CODE_UNSPECIFIED);
-		netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
-							cmd_deauth,
-							netdev_disconnect_cb,
-							netdev, NULL);
-	}
+	netdev_deauth_and_fail_connection(netdev,
+					NETDEV_RESULT_ASSOCIATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
 static bool kernel_will_retry_auth(uint16_t status_code,
@@ -3027,17 +3064,9 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 		 * to keep retrying, tell it to stop
 		 */
 		if (retry) {
-			struct l_genl_msg *cmd_deauth;
-
-			netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
-			netdev->last_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-			cmd_deauth = nl80211_build_deauthenticate(netdev->index,
-						netdev->handshake->aa,
-						MMPDU_REASON_CODE_UNSPECIFIED);
-			netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
-							cmd_deauth,
-							netdev_disconnect_cb,
-							netdev, NULL);
+			netdev_deauth_and_fail_connection(netdev,
+					NETDEV_RESULT_ASSOCIATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
 			return;
 		}
 	}
@@ -4545,17 +4574,14 @@ static void netdev_sa_query_timeout(struct l_timeout *timeout,
 		void *user_data)
 {
 	struct netdev *netdev = user_data;
-	struct l_genl_msg *msg;
 
 	l_info("SA Query timed out, connection is invalid.  Disconnecting...");
 
 	l_timeout_remove(netdev->sa_query_timeout);
 	netdev->sa_query_timeout = NULL;
 
-	msg = nl80211_build_disconnect(netdev->index,
-			MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID);
-	netdev->disconnect_cmd_id = l_genl_family_send(nl80211, msg,
-			netdev_disconnect_cb, netdev, NULL);
+	netdev_disconnect_by_sme(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID);
 }
 
 static void netdev_sa_query_req_cb(struct l_genl_msg *msg, void *user_data)
-- 
2.42.0

