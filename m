Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058734CF1
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+baRH76"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6c431ca7826so1865391b3a.0
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700230352; x=1700835152; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNqI475HOit2RPlWZellSZ1sJnbM27dbXgbDlmEptVk=;
        b=f+baRH76xJP4IqiFVHFGx9gu1rmrfM3yPfhXnbxJ8XQZFDrxYFm4ZdBzoSkQs6lLo+
         sCCGdycKXgDTPcbWgxQCCJ4Z5g7mkqzBiR0g90631xMAnelM+6dWu1kwNZMAMIRl7ett
         ol+vncXSCPyj2734fJZ/9ojcXx3YaDkUaav7Zsy6c8lzb+MsSehjXnj2AEGKbtQET1x/
         +QxPrvd9eAs7f0aBNaZDGfekLJC71kXp5fCXLXTYdIYZKQbrmRODiBh6E6lHfDgdW3vf
         R9AblBTrI5x2p0p6xaz7b5a1VeCRLOrBQO7Q/61GTJvwZUa+sLH+Llg1MRy6X11unsWb
         /9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230352; x=1700835152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNqI475HOit2RPlWZellSZ1sJnbM27dbXgbDlmEptVk=;
        b=JDwGAawIgS4NcRRL576Nqx5hLNL1vE1fygbLeN+3uF1BhE+2uiha7l2gETJz+wbyD5
         vkvBtuLc0k+4ke6pHP3eoKdnKC0HRSZ4zljIV7Q3UsHBQ1oyFfMUrV6ZEfzv8MfVvvBD
         /0b/wQ8m1tBPNll2XUC/WPw9B5hxW/0Mo5aYoiHXbKZ1GRvIgnHzx8X/k9/68pOSWLUm
         LmH7O5CRbsM+ATIXHWQJS91rsSyq7/NWCPR2tPS3lfovoh73kDv67/G0R74HbO2psHr6
         muiJuzLaO3lGJFOqUBBl1m+EDl3d2zqv3fXvqwsKZV399CrtlxNoFj6xBQ8fxN5bUJvX
         AFxw==
X-Gm-Message-State: AOJu0YwcK6dqu8yU4FW5XWPe4NnX2v0ICMfNcLfp47zUd+T4/bFKcWFz
	HDP6R1IMA73cUmx1lJ+BQ2RKjDZugJZwPQ==
X-Google-Smtp-Source: AGHT+IFCcAKp1eTX7XP2YE/i9PcwC8r+xK1fa+5M89lgJ6CJIw/xkIiWsy1YGMxCLVTT/CV4Cusabw==
X-Received: by 2002:a05:6a00:179f:b0:69b:5395:59a8 with SMTP id s31-20020a056a00179f00b0069b539559a8mr21176123pfg.34.1700230352323;
        Fri, 17 Nov 2023 06:12:32 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79398000000b006c4db182074sm1447897pfe.196.2023.11.17.06.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 06:12:31 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: add checks for DPP 3rd party settings
Date: Fri, 17 Nov 2023 06:12:26 -0800
Message-Id: <20231117141227.60722-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141227.60722-1-prestwoj@gmail.com>
References: <20231117141227.60722-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the newly configured profile contains the additional
SendHostname setting that the configurator sends.
---
 autotests/testDPP/pkex_test.py | 6 ++++++
 autotests/testDPP/ssidCCMP.psk | 9 ---------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index 6c5cf054..9e0b5dd8 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -168,6 +168,12 @@ class Test(unittest.TestCase):
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device[1], condition)
 
+        # Check additional settings were carried over
+        with open('/tmp/ns0/ssidCCMP.psk', 'r') as f:
+            settings = f.read()
+
+        self.assertIn("SendHostname=true", settings)
+
     def test_pkex_configurator_with_agent(self):
         self.start_iwd_pkex_configurator(self.device[0], agent=True)
 
diff --git a/autotests/testDPP/ssidCCMP.psk b/autotests/testDPP/ssidCCMP.psk
index d428fd34..a82324c8 100644
--- a/autotests/testDPP/ssidCCMP.psk
+++ b/autotests/testDPP/ssidCCMP.psk
@@ -1,14 +1,5 @@
 [Security]
 Passphrase=secret123
 
-[DeviceProvisioning]
-SharedCode=secret123
-SharedCodeIdentifier=test
-ExactConfig=true
-
 [IPv4]
 SendHostname=true
-
-[Settings]
-AutoConnect=true
-Hidden=false
-- 
2.34.1

