Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B951B0F1E
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442478; cv=none; b=MFzhBTWFOHvgeVPEw/0l2te5bdkvLqyZr1bikwsk4O6wOrkGEYA9Z7cgp6duxiKjGSw2jmd5pqz4jj5/Fsjc9HLqBeKplMwmoDm7+MPSaRnsKHKr5aw4zeMXsPPdkSSUagjMvOl956Xx16UnpAFP67Dm3mK4yHqLcHawbKHkGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442478; c=relaxed/simple;
	bh=yNCOFemxTaW9eVu1WeklKsHSZWqDQqc7dUw/cLMDEz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ti/xQsEW6ltbhH6xY1/nKXuIwhIcwXy9SCSpUf3o5wHpIpmQbCkOj1JmQdbElmbEqpZg2qtVwWbRZZDrfm+/LA+MKtaerQDFW0gZMu5Bw4J7yc+rYjdiLyd+BD0TipSOeEkh92Muc0XHWukJgNhjC5moVAkKxbLSiKpQp+5Zzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL2IERSk; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL2IERSk"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0ad744811so27432366d6.1
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748442475; x=1749047275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UslDIdL6Bdqac1WpqkDbXx8fCULQLCDGb6FI8tT10/c=;
        b=JL2IERSk5YjIKWWeOYcFpwPwgq5wBk8W1t8hFZzCRpIhxpXtQ8VtiBukRh2M/B/6kK
         ReAXdqyWg2WdEdYjpdylgqZqKJFNNqV4zuP5XdLF2fUhIDAYGKxj2tSxTBce0WF01pgo
         4gYC9SKMWQF53fMpZoG0qHQUcyazwf/n/vz/832ZPG+fg672RHCpaEes9H4CZDptFYNy
         1s4DKp4DKC2RKQojF7NdkW2KoZplo97UZO969Zyl2WKs8N1IL3T9+Q81vJDEuJM88Gt1
         pwY+gi7qgTU7FQoxAoONO0nOn0yb+gHntZubkgGLj6GmepVDqfw9G3eMpxWMFmRYglNE
         2zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748442475; x=1749047275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UslDIdL6Bdqac1WpqkDbXx8fCULQLCDGb6FI8tT10/c=;
        b=meFtss5OKoA6OFV8VCIgXoHCso5Bekfus7jI8w52VQIL2qjX1Cu1OH/ztMtdkq0wi6
         AYVtHqVY5R+TJsNB0jIQ12Dg8oqxyPU7YfENDCtVXeaYqjQfwsuToHmfJOUObjUru4ne
         rl6WA5ED4clCqQOIb4lsTOnpxl6Zbpdqse9UehkJiHnMZhZMfcgxkCUkh6pUlHsAxqW+
         VsOa1jB/C1dYZV8Bmc0xGMtO9kP5wccBP7GNiirUSSwPNBSQjRJwyXIxpToRtwn5XgOq
         96RfE0AsDcoJHWDjEvXMGu/Je9/38bzPVuGYsy2kyt5qEZcY759YFb9CxrlAW4uceSlP
         6WLA==
X-Gm-Message-State: AOJu0YzHBFxP/AZfJDGUn2X+ZoUpprrgOBIlxTH3UZ//rWvYsI9ZKJyP
	ul/IgtY/aVyWMyGNE8E+dGyS6aiqot5zuLlmdEDzeKuwRKcCQipaIWg6XmcIxQ==
X-Gm-Gg: ASbGncvRZNIi9I/2cf5Es6OgHrc8isdtvVI1f+fAm6u+MwHyfli6xR5d8+CZs3eDytn
	nZNcDWd1E15Z3wAorgC051P9+kW5aGGsmJQDJ94EOAHqaimQIZsX1xYD6F/9tN+iSYWtv1EsE8I
	wmTO5mh1SqNkaMBvixByPRiATEJjQv7fu63KtI1igWVKC7ESmkUQ44RWQifIog1kKCxWS8BAdz8
	vM2uGgG/vy3d/5a+j0j4n6rN7IqEV+fJK1caZvqksZdtamEvIf67QDuwSqPpr5DsxDB89r3G1xh
	zcF1yakTTvyjUQp4ceMSjlSvE4SlbnRWLwaviKdLpQpRVpRoGkAL75IjxbJx/Q==
