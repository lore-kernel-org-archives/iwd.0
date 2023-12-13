Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7556B86
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGArqCo1"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-423d9d508d1so51864971cf.1
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 09:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488366; x=1703093166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZdR2Y3WTjhHoUByK3zKp5ikwBZKIUwPV1+jmwCs6+g=;
        b=PGArqCo1M4EbxKpf0b6mpUtwcvwkqfgPHKCKNayiUKIJPVJbDuYtoUhRaykUGkG0n6
         0PapSPthnI2Lz1k2yJuBD3v9RFlxF5E8dkl0BvJd+aqk7KXxb73lzwvHfRnjFxjQOZ9J
         2TVnRh7GnBG+36h9HaAbDwlwkfVJm22H0cd+6w0uWTTFKGJzSz9AmtX/YbyXm6JQjFLP
         Sm56yNUalYEQh3OgM/eGS0L4SM4I8zogCrfg5NXLl1530XWCtFCeKYzkgtiUMXvMd2gy
         4E08Jw3tfnBsw/NI7W2JW5oldh4Bh1T0QSZmGj+Q7YQqAC5kNUibq2DdUGIk53+K1Bgt
         NXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488366; x=1703093166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZdR2Y3WTjhHoUByK3zKp5ikwBZKIUwPV1+jmwCs6+g=;
        b=SuS+9rLEHym+flJHaJJi+h/95Sexo4VMjx/X+7XbJjRldAnSQgr2auJpg7xhrJIBNB
         dRGiL39uPVhcxH1fjlKr2CheVxbXMYRc93dpxqnXDKoL4YXhOFmZbRAflzHiwXrw21ck
         sswDdlR9OUkwEptFUqxuZrE9PfVZTja5668xakGda+rxDvq846ehQbULY7eBzXYIpdDO
         oxh45E/FioBYkqHgNiWwuiJjYPQAFaSVQd4kqLbhNzbO67xyg/oRzBWZEzNeSDsLTLea
         2iBU3CdV4+KTPajrJvgwBVChQ5FA6ljZHaH76gSlEUtAkFi5zcuM5Rd2JaBw322A/+FA
         6ssg==
X-Gm-Message-State: AOJu0YymqS8P5vxVEPTP/eIKe5to6jXWgCriAIVmwxtDObzg/Xh4pktr
	QhknnKg152nEbf4TX78jNQwqGtpTl70=
X-Google-Smtp-Source: AGHT+IGP+jdvqnEE1lZFmpf4QTml6DTGZh3FpBJFOVnU41xSI3YQrD32lAaLuCY9Xkffcn9KWeDThw==
X-Received: by 2002:a05:622a:10a:b0:423:708a:778c with SMTP id u10-20020a05622a010a00b00423708a778cmr12225874qtw.64.1702488365730;
        Wed, 13 Dec 2023 09:26:05 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b00425f0ab0393sm556914qtb.17.2023.12.13.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:26:05 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 4/4] auto-t: add a few more DPP tests for seen/known networks
Date: Wed, 13 Dec 2023 09:25:46 -0800
Message-Id: <20231213172546.145998-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213172546.145998-1-prestwoj@gmail.com>
References: <20231213172546.145998-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These ensure DPP works correctly when a network has already been seen
in the scan results as well as if its a known network.
---
 autotests/testDPP/pkex_test.py | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index 9e0b5dd8..07def453 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -186,6 +186,46 @@ class Test(unittest.TestCase):
 
         self.agent = None
 
+    def test_network_seen_before_dpp(self):
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        # Scan first so a network object already exists
+        self.device[1].scan()
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == True')
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == False')
+
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
+        # Check additional settings were carried over
+        with open('/tmp/ns0/ssidCCMP.psk', 'r') as f:
+            settings = f.read()
+
+        self.assertIn("SendHostname=true", settings)
+
+    def test_existing_known_network(self):
+        # Copy an invalid profile, make sure DPP overwrites it and connects
+        IWD.copy_to_storage("existingProfile.psk", "/tmp/ns0/", "ssidCCMP.psk")
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        # Scan first so a network object exists, and its a known network
+        self.device[1].scan()
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == True')
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == False')
+
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
+        # Check additional settings were carried over
+        with open('/tmp/ns0/ssidCCMP.psk', 'r') as f:
+            settings = f.read()
+
+        self.assertIn("SendHostname=true", settings)
+
     def setUp(self):
         ns0 = ctx.get_namespace('ns0')
         self.wpas = Wpas('wpas.conf')
-- 
2.34.1

