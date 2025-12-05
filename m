Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141682FE07E
	for <iwd@lists.linux.dev>; Fri,  5 Dec 2025 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918238; cv=none; b=d2O2IUI+TtBiI69aXVLhxeWydTkYn3YA40rfVxAUIKJVynhCZrgqv+nJZ6cctQALakR7E2f4Fot3NJcBLImULlevuT0Wwg/U1hFcpLuKaUq6t4HZim/n79vx3RKQg3f3+p5bg4iNEYU0mlT0y7t9bcUiS2rMRx+CJ9qf9Gpsxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918238; c=relaxed/simple;
	bh=CoLjqLykamGXNtzGoqt1zKyMnl14r3DXaJc5vANUpaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=irugc6puFTqK21kXnnJKPH5j3Dj4uaUwD3Vbhi7XpMC4zCFdB+2MWNy33L4NdekOma2rOoPRxIn1t9xaPAkBki79jkbfJiMMkuLQqRmrlAeXepFBvOwuJsU99tR2Hx4ZtB/laRRHKvvx9VIxT/yy7LXPzyqA1AxrhMdrTagOOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=H6nUTsME; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="H6nUTsME"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso1478978b3a.1
        for <iwd@lists.linux.dev>; Thu, 04 Dec 2025 23:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1764918236; x=1765523036; darn=lists.linux.dev;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/krLG+NmsNGPlf1mT1ZCHi1i6IBtNRa3Sc2bUTNJCY=;
        b=H6nUTsMEycjqgWfrZHyYnNaLuSIZ83JfoJJHC2Ow9Jd/YAU3NLrF9QKZw22aI+Pczw
         623dTv55AJ/QIvWNqQ4Q+eFT2l37X9Cs8yYqRBSaQ1phmFs+UClBLRLQb7KyPP0bgd6c
         VTfFfd0aYf9qeRavjQ1mYcKZsszCNDxWmombw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764918236; x=1765523036;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/krLG+NmsNGPlf1mT1ZCHi1i6IBtNRa3Sc2bUTNJCY=;
        b=AAAggR3QNdoThEkwDXFHTCoTgcFKJyQwaP1BOMw76DrYBmJelvyYxAjJOLvbWM8zEi
         FXWRa+DwpcsRSR7/O6v+brbqfV+HEC9Ie5CIJH6hFC7Fi+pMPqzz8KIqLuMoTxTVx5U7
         VX+mVqELgJXuQrUoWACJLVghwoSJTbhG0yu5cSR2j3H/Fdg1A5EYqDT1Yz5k+Goe/rs3
         NTo5BgLlsRs8GPnTKxKi++if8wD6jGBfJXW6CtnQDyNWGpd5uDaDv0I5tpnprToiWvdx
         VFaOgLC5El9FV4yWvfSINtsaicSMiyASF5dz/QAU9T0EJpDXLAR1zsXhsNhdANJ1X6s6
         bS2g==
X-Gm-Message-State: AOJu0YyOhlcXO1lfPoayVKOPk56yld3MhJrHRFTriOSrRNDo5mf6dP1Z
	aa+6EoHYlNCX+dTB4xsFmmWFS+8SYA/yyXT84+xDyNYS4IDUf+YIXGGlKM57DS4Aj/W24YqGY+V
	7YGN22kcQyA==
X-Gm-Gg: ASbGncujK4G3Q4IbBqO7tSffcjAybNSGR285eEZPPGc0oR7PQyvAB5+E5TqCgHCQeSV
	aRfyyCBt1O9gJjokfLiKtK6cl/q1npV9wzuhOhjb99pcL2g6XdLNHDZMtY3OI9CPfQPiPQE1AfK
	RNniqIDAvPB+zQE3DNC2cQkjf7Dc7hlbG4vYhQl+a2megHbzbMByGDBunsXYonLz9lnRuIyO6kh
	mkCPPe9LLCDD0Ey4uDjSHrQ9Xy9eeAgNsXx0Y0sv2ne+1jm6vBpDlPLErX/oevtGFrJjxijX2Jd
	y7iz2IJ6aXYMRjED3aHzupDs1ejWCYXgC9e6ypgZfqmckiGL13Stau7JNrokD4b7rxN7aARyOQb
	b72dTlYNpatyaUuqsexwVnNtMEEH0oT6Amw3S7OL9kg94vQGb8bDYI9DPSk9rz6aPzGUp8qFkYZ
	oHWCyXcs/D095UGcFV5w==
