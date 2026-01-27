Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2178F2E
	for <iwd@lists.linux.dev>; Tue, 27 Jan 2026 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553983; cv=none; b=ecVCY27BsWCbr2qgzNo52PUAEZ63WHYkisRYx/0db6zGozWwQnj9t2k4vt8q8gI/gp6X2iEgSIrCIJZYiY8bdNbwTL4of+Z/cNfNeazGz0ycZArApoXU9gievbFPGDtyLYamcHd7EmhVqxYsFsrQEBCBMYRQPVp8XL3Bbd8s3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553983; c=relaxed/simple;
	bh=KAO8DOVEPyaFbj0hNLiM2cLOTChrN3itjQs6xF0Czhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/zHFm+DCHPSjqKjgHZTHWvYl8e9o2sR7qLtu5JtuvPMSjNN7xEgKAI7j6tv6tbmjy3FAUPuclIZ5NgnvOzb9HEoikRCVJikOuWJl+DoQDkLhHQCDi6tcpLSXSCE/oVaRq1sbEwAZsFXaKyifnjJ42SIxH2tGdUZg//nS04l3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=QJHrvGjc; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="QJHrvGjc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1769553979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24mbL4NGxaFbUnKLZwzklEESqk+YxpHyUX0lArnYUiU=;
	b=QJHrvGjcL36IV4w34jX+b5yzne3LY8rCGb+NRhscFquCH9nMm31gI/dfylfzB1zaaMXc8u
	S0/jlZMMnP32gyrsuy0YK3oakBqaQ+2+u3ZRmS89cxZkHhP8pJOMhFAso3fhxHSUgdbTNq
	/fHVw9FhLboXMxtB34DLOvxZ04lKM58=
From: Ronan Pigott <ronan@rjp.ie>
To: iwd@lists.linux.dev
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH] dbus: register interface before acquiring name
Date: Tue, 27 Jan 2026 15:40:27 -0700
Message-ID: <20260127224325.86027-3-ronan@rjp.ie>
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
This code seems backwards to me. Presently, if IWD is not running,
calling any IWD methods will fail:

  $ busctl call net.connman.iwd /net/connman/iwd net.connman.iwd.Daemon GetInfo
  Call failed: No matching method found

only to succeed immediately after once the bus activation is complete:

  $ busctl call net.connman.iwd /net/connman/iwd net.connman.iwd.Daemon GetInfo
  a{sv} 3 "NetworkConfigurationEnabled" b false "StateDirectory" s "/var/lib/iwd" "Version" s "3.10"

With this patch, we register IWD methods before acquiring the well-known
name, and the abovve call succeeds on the first try.

 src/main.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/src/main.c b/src/main.c
index beaf228fb3cd..0f27488211d0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -197,29 +197,8 @@ static void request_name_callback(struct l_dbus *dbus, bool success,
 {
 	if (!success) {
 		l_error("Name request failed");
-		goto fail_exit;
+		l_main_quit();
 	}
-
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
-	/* TODO: Always request nl80211 for now, ignoring auto-loading */
-	l_genl_request_family(genl, NL80211_GENL_NAME, nl80211_appeared,
-				NULL, NULL);
-	return;
-
-fail_exit:
-	l_main_quit();
 }
 
 static struct l_dbus_message *iwd_dbus_get_info(struct l_dbus *dbus,
@@ -249,12 +228,29 @@ static void dbus_ready(void *user_data)
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
+	/* TODO: Always request nl80211 for now, ignoring auto-loading */
+	l_genl_request_family(genl, NL80211_GENL_NAME, nl80211_appeared,
+				NULL, NULL);
+
+	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
+				request_name_callback, NULL);
 }
 
 static void dbus_disconnected(void *user_data)
-- 
2.52.0

