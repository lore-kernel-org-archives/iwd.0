Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728331A8F
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/wDvLnN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-66d0169cf43so46370476d6.3
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464122; x=1700068922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocbSyIuDMHivK+9rbtk74SkXgk6QhMWhxVluwON7zFs=;
        b=i/wDvLnNupyVtYwihOCjildTOPS7Z3G8DS8KaRph3QSLQ9hRVReNS2oF++bC+p8GTF
         jJ8KD1KLc0PAJuTwdaq6txBlKng8nXaTKLtdEVpxMaGPKKM6ieiwtWe/QZJaV3KMQlr8
         LXPqTFMU+PnDrrM0e3jBs5G4UG05Enssd9Zmbk1tmkJGHtgB8pZNJznK5yjwfOexbyx/
         DuTwfKG0SLtZVsAjU3+gxdFCqnLym+gx8wc9AXF6Vc77Yd8UVIioEe3q0VS9zxY8H3rG
         KM2XOSvNpSRXjrtkhx94YYtLkedfETBcDH2GO1Vakb2qvAQzyvxFUXNY4EYVPZv1adPp
         4FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464122; x=1700068922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocbSyIuDMHivK+9rbtk74SkXgk6QhMWhxVluwON7zFs=;
        b=Lr6zcVwJgRUm7MXd/mHSpVs3rwwhbMxpMJCCZU8UteMiNDj+eHxk+1xedZ7CDvZAWJ
         ZAOFZVEOwjeuBUokrTeApxeIcUEK9lj5kdOrbHa9Wcu+78caUKgJVpNoWE4DAlRJX7sz
         z2ZJKMVtrNYDtG1oPdYzYcL2je7bCcfdisIEh4fRUCnqWq8k8bO8tuBxD26Kczn3SwrM
         iGGnJ09s8e6VoXtqTNaTBKZDJKmtmGgk01qtVS29KaGO84yX2a04CCJQJuDcPZHvLNB4
         rsZqcuXwTkkUi17gOP2YndAczJKG8Pn08sD2kfCJkoTD3Eu2gLzVmcasM81DQIEIzKJt
         BtEQ==
X-Gm-Message-State: AOJu0YypvGl5+8tqzIeIWn+j0c2vasiJ1VioQt7QEwYOBicWDp2/0ziO
	PnN/uSymd3sCiYNnisqMNcQXowkynaE=
X-Google-Smtp-Source: AGHT+IHo9UK+e91Zk3QOMQNu5a8lShRu7DqzUMVDmg6yMRT0IUfWaszBTfFtnW/QSlFiLttsfGlflg==
X-Received: by 2002:a05:6214:2386:b0:658:3680:5185 with SMTP id fw6-20020a056214238600b0065836805185mr2621826qvb.36.1699464122284;
        Wed, 08 Nov 2023 09:22:02 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:01 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 03/10] auto-t: fix testDPP after Stop() change
Date: Wed,  8 Nov 2023 09:21:48 -0800
Message-Id: <20231108172155.2129509-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
References: <20231108172155.2129509-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop() will now return NotFound if DPP is not running. This causes
the DPP test to fail since it calls this regardless if the protocol
already stopped. Ignore this exception since tests end in various
states, some stopped and some not.
---
 autotests/testDPP/connection_test.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/connection_test.py
index 0cab5ff1..f72a412d 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -148,8 +148,13 @@ class Test(unittest.TestCase):
         self.rule0.drop = True
 
     def tearDown(self):
-        self.device.disconnect()
-        self.device.dpp_stop()
+        # Tests end in various states, don't fail when tearing down.
+        try:
+            self.device.disconnect()
+            self.device.dpp_stop()
+        except:
+            pass
+
         self.wpas.dpp_configurator_remove()
         self.wpas.clean_up()
 
-- 
2.25.1

