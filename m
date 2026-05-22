Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F93624A5
	for <iwd@lists.linux.dev>; Fri, 22 May 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475239; cv=none; b=ekTwZRpYbofxaojUuiKzpz56/xU64I4viFOj3AO9CGBCWVYuCEErxyM5JNTif8QrGXqTwPyROyavxyTxkKhRO9oY9PkCoSrrvXqlr1XQ7MGgSgeAeuEYyTf3iOmGqwk+azDvUv8x/lTO5JA5WolUru3FxgxARRTyWwrOV1pMHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475239; c=relaxed/simple;
	bh=N+ayA25I1xWxo+sHC3+m7Sog6AHnhM/YXdSt74MHDfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUHPzfO3yt5VbsheMgfEri6M2rSnmt699Pno+ZEutAtj89vud6r8vIiJidj9v7k3CYxyowy8wzWEdhzFro9Jh7W+wnB4dpEjLBletgh7isYTA95LYWZk+NrnmDB9aZNiPrvAD/5eRWT7ODzXC4Zxmiou3cx8PSCj5DmsTSFyYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7fq/LV2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7fq/LV2"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b8e98fd885so97699386d6.0
        for <iwd@lists.linux.dev>; Fri, 22 May 2026 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475237; x=1780080037; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0QBZsazxGqml3Qjpbv42nS9l38WM6vCL4Z20WEknet0=;
        b=T7fq/LV2vFhf5Z/+2wwh2b4zg+X8zy/zDSO+eADAwrC0P+ZWeBdoiyV9417xaiolY6
         VOR3ZRGj8WFuax7JLq534q44QMPvd93cNP1RywBKTx13rY9gewbCFAzbA2rj5M9rIMPC
         s4daLRRPNGbwgguFpqkBMvTRGkVsQlaLB+ubiyvl9+ieQ1y7iyGN588UKTGRXWilXMRc
         KEDQQmugJkwQjTR6Kh3zifSiP0i2GDX9Werc8ofYXrb0MKi+PePZBidoye0CcPY6CwYW
         +cjAijTrIwUl3pVRJ9Loh16OIVkCBWMawN1k7ysotDyUPSbx0A+GNVxaR+3OaZWKBbpw
         XmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475237; x=1780080037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QBZsazxGqml3Qjpbv42nS9l38WM6vCL4Z20WEknet0=;
        b=b8n/y4R8/RW/szDhN9zQ/3vlW6Il3zca5RMelLq4Sm7gaBSHmYUC8XThsojoFMW1Jy
         6yqA0wXkS57YrdobaFIiDjbqVOYFsGMObsfZsuDCPYVlIdb1Z12ehUNONrEG5yyAbsCJ
         o6wRHRvBpRN8JpNlsrnnAjRWeUX565t/zqv4afurDt6pWXyCwXCSQZOFuihHThx+Lfkk
         OgQHS8mBdiLi1hJpM+aJ6VsiTOcOmu8T7Pp7RCeTql0BXNnxWTaFiFo10/mHS+Tds2zk
         8mnlZmeH8Ts8zqwrRaGnI7CtEt+VLWnPKw5rS0IBm3xEsK1dhb+sMK3HfUzfFm7YRdT6
         UxPA==
X-Gm-Message-State: AOJu0YxNZ59HI667qAM0PXyC8aIAxcyTovWuJLmowgNPHvuH8DdCk5sy
	UlTMVXoB9raPsLDWEBrufzik9zE94FnWVV2oCapEGUSvAY1CyYjnaK72gF0A7A==
X-Gm-Gg: Acq92OFC8TcDcHcIUUbkwAvB2UPT+rnd1uVqoFQyKB8Jj8oPBcd2antqxsiLhm3FZFl
	I3X6oQOUoickwJs4Nd6XQ0KbXM2gHDIV/edcTBdcCh6fRKaFpW14FBCOR/S3c1IyMV7RD7weiKS
	cGebstPRa4VDDPFdDSGeUsamfei7GNOcv2inKcV1m1KhFS/bB7s273En3pPlFFCpZN1eHZc82rc
	k8JuatetynWSFzHhFnZXFowSE8l1HRzbqFjzgWnfNJFMAC78E8ygcdc0Pi96C/TMiYC1q+fx12v
	FEBjC+OY6/cx/jgWTY2t/xOetWr3AWby6aJZftHNar7gZUbqtJJllpwj6LG4WGAUZMze9+djccr
	bpw2f0Wksgy06ViN+cCedmK+X9nnEokuEbF9uTriusur8O9FNiiOcPG45kD41w2xnCp2sP0Yo5X
	oKx7VyQ2EmRtrVE67UR3xOjbhpx+quuLO0DC7pWex63NABGuIGKKDpOyWvHowq2kARSXBFL3KPV
	vE=
