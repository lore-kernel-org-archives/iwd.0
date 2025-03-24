Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AD2E3380
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825757; cv=none; b=XfmtbRe1jSHUhtz44ltUjhu+3ROCTggQHNPFxcK9Z+7MSSaFn1DB+Ce5D24jbcfOCqnBxG4dYUgfa+BMYgC+5GARDYHrLbjfTpuqNTT/nTEoMSvfGrFMJ9y+YzcBRqI5I3BcS+oUu3qiVIP/JrQxZDMCyX8I916TW5WB3yzpmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825757; c=relaxed/simple;
	bh=RuQY+rH5cxO4piN6+5wH8ICIX8e/hooGS/Quj3DEKgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E1U7co4KjrGBWD8ULFoNq7s+Gi3SSEChyde+f4Got4+oHB1DnNgxohQnAzqa1XfpL786qbCD/PSMrRWa0Ct6/8wokkJjFb/zMNlpbi6KxaJq/1GJP0+k+buhpFa6eUI9P2GKyRlF8du6XQnIviDcc8Tf4bb36SmArW/1Pt22DZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO4fLdel; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO4fLdel"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227a8cdd241so5676395ad.3
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825755; x=1743430555; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y8J2vmE79n+rammSb68Vx/t2JXWMbDjn+1OH9GUK8w=;
        b=FO4fLdeltQqknM0ACKJgO91rHBgdEDcFrSyug5T4d0yDLDnIVmz4nMOJQrSZz56Qhj
         MC9P1UEGhq/wKyi1j1jKLwNWDWqDfzXzet0E8GvgIF+V+Wi/mBe7n0uQ+BN6eDwNhUET
         FdqE8iyisac6cA4yow8kfMQh4NevRaD0ANh5f5D3ku6Tle7HbZ7h0nNfDuzInyDCQqtz
         rRNxq0x3jQTqPj/F80NqbanZKDHcCSw4Y+MCcW4zLPrffHy0VPp8Cl3gXiP/8PbCibU+
         ozIFTa2Yh2kd9l74vKUCKyS16ZHWt7XDdztpW+m0MCvLLN1l2Bdr/W857bs7JyGX3UcF
         K3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825755; x=1743430555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y8J2vmE79n+rammSb68Vx/t2JXWMbDjn+1OH9GUK8w=;
        b=SECz9jc5nPXE5hBS7Wr4Wwe7IQoZoj9MRo913WJ4fnpUU+So4P6vAzjSs4KJ82uo2J
         SrwXLG7HdCnkHPuSbvuJHsCk5SDsIbSSGuEqWx2rluyoYCxFY/xbAiADXylls9Tk7NfD
         Ezg/P/T1b/KP7CvWF2DlnvMXsA5a26OwO75SKbK9ZP7D0RqSMk5kciQQAAN/m9XoBApj
         7qX+210lq6e54RcknsxWjeT5O+91myQnWKuLKuL960TmL5Id8gL0DhSCWFoWYLncFVv0
         nZP3Tcq//coRZIdBe5ROveFTEDlZYnZCPAJoaygGOIic9/edsWx4uKrIU7GcpEgyYw1a
         5FZg==
X-Gm-Message-State: AOJu0YyYoh3ZJPtEiB2ZH9uD3O1qAWBnVpO85qOYDvLfTNUC2qXmgECM
	0W0cWO+vGSs0ntKLlmf3TxuhFJCPqQsQtyvnqExdZbsyS2v6WZIqnELeoA==
X-Gm-Gg: ASbGncsBQ97d7FDzFEIl/kN0SOJSspphBxlMBXyD+YTxOzmwFjzg7byHwicQoN8FNAe
	AfWq+cPqrzLQm+2GXOd5Z62WoGx4lswnmLsu49R3BbeVvHNU+N6s/PhdGpRa9i0pe5r6STVv7Kt
	D8MrC6PaM4Cs4A927SYUPtDbBn6Nk8HtpF8kGpcPF8PLK0ezP4ssp/o1pRj0b2xPw6yW5LIg6cY
	UazlTOKWM+hsmf/MQBu4JswZe90biCTUiP/K4ttaS+/Gc3E1Jui9819MTFzuXPI02nS1Ktp1t64
	v5L5X0VXOGyk7QqVbCQd2AkOUwMfJFdN9vvNLEcgG1TENFWlNdnXMTs=
