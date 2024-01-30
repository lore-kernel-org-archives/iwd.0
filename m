Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C61292E9
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637046; cv=none; b=CRFskEfdZ4lL+qJ4fcYw1eoVSD2nCAp12tOYzbaaHGMFCvb37kFe3+ThhIOY61avMYWSh65Sph0fmsFcBGekGXI/NrO8nDlavK2Fblp7XoVDDtJwy1WXYXjus2dt5YsLNwrpO1753TnCc3oRN501yqAzmbXZTMP9FnSpiBYF9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637046; c=relaxed/simple;
	bh=ISd6gY5lxPJNMXnRkokjSnR2o7bVhG4rdwEsdwZ6r4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQhLZMCeYCNoBSVrKxasUZHNj5jLQ30y/fk6SMdM0TFFJSjJy7fx7SAWX66JLUh1/fccWvE3mvK3kxs4A86j7vAB0iBCEINhv2lNzxWueqeVZZSD4cSO7YygLyBzj/1YfkkLYCzi/eQ+OLcHnnx8ehs7WhcUCl3BAvxk4JgZumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5Y1z3yp; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5Y1z3yp"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a31b90edcso38135351cf.0
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706637044; x=1707241844; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii8jDIcX/DsDEv7agdvlos1P1vVaKTJYjhbGZ/mMXNQ=;
        b=j5Y1z3yp7ThvfTyJCPL2zs56geCgUorpi7RR3IvUceGg8kJkw90FDuh1zP1x9nrdyN
         p91uSKfgcGa0I8fGfzH3LeUsVbfzSRcZtZU2BD3NHnRyYMSLlY86tv2eoH277UdHlxWC
         WfyrkWRVJG90i7fZNgoM84j3vHFG3E/f7rQBCxgt5fi4vxxep7NZk7oEyL0RCN3oBaHf
         uHdsD9a8A7C0pJgB3MfMvEAy7lw0P14B++my5k8vYYlIcSHMfLxngGuPalEncGewGewd
         hnXyqxTl68zGGpRjDConEwSCh0J+yK4rqk6bi4KTUmSl7pBdck75uu8M0oQGUqz6gUVU
         4XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706637044; x=1707241844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii8jDIcX/DsDEv7agdvlos1P1vVaKTJYjhbGZ/mMXNQ=;
        b=MiA1HfcGoMY5amtlVvDEdVmKdXBAmTTA7R1iYuPDvJh2/E1qLvqlmroSKk+Om8dTmU
         9uI3MpCPHVdHRWbN4YmHTmpK57CKMo1XubES5/IRnw01dguJXnoE/bQJv1EVbQ+hlq6M
         s/obHOveT4CXNWDFICvKTgesKOFzm6LY41y+b4blXWkZAtZXbV7mMIKszna4+7/oyD83
         G+cUJ3UqroWKzVcO5NGDdHQStWchUZINDKhoukP6S0RWXGzKIez/RTZ50ccwlnBkjW9Z
         YQPlVWgliuLcJAvyJ7o0cGr2ilhky8JZYi2Mn0tI/wpWsy6OgVS41cGxa6L1YtewEX1f
         6YTA==
X-Gm-Message-State: AOJu0YzVPhc8eQAi0ONo6Wq8zlE6fDviEs0pFGVExSD46pn0DEbP129s
	aS/tb7LdOuPKyBijlXCDxWmCWMom9nK87VCaDnqn/cx/D7u7PpEymvokYhW4F9Y=
X-Google-Smtp-Source: AGHT+IF0icFwhyKXV2wIAAIoTFi/4HP0H/LhlHWezIQhgBPXz+wOVM3yXYMheoxlZTzekFh0iKtQcA==
X-Received: by 2002:a05:622a:138e:b0:42a:a952:69f7 with SMTP id o14-20020a05622a138e00b0042aa95269f7mr4349529qtk.18.1706637043807;
        Tue, 30 Jan 2024 09:50:43 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id cr7-20020a05622a428700b0042a31bc98b9sm4718914qtb.24.2024.01.30.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:50:43 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] auto-t: add netconfig timeout test
Date: Tue, 30 Jan 2024 09:50:38 -0800
Message-Id: <20240130175038.77908-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130175038.77908-1-prestwoj@gmail.com>
References: <20240130175038.77908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that netconfig eventually times out and that IWD disconnects
---
 autotests/testNetconfig/autoconnect.psk |  2 +
 autotests/testNetconfig/timeout_test.py | 65 +++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 autotests/testNetconfig/autoconnect.psk
 create mode 100644 autotests/testNetconfig/timeout_test.py

diff --git a/autotests/testNetconfig/autoconnect.psk b/autotests/testNetconfig/autoconnect.psk
new file mode 100644
index 00000000..c28936bf
--- /dev/null
+++ b/autotests/testNetconfig/autoconnect.psk
@@ -0,0 +1,2 @@
+[IPv4]
+SendHostname=true
diff --git a/autotests/testNetconfig/timeout_test.py b/autotests/testNetconfig/timeout_test.py
new file mode 100644
index 00000000..a15706e3
--- /dev/null
+++ b/autotests/testNetconfig/timeout_test.py
@@ -0,0 +1,65 @@
+import unittest
+import sys
+import os
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+
+class Test(unittest.TestCase):
+
+    def test_netconfig_timeout(self):
+        IWD.copy_to_storage('autoconnect.psk', name='ap-ns1.psk')
+
+        wd = IWD(True)
+
+        psk_agent = PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices = wd.list_devices(1)
+        device = devices[0]
+
+        ordered_network = device.get_ordered_network('ap-ns1')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        ordered_network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connecting'
+        wd.wait_for_object_condition(device, condition)
+
+        device.wait_for_event("connecting (netconfig)")
+
+        # Netconfig should fail, and IWD should disconnect
+        from_condition = 'obj.state == DeviceState.connecting'
+        to_condition = 'obj.state == DeviceState.disconnecting'
+        wd.wait_for_object_change(device, from_condition, to_condition, max_wait=60)
+
+        # Autoconnect should then try again
+        condition = 'obj.state == DeviceState.connecting'
+        wd.wait_for_object_condition(device, condition)
+
+        device.wait_for_event("connecting (netconfig)")
+
+        device.disconnect()
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    @classmethod
+    def setUpClass(cls):
+        cls.orig_path = os.environ['PATH']
+        os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
+        IWD.copy_to_storage('resolvconf', '/tmp/test-bin')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        os.system('rm -rf /tmp/radvd.conf /tmp/resolvconf.log /tmp/test-bin')
+        os.environ['PATH'] = cls.orig_path
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

