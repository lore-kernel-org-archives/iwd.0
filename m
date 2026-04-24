Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745933368BC
	for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019541; cv=none; b=q1iPDRNK3ejQPvRcg5ujytBpgEB7hiWHV8W5MQ9dnWTxJoZzaMiCr8wuaj9vQ9mMTDppmEiySehlr92UXnZ1Mno7sJZTq/jkIaJgb3kG6XYDVpTMJ1IEQwYFqWT/DPsh8hadqIz2zX/Nx62U2xSxTjl0c3QphEnY7ph9XwkyekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019541; c=relaxed/simple;
	bh=29uzo4ls4bpauc0tZN/lexU1DOhcw7ruA1m9q4TmPLQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpqNFrwKuer4Fg3rBengSGeVtUNcVFnL+Bvzq339y1ltPWjEoasE0HHDhXfTMw7vpvbZ69LXosrlP3S2oc/tgUm/qIAJA76u105i+VRsNbhWHGd6LoQYveU06x9QfFlHd0CrqF8Oen6GU7/zoJAzbvcoyMLvcZ256mcLd0uf+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=kdAUfJWt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="kdAUfJWt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso35036055e9.3
        for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777019536; x=1777624336; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=111R/Gf0K4x27b/g4+S27DtDMX3TdPZxJES/Dmt+4CU=;
        b=kdAUfJWt1WozO+UwKKIdCyUXxGLKsnk1d5b4kH4DbxbismI81+3aBM3E4N57eUNtXS
         xrjRLqIqHvVEuBm3GqT6xc1+hwnAa+vyE/NdftCmEUZktECSZnhRRAGeXIyo+2pfJ+Mk
         nzS7yC5fP+SxLYJgNGdZMVU7lvoaBJLj9JLKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019536; x=1777624336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=111R/Gf0K4x27b/g4+S27DtDMX3TdPZxJES/Dmt+4CU=;
        b=mzX6dZxpmHVFhYUXHkqLqQKnUqpMY6AaAa1smaf8Aon5emkYTtatpUjrW07841kpQ7
         G9+g8NIxZeisotb+Hl0kPVav48JiG5QKIexLIIohSMAuCnlQ64tazd0ky+cRErHggZ/n
         +T31Ux6bqyd8NQirasx8H9zclAXuZ1or2BOAgJIS5X5DUSskAb7w5kQTfpZBcbXr81Y3
         yIf9x04D8jtq6HhX2fL4tyyGRt7mK1Sk5Z/RuVPgIJocuA6Wnyhl5GOwmv0FYIqZBgKh
         KP5FZfwioniFiQw8Tli6dGYUnYVEUu3zLnxAA8DM2rFiw3QblTFaTEEgv8xIRxuS46+/
         qQ8w==
X-Gm-Message-State: AOJu0YzlhN1eH0VBkRITuW8rP/X3hRkI3MU88sDUyP08QbXU0LEJb/76
	QOJD69f//XaIuTYBEIW2kYy3buXGizqvii8n9mswFDVv2cI8WMYBs0qcxRtqMxydL7nn8PZ/Xrv
	2a72P
X-Gm-Gg: AeBDievbZ/XwwVN4fR9mh9fykNrsUkFgMazaF1xh5hlgiFglaVLdyXYW9fjiZgCuhzn
	cHs79WwvTimNMYW7ZesbM38oqNFG/5LtC9Ze/On2eRR+beTODyLzxWSlxbeQQ43eI/PGQ8cSJoe
	T9plgm7sHoxVBU9Y9rdX9+762TvuM3RLCNl07ROOzSVRHMlp6o5JffKUMY54V3Sb0uLE/etJQwk
	jowgbflMwn2kf+CRyp3xqqu0hNz6zRwErJUra3h7n/aifbNGInMEjeKTt1UUTYoHn9kuYV97590
	eeLsbW63GY+Hc5hRhEzm3ScyY8TkuW06U0CKDNKMAY5LNvT9xVYKDFA09vY9Q7XFtuA6Ni1QQUO
	UOwfkivtihGUWi9xT/zhgWruKB9BLFnwI/Hmx03Qmx0AmjNT46xqcR2a6iA5fbIgF1WRW5gNMgl
	t/v02Q7JfcMNRky6jc0lD5WJyVOsPeHJgmcHudHviU5nx6YzyX4gMqJGxNhGfvCOvTygY9ijs36
	ADivrfAXCP1+AonLKQ+oi6mspYcAgb9oDGusRFtl0YWCubfh2XJiP1dFOgmOsyUV2VjPGbjKcEb
	wa2u6wURBkxNdRP3vCYAAkRCYsSTWq4haZj1QAAI0bGbsMv9qYNq364hkQpgWwB46HfjkkrqAgK
	2EWlfbYEdSm15S4KcYIWk
