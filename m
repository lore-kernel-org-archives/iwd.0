Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D163AF
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:31:01 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id g62so2242862pfb.10
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuaLdpWzsIa65B9D+BQqDuU1vAJrEspEFUSJXgonnZ0=;
        b=LtMz24XGJEZ48pes+bXthzt3jspgkHsjmpX7tKunYxrWSWERUkbSE6WK0MSvHQjYYC
         zyyBHww0wkGbDs6niMM2hvT5koDY4nVGI91930qlTW7zarW6Wp3NFnVux/2NZFJl84CI
         CXppO/pYUFfhgdjnDNXEY1ZnvaOXLIKI/EFS2Mdy8DfHkIOjsCfABgzA6gY8CksihyiM
         l1mDA7sNtieDHnVE/Op+n4h8vQG0vsAl4XFieN59K/wqno5PQHn1bWxVNQJtwhsSw7rE
         GVvrSHOly0YH8o6LFxgrnb5SY4sJb1YMrBfmyd/So+hCqFuy323sOqR770lWEZ0f12mg
         YQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuaLdpWzsIa65B9D+BQqDuU1vAJrEspEFUSJXgonnZ0=;
        b=laukhs8Pg01iHBxTXqlJqJs+ltLZ2CcM15mQWh6Ns7qGInY+OfrL4/abwdBbhjwC70
         P+okrob7xJZA+sqj8jebCHOAa9C4bVjUDOcAhmdZ8bhEeSwRssN5EWOYYXf7MkE3dIyJ
         /P/KwGvTq0j19iv0wTQNghLvCslFdK0gBiciqSQPsKgEzuUYoX+dbylKOrLSW8AAhkHa
         7yMKftH8wyzcJ3SSvj5gdpVZVIQLdfByLLXfEUacn4DJvoAAzXWp0/MA5IO10COkUwxP
         uDTF4Nbl/1uN+n2+MKl3w5BEtX2T8Mtk84w5UGYPWv9M2ffONxIbn7ClUcwJDrBtPeZn
         s1lw==
X-Gm-Message-State: ACrzQf2IcXmqF40O28XPeHv+BeknrmpKLzPFYCtGLiUzULXXQOivpCDB
	92gUy6HDUB88+gwuRp07Akv+3wiaU/E=
X-Google-Smtp-Source: AMsMyM4yoTisdGUKDvd5msAHwvK9UsMfLt4y5Ep5bJXUYsqsi9fNQ4wE2ljUHJwvwcElfNZVjacGhg==
X-Received: by 2002:a05:6a00:1995:b0:56e:1fff:da75 with SMTP id d21-20020a056a00199500b0056e1fffda75mr8190795pfl.81.1667496660967;
        Thu, 03 Nov 2022 10:31:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79d12000000b0056afd55722asm979721pfp.153.2022.11.03.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:31:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: iwd.py: allow certain APIs to be used in AP mode
Date: Thu,  3 Nov 2022 10:30:56 -0700
Message-Id: <20221103173057.381232-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221103173057.381232-1-prestwoj@gmail.com>
References: <20221103173057.381232-1-prestwoj@gmail.com>
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

