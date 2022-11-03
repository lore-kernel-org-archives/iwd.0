Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F624F28
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:00:55 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id b62so2228335pgc.0
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuaLdpWzsIa65B9D+BQqDuU1vAJrEspEFUSJXgonnZ0=;
        b=SZf4tnuHvsk63OIDCbt8zps0IZN0MgqjrC2GXMAhcZKOVJe+9oA5s9y+o4d39x/Abj
         vvr/8QuAefOarafHGu1ewQuzoXLp69+mIuGdq+R7iHF3/3AZXhStzZQnpw/5Q5aLt4AS
         kxuWKArrP0O82kF4JjO0uPBMbWULBnOt60X+qcAT0kCn0VXJEeShF5qykbzTKi6+C7Xn
         L2l1qXo2FzajS0SMZut0SUfE0VlPNMMDxw+Dqb0yeXXmdpOD7pn3qfq9TnuFw8H/jUF4
         PTBNozy+1p54hblAxwsFPOzNd7JyKRRhThjD+kRgCW1jxerjYk2/4M4E9PigZaAFB11G
         Gw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuaLdpWzsIa65B9D+BQqDuU1vAJrEspEFUSJXgonnZ0=;
        b=LFCy6Um9dejjKyutZ2EUEw5Fh5vWpkNDEYs1A6Ghc3er6wP4A/3l94tdkf4VeJUc4j
         +FFFeeFGyhDk6u0qWxRknEhuI3ULh4JeVZSSy369jBqwZ/SNp6EtzKmWN5LY58H+HhP9
         d/QgxzpE8S1WSrUKH4q+kd9o8w6rou4UdfrnTNxlGHhs5R2UJRRayKGLL+MqzWCW5hGe
         aFLeIWmykiAgK6Vy8AN0Ivl+81fwA56aoY29wDJ/zlOxjQw9KGXplo99rB7bw/xTVZji
         Xrna0tqOyU28g4vjvdkuxbbiqJrNa3cL0twO27vDzmXkmHJWnmJ2Gbq2BPOTtjZ5U0BB
         YZNg==
X-Gm-Message-State: ACrzQf3BJ8pni/1Lr0DXvvp7B1Amr8vSIz2I1qn8DyBOaEvSWFmyYb4X
	+NhNIVQGbcBghe0v92xMCRG8OMNtxzc=
X-Google-Smtp-Source: AMsMyM5z5OW5DZ98MlNjmSy2kDvLly2cMYsHA1XkRrYtfxztQeQSp0Yhcoi3/tdSzvpKXDnTWSDDGQ==
X-Received: by 2002:a63:fd57:0:b0:43c:9a42:74fb with SMTP id m23-20020a63fd57000000b0043c9a4274fbmr26541015pgj.174.1667494854684;
        Thu, 03 Nov 2022 10:00:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z3-20020a623303000000b0056c349f5c70sm995465pfz.79.2022.11.03.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:00:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: iwd.py: allow certain APIs to be used in AP mode
Date: Thu,  3 Nov 2022 10:00:49 -0700
Message-Id: <20221103170050.379587-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221103170050.379587-1-prestwoj@gmail.com>
References: <20221103170050.379587-1-prestwoj@gmail.com>
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

