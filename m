Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B928471
	for <iwd@lists.linux.dev>; Fri,  4 Nov 2022 16:38:07 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id b29so4947012pfp.13
        for <iwd@lists.linux.dev>; Fri, 04 Nov 2022 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuaLdpWzsIa65B9D+BQqDuU1vAJrEspEFUSJXgonnZ0=;
        b=UscH8k4Cqccn3y9Bvehog0SRlvJmIScb/yh8UcvwpuR1ncRa6V8/giixcHHISAoOyY
         ak1pEqShxBxYIy3aB0Xfv5wpGesOi7LmkA2MO4nho/orVuelVucOa52mOmK9pLCCYx6r
         6pMPlGK1PJWjuaFV407A1gT7dQ0ToyzN7ksvhpp3L4/QGJGyNxH2pfs9Jms0sc69FI4U
         peB9iJKshgo3RP0tmV9kJc1c4klBBb7IyBKl7nUMzEndgQ2bpGl5s6TUM+KRjPsJmkJN
         vw/3se7cfjK3gC//HhSPYSG1jBPVQ6VIj/TuCpAxGFSdrjI8UYM9GwCut5UUJ2CgSwq0
         Tjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuaLdpWzsIa65B9D+BQqDuU1vAJrEspEFUSJXgonnZ0=;
        b=4ErM1D4/SkaobWQc0DtjeN8dkeLqX1aFyeA20Dx8KI2gPAaXDtAuIhkGtYxBCRn0d5
         RY9yhJR5cW2JtW2o+1EDNi9piCGWfWrvAnWyeRXScWVTdpBJG0IELMogYMlMGU2j0e3q
         avehaMQywkinJ6yzIX7cXB4G5Enx+hpmuJVcjFjS2UHrVqivX+HcqW7hEtqP4W4v23VE
         nCbLqzHApAiRQwHcfZce9b9Gm5PgL+YzcSK3JMzTRGVvIwqSoZLJg1mT7lltL0Kh+54w
         k38kPPlar9pdubkmFwLEJFYZBLwitKR55LQCSWzS5Af1Hqls25c2pxXCqOUDcMaTvjAz
         LfoA==
X-Gm-Message-State: ACrzQf0lwumuuazlM57k2jpZY3ywteKU0dskBeCOyr3hzFhc7qvdPmCr
	igg+mThGPBboQvCBKRFjbAbyh/jPEo0=
X-Google-Smtp-Source: AMsMyM4Qy/AFIZKdYf7Ntn10ZYwOeYU7Y+Ih4qELw9DmO30ogAi0OAh3bIbB7H3oTD10qAHL8PaXnQ==
X-Received: by 2002:a63:6b49:0:b0:46a:fcba:308f with SMTP id g70-20020a636b49000000b0046afcba308fmr31475808pgc.8.1667579887064;
        Fri, 04 Nov 2022 09:38:07 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b0056e15b7138esm2904741pff.157.2022.11.04.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:38:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/6] auto-t: iwd.py: allow certain APIs to be used in AP mode
Date: Fri,  4 Nov 2022 09:37:56 -0700
Message-Id: <20221104163800.451867-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221104163800.451867-1-prestwoj@gmail.com>
References: <20221104163800.451867-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AP mode implements a few DBus methods/properties which are named
the same as station: Scan, Scanning, and GetOrderedNetworks. Allow
the Device object to work with these in AP mode by calling the
correct method if the Mode is 'ap'.
---
 autotests/util/iwd.py | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 98b9ea1c..5fa12444 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -521,13 +521,16 @@ class Device(IWDDBusAbstract):
     def scanning(self):
         '''
         Reflects whether the device is currently scanning
-        for networks.  net.connman.iwd.Network objects are
-        updated when this property goes from true to false.
+        for networks.  For station devices net.connman.iwd.Network
+        objects are updated when this property goes from true to false
 
         @rtype: boolean
         '''
-        props = self._station_properties()
-        return bool(props['Scanning'])
+        if self._properties['Mode'] == 'station':
+            props = self._station_properties()
+            return bool(props['Scanning'])
+        else:
+            return bool(self._ap.scanning)
 
     @property
     def autoconnect(self):
@@ -544,12 +547,14 @@ class Device(IWDDBusAbstract):
            Possible exception: BusyEx
                                FailedEx
         '''
-        self._iface.Scan(dbus_interface=IWD_STATION_INTERFACE,
+        if self._properties['Mode'] == 'station':
+            self._iface.Scan(dbus_interface=IWD_STATION_INTERFACE,
                                reply_handler=self._success,
                                error_handler=self._failure)
-
-        if wait:
-            self._wait_for_async_op()
+            if wait:
+                self._wait_for_async_op()
+        else:
+            self._ap.scan()
 
     def disconnect(self):
         '''Disconnect from the network
@@ -576,6 +581,9 @@ class Device(IWDDBusAbstract):
            groups the maximum relative signal-strength is the
            main sorting factor.
         '''
+        if self._properties['Mode'] == 'ap':
+            return self._ap.get_ordered_networks()
+
         ordered_networks = []
         if not full_scan:
             for bus_obj in self._station.GetOrderedNetworks():
-- 
2.34.3

