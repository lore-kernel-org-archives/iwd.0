Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9754A2D
	for <iwd@lists.linux.dev>; Fri,  9 Sep 2022 16:07:06 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id c24so1980417pgg.11
        for <iwd@lists.linux.dev>; Fri, 09 Sep 2022 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dKWryWbj5Np598O2h8N+Oyw9Cf+gv62I5NbZlj9W4xc=;
        b=XQli1zlOt8UnlxWzeUXa6ZAXf5Mm3CmHRWVE1cy7VUgM+MxeXPN1qZRkeG/WNLg0Yx
         cvz4aP8Tly9VlBOcetpthk9W0tYySd0jU3WJCX1ibF7ZgVVf9VArqzxYEEicYxhNHjFm
         1VA8iPdaQ9vanWAOAicJZ1k4OJLoYmacsfUrZIQ1tXoefNT4H+W+ThTdez3jRpPONI1G
         A8hMPYCzMHyadWuBEI5V3SVyrq4LQomjHHqF2T9RWMnUHbopRI+JdOXKP3SVT4vJibBj
         E8v2BdIOuEnF9ewbos/pF/6CKJ5FrlG7EAxJTXwFlzZ2hsbaA0dxh6xS9XBBviOr4SH4
         EHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dKWryWbj5Np598O2h8N+Oyw9Cf+gv62I5NbZlj9W4xc=;
        b=4Pd9uek34lrqqEsiXQlRz7taFI+J4HkwRbymonpfkWYz24vs8oN7fHqmWDHIvJ34pR
         mv89GjMOg8YbnOUbmbiEQKHKV0dgsN0N1NnReuvDLw1+nfcHBiSXZ0ozwMODeD3baEs6
         IImdFL6ub2nrVXq2FMIMvasWHOQK9AA6drqq6dd3f2xvGUgrMLxBYIT6HeSABih2N4e+
         MvsxiCC9ZHKF0pmOlnhjPQcmFRijsRRLfwt7/OA5e1WQB//uxEBl4NBNe4KTJEHHqwC8
         ynK8qRvHe+jAcAsamZ2XvdKbL3lRtpcOF2wvzanfH4MpW1YspTOsN31bHf9io5KU9bca
         zeNQ==
X-Gm-Message-State: ACgBeo2BEiVY0FZJ6jjdYmPwGXsAddk4ip/hTgtETl2WW21198+ZcAsd
	ZRspY8d26qEFfhtFiTyM6aaCKTIHpFQ=
X-Google-Smtp-Source: AA6agR7jrhP6rUPmv+dtwrLDprOC6BJzArtyYW//e6JNF2o9xpeQHuOC4eM/Hb5/CWt2oKuiCSaNJA==
X-Received: by 2002:a63:e352:0:b0:42b:dc03:cc38 with SMTP id o18-20020a63e352000000b0042bdc03cc38mr12314727pgj.545.1662739625562;
        Fri, 09 Sep 2022 09:07:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id c3-20020a654203000000b0042c0ffa0e62sm684144pgq.47.2022.09.09.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:07:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: remove ptk/gtk rekey value for testPSK-roam
Date: Fri,  9 Sep 2022 09:07:03 -0700
Message-Id: <20220909160703.490083-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When timed very badly the hostapd rekey timer could kick off
during the roam scan which ultimately results in the AP
disconnecting since IWD cannot reply to any EAPoL frames
during a scan.
---
 autotests/testPSK-roam/ft-psk-ccmp-1.conf | 2 --
 autotests/testPSK-roam/ft-psk-ccmp-2.conf | 2 --
 2 files changed, 4 deletions(-)

diff --git a/autotests/testPSK-roam/ft-psk-ccmp-1.conf b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
index c012b4ef..4a2ceba5 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-1.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
@@ -13,8 +13,6 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 rsn_preauth_interfaces=lo
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-2.conf b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
index 84875fdc..a42e175d 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-2.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
@@ -13,8 +13,6 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 rsn_preauth_interfaces=lo
-- 
2.34.3