X-Google-Smtp-Source: AGHT+IF0B6R0LaV4WxoXCdfpCBFZhULSqDJ/C8buUiHBTCLUne44ZNUWaUYT0vK/f3Vza3LEYOox4g==
X-Received: by 2002:a05:7022:e02:b0:11a:5065:8763 with SMTP id a92af1059eb24-11df643c2b9mr3493260c88.5.1764918235962;
        Thu, 04 Dec 2025 23:03:55 -0800 (PST)
Received: from localhost ([205.220.129.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76edd4fsm13822653c88.8.2025.12.04.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 23:03:55 -0800 (PST)
Date: Fri, 5 Dec 2025 15:03:45 +0800
From: Chris Down <chris@chrisdown.name>
To: iwd@lists.linux.dev
Cc: kernel-team@fb.com
Subject: [PATCH] device: Improve errors when station not present
Message-ID: <aTKD0dCKHpwYUICo@chrisdown.name>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.16 (7b98015d) (2025-11-22)

When a user attempts to use station commands (scan, get-networks,
connect, disconnect, show) on a device that does not have a station
interface available, iwctl currently displays the generic error message
"No station on device: 'wlan0'". This message is quite broad and does
not really help users understand why the station interface is
unavailable.

The station interface can be unavailable for several distinct reasons:

1. The device does not exist (invalid device name)
2. The device is not in station mode (device is in AP mode or ad-hoc
   mode instead)
3. The device is rfkilled (either hardware rfkill via physical button or
   software rfkill via rfkill utility)
4. The device is not powered for other reasons (manual ifdown, driver
   issues, etc.)

The current implementation simply checks if the station interface exists
and displays the same generic message for all of these cases, which is
particularly confusing when the device is rfkilled, as users may not
immediately understand that "No station on device" means the device is
rfkilled.

This commit improves the error messages by checking the device state and
providing specific error messages for each scenario.
---
 client/adapter.c | 12 ++++++++++++
 client/adapter.h | 25 +++++++++++++++++++++++++
 client/device.c  | 31 +++++++++++++++++++++++++++++++
 client/device.h  |  2 ++
 client/station.c | 18 +++++++++++++-----
 5 files changed, 83 insertions(+), 5 deletions(-)
 create mode 100644 client/adapter.h

diff --git a/client/adapter.c b/client/adapter.c
index 1719b97..7091a22 100644
--- a/client/adapter.c
+++ b/client/adapter.c
@@ -28,6 +28,7 @@
 
 #include "client/command.h"
 #include "client/dbus-proxy.h"
+#include "client/adapter.h"
 #include "client/display.h"
 #include "client/properties.h"
 
@@ -410,5 +411,16 @@ static void adapter_interface_exit(void)
 	proxy_interface_type_unregister(&adapter_interface_type);
 }
 
+bool adapter_is_powered(const struct proxy_interface *adapter_i)
+{
+	const struct adapter *adapter;
+
+	if (!adapter_i)
+		return false;
+
+	adapter = proxy_interface_get_data(adapter_i);
+	return adapter->powered;
+}
+
 INTERFACE_TYPE(adapter_interface_type, adapter_interface_init,
 						adapter_interface_exit)
diff --git a/client/adapter.h b/client/adapter.h
new file mode 100644
index 0000000..c3886d2
--- /dev/null
+++ b/client/adapter.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct proxy_interface;
+
+bool adapter_is_powered(const struct proxy_interface *adapter_i);
diff --git a/client/device.c b/client/device.c
index ce2afc8..94e9262 100644
--- a/client/device.c
+++ b/client/device.c
@@ -29,6 +29,7 @@
 #include "client/command.h"
 #include "client/dbus-proxy.h"
 #include "client/device.h"
+#include "client/adapter.h"
 #include "client/display.h"
 #include "client/network.h"
 #include "client/properties.h"
@@ -433,6 +434,36 @@ static void device_command_family_exit(void)
 COMMAND_FAMILY(device_command_family, device_command_family_init,
 						device_command_family_exit)
 
+void device_check_station_error(const struct proxy_interface *device_i,
+					const char *device_name)
+{
+	const struct device *device;
+
+	if (!device_i) {
+		/* device_proxy_find_by_name already displays "Device %s not found" */
+		return;
+	}
+
+	device = proxy_interface_get_data(device_i);
+
+	if (!device->mode || strcmp(device->mode, "station") != 0) {
+		display("Device '%s' is not in station mode.\n", device_name);
+		return;
+	}
+
+	if (!device->powered) {
+		if (device->adapter && !adapter_is_powered(device->adapter)) {
+			display("Device '%s' is rfkilled.\n", device_name);
+		} else {
+			display("Device '%s' is not powered.\n", device_name);
+		}
+		return;
+	}
+
+	/* Fallback for other cases */
+	display("No station on device: '%s'\n", device_name);
+}
+
 static int device_interface_init(void)
 {
 	proxy_interface_type_register(&device_interface_type);
diff --git a/client/device.h b/client/device.h
index f8481ef..9965948 100644
--- a/client/device.h
+++ b/client/device.h
@@ -30,3 +30,5 @@ const struct proxy_interface *device_proxy_find_by_name(const char *name);
 const struct proxy_interface *device_proxy_find(const char *device_name,
 							const char *interface);
 const struct proxy_interface *device_get_default(void);
+void device_check_station_error(const struct proxy_interface *device_i,
+					const char *device_name);
diff --git a/client/station.c b/client/station.c
index 5066a9f..3d1c09b 100644
--- a/client/station.c
+++ b/client/station.c
@@ -242,6 +242,14 @@ static void display_station_inline(const char *margin, const void *data)
 				8, station->scanning ? "scanning" : "");
 }
 
