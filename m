Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359F612D
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:14:03 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1364357a691so4734842fac.7
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4qCZyjaDNColV29S3cX/gLW4CzvmVP6huDOAyIsec8=;
        b=SnzYYPjs2FEYfQuhdtecTIo0qjR//j+Qn3cgOkaun/68nBSJ76oS4LXGg1zpE5+uBU
         b5DuRy4oOk3/+Kgq/pecRcoeJLUp8DY8yebavqXo3dTSjELpHSvx+fMoD3LMAjExvqVD
         S9ckJHBvRyUgV9irfpgz5Ugd96NNjp3vR65sIinL7GZY5aciZiI9fHeSa9vkdKyaibgO
         aaR1Gs8TCKInTR8ILFreIeWopgqVAmt7DuF8jiFh8R0rqMx/RmhfVX29BOg5JNAxoP9a
         8TqJQIHZ9f1CHPkYMa2WeNTTvrWxBzexdRgow120bz7RJqTz3AJ6ngABcoqXLr+nCsD5
         RMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4qCZyjaDNColV29S3cX/gLW4CzvmVP6huDOAyIsec8=;
        b=FmYiPVWidDljDguJV1YciseyXBUu/gBWjcN2Pd11eArCW6LQHKGFInOAUjciFx2lD+
         BE/PpIyfWhTsIQDSYJcJnDf3cErZd97KlCMVe4P23nqslKP5GBtZDDZLfwH7xSGIx7Xj
         6eWhRnxd6KtgkfQbo7Xmpnpz8kJ9FpxuaRoAdoGLiJq7MvvCYVjAfCg6VtjYstl1vRx3
         SEpg53eWBxfuNW9V+HeJ1esqdsItapheb+mF6Khza0n5VnPVeGpd4B5X77c1XmAgzS8j
         OXO/tmQuFWNFS0wShFsqQ+i+pGCMhkEmfVAj8ehzN3E3RH4hUL2YGCe5aZZRCQfsgwYy
         DCsg==
X-Gm-Message-State: ACrzQf0Pv0RNpGtyP4QbdEWTniQrf/GLJ+V49rc6vmLnWZPfkfcet/F7
	HkHD5yTOKrtNAW5AURtXCatYjX8Bi8o=
X-Google-Smtp-Source: AMsMyM44N5gDCvxKf7NdEIm1HPl5+XPg+sFWvnguJlPlic3rPFSyhucKsT3HB3NRSV6EH+TR7MSNtg==
X-Received: by 2002:a05:6870:738d:b0:131:f040:fb49 with SMTP id z13-20020a056870738d00b00131f040fb49mr29683297oam.253.1666379642266;
        Fri, 21 Oct 2022 12:14:02 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:14:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 22/26] auto-t: Add GCMP|CCMP-256 to WPA2 test
Date: Fri, 21 Oct 2022 14:13:03 -0500
Message-Id: <20221021191307.31492-22-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testWPA2/connection_test.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/autotests/testWPA2/connection_test.py b/autotests/testWPA2/connection_test.py
index 2cbdf8e1b788..a5a655f58795 100644
--- a/autotests/testWPA2/connection_test.py
+++ b/autotests/testWPA2/connection_test.py
@@ -54,6 +54,18 @@ class Test(unittest.TestCase):
         self.hostapd.wait_for_event("AP-ENABLED")
         self.validate_connection_success(self.wd)
 
+    def test_gcmp_256(self):
+        self.hostapd.set_value('rsn_pairwise', 'GCMP-256')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
+    def test_ccmp_256(self):
+        self.hostapd.set_value('rsn_pairwise', 'CCMP-256')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
     def setUp(self):
         self.wd = IWD(True)
 
-- 
2.35.1

