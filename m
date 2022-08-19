Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390914A14
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 19:24:38 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id g18so5545621pju.0
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=B+KeXq1qhL/tJlopwaEdqPJEoRdGIotNJFuasGAMrssn8AhsB74ed0nKqT2aplfCDF
         e7qP+fuzWALH8l/29xPp6E3bJvJmw976E1/VL1oHBGevPYCmchcboP7i2g9XnPz7zixb
         BJ1/wy3c/9Y72v9exqL7obG96OeqYzuG29hB4mKQLFa/50CVO9WVCKh+ru6cfNFJZmx0
         giZ5n+ckWeGBjHkYh4U/YYfzmdVxsU9fEWhXdXRsw3IYj9+LnUlAyA9EEegMbFLaVVCh
         ExSIyri8wruEsI4VwjfwBCu2AMQ+zgRwuvtXQfP0fVGeCBfzoGxpnNgcA+Ws2jPW5GQD
         Q8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=LfZ8OZz5AiJBj8amW2fG83LM1z5bbtg3fAPug/1+t6uW0Y2OdxYp6LmgzuJpbzvKw2
         jKC/0f2nKcv8SGgZYZA4OY63EW1zfDxq5I/1xGvVQKkammbdq1//LCK1/D6BZSnUNtj3
         0WwPZepG4wm4Wgbh7OyVhyaS/37SM06dXztKmaWno+sMSmWB5VVRrK+mh31exjqGyVKR
         M93Z1TOXtcM8Y33P/H2kKEgoJI7qFPbiC1AOlwy7n6aL7OUVbapc9+mHWwYewmlCEeuQ
         YR10ukZxzdbDSy8RClGZ2mu0PD9VBYQa/W/rC9+aVUz2UDxGiMjuS8nSpyVwTt5nddcp
         5Ayw==
X-Gm-Message-State: ACgBeo0BQZi5knC5PUaNebuNETMCkCvx6nAuFV3yMkOANtcUsaeaLbhR
	oXxPeRDkSPrRvAuUXN7ZkIb4TYcaQoc=
X-Google-Smtp-Source: AA6agR5P9A336aWH6UpULYjrBFtREuPNemhMiUTorOJUpeNym8xFb7z7+kNvtWvglNXnkYE67fwyDA==
X-Received: by 2002:a17:902:7007:b0:170:8d35:bafd with SMTP id y7-20020a170902700700b001708d35bafdmr8528351plk.51.1660937077509;
        Fri, 19 Aug 2022 12:24:37 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902d14200b0016dbe37cebdsm3472982plt.246.2022.08.19.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:24:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] auto-t: hostapd: add set_address/group_neighbors
Date: Fri, 19 Aug 2022 12:24:28 -0700
Message-Id: <20220819192431.1605386-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220819192431.1605386-1-prestwoj@gmail.com>
References: <20220819192431.1605386-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a few utilities for setting up an FT environment. All the
roaming tests basically copy/paste the same code for setting up the
hostapd instances and this can cause problems if not done correctly.

set_address() sets the MAC address on the device, and restarts hostapd
group_neighbors() takes a list of HostapdCLI objects and makes each a
    neighbor to the others.

The neighbor report element requires the operating class which isn't
advertised by hostapd. For this we assume operating class 81 but this
can be set explicitly if it differs. Currently no roaming tests use
5/6GHz frequencies, and just in case an exception will be thrown if
the channel is greater than 14 and the op_class didn't change.
---
 autotests/util/hostapd.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 3ae8ff89..d6c13e2b 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -281,3 +281,34 @@ class HostapdCLI(object):
     @property
     def enabled(self):
         return self._get_status()['state'] == 'ENABLED'
+
+    def set_address(self, mac):
+        os.system('ip link set dev %s down' % self.ifname)
+        os.system('ip link set dev %s addr %s up' % (self.ifname, mac))
+
+        self.reload()
+        self.wait_for_event("AP-ENABLED")
+
+    def _add_neighbors(self, *args, op_class=81):
+        for hapd in args:
+            status = hapd._get_status()
+
+            ssid = status['ssid[0]']
+            bssid = status['bssid[0]']
+            channel = int(status['channel'])
+
+            if (channel > 14 and op_class == 81):
+                raise Exception("default add_neighbors assumes opclass 0x51!")
+
+            channel = '{:02x}'.format(channel)
+            oper_class = '{:02x}'.format(op_class)
+
+            self.set_neighbor(bssid, ssid, '%s8f000000%s%s060603000000' %
+                                (bssid.replace(':', ''), oper_class, channel))
+
+    @classmethod
+    def group_neighbors(cls, *args):
+        for hapd in args:
+            others = [h for h in args if h != hapd]
+
+            hapd._add_neighbors(*others)
-- 
2.34.3

