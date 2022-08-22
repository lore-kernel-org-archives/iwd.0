Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC872F56
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 17:01:53 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id d71so9896556pgc.13
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RWhcffeOl0sLwh5sHM/qrGVC2x09eQpm+E1rqtcVqjw=;
        b=JOTx1RZQRsjNcN00sV8Mr8ZrEe8+XDbGVvSd/p6YCMYfegsG1Jj9wdDGhq8WiWLvAl
         vSQPeSbKKYmEyIVKQsz/i6h2VEOSC5jDW483057EmkJV3lqYvro5YKRvIFWq8xcRFREX
         fpyZ6Mkq9XZiGIX0k8zLDKUF9qz1Vy9xPC4bRASL9gS//6jcNRmnBJCeHeoKUFCL9BB1
         KgZuepyKeQQBytlYiswAvg8+7aHwJ6fNRQqk1UbD1shBOT/8nNpIMdH9T070ECj2b4Ja
         Mm5mEh9PSHQTv+l/hBvO2xgw01PxGj1vFtxnu+HBsIB4z37dn+g/m7iVYZ+oULu4z46A
         xp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RWhcffeOl0sLwh5sHM/qrGVC2x09eQpm+E1rqtcVqjw=;
        b=uE5/oVmfnNl8Jl1GVhpJ1ERVxpJj9A/aM86V+HkQoGwbBvvef08UH9WS8gMsHdYFec
         adSCixe7JTyU18OsWZLTLGcuoW7Uoa9mI/i9xyBj5RWxT46SM/0D9nvTSBwyuZm6QUV8
         QupLB1p3NGH0PF7LJwgIPgn9u0LlfyJpkEHilCWNXoe3TpaW9kDBZBiUE5RZG6KihQC8
         X4UWlYaTUqXNoqyFnM47XWdwGUIaifjwYZB+U3QyAFv425ukCshQppzvt8R5uaauwS9j
         SerElfmVWUcXwDFp3tXtpnAPIaa7veDf+HWOq4qVBp7OMfyg/q74UOgovHOtoIPo8gVW
         Wnig==
X-Gm-Message-State: ACgBeo2ZceqKntwuXmEYOc7TiFTsqZ1jNEVxm46Wjf4R79K7M0Va/iK+
	RAPDi6UGU3vEsK74tXxJEAXT/EKrVBI=
X-Google-Smtp-Source: AA6agR63yunTTrdtOVEEW2x81H2/Nyhuk3maKhdzjgmKQ9yX3SPmCwMl5cOz7/NdoklaIK8Ijs4CeQ==
X-Received: by 2002:a63:4916:0:b0:427:d463:55e with SMTP id w22-20020a634916000000b00427d463055emr18165030pga.374.1661187712552;
        Mon, 22 Aug 2022 10:01:52 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b0016ef87334aesm8691002plh.162.2022.08.22.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:01:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/6] auto-t: fix unreliable behavior in testPSK-roam
Date: Mon, 22 Aug 2022 10:01:45 -0700
Message-Id: <20220822170150.2049490-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The packet loss test had a few problems. First being that the RSSI for
the original BSS was not low enough to change the rank. This meant any
roam was just lucky that the intended BSS was first in the results.

The second problem is timing related, and only happens on UML. Disabling
the rules after the roaming condition sometimes allows IWD to fully
roam and connect before the next state change checks.
---
 autotests/testPSK-roam/connection_test.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index c926e255..364f75c2 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -55,16 +55,16 @@ class Test(unittest.TestCase):
         condition = 'obj.state == DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 
-        if pkt_loss:
-            self.rule1.enabled = False
-            self.rule2.enabled = False
-
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
         to_condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 
+        if pkt_loss:
+            self.rule1.enabled = False
+            self.rule2.enabled = False
+
         self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
 
         testutil.test_iface_operstate(device.name)
@@ -197,7 +197,7 @@ class Test(unittest.TestCase):
 
         cls.rule2 = hwsim.rules.create()
         cls.rule2.source = rad0.addresses[0]
-        cls.rule2.signal = -4000
+        cls.rule2.signal = -7000
 
         # Set interface addresses to those expected by hostapd config files
         os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
-- 
2.34.3