X-Google-Smtp-Source: AGHT+IGFxwx5PsGnkrAWU/oX56KaRmCmOpyUrL7SEPnp5pCj7Ej57/Qp10a+N+gANmQqZJlY8tQImg==
X-Received: by 2002:a05:6a20:3942:b0:1f5:7007:9ea5 with SMTP id adf61e73a8af0-1fe42f2a027mr22172859637.2.1742825754505;
        Mon, 24 Mar 2025 07:15:54 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:15:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/13] auto-t: add test for disabling the timeout blacklist
Date: Mon, 24 Mar 2025 07:15:27 -0700
Message-Id: <20250324141538.144578-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testBSSBlacklist/TestBlacklist.psk  |  2 +
 autotests/testBSSBlacklist/connection_test.py | 57 +++++++++++++++++++
 .../{main.conf => main.conf.default}          |  0
 autotests/testBSSBlacklist/main.conf.disabled |  2 +
 4 files changed, 61 insertions(+)
 create mode 100644 autotests/testBSSBlacklist/TestBlacklist.psk
 rename autotests/testBSSBlacklist/{main.conf => main.conf.default} (100%)
 create mode 100644 autotests/testBSSBlacklist/main.conf.disabled

diff --git a/autotests/testBSSBlacklist/TestBlacklist.psk b/autotests/testBSSBlacklist/TestBlacklist.psk
new file mode 100644
index 00000000..abafdb66
--- /dev/null
+++ b/autotests/testBSSBlacklist/TestBlacklist.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=secret123
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/testBSSBlacklist/connection_test.py
index 9631a322..ac1cb86d 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -260,12 +260,69 @@ class Test(unittest.TestCase):
 
         self.wd.unregister_psk_agent(psk_agent)
 
+    def test_blacklist_disabled(self):
+        wd = self.wd
+        bss_hostapd = self.bss_hostapd
+
+        rule0 = self.rule0
+        rule1 = self.rule1
+        rule2 = self.rule2
+
+        psk_agent = PSKAgent(["secret123", 'secret123'])
+        wd.register_psk_agent(psk_agent)
+
+        devices = wd.list_devices(1)
+        device = devices[0]
+
+        rule0.drop = True
+        rule0.enabled = True
+
+        device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        ordered_network = device.get_ordered_network("TestBlacklist", full_scan=True)
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        # The first BSS should fail, and we should connect to the second. This
+        # should not result in a connection blacklist though since its disabled.
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        device.disconnect()
+
+        rule0.drop = False
+        device.autoconnect = True
+
+        # Verify the first BSS wasn't blacklisted.
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
     def setUp(self):
+        _, _, name = self.id().split(".")
+
+        # TODO: If we have this pattern elsewhere it might be nice to turn this
+        # into a decorator e.g.
+        #
+        # @config("main.conf.disabled")
+        # @profile("TestBlacklist.psk")
+        # def test_blacklist_disabled(self)
+        #    ...
+        #
+        if name == "test_blacklist_disabled":
+            IWD.copy_to_storage("main.conf.disabled", IWD_CONFIG_DIR, "main.conf")
+            IWD.copy_to_storage("TestBlacklist.psk")
+        else:
+            IWD.copy_to_storage("main.conf.default", IWD_CONFIG_DIR, "main.conf")
+
         self.wd = IWD(True)
 
     def tearDown(self):
         IWD.clear_storage()
         self.wd = None
+        self.rule0.drop = False
+        self.rule1.drop = False
+        self.rule2.drop = False
 
     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testBSSBlacklist/main.conf b/autotests/testBSSBlacklist/main.conf.default
similarity index 100%
rename from autotests/testBSSBlacklist/main.conf
rename to autotests/testBSSBlacklist/main.conf.default
diff --git a/autotests/testBSSBlacklist/main.conf.disabled b/autotests/testBSSBlacklist/main.conf.disabled
new file mode 100644
index 00000000..aae6bc12
--- /dev/null
+++ b/autotests/testBSSBlacklist/main.conf.disabled
@@ -0,0 +1,2 @@
+[Blacklist]
+InitialTimeout=0
-- 
2.34.1

