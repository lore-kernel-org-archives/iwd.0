Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA251747E
	for <iwd@lists.linux.dev>; Tue, 21 Jun 2022 18:27:26 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso14289281pjh.4
        for <iwd@lists.linux.dev>; Tue, 21 Jun 2022 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SM4wisBz73Gel3yJaay+iHhEVDNgC6KWfn5X7rkRDng=;
        b=OvYK0DDN3AFaz010q1rlvnx8dETbUJc8D32pa2dL0CfNqj4m3fPkhfjHTBjwXrS8e/
         vHhk24/fo5JPkKlSN1ptxyqGHTbdxFWcdAoZzjHfy/7EGiwzwNug/N6mk7luK/1yFq5u
         eSzMIqbATlBIj2S4RIXQ/enZI4PWnZyOEJyqbII9HKU4W0uTCWEtiNEtMeS4DCCq+9w2
         Ufc1a02ze8uHiRVezdMj+Vt1bZInSJZszsrSWJD7SEvgKCXunMwQ3baVc6lSGaVWhJEt
         Z6bufkrtGeIwj55OZd/Ti5rE0VySEzxAhisZgxAmNSf6WAMlibVTuaGsc7vb4sdQvOQB
         52HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SM4wisBz73Gel3yJaay+iHhEVDNgC6KWfn5X7rkRDng=;
        b=n4iSs0nJ5CtT8cGaCk8we+Gqn4bkqQMFO2KawAp72LEYpXW9GPcrjpx31z7nqdUbgL
         OxgrmP3yM4KACZYpWqRcshJogD/Pkdn/QyAjq277dTG/J20XbNRWmCa0okXcmF0RFDSV
         WTQeS1+iJEBn3Uy0sYgEe5cBvIYk+Uh+ZndRsLOm3YFBYiyXVAebGXZxO6tZ6wbHKK6E
         eAVUBcWmkxPbw8WsIyz0sB+9xiJoLBhbIpsiLeP0ALQZ+jkVazGNdM/FBRlHZ7/SWmaI
         qvVq2JOlwDT3kRN88me4eDLBCpCgj6D4jghSp19R6y6QGcc2b6dnzLIB4aQ2lIG+Idnx
         JdQw==
X-Gm-Message-State: AJIora/wjnP1Ixpw4btbGPsd1Gd9D7bMlgD956PAbYkMwUJBH2W1HKe0
	IB5CF7Q3nT2yBIYcaWs0plP1y8Eu4AE=
X-Google-Smtp-Source: AGRyM1tKXuhKeuVDlhdfN1WclH4tpr8/71VqhwjAAgT808LQeCh976q1c094qEvmZE/6hSdeyY6qGQ==
X-Received: by 2002:a17:902:8bc2:b0:167:7645:e76a with SMTP id r2-20020a1709028bc200b001677645e76amr30714535plo.115.1655836045861;
        Tue, 21 Jun 2022 11:27:25 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 17-20020a621511000000b005251c6fbd0csm5622639pfv.29.2022.06.21.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:27:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: fix matching with --verbose
Date: Tue, 21 Jun 2022 11:25:18 -0700
Message-Id: <20220621182518.1308203-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new regex match update was actually matching way more than it should
have due to how python's 'match' API works. 'match' will return successfully
if zero or more characters match from the beginning of the string. In this
case we actually need the entire regex to match otherwise we start matching
all prefixes, for example:

"--verbose iwd" will match iwd, iwd-dhcp, iwd-acd, iwd-genl and iwd-tls.

Instead use re.fullmatch which requires the entire string to match the
regex.
---
 tools/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/utils.py b/tools/utils.py
index 3cee9a22..04f6d910 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -8,7 +8,7 @@ import dbus
 
 from gi.repository import GLib
 from weakref import WeakValueDictionary
-from re import match
+from re import fullmatch
 
 from runner import RunnerCoreArgParse
 
@@ -98,7 +98,7 @@ class Process(subprocess.Popen):
 		# Handle any regex matches
 		for item in Process.testargs.verbose:
 			try:
-				if match(item, process):
+				if fullmatch(item, process):
 					return True
 			except Exception as e:
 				print("%s is not a valid regex" % item)
-- 
2.34.1

