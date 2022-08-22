Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E02594
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 15:58:07 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id w29so5191277pfj.3
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=Q83fb57H1Dod5vgwgyaDeSezmlP7IW8CElvfBH8b9NJKCucPeeP2X58fw4ezKt3ZMk
         h/muhEqpc2l4jLJNLsCFaaWUR8AGje/jYP2XjuCEQs57MnWmhz0G0DiaBpCgqHXnshvC
         iGldHagdJ7IxeGlztMB76Egxn+CmNysXVe9ASJ3XqeyfO5KzowG2T8UzcIrjA27WTff/
         T05/STYt4fQSbDN4/qdyNNeaxT33oBF0LJLAxZoYuxc8hKqz5t+B8YeegJsJYC0Joo81
         o1eBVciRaF+ZPM0NBMtuiD72iJJ7W6zjYfAuQdW781LPL4uxTRIx3eUjSZLfFzG4NBf7
         273w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cLqZNAZ2bC8+7FrYtP6Gp/ZSnMJLta9rTFEInz1Nvo8=;
        b=d/jA/beQ5D8zpoD4GX7084Al3Q1L8db7kEvlwI7y9jxaqKTDMw8r3WXf2MJEIAnmCi
         4GEfL1yYWouIb9X3w/fZ6aDRcPW/ayQI5d2liFawgcR5z96uMnsCBP+forovdVKPWlEz
         bB+lFwatdLPL277aUdryJ8VLJUfuwTKEL36Z+/KwtRKO6qbk/gvS6KMTj6oRKcw6iMVm
         UXcJkynJAEYjvl5lm8Kodl0/JRvMsozg3xrHNzyrSGhZvx9J6Y310eeq6YJRJVrbdr1I
         EL1stsO+pKifEMKbaZl4otQWZmXOWD4X5UF8Zar8Ro0A6u6u4ehPmmPkFQwN3rbGyJb6
         mJPA==
X-Gm-Message-State: ACgBeo25epa+RLHy3MjaK8wOv9CEd+ocsMyAixd5v6Z46LWNl/u6neG5
	z3QbzKroYH+NQzKfnXfsHKdxfIxNNis=
X-Google-Smtp-Source: AA6agR56UtVL58QfBOHRdLJ2KUygCPNx7VKMtRJTsv5cqcwOiApaX4oSvGb+BwwJPPmhUDOfnh5j3A==
X-Received: by 2002:a63:174c:0:b0:42a:81ff:6913 with SMTP id 12-20020a63174c000000b0042a81ff6913mr8156439pgx.625.1661183887054;
        Mon, 22 Aug 2022 08:58:07 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x64-20020a628643000000b005368192372fsm3216440pfd.200.2022.08.22.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:58:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/5] auto-t: hostapd: add set_address/group_neighbors
Date: Mon, 22 Aug 2022 08:58:01 -0700
Message-Id: <20220822155804.2006566-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822155804.2006566-1-prestwoj@gmail.com>
References: <20220822155804.2006566-1-prestwoj@gmail.com>
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

