Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041426BD9F
	for <iwd@lists.linux.dev>; Thu,  6 Mar 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287335; cv=none; b=sQzyaSCW5vB/kXs2pHbL5ujn8yk1ZdHw7O/4G2bQ9LKBZgBvtZuoOhF3Rhy7oUGWyvtyLV7cm7/Qa9HpuPADti80aCqf6FB3FsjvWjDh+FGhCKpxsQyB9VbapogorLeo3S+uWDbmeKuTh1+Ryc6lKAonpwUKJ0pdLIiTlA0V624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287335; c=relaxed/simple;
	bh=xCbiKDZzlTQRwmKuUYnbKqEsgeWOr+3hJSiSbJ8ylJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SUouaTpdkNkoKPDkB0ARyrjjdoOqTux2KrmY8ZF2gHryDmbEy0hTQF0xs7MIv4Nbtd15mnnf4TTcyWnXW0PHWMj/R0hybO5SHSH/NeylnBxlpWgDxLfLI7+972cukmVD2bxVym7fMqe09bnUPMRj48hbhosFwEwuZUs8Rqcs9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHjTBqNj; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHjTBqNj"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c2303a56d6so117700685a.3
        for <iwd@lists.linux.dev>; Thu, 06 Mar 2025 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741287333; x=1741892133; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8B4+xLprTJdM+mCL7geno4nxmQxZ2p3JXdPa9g7xLtk=;
        b=ZHjTBqNjuitUjwS44FCEMH6RHyy4pVkBZ/8A/H7OJFjrEjLYK0XcIxOwbHkabAne8D
         QrNhlpKHVtGIQtpACZMsxbSz9l0JXgf1za7UdRaM0NbUDS4FiqNyrJRJnru8AU8iiQsa
         9LSV2j0iAW+LejKGd+rd0yetWvq2qEpsb7jGB11hOzlCxTVOJUcy7cNt5jnA/Blo3Joe
         uBCdDGWIRdpL/GLaYxM931DHYmtIMbZ3dMnShoemngm4HsTjjVRgXW+EoNY5W0Ls5HDa
         XcCAZ8vWKeZidfyTRt4OLEpdtrTtF0X3WApeRiKs70YZNXf+/ckpe+U1UnZk0uZifFCU
         3B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741287333; x=1741892133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B4+xLprTJdM+mCL7geno4nxmQxZ2p3JXdPa9g7xLtk=;
        b=hSziBI+Xo5nqoAacG7HS++CKfLjEYldu/ShglCNvaJuL0aNP+3JRuiWuxONj0WWMxC
         MVqRd78zMw6CKsQAW1YGGXTeLLBOxLqoq8e67Yw/Dzc5X29WKUtsm/cUu+MqZmoSUL1t
         /Xvcawlb3VhCtT0x96zvpCkca8XgG3jkhuWg4+3KNfFGnxunTwI0XnAvhSLf9xgJ+hyq
         BHGPf38fo/ajyc3Yir7u9HJuoNYXUuRZwLPgdd4S5BcRZaXsumhmAhr5HPfa4ei7upPJ
         grDZkgO4FPIuhTXktvpQpQtEwKv9sxPIXWjZCigTOZVZyXlvfOOnxSDAAQ96mhZ3LRy0
         UAtA==
X-Gm-Message-State: AOJu0YygskUDMlRiEMCVpLUwTgKTDQfE5KEWbvxM3B6ufQMPQB85gijo
	SjMlIsf4PR7sSZPYr7f2eox42Us4G6BvX18areYP3jz/wNgRngiylMZ8Ow==
X-Gm-Gg: ASbGnct9xUDrIPtOdJWhjhcdG+IpZE3q3NA/U1q7oAoGdOabiQvj9dP5TsEb2CdJjfu
	jvTYBXgI1Sgbbh6VcLxUfBfc65qLiRpiCEsif527D9GZBF55eIgFPx0sPrjNn1guhz7xQqZYrmg
	xGoXQpVfS+qlA/vMFgbKndxz2tucWvyc0PwDUoaJXz19fzxmHGSPFjpTuhdyB5yhsK94OastwDf
	BW9UedfONzavwEoLDj4gr+IzJnqkJx/L4m7vPcU37AqwH1gshZHjBcbxevkkHU3UwXFa198mq9t
	6OsuszJ1YCzD0ippFHhfflV54TS9U3F5azIiLoZx0kKNF3lqq2OYZMc=
X-Google-Smtp-Source: AGHT+IE4ERJ/BiWrefrF42nfffHhrXGrg25TEDQyOX6XMNtfJTMwFQx9dDEDIkwhboR5nsk5KgEttw==
X-Received: by 2002:a37:de01:0:b0:7c5:18bb:f8b8 with SMTP id af79cd13be357-7c518bbf8d5mr2248285a.1.1741287332636;
        Thu, 06 Mar 2025 10:55:32 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e55110bdsm121982585a.104.2025.03.06.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:55:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] auto-t: update scapy imports for newer version
Date: Thu,  6 Mar 2025 10:55:28 -0800
Message-Id: <20250306185528.365677-1-prestwoj@gmail.com>
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
 autotests/testFrameFuzzing/fake_ap.py |  6 +++++-
 autotests/util/hwsim.py               | 17 +++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/autotests/testFrameFuzzing/fake_ap.py b/autotests/testFrameFuzzing/fake_ap.py
index 8ee369de..a9eaa1e9 100644
--- a/autotests/testFrameFuzzing/fake_ap.py
+++ b/autotests/testFrameFuzzing/fake_ap.py
@@ -3,7 +3,11 @@ import sys
 import sys
 import os
 from scapy.layers.dot11 import *
-from scapy.arch import str2mac, get_if_raw_hwaddr
+from scapy.arch import str2mac
+try:
+    from scapy.arch import get_if_raw_hwaddr
+except:
+    from scapy.arch.unix import get_if_raw_hwaddr
 from time import time, sleep
 from threading import Thread
 
diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 5456d30b..df6be26a 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -7,7 +7,10 @@ from weakref import WeakValueDictionary
 from abc import ABCMeta, abstractmethod
 from enum import Enum
 from scapy.all import *
-from scapy.contrib.wpa_eapol import WPA_key
+try:
+    from scapy.contrib.wpa_eapol import WPA_key
+except:
+    from scapy.layers.eap import EAPOL_KEY
 
 import iwd
 from config import ctx
@@ -444,9 +447,15 @@ class Hwsim(iwd.AsyncOpAbstract):
 
         # NOTE: Expected key_info is 0x008a, with the install flag
         # this becomes 0x00ca.
-        eapol = WPA_key( descriptor_type = 2,
-                        key_info = 0x00ca, # Includes an invalid install flag!
-                        replay_counter = struct.pack(">Q", 100))
+        try:
+            eapol = WPA_key( descriptor_type = 2,
+                            key_info = 0x00ca, # Includes an invalid install flag!
+                            replay_counter = struct.pack(">Q", 100))
+        except:
+            eapol = EAPOL_KEY( key_descriptor_type = 2,
+                            install = 1,
+                            key_ack = 1,
+                            key_replay_counter = 1)
         frame /= LLC()/SNAP()/EAPOL(version="802.1X-2004", type="EAPOL-Key")
         frame /= eapol
 
-- 
2.34.1

