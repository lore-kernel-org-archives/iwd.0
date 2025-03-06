Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BFE25A352
	for <iwd@lists.linux.dev>; Thu,  6 Mar 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285229; cv=none; b=KYUfZ0sH7q72FuAmYnvjUNpDVpxxsIF0ZhqKJwVE6mRt+AxJB1Zq5VOue7cbiob7JhaGSZpNw206WjVHQTvTBrQ7bkEqaLSkEbkwiAhrr6zWP2AIlWl65r18pc3Uugqiu4+NDt3vEQUHcg387v7fymMXYpnkO3+oS7GPH3r3blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285229; c=relaxed/simple;
	bh=e+5aBeGSespJGAq9MlIDWjlGFFQV8Y8yEJXsNLBlWkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XghDEt4LCsZ2kwKudEagVLTFEBohCsq3PbZUwQBr7TKAwf5sG07KxKRqH5/W1pmILHZbVe+xzEJXfjo8JM6fTIpZxYs5gVBI0f2c4hjVSkAhWiXFu5GonxWztzfFgfsITx8g76Gy0pMsVUZCE7xWcy6VWAJHMn+PzwC3GAQzKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQU2u/yr; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQU2u/yr"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8f7019422so8767356d6.1
        for <iwd@lists.linux.dev>; Thu, 06 Mar 2025 10:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741285226; x=1741890026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQc6MWmrex2GcirThrqrjgwTU1r/j638BsIpOtv22Rs=;
        b=FQU2u/yrj4ZbpgjpKVHTKUbaByB1/Njzj5qGRjmkXWxvXbTjuhk6weHEuXIctPI9Kb
         OnvuB4m7nx4Gb7byBNZzFXLk6zoVuqezvY2wLxREKuG/GUe8bHiHE8P4jo+R2eOCdMwQ
         CfQ1KSzENAHNRheEa+mp2LeOC+oVcPgcLK8/p+Cc0BxEIK/S4grXMmLTvrgykFcKYbrh
         FfvuFzA9cb58fCDekO8JQZOmUfw+cd3K2pRxc5YMOsS28T95ZcQlLlZNz98UNPw8BuCA
         0pC19CnYmo92TncTCL+kHzIsQhDSpSP1PwW7v9LIrRjX0fcjwQdx7TSw29t4xjgP2S8u
         cEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285226; x=1741890026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQc6MWmrex2GcirThrqrjgwTU1r/j638BsIpOtv22Rs=;
        b=ZHphNy3ha5VumREyqO3VJ7AoZ62HL7mUtbzTXvTJ1xfCPwZZ3wQ8IcgrQwkNKha30t
         GDKKGr+mV5SqjdF8xH6DyE79CRHty3J7SZW1cdd/Ua7QEk+X95gztqL2s8+7ug10w59u
         eWSFnmxK0J1fe6tcZkpT3Sc8sakBbpFvoyLqeumZhWRgmm7rVdGZS7YkjVAkXF9p5PYg
         g48IMUKecVnOWLz6bxe3uhIzQYG9UBRSq643aJOKF5RE4g6QjImn5Qrb8PasVTE31s3M
         OxwnuYjcY/i2Mk1S1e1L7DNUWmmxFI7ExWoo9WuaSlQpoBrlR73pmPo0j5kvEIgfWo82
         Xljw==
X-Gm-Message-State: AOJu0YwsKowopTter9qWfJCAk77g7ooHulqAR5q5jLDfxZRlaA1HIW9y
	M5asPbHW1Unml1J9skFmOzMVFXa8dbYHUcf6iwDqz7l4S1iKwVVU/qi1pw==
X-Gm-Gg: ASbGncvhOU7BRrDJutJio6r5TcsDqE1UQOja2aabCRAR1VcyTD4+emGGoaMddY417nt
	C282tJaMH92zVJqvtnxIdUcLFOKq9zteh35qUO2X9uXQPJ9Z3wtZb+UyKREeJ0M756mfiCwAukP
	hqiwVj2vOK0pr3N8S0WlFEYNLsNBPB9EMgkaIzkBusPjx84ZJHm5ykbbJIJo18EmbtzvUit3vMT
	06u8+8uTYS3Gc9PpbOEMA0j80U/mU1urUEiuNKUNLxtuj0bxow0gWwVMjzeXEXnoWCRjM0gLpjk
	sfs/OZkex9zWtA4wyvJ4sJc7+nlE5B7GDetbdoY5orXbWWR4svNZBTI=
X-Google-Smtp-Source: AGHT+IF1t0Cft8J7hROK+KOYgkTUPNeXRG+GGoG45IWCx+0moc2Qru2ODeDehH9pKD5pEZfCeRr3Mw==
X-Received: by 2002:a05:6214:20c4:b0:6e6:6103:f708 with SMTP id 6a1803df08f44-6e9006cb371mr45596d6.38.1741285226579;
        Thu, 06 Mar 2025 10:20:26 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf47sm9883136d6.25.2025.03.06.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:20:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: update scapy imports for newer version
Date: Thu,  6 Mar 2025 10:20:21 -0800
Message-Id: <20250306182021.328131-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Something changed between scapy versions and now the modules
being imported don't exist.
---
 autotests/testFrameFuzzing/fake_ap.py | 3 ++-
 autotests/util/hwsim.py               | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/autotests/testFrameFuzzing/fake_ap.py b/autotests/testFrameFuzzing/fake_ap.py
index 8ee369de..ddfe2afa 100644
--- a/autotests/testFrameFuzzing/fake_ap.py
+++ b/autotests/testFrameFuzzing/fake_ap.py
@@ -3,7 +3,8 @@ import sys
 import sys
 import os
 from scapy.layers.dot11 import *
-from scapy.arch import str2mac, get_if_raw_hwaddr
+from scapy.arch import str2mac
+from scapy.arch.unix import get_if_raw_hwaddr
 from time import time, sleep
 from threading import Thread
 
diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 5456d30b..8da01311 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -7,7 +7,7 @@ from weakref import WeakValueDictionary
 from abc import ABCMeta, abstractmethod
 from enum import Enum
 from scapy.all import *
-from scapy.contrib.wpa_eapol import WPA_key
+from scapy.layers.eap import EAPOL_KEY
 
 import iwd
 from config import ctx
@@ -444,9 +444,10 @@ class Hwsim(iwd.AsyncOpAbstract):
 
         # NOTE: Expected key_info is 0x008a, with the install flag
         # this becomes 0x00ca.
-        eapol = WPA_key( descriptor_type = 2,
-                        key_info = 0x00ca, # Includes an invalid install flag!
-                        replay_counter = struct.pack(">Q", 100))
+        eapol = EAPOL_KEY( key_descriptor_type = 2,
+                        install = 1,
+                        key_ack = 1,
+                        key_replay_counter = 1)
         frame /= LLC()/SNAP()/EAPOL(version="802.1X-2004", type="EAPOL-Key")
         frame /= eapol
 
-- 
2.34.1

