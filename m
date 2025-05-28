Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621E2206A7
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463036; cv=none; b=H73US9HvcfMVuh+u+8JAPaQ/9tAjd1L1hFhZsK+yjDJvExl80Colr4/tzyqO4i54DnGyFMIYK2sxZL4bqw/0tZ3j0iCien8GaO5UfT+Vc6mFwjgZDMWixD/nHmz1HvcSL7TjuRZAfCA26MFvbXeWiPYncwgpEVwp2/8YtLY5PtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463036; c=relaxed/simple;
	bh=yNCOFemxTaW9eVu1WeklKsHSZWqDQqc7dUw/cLMDEz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jM8OCAPB3NxkxRqasxRex4yeHhq1S4ThChINxM6eL2S4EisvHQfS7b9wATgYkhUnZwiPNpd+TRcoSwbRAtarJt9l01RfoHVJ0FSdkHJx8XWtHLkidUufSfU5Oawxz/xRvmcrQhInviHtfKS9avJUDA+h2zaikSVbv1x77qjHVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYE6TFw3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYE6TFw3"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6faacf5d5adso2720176d6.1
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748463034; x=1749067834; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UslDIdL6Bdqac1WpqkDbXx8fCULQLCDGb6FI8tT10/c=;
        b=lYE6TFw3RNxQSVBP2kdMQAH1srk16V605ISGK5PCLx7uKC9ZrFE2AJpvmlxrcHxuw6
         CoNco+YD0BJyy3QZwOjjB1IBdVvztgr0NgVFDuaYePVeJVSPwCJGinbbPftMFlyiTb6K
         C+oBaOJGKdz24MTQ/+yId7H3cE2jRHx7XZDYoV3nySigN8er1IdOLhIw8RYzxT8cclLi
         QV7ctTqfFBjEby6XlC4tcLJ4v9BxThsw9Nulz9UlBp3g/BD2ZiJi3g7xM71/WbDmNXFR
         1byKYfoiSGHdVgJXqju620ZFTjyyuilEYbRhcNFNnoE0TCZoXXyrxzlftCeTuWecU/j7
         Yi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463034; x=1749067834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UslDIdL6Bdqac1WpqkDbXx8fCULQLCDGb6FI8tT10/c=;
        b=wXrJac7o5cMzzgzBZqfb7/zStxGoQDtg2/zlshH+bgMMWLmlZo1py1iuaLvhFeevXa
         5axxEg/IkYEhFvwAvwCCnEkqeDDO9EgDwU9+/3vAuDLfMpwQnefSU8clqCKXYoQaSZYU
         nUtpffenjODrzs5Hb0TZSUnPA5zo2G7GbLUrhLadYp2xAquwciYwUs2WsMV3qgot/BxH
         r9KcEkRX/4aoiSf3i9/+E6F240ZCiTijKURQnEpBx5QBF2XLZrXm4hgbQDf4G0J0a6j0
         T22TL3uq6jwBCybBBiz4pJxD9LfMSpNvIDj0iLYLPhl9Lf4c9ZBRuzUrNTnk0mEtx8NT
         22BQ==
X-Gm-Message-State: AOJu0Yw2PWCFcjwq2oHeuxaGjZ1imKEfSEu3J1qnfu+pkduhDIn+SaoZ
	vUATVBCC9cPAD7Dnc2mJPpGLLCBDBm14Qhj3r1MGxRNHLjIWEL7nxvcs0g91VQ==
X-Gm-Gg: ASbGncsCEFbQMX2RCXly4ODk15CSmQlxvOSnGFF48sOG5MmnA+/yIUJ4gd98Jph0fOV
	kEY9iZRv+8+2ExOk4FzHw6W5Ijofvj7G3ev25OzK4Od4C0xrUmyikN813zQlheuQtcDq3ff1QYK
	Fzoz6UFF0+Ofni7N9rGG+5haVnWaXMqnrYXNClyh/stIUErK7ofSyowBbVnRlBiQnp0xXioiXV9
	bLKyVFJnbj9pRH8Os9a4KDxBSrOuuVX/sRx+0WBx57/V3/cOqblSKeSnc4hQ2UR9hMweI9ZUn4d
	Ke8hW6ZdelHxiRY4dLYeYiilPMRzmQYRjWWKhR40MSpBFOQIC8l9vVb1evQS/A==
X-Google-Smtp-Source: AGHT+IEFbFu4HtE1Vq8nZp389H7JJxw0GnOOprAhpDCjBFrFdsDkQzQ+bs4u1NvEIVNVYjoiHljerQ==
X-Received: by 2002:ad4:5cce:0:b0:6fa:ac51:bbda with SMTP id 6a1803df08f44-6faac51bd64mr157230236d6.26.1748463033816;
        Wed, 28 May 2025 13:10:33 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2888asm10408126d6.45.2025.05.28.13.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:10:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/6] auto-t: allow configurable DBus timeout/callbacks on connect{_bssid}
Date: Wed, 28 May 2025 13:10:24 -0700
Message-Id: <20250528201026.598221-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528201026.598221-1-prestwoj@gmail.com>
References: <20250528201026.598221-1-prestwoj@gmail.com>
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

