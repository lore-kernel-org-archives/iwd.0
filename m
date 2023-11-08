Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941B31A93
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdCicUvf"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-66d134a019cso48730036d6.3
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464123; x=1700068923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+D6jqKPRoAnLv15gBofvXqWmRGAKDWcecg64WMooVg=;
        b=bdCicUvfYWnCziccA8pM89Drz6q+R2XR3FU4wCEMZA1JLy8wGtXUrJECqbuvqrg21T
         +BbU38YnN7LCNsGK8/KVlSwoVVrcq6NzGmpZg9UgNPKnydGqWaQS3w3aXpFq33p5626J
         G3daXcNHibN0M0BitpDtKnTCNTW59+5S4mUXGkjP2xYAjMBmFkMzrS7suM4rEIkiON6x
         ScgECt2dJwcKE34jueVXoBCBN45aVVyuar/OTpiF0SvIjSCvQPxWt4BkxTu3Tlr9kGlK
         r/1W8BYv3Gq1WfOrYDLcbT4LICtlC3tU540UEUSAMOiLP5NIDFNB0AKCt8rPZrVw0tNn
         v95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464123; x=1700068923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+D6jqKPRoAnLv15gBofvXqWmRGAKDWcecg64WMooVg=;
        b=MeXjBDVnP9AwtSRcMDPW9GZI2uyyG3fMuoce113T4YgzQcqQZAU6u9QX+jJ7iElz0M
         8+4eECl5m6kuxIuZ5Pcxb8Uz+YSP+0uFmiLWwGeSJ1DQ9Fdh8RwD6bRizda50sfeo4Jj
         tp0JehP9xbe6t2rKvW46hbO4Sy5BW/iacddCglllhm1jZtkKPK4u7xKHUyDq7EoAabtV
         mG+EGvKycprUagzB8qBZGFdknTBTnbLvZTWY36MS+JXecTwatPNNLZ06oQYmqgBg0neA
         65pvebrpwrcEssJ2NTA9bxCHg4hzlVlzHDRXqgohtqKFcilkxiYNcRnzUKNuDjQfBpD9
         v3NA==
X-Gm-Message-State: AOJu0YyuNq6kT88IQVPAtviJmBewB0KesgtectpuCRNTBCGE/IHYjM7w
	FlhZcuVXPFrUAnwCRnLjE9M54UuUaNQ=
X-Google-Smtp-Source: AGHT+IH3aTWbtLYGRxEcmBREv+FPez6AfxnYXrLO+/ECC8WutBzrsaep2PLTGZq4OVlLOOsTB+MHPw==
X-Received: by 2002:ad4:5d4a:0:b0:675:6ede:f376 with SMTP id jk10-20020ad45d4a000000b006756edef376mr3030642qvb.36.1699464123384;
        Wed, 08 Nov 2023 09:22:03 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 04/10] doc: document Stop() correctly for both DPP interfaces
Date: Wed,  8 Nov 2023 09:21:49 -0800
Message-Id: <20231108172155.2129509-5-prestwoj@gmail.com>
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

Stop() was separated more clearly between the two interfaces and will
now return NotFound if called on an interface that isn't currently
running.
---
 doc/device-provisioning-api.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index 2a34d4ae..9994aef5 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -18,11 +18,9 @@ Methods		string StartEnrollee()
 
 		void Stop()
 
-			Stop an enrollee.
+			Stop an enrollee or configurator that is running.
 
-			Possible errors:	net.connman.iwd.Busy
-						net.connman.iwd.Failed
-						net.connman.iwd.InvalidArguments
+			Possible errors:	net.connman.iwd.NotFound
 
 		string StartConfigurator()
 
@@ -168,6 +166,8 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
 			Calling Stop() if DPP was started via the
 			DeviceProvisioning interface will not stop it.
 
+			Possible errors:	net.connman.iwd.NotFound
+
 Properties	boolean Started [readonly]
 
 			True if shared code device provisioning is currently
-- 
2.25.1

