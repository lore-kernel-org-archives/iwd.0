Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CC23D78
	for <iwd@lists.linux.dev>; Thu, 18 May 2023 16:50:06 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3f4c8d78a18so23253011cf.2
        for <iwd@lists.linux.dev>; Thu, 18 May 2023 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684428605; x=1687020605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvyiYUqoqdRmkFTliyZi62r+N0b0AOgiyYrPEVc04rg=;
        b=KBu0O/loJc4NcOedbPFA7lcObDpBYhTI8PWRZCsmNw8lvwz7RicLcTv+AYk6jeyhsk
         HfYG/kRpPAK2DTLiQIP4gCAZn3iW8BqjiN+r4sB7dFhJ+aBoLuZ5d3u5X59PaH0t5XkH
         ZzdOY9Kt6/SVLjAOFSMgFby84oL/NbjZSwm3vVIC1ja1IArIrDGzDHMDu+4gxrUia1Rr
         gtGxEub78ccf4DWnycvUy4W5fXuAmSAgQAA5UfGxG60I+W2XxoEQTBSstclZYThriqsE
         +yMy5LZto2Bd84eLOY+R58h82rkjM8L6LNTb+W30JNFzs+ZCkm45wK8c+jZ8EGGqSyZC
         i4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684428605; x=1687020605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvyiYUqoqdRmkFTliyZi62r+N0b0AOgiyYrPEVc04rg=;
        b=NBnttWy8ca1cJgRq62P5McNLHRQ4ocwyzQOxlp1dld+W1k69Q3+iAEVDiIUT29uB3R
         z07+kp5kd6Dsf7Jn13sTZeM9cgyyZBkkazO2taUlhaTUejpwqrh/s7EroKbONvCPlSiD
         HH+lY/A0tjYsNTjDHG8iaVYEhkf5P5dPVCiboOtselqHELp1i0a+OnuDEy2JDIt+M138
         930T3TeYj4jMN0UydvVGjtvsfnj24H4IxC8AvVjvmKoMVMwH/+7g1sypk6TplbhM5rJ1
         9AcgANd2eDjCqhKFmyhtopKXAtDa+PP8GjrzashFCObBh+oLprBepRYBDiLvldppnfFk
         hdYA==
X-Gm-Message-State: AC+VfDyPfb5UIGx4umvumKW187L5iN1laVIV+09cvBkx//TAe8ac8sNj
	s3jhv8fh2ZZyiO92msA4FrAX3H8UtS0=
X-Google-Smtp-Source: ACHHUZ7SdTYd8vPycrHufNt0To+w/TaZDAEvJ+hgvbATLrc5QN8+Iat59lKwz3uqdfyWDC6zy52C9w==
X-Received: by 2002:a05:622a:389:b0:3f5:279f:c4dd with SMTP id j9-20020a05622a038900b003f5279fc4ddmr467028qtx.64.1684428605682;
        Thu, 18 May 2023 09:50:05 -0700 (PDT)
Received: from LOCLAP699.cardinalhealth-columbus.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id cn13-20020a05622a248d00b003f3941ba4d9sm626112qtb.32.2023.05.18.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:50:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] auto-t: increase timeout in testPSK-roam
Date: Thu, 18 May 2023 09:49:58 -0700
Message-Id: <20230518165000.275611-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518165000.275611-1-prestwoj@gmail.com>
References: <20230518165000.275611-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was causing random failures and increasing the timeout seems
to be a lot more reliable.
---
 autotests/testPSK-roam/roam_ap_disconnect_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index 130e1702..b5775990 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -33,7 +33,7 @@ class Test(unittest.TestCase):
         # Since both BSS's have low signal, the roam should fail and trigger
         # another roam scan.
         device.wait_for_event('roam-scan-triggered', timeout=30)
-        device.wait_for_event('no-roam-candidates', timeout=30)
+        device.wait_for_event('no-roam-candidates', timeout=60)
 
         # Hostapd sends disconnect
         self.bss_hostapd[0].disable()
-- 
2.25.1

