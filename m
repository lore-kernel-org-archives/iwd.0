Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6AC110A
	for <iwd@lists.linux.dev>; Fri,  1 Jul 2022 16:33:18 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id w24so3074300pjg.5
        for <iwd@lists.linux.dev>; Fri, 01 Jul 2022 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SoSr9CWiYGOSao+n+EadY97VQAGXVX3eimNhlCVXg84=;
        b=JMdgkT1nTxnDFYawgnutG7VIyyFJrNqV2YQMFAEYdouRNiVl7a881UtnXhFU63ZTLt
         BFtvrSQconyxHPwERyP3wcKKDe18vXn1hfFS7M7FsNnyXogMYUP+y/AmhRPAL1OUa996
         /RKJMD7xWMROZen010HHyBUF6k6MJRV9zB6MsejvRzo3akHMTDs44b6CQ8sbpo2I5j+J
         7N7o6snVmOTu6bHNGjmphNBmOrpbkE9ukwU81NVBt+Gqtr3ui2erUVqKV8CuqiIJrCPX
         s4sY7iPHAamb0t+rxA4M5i9Xcb5AQPQ7VKkC5HQD3OLTHzqN896yikRoHw6wi1bD9zqR
         r+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SoSr9CWiYGOSao+n+EadY97VQAGXVX3eimNhlCVXg84=;
        b=5Mck9HwkrwQAoEcx8tENxK3p0VspUnv2GCkvuOo5Ou+MENXbpjlYvBL0q3gJrbuVJd
         9ZBaSzvi8N41YgL8/YpIrwdNKxcdx7VPu8O7dc9cA6MFfpOM/d2h6C4Y2es7mN7xJNZ8
         T+JMEZUE4FW5WRXESvzgmRAKFCbB5EXLtSQcy6t/gAGzpWGmdPGLfExPgD2+RQ9WHPRb
         F2kemNlnfngWeSf4BtmTpt06IenwBPdaSVudlXlmjXIPqqMHDtF3nzTJ9Xl/I+cglpDy
         FM5cZ5eUynjtx2hfXKiDZ5YSha0qWcyo0txWvzLsqWS+RMZyiHGvQEBzCPs2vP3kyWCh
         5bVg==
X-Gm-Message-State: AJIora+JcZAxwOvrfuUsVqxDnIVigpQzOYtB05bIpzlh8VAeRybOxJgj
	Ps+Vdu0NJl8OFsxPdsLmz09WLmeR4F4=
X-Google-Smtp-Source: AGRyM1sXyh5QC0VzTTtp29wlOqzixNVLAKLy8qc2jLjh5B4K4Sr6LlX8e/OJLi9+3ykVgzwDNNHYzg==
X-Received: by 2002:a17:903:44b:b0:16a:1aba:9f80 with SMTP id iw11-20020a170903044b00b0016a1aba9f80mr21965758plb.56.1656693197744;
        Fri, 01 Jul 2022 09:33:17 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id k11-20020a6555cb000000b0040d87299ca3sm15447885pgs.54.2022.07.01.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:33:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: remove diagnostic interface when netdev goes down
Date: Fri,  1 Jul 2022 09:31:08 -0700
Message-Id: <20220701163108.450486-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a crash associated with toggling the iftype to AP mode
then calling GetDiagnostics. The diagnostic interface is never
cleaned up when netdev goes down so DBus calls can still be made
which ends up crashing since the AP interface objects are no longer
valid.

Running the following iwctl commands in a script (once or twice)
triggers this crash reliably:

iwctl device wlp2s0 set-property Mode ap
iwctl device wlp2s0 set-property Mode station
iwctl device wlp2s0 set-property Mode ap
iwctl ap wlp2s0 start myssid secret123
iwctl ap wlp2s0 show

++++++++ backtrace ++++++++
0  0x7f8f1a8fe320 in /lib64/libc.so.6
1  0x451f35 in ap_dbus_get_diagnostics() at src/ap.c:4043
2  0x4cdf5a in _dbus_object_tree_dispatch() at ell/dbus-service.c:1815
3  0x4bffc7 in message_read_handler() at ell/dbus.c:285
4  0x4b5d7b in io_callback() at ell/io.c:120
5  0x4b489b in l_main_iterate() at ell/main.c:476
6  0x4b49a6 in l_main_run() at ell/main.c:519
7  0x4b4cd9 in l_main_run_with_signal() at ell/main.c:645
8  0x404f5b in main() at src/main.c:600
9  0x7f8f1a8e8b75 in /lib64/libc.so.6
+++++++++++++++++++++++++++
---
 src/ap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 7b705c9c..8681189b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -4084,6 +4084,8 @@ static void ap_remove_interface(struct netdev *netdev)
 {
 	l_dbus_object_remove_interface(dbus_get_bus(),
 			netdev_get_path(netdev), IWD_AP_INTERFACE);
+	l_dbus_object_remove_interface(dbus_get_bus(),
+			netdev_get_path(netdev), IWD_AP_DIAGNOSTIC_INTERFACE);
 }
 
 static void ap_netdev_watch(struct netdev *netdev,
-- 
2.34.1

