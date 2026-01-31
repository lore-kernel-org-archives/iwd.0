Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74E376479
	for <iwd@lists.linux.dev>; Sat, 31 Jan 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769896464; cv=none; b=EP2DkK6G5o/hcSOSv4HCgoDjvB9ls+rgiEc3WA6liKquYCb5omShDNALo6f0QSdXcj3UmZsnhR8Om0kdS9gm9x/Yn5XVB+xUR92KDU/7UIXohrOwVWxtLkhhq+iiD2hwtVHbgtY6e8XxwpGcV7Hr+t1MHg1JOiDkdp9eMGVgjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769896464; c=relaxed/simple;
	bh=6kzG7EZFv0DQZM9iJjIimVYGEpEaf6LDBFsclndH1rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3VOCTSxr24yH9s1YjV3SI8pqGAqdj8ND3fSUrUY0/vQZpgjF6PZu3Z5fc9mWm/6DXPB2rMt7WoGaGAO/3iDqk1JQRQKkmC22LuSj9KeKC2A+aZwDqzk5+0RKCXDCXVg5BI+V9mc+OMCFJsO0yMFMx/+1HSTAvWLy9OXNBPEp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=oLREqoAl; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="oLREqoAl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1769896460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z/rU/r1rLzV88i+g0Tr72JYeYWXFYOxOVXJGpZnh2AE=;
	b=oLREqoAlM65DCb6f5EBQxPII+eQa5f+gYZbCyr02I0RmJ6QMq3kXuvTz6hXYBg3fitg1lu
	Cu0nO76Ipy4c+NaOMTKHY+Z/iNvkDK0HeJt1H+mwuuJu5a/BjImGky67jqw9Dqy/pNGyH2
	e0IYmGdzCA5/LEA1k8e0w/6SXQgoBWc=
From: Ronan Pigott <ronan@rjp.ie>
To: iwd@lists.linux.dev
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH v2] dbus: register interface before acquiring name
Date: Sat, 31 Jan 2026 14:53:54 -0700
Message-ID: <20260131215410.173845-1-ronan@rjp.ie>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the interface isn't available by the time we acquire the well-known
name, clients can get confused when the expected interfaces are missing
during bus activation.
---
changes in v2:
 - put the NL80211 request back into the name handler
 src/main.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/src/main.c b/src/main.c
index beaf228fb3cd..27b2ced2a0b0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -197,29 +197,12 @@ static void request_name_callback(struct l_dbus *dbus, bool success,
 {
 	if (!success) {
 		l_error("Name request failed");
-		goto fail_exit;
+		l_main_quit();
 	}
 
-	if (!l_dbus_object_manager_enable(dbus, "/"))
-		l_warn("Unable to register the ObjectManager");
-
-	if (!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
-						IWD_DAEMON_INTERFACE,
-						NULL) ||
-			!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
-						L_DBUS_INTERFACE_PROPERTIES,
-						NULL))
-		l_info("Unable to add %s and/or %s at %s",
-			IWD_DAEMON_INTERFACE, L_DBUS_INTERFACE_PROPERTIES,
-			IWD_BASE_PATH);
-
 	/* TODO: Always request nl80211 for now, ignoring auto-loading */
 	l_genl_request_family(genl, NL80211_GENL_NAME, nl80211_appeared,
 				NULL, NULL);
-	return;
-
-fail_exit:
-	l_main_quit();
 }
 
 static struct l_dbus_message *iwd_dbus_get_info(struct l_dbus *dbus,
@@ -249,12 +232,25 @@ static void dbus_ready(void *user_data)
 {
 	struct l_dbus *dbus = user_data;
 
-	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
-				request_name_callback, NULL);
-
 	l_dbus_register_interface(dbus, IWD_DAEMON_INTERFACE,
 					iwd_setup_deamon_interface,
 					NULL, false);
+
+	if (!l_dbus_object_manager_enable(dbus, "/"))
+		l_warn("Unable to register the ObjectManager");
+
+	if (!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
+						IWD_DAEMON_INTERFACE,
+						NULL) ||
+			!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
+						L_DBUS_INTERFACE_PROPERTIES,
+						NULL))
+		l_info("Unable to add %s and/or %s at %s",
+			IWD_DAEMON_INTERFACE, L_DBUS_INTERFACE_PROPERTIES,
+			IWD_BASE_PATH);
+
+	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
+				request_name_callback, NULL);
 }
 
 static void dbus_disconnected(void *user_data)
-- 
2.52.0