X-Google-Smtp-Source: AGHT+IHizVtFPou08ndD6Fu/VvWWV20U6VFpvlC7gIY7nR5CGdxRgKB1R+rPLPI1zkXuxNDUPPqcBA==
X-Received: by 2002:a05:6214:2403:b0:6fa:c46c:6fa6 with SMTP id 6a1803df08f44-6fac46c736fmr11617636d6.12.1748442474966;
        Wed, 28 May 2025 07:27:54 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2244fsm6960526d6.17.2025.05.28.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 07:27:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] auto-t: allow configurable DBus timeout/callbacks on connect{_bssid}
Date: Wed, 28 May 2025 07:27:48 -0700
Message-Id: <20250528142750.498252-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528142750.498252-1-prestwoj@gmail.com>
References: <20250528142750.498252-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the caller specify the method timeout if there is an expectation
that it could take a long time.

For the conventional connect call (not the "bssid" debug variant) let
them pass their own callback handlers. This is useful if we don't
want to wait for the connect call to finish, but later get some
indication that it did finish either successfully or not.
---
 autotests/util/iwd.py | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 9091807a..37eb4943 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -112,8 +112,8 @@ class AsyncOpAbstract(object):
         self._is_completed = True
         self._exception = _convert_dbus_ex(ex)
 
-    def _wait_for_async_op(self):
-        ctx.non_block_wait(lambda s: s._is_completed, 30, self, exception=None)
+    def _wait_for_async_op(self, timeout=50):
+        ctx.non_block_wait(lambda s: s._is_completed, timeout, self, exception=None)
 
         self._is_completed = False
         if self._exception is not None:
@@ -280,8 +280,15 @@ class StationDebug(IWDDBusAbstract):
     def autoconnect(self):
         return self._properties['AutoConnect']
 
-    def connect_bssid(self, address):
-        self._iface.ConnectBssid(dbus.ByteArray.fromhex(address.replace(':', '')))
+    def connect_bssid(self, address, wait=True):
+        self._iface.ConnectBssid(
+            dbus.ByteArray.fromhex(address.replace(':', '')),
+            reply_handler=self._success,
+            error_handler=self._failure
+        )
+
+        if wait:
+            self._wait_for_async_op()
 
     def roam(self, address):
         self._iface.Roam(dbus.ByteArray.fromhex(address.replace(':', '')))
@@ -870,8 +877,8 @@ class Device(IWDDBusAbstract):
     def stop_adhoc(self):
         self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
 
-    def connect_bssid(self, address):
-        self._station_debug.connect_bssid(address)
+    def connect_bssid(self, address, wait=True):
+        self._station_debug.connect_bssid(address, wait=wait)
 
     def roam(self, address):
         self._station_debug.roam(address)
@@ -999,7 +1006,7 @@ class Network(IWDDBusAbstract):
     def extended_service_set(self):
         return self._properties['ExtendedServiceSet']
 
-    def connect(self, wait=True):
+    def connect(self, wait=True, timeout=50, reply_handler=None, error_handler=None):
         '''
             Connect to the network. Request the device implied by the object
             path to connect to specified network.
@@ -1014,12 +1021,19 @@ class Network(IWDDBusAbstract):
             @rtype: void
         '''
 
+        if not reply_handler:
+            reply_handler = self._success
+
+        if not error_handler:
+            error_handler = self._failure
+
         self._iface.Connect(dbus_interface=self._iface_name,
-                            reply_handler=self._success,
-                            error_handler=self._failure)
+                            reply_handler=reply_handler,
+                            error_handler=error_handler,
+                            timeout=timeout)
 
         if wait:
-            self._wait_for_async_op()
+            self._wait_for_async_op(timeout=timeout)
 
     def __str__(self, prefix = ''):
         return prefix + 'Network:\n' \
-- 
2.34.1