+static void display_station_error(const char *device_name)
+{
+	const struct proxy_interface *device_i =
+					device_proxy_find_by_name(device_name);
+
+	device_check_station_error(device_i, device_name);
+}
+
 static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 {
 	const struct l_queue_entry *entry;
@@ -351,7 +359,7 @@ static enum cmd_status cmd_connect_hidden_network(const char *device_name,
 
 	station_i = device_proxy_find(device_name, IWD_STATION_INTERFACE);
 	if (!station_i) {
-		display("No station on device: '%s'\n", device_name);
+		display_station_error(device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 
@@ -369,7 +377,7 @@ static enum cmd_status cmd_disconnect(const char *device_name,
 			device_proxy_find(device_name, IWD_STATION_INTERFACE);
 
 	if (!station_i) {
-		display("No station on device: '%s'\n", device_name);
+		display_station_error(device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 
@@ -527,7 +535,7 @@ static enum cmd_status cmd_get_networks(const char *device_name,
 			device_proxy_find(device_name, IWD_STATION_INTERFACE);
 
 	if (!station_i) {
-		display("No station on device: '%s'\n", device_name);
+		display_station_error(device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 
@@ -661,7 +669,7 @@ static enum cmd_status cmd_scan(const char *device_name,
 			device_proxy_find(device_name, IWD_STATION_INTERFACE);
 
 	if (!station_i) {
-		display("No station on device: '%s'\n", device_name);
+		display_station_error(device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 
@@ -701,7 +709,7 @@ static enum cmd_status cmd_show(const char *device_name,
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
 
 	if (!station) {
-		display("No station on device: '%s'\n", device_name);
+		display_station_error(device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 
-- 
2.52.0