X-Received: by 2002:ad4:5b82:0:b0:8cc:3546:2616 with SMTP id 6a1803df08f44-8cc7b558562mr84358436d6.21.1779475236738;
        Fri, 22 May 2026 11:40:36 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffca70sm26041616d6.22.2026.05.22.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:40:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] main: make developer mode more configurable
Date: Fri, 22 May 2026 11:40:25 -0700
Message-Id: <20260522184025.96758-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The developer mode (-E) option is used only for the autotest
framework to start up IWD in a state where:
 - Autoconnect is disabled
 - The station debug interface is available

For testing and development on real systems the debug interface
is convenient to have available, the trouble is starting IWD in
this mode loses the autoconnect functionality (unless you manually
enable after starting).

This patch aims to allow developer mode + autoconnect but making
allowing the -E flag to take several options:

-E (no args) - same behavior, debug interface + no autoconnect
-Etest	     - same as -E with no args
-Edebug      - debug interface with autoconnect enabled
---
 src/iwd.h     |  7 ++++++-
 src/main.c    | 48 ++++++++++++++++++++++++++++++++++++++++++------
 src/station.c | 16 +++++++++-------
 3 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/src/iwd.h b/src/iwd.h
index a8e2c5db..ee7c8544 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -30,6 +30,11 @@
 struct l_genl;
 struct l_genl_family;
 
+enum iwd_mode {
+	IWD_MODE_NO_AUTOCONNECT = 1 << 0,
+	IWD_MODE_DEBUG_INTERFACE = 1 << 1,
+};
+
 const struct l_settings *iwd_get_config(void);
 struct l_genl *iwd_get_genl(void);
 struct l_netlink *iwd_get_rtnl(void);
@@ -41,7 +46,7 @@ const char *iwd_get_iface_blacklist(void);
 
 const char *iwd_get_phy_whitelist(void);
 const char *iwd_get_phy_blacklist(void);
-bool iwd_is_developer_mode(void);
+uint32_t iwd_get_developer_modes(void);
 
 #define IWD_NOTICE_STATE		"state"
 #define IWD_NOTICE_CONNECT_INFO		"connect-info"
diff --git a/src/main.c b/src/main.c
index 27b2ced2..babfd1ea 100644
--- a/src/main.c
+++ b/src/main.c
@@ -35,6 +35,7 @@
 #include <sys/mman.h>
 #include <linux/rtnetlink.h>
 #include <ell/ell.h>
+#include <linux/limits.h>
 
 #include <ell/useful.h>
 
@@ -64,7 +65,7 @@ static const char *phys;
 static const char *nophys;
 static const char *debugopt;
 static const char *logger;
-static bool developeropt;
+static uint32_t iwd_developer_mode;
 static bool terminating;
 static bool nl80211_complete;
 
@@ -137,9 +138,23 @@ const char *iwd_get_phy_blacklist(void)
 	return nophys;
 }
 
-bool iwd_is_developer_mode(void)
+uint32_t iwd_get_developer_modes(void)
 {
-	return developeropt;
+	return iwd_developer_mode;
+}
+
+static const char *iwd_mode_to_string(uint32_t mode)
+{
+	static char str[PATH_MAX];
+	int idx = 0;
+
+	if (mode & IWD_MODE_NO_AUTOCONNECT)
+		idx = sprintf(str, "no-autoconnect ");
+
+	if (mode & IWD_MODE_DEBUG_INTERFACE)
+		idx += sprintf(str + idx, "debug-interface ");
+
+	return str;
 }
 
 static void usage(void)
