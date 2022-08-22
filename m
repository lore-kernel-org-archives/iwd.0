Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8946AB
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 17:01:54 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id pm13so2670238pjb.5
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=F+5zSIq5EUWCPNwuT2nAmr7DPYxXlKj7FsAszUjtLom/SD79UX9dbB0YDnW8nZfA/t
         AqX5v/SBLVB5taHPDZbWja2pz/jRyObo5o+wikGQG4Nw9jvpbAilwmlf/83vW3PcVr0m
         Appci41e+8zx/L3NsCjEDOetasFTB/LwmmYhqZaAJwjX8RcopttxQ5nicCPzKD7RrfHv
         jkWvnZEQzq/XbDEBtLkIq1p4embSR9nmWpTRp0QPI8ew2JJaldCUYgcjs/dawRMfw2c+
         zJRhtWeDuAyfEgg8nyViqz78XZl5VortJNeRgmoT277oHDD5kviamMiRyb6vch6wWcgA
         JqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=HeZwJ41dKcfEZLBbefNcwYIKbP4CjOh3ErEOSB1B5ULeH8gQUh2WZekxvVD4L4559/
         s6t3ekkEMgCP3jWCg3s6AFanSAewz+x9o1XcvKMFM5SdQR0KNdH/BK4wF7oeDnazkZ6Y
         rb+pMzZhuAKofPxH66ASig02RjwQ7xdQzUjmpe+LcQek1HP+AIQAn76lqfcqujMGgYcY
         YdTLvZbLcqZcAKxrc3wVM992TdSKFrppKydwBYkDya2+ggOXrBFemnnlw3EQEI9PMpyi
         jThmFzNwFUyunyRkZh7jxNGLO3bLh7+833DDd3iTdBefaa6R5fyF7sRjtksZxqudoDmT
         wAtg==
X-Gm-Message-State: ACgBeo0ftt5OeN2R7XrVQB2wbqJNL4S8+ALMjuxzull+9mb7igUnPgLp
	vgY3Ux3DjjvK4/wifqycKMqwPC3cy5E=
X-Google-Smtp-Source: AA6agR5pAjAjn0eATHH4pupy57alYFGWYzv2A5uABahFYTvsMozMSVVuf9RY035bi5FDMWdABETKYg==
X-Received: by 2002:a17:90a:4887:b0:1f7:7676:e46e with SMTP id b7-20020a17090a488700b001f77676e46emr29407311pjh.107.1661187714123;
        Mon, 22 Aug 2022 10:01:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b0016ef87334aesm8691002plh.162.2022.08.22.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:01:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/6] auto-t: hostapd: add set_address/group_neighbors
Date: Mon, 22 Aug 2022 10:01:47 -0700
Message-Id: <20220822170150.2049490-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822170150.2049490-1-prestwoj@gmail.com>
References: <20220822170150.2049490-1-prestwoj@gmail.com>
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