X-Received: by 2002:a05:600c:19d3:b0:489:1ae1:4eb9 with SMTP id 5b1f17b1804b1-4891ae14f23mr289396045e9.28.1777019536259;
        Fri, 24 Apr 2026 01:32:16 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-8de6-cca3-34a7-690d.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:8de6:cca3:34a7:690d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm601386945e9.10.2026.04.24.01.32.15
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:32:15 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: iwd@lists.linux.dev
Subject: [PATCH 3/3] auto-t: Test transient PSK agent secrets
Date: Fri, 24 Apr 2026 10:31:59 +0200
Message-ID: <20260424083209.383093-4-m.kurz@irregular.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424083209.383093-1-m.kurz@irregular.at>
References: <20260424083209.383093-1-m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the PSK agent test helper to implement
RequestPassphraseWithOptions and add coverage for Store=false. The test
verifies that IWD can use the agent-provided passphrase without writing
PSK secrets back to the profile.
---
 .../testEncryptedProfiles/connection_test.py  | 27 +++++++++++++++++++
 autotests/util/iwd.py                         | 14 +++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/autotests/testEncryptedProfiles/connection_test.py b/autotests/testEncryptedProfiles/connection_test.py
index eb7fd7c5..17c5ff11 100644
--- a/autotests/testEncryptedProfiles/connection_test.py
+++ b/autotests/testEncryptedProfiles/connection_test.py
@@ -21,6 +21,17 @@ class Test(unittest.TestCase):
 
         return True
 
+    def profile_has_psk_secret(self, profile):
+        with open('/tmp/iwd/' + profile) as f:
+            contents = f.read()
+
+        return any(secret in contents for secret in [
+            'Passphrase',
+            'PreSharedKey',
+            'SAE-PT-Group19',
+            'SAE-PT-Group20',
+        ])
+
     def validate(self, wd):
         devices = wd.list_devices(1)
         device = devices[0]
@@ -80,6 +91,22 @@ class Test(unittest.TestCase):
 
         wd.unregister_psk_agent(psk_agent)
 
+    # Tests that an agent can request one-time use of a passphrase.
+    def test_agent_transient_profile(self):
+        wd = IWD(True)
+
+        psk_agent = PSKAgent("secret123", store=False)
+        wd.register_psk_agent(psk_agent)
+
+        with self.assertRaises(FileNotFoundError):
+            self.profile_has_psk_secret('ssidCCMP.psk')
+
+        self.validate(wd)
+
+        self.assertFalse(self.profile_has_psk_secret('ssidCCMP.psk'))
+
+        wd.unregister_psk_agent(psk_agent)
+
     # Tests that an invalid profile gets re-written after an agent request
     def test_invalid_profile_rewritten(self):
         bad_config = '[Security]\nPassphrase=incorrect\n'
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 37eb4943..54096b01 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1153,7 +1153,7 @@ agent_count = 0
 
 class PSKAgent(dbus.service.Object):
 
-    def __init__(self, passphrases=[], users=[], namespace=ctx):
+    def __init__(self, passphrases=[], users=[], namespace=ctx, store=True):
         global agent_count
 
         if type(passphrases) != list:
@@ -1162,6 +1162,7 @@ class PSKAgent(dbus.service.Object):
         if type(users) != list:
             users = [users]
         self.users = users
+        self.store = store
         self._path = '/test/agent/%s' % agent_count
         self._bus = dbus.bus.BusConnection(address_or_type=namespace.dbus_address)
 
@@ -1193,6 +1194,17 @@ class PSKAgent(dbus.service.Object):
 
         return self.passphrases.pop(0)
 
+    @dbus.service.method(IWD_AGENT_INTERFACE, in_signature='o',
+                                                        out_signature='sa{sv}')
+    def RequestPassphraseWithOptions(self, path):
+        print('Requested PSK with options for ' + path)
+
+        if not self.passphrases:
+            raise CanceledEx("canceled")
+
+        return (self.passphrases.pop(0),
+                {'Store': dbus.Boolean(self.store, variant_level=1)})
+
     @dbus.service.method(IWD_AGENT_INTERFACE, in_signature='o',
                                                               out_signature='s')
     def RequestPrivateKeyPassphrase(self, path):
-- 
2.54.0