@@ -160,7 +175,7 @@ static void usage(void)
 }
 
 static const struct option main_options[] = {
-	{ "developer",    no_argument,       NULL, 'E' },
+	{ "developer",    optional_argument, NULL, 'E' },
 	{ "version",      no_argument,       NULL, 'v' },
 	{ "interfaces",   required_argument, NULL, 'i' },
 	{ "nointerfaces", required_argument, NULL, 'I' },
@@ -473,14 +488,31 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "Ei:I:p:P:d::vhl:",
+		opt = getopt_long(argc, argv, "E::i:I:p:P:d::vhl:",
 							main_options, NULL);
 		if (opt < 0)
 			break;
 
 		switch (opt) {
 		case 'E':
-			developeropt = true;
+			if (optarg)
+				if (!strcmp(optarg, "test"))
+					iwd_developer_mode =
+						IWD_MODE_DEBUG_INTERFACE |
+						IWD_MODE_NO_AUTOCONNECT;
+				else if (!strcmp(optarg, "debug"))
+					iwd_developer_mode =
+						IWD_MODE_DEBUG_INTERFACE;
+				else {
+					fprintf(stderr,
+						"Invalid developer mode '%s'\n",
+						optarg);
+					return EXIT_FAILURE;
+				}
+			else
+				iwd_developer_mode = IWD_MODE_DEBUG_INTERFACE |
+							IWD_MODE_NO_AUTOCONNECT;
+
 			break;
 		case 'i':
 			interfaces = optarg;
@@ -539,6 +571,10 @@ int main(int argc, char *argv[])
 	if (debugopt)
 		l_debug_enable(debugopt);
 
+	if (iwd_developer_mode)
+		l_debug("Developer mode enabled: %s",
+				iwd_mode_to_string(iwd_developer_mode));
+
 #ifdef HAVE_BACKTRACE
 	__iwd_backtrace_init();
 #endif
diff --git a/src/station.c b/src/station.c
index 8fcf8c70..fc1ce040 100644
--- a/src/station.c
+++ b/src/station.c
@@ -279,7 +279,7 @@ static bool station_debug_event(struct station *station, const char *name)
 {
 	struct l_dbus_message *signal;
 
-	if (!iwd_is_developer_mode())
+	if (!(iwd_get_developer_modes() & IWD_MODE_DEBUG_INTERFACE))
 		return true;
 
 	l_debug("StationDebug.Event(%s)", name);
@@ -1921,7 +1921,7 @@ bool station_set_autoconnect(struct station *station, bool autoconnect)
 	if (station_is_autoconnecting(station) && !autoconnect)
 		station_enter_state(station, STATION_STATE_DISCONNECTED);
 
-	if (iwd_is_developer_mode())
+	if (iwd_get_developer_modes() & IWD_MODE_DEBUG_INTERFACE)
 		l_dbus_property_changed(dbus_get_bus(),
 				netdev_get_path(station->netdev),
 				IWD_STATION_DEBUG_INTERFACE, "AutoConnect");
@@ -5144,6 +5144,7 @@ static struct station *station_create(struct netdev *netdev)
 	struct station *station;
 	struct l_dbus *dbus = dbus_get_bus();
 	bool autoconnect = true;
+	uint32_t iwd_mode = iwd_get_developer_modes();
 
 	station = l_new(struct station, 1);
 	watchlist_init(&station->state_watches, NULL);
@@ -5175,13 +5176,14 @@ static struct station *station_create(struct netdev *netdev)
 
 	station_fill_scan_freq_subsets(station);
 
-	if (iwd_is_developer_mode()) {
+	if (iwd_mode & IWD_MODE_DEBUG_INTERFACE)
 		l_dbus_object_add_interface(dbus,
 					netdev_get_path(station->netdev),
 					IWD_STATION_DEBUG_INTERFACE,
 					station);
+
+	if (iwd_mode & IWD_MODE_NO_AUTOCONNECT)
 		autoconnect = false;
-	}
 
 	station_set_autoconnect(station, autoconnect);
 
@@ -5201,7 +5203,7 @@ static void station_free(struct station *station)
 	l_dbus_object_remove_interface(dbus_get_bus(),
 					netdev_get_path(station->netdev),
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
-	if (iwd_is_developer_mode())
+	if (iwd_get_developer_modes() & IWD_MODE_DEBUG_INTERFACE)
 		l_dbus_object_remove_interface(dbus_get_bus(),
 					netdev_get_path(station->netdev),
 					IWD_STATION_DEBUG_INTERFACE);
@@ -5995,7 +5997,7 @@ static int station_init(void)
 					station_setup_diagnostic_interface,
 					station_destroy_diagnostic_interface,
 					false);
-	if (iwd_is_developer_mode())
+	if (iwd_get_developer_modes() & IWD_MODE_DEBUG_INTERFACE)
 		l_dbus_register_interface(dbus_get_bus(),
 					IWD_STATION_DEBUG_INTERFACE,
 					station_setup_debug_interface,
@@ -6062,7 +6064,7 @@ static void station_exit(void)
 {
 	l_dbus_unregister_interface(dbus_get_bus(),
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
-	if (iwd_is_developer_mode())
+	if (iwd_get_developer_modes() & IWD_MODE_DEBUG_INTERFACE)
 		l_dbus_unregister_interface(dbus_get_bus(),
 					IWD_STATION_DEBUG_INTERFACE);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_STATION_INTERFACE);
-- 
2.34.1

