Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06C468D
	for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 18:52:06 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id b21so7059846plz.7
        for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=k8aqrhEoaPAuA620N8ADMiJZfjgQ2HT2qJt5SQQLE2M=;
        b=Jm3Ycc9Iukt5Xiqp4zPGkPDV5ItRzajw92F8jISon3E7m2vXycH7uVP+7O05QlDk3b
         2fdU/HrOwM23uJadEj6if0MJigiqp3SzSdz2z7IsvTDF4RCvOMifocMheZ+mlINm2xDn
         kytJzFiV4PeMAIim4anddMBw1cvbEOfPuSMTNv4PxZOfKYbejFYEQn+R1QZLxp5Gc6g6
         N+/zhZrEaa/4glJb9D1b6bhYplRkUJ+WEy1VbZLpxHDlSKoNvcFhPujS4ubDoNOAtS5v
         ePNGfHZvuQ42LBXHW/xDY9MiFJ3vCf7E8+Bmr+Ndf7uysBTeetpRwavSmj4E8q7EHo6j
         usMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k8aqrhEoaPAuA620N8ADMiJZfjgQ2HT2qJt5SQQLE2M=;
        b=nMJ9TPRRC33g2gPIz/GfO5mYBoXMk5pyLjlmDcnkd3lSFmTjuLxLL3rHbagbg5+6Kq
         qwH67D474sgGtBRGzFXNgtb6mH4c/DBXeuH9a7DO85Xxii/sBQmxwieHsdve8QkiCqHW
         X/PaiW2bPEtPJlJc9WqAXwzJSWqm1cOVA0995aCJZkOk3vWaufexlfqyjDQPWXVMjEsE
         bgEnPiVVQI5OyBMniH7MTEf/mk0LkqWOdh6Ri+Yj5JAHCnRuz48/SUDf5GCgULizm1ZF
         kSu1+GQhVLaGypBS+PtSX4BKjjIrbu1dk6zI+KbIV2qDx+8yNDpjwMlSiSjAj1Z3Aek3
         2chg==
X-Gm-Message-State: ACrzQf0C9Dqv/C6H7maVhk5eMkZ8SEnQ3ZjDVGg2ppOeZ/XEj7fsuo+s
	PvGVQzLYPXQYPMMgLju6rnJoROddd/o=
X-Google-Smtp-Source: AMsMyM4CCaj8Lc2cVA8tggwHOCznk7oVnFD3f9xDTW7Wj2iOJrMsQPqvdfs37oidgLWUgMfwoPFDuA==
X-Received: by 2002:a17:90b:1c8e:b0:205:783b:fe32 with SMTP id oo14-20020a17090b1c8e00b00205783bfe32mr173503pjb.39.1664218326215;
        Mon, 26 Sep 2022 11:52:06 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090b010e00b00202d36b7403sm7111115pjz.25.2022.09.26.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:52:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] test-runner: add custom verbose option iwd-sae
Date: Mon, 26 Sep 2022 11:52:02 -0700
Message-Id: <20220926185202.52479-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220926185202.52479-1-prestwoj@gmail.com>
References: <20220926185202.52479-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enables IWD_SAE_DEBUG to be set in the test-runner environment
---
 tools/utils.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/utils.py b/tools/utils.py
index a1b3e041..a07c3183 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -449,6 +449,9 @@ class Namespace:
 		if Process.is_verbose('iwd-rtnl'):
 			env['IWD_RTNL_DEBUG'] = '1'
 
+		if Process.is_verbose('iwd-sae'):
+			env['IWD_SAE_DEBUG'] = '1'
+
 		proc = self.start_process(args, env=env)
 
 		proc.wait_for_service(self, 'net.connman.iwd', 20)
-- 
2.34.3

