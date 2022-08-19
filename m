Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F5748F
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 20:26:27 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id r22so4527582pgm.5
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=aJAxW0gWJNNk5368rOt1KMwDICQXDUBsYyoN+gVSMGgjMAStnIDx6mwYT1TdI353vK
         1gkjKcN4T2L0sKW2aeGYbdHNIaPmscZZ92bf5Xjf2qTqK4QrZAvOQKrDWZRy9/fQ6fKZ
         YyATNZDHhpYWfDP+34XSEzLvJK4LEWImvxYyfElRxv7RdlmQxbM4OSPWFPANFCNYbz2I
         qtTMuklAvuspvvStYTnC220NCwTbVAsywBRBGSzk6nzIq34HH3ON3un6QyPxzShadfyO
         OFPDfd0dJe5IUPGdP31yrWySbL9qhzZX6ctyjuDYS1pbTpdVjwXmdIxqOzgojNaMo5x2
         TGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=KS/atvEMYrIIjH/rxw8vmifMjOcRqVXVg8fkJ6W0IdDQzXmR2fSsB4BLw+P5s8I9KX
         oM0/GI2s9ERtNF3EbFx7xxUxmA5fnSsW97MW4CG5kCWdrtADqbdqo/tfi926P3wd2VBX
         yB4A24gLU1x8oGeww44LE+gssdUrumQZj8xt+6CejaNbuXJf+zBb902boIRLtnEEDPU/
         R8Wd5+Ceg1J1g1O3UuV9yd2OvKNYh4RX4eBPIAsW6Ho0YBs3Ja0MuTiyFyQe5Ij5XiSx
         8p1IrDzVr2cZGg/46dBpZ2r6PxuvklJlUGSGI4jPb5KTXmHaiIcJeE2FBmplogykNRQQ
         46Cg==
X-Gm-Message-State: ACgBeo1SokXLsPntcdW1RrL8ULSLSJRW+dnzIjeUyrwASdUOLZjyybXh
	ng2engl3ybNKoDmiWXJQAkBnl1LIyfY=
X-Google-Smtp-Source: AA6agR50gNylvO307g8NNy4zU+06tVaoXbs0Hib6jphcc9FqJyPSqzU2A9Q5HajH5V+i6G0dzoJeEw==
X-Received: by 2002:a63:4f4f:0:b0:429:f656:69a6 with SMTP id p15-20020a634f4f000000b00429f65669a6mr7545515pgl.287.1660940786406;
        Fri, 19 Aug 2022 13:26:26 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016dbce87aecsm22206pld.182.2022.08.19.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:26:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/5] auto-t: hostapd: add set_address/group_neighbors
Date: Fri, 19 Aug 2022 13:26:21 -0700
Message-Id: <20220819202624.1681246-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220819202624.1681246-1-prestwoj@gmail.com>
References: <20220819202624.1681246-1-prestwoj@gmail.com>
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

