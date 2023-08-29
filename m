Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B3156CC
	for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 14:40:03 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d74a012e613so6057372276.1
        for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320002; x=1693924802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ACtGDT+wBKM1aqa/0D18ygofmsmdxA1ZtOo9QKtWsM=;
        b=HQekz9mtSOaTzi/S7PUjQ1IujTE7P1QLPbmTJzAyYj12mTdjhW38d8WaQrW5wV7qDT
         zYJ0I30uaLgDlmp4IOPgY+iCQnoVN5aE6AaB6TKEZmIP5bkcomDPC8QnCia6UCr5uyIP
         BMKj+cxi3C7/acemeHWZhwkP40nYpjICTmiC/yAUBu7a6SvFfEbzzbEsgvwqRRsCiDXa
         TemRlLicV3yH5C/Eo+GyCYr82jqbRnOUwfHGwdf3bwOpCP54IOEnYTb/rmb7X/nNAEvz
         UjmTsR8kZmYR5Lu5joG3v4I2kNg4OvHRwcMxJoaEwilSzm2tkhSacdezcvh5npVhRIIS
         zJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320002; x=1693924802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ACtGDT+wBKM1aqa/0D18ygofmsmdxA1ZtOo9QKtWsM=;
        b=YTw7eAvTQsRcW5fJ2V9T/SQy3X4AOoseJ3rtuAopzaNj455Tr/g6jJRG8uFXWR1h9V
         pcQ4VSlFWFj04EPk7cuWfJ7wHL0Rxh0X+1lecwlQr3aYrplneOqzOh9LL9d0iJtz3ezK
         Pnkvbj3JJZa0ejbRPg3iSAjhMWh1emZR2m0ZjcoWG6ad3qX0xc5/OFOrjwn2wvH90Pcy
         A21sgMPhEdye7qV0W94cBTu9eKwQNzMMQpGyeYvXmKiUszkEMecrDPVWmfVe8yd5bN5A
         iY0J+k0+sd1LdrL9XKBu/phobVEkN4wrwmOvzUmfZxk7+GWJx3Hi0Rz2SW6llehShRWL
         KGOQ==
X-Gm-Message-State: AOJu0YwnzeIeF/iA8LKMA7kKHFJwmNBhJr/iC6pbK4iOzVTPdLIPAq4Y
	L7DNjxoPugQA3wsJXyUdbNjOpfBI2Qw=
X-Google-Smtp-Source: AGHT+IE9hPCVNKgvfWeju8EpF/tVbWb5ZsvOtjkNamNBO3nLTBPJEb4idWBJ5jEZKhLXdprzAT9/fA==
X-Received: by 2002:a25:9b46:0:b0:d7b:9419:a07d with SMTP id u6-20020a259b46000000b00d7b9419a07dmr397562ybo.10.1693320001876;
        Tue, 29 Aug 2023 07:40:01 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v124-20020a252f82000000b00d7465a90f0csm2217817ybv.22.2023.08.29.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:40:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: require a complete hostapd default config
Date: Tue, 29 Aug 2023 07:39:54 -0700
Message-Id: <20230829143955.267742-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many tests the hostapd configuration does not include all the
values that a test uses. Its expected that each individual test
will add the values required. In many cases its required each test
slightly alter the configuration for each change every other test
has to set the value back to either a default or its own setting.
This results in a ton of duplicated code mainly setting things
back to defaults.

To help with this problem the hostapd configuration is read in
initially and stored as the default. Tests can then simply call
.default() to set everything back. This significantly reduces or
completely removes a ton of set_value() calls.

This does require that each hostapd configuration file includes all
values any of the subtests will set, which is a small price for the
convenience.
---
 autotests/util/hostapd.py | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index bb27686f..1b1bc399 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -64,7 +64,16 @@ class HostapdCLI(object):
         hapd = ctx.get_hapd_instance(config)
 
         self.interface = hapd.intf
-        self.config = hapd.config
+        self._config_path = "/tmp/" + hapd.config
+        self._default_config = self._get_config(self._config_path)
+
+        # The vendor_elements is somewhat of a special case because you can't
+        # set it to 'nothing' within the hostapd config. In most cases tests do
+        # not use this and we don't want to require they unset this value
+        # during initialization. Default this to '' so set_value won't throw
+        # an exception.
+        if self._default_config.get('vendor_elements', None) == None:
+            self._default_config['vendor_elements'] = ''
 
         if not self.interface:
             raise Exception('config %s not found' % config)
@@ -89,6 +98,12 @@ class HostapdCLI(object):
 
         ctrl_count = ctrl_count + 1
 
+    def _get_config(self, path):
+        f = open(path)
+        lines = f.readlines()
+        f.close()
+        return dict([[v.strip() for v in kv] for kv in [l.split('#', 1)[0].split('=', 1) for l in lines] if len(kv) == 2])
+
     def _handle_data_in(self, sock, *args):
         newdata = sock.recv(4096)
 
@@ -151,6 +166,10 @@ class HostapdCLI(object):
             pass
 
     def set_value(self, key, value):
+        # Don't allow new settings, defaults should always be in hostapd config
+        if self._default_config.get(key, None) == None:
+            raise Exception("Untracked setting '%s'! Please set default in hostapd config" % key)
+
         cmd = self.cmdline + ['set', key, value]
         ctx.start_process(cmd).wait()
 
@@ -179,6 +198,12 @@ class HostapdCLI(object):
         ctx.start_process(self.cmdline + ['disable']).wait()
         ctx.start_process(self.cmdline + ['enable']).wait()
 
+    def default(self):
+        for k, v in self._default_config.items():
+            self.set_value(k, v)
+
+        self.reload()
+
     def disable(self):
         ctx.start_process(self.cmdline + ['disable']).wait()
 
-- 
2.25.1

