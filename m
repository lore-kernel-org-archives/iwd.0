Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD567B73
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISmZ6rSr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-425ff068d17so6506471cf.1
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 10:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702576885; x=1703181685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHQHosg5Zj41fusGceU7mz94vvneJxJ0CXEcwdHRAhc=;
        b=ISmZ6rSrjawN0GwXaRqfV18IB3lkpAjsGpjEwLMzcIpjM/QKC+xyxvlQcrZz47uf9E
         WEqlWUPfILyz1/Z9EB2knzSxSZl9G1uTcYQqsZ8JrfgSIolNr9vP3Nbv343MPtPk/heg
         Bu3NtJiHnPGwbOGbuyee7wN9MwO1GVbEm89vvJyeRbZ7PEshv59h0TdeE8/zwacESwzn
         sq8s2uxPRMFK2rHkXtmgEYxUr0ijCculJ1Iw/PcJM9oF9qh+EKiV9yGlWLK7iblfRegp
         PnI/AYNbDICe00/Cp1xzvEqPmVqDAuzfRmQ+CgbB9EMoW9yrh3jyqC2dhUmoD8+g+2oI
         HIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576885; x=1703181685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHQHosg5Zj41fusGceU7mz94vvneJxJ0CXEcwdHRAhc=;
        b=vLlzGy+YJRoOH/l3lYbErwjdKQbkeYjqPhoc34Ce7cm0J3cU5Re9pMFTy0Oxa9qfI1
         i4id9+gXP932B1LJMTyKw075fWuAwZ124ynUiGPfsTfnmIPnY0ZLnf+s8aer6tWsm6a+
         l4XTB6mHP3jv8SqSBl2qar1I14fPeaHs9j3dDFYS/+/swooFkZKaQmFSSAaxuD6B7crk
         UGm5PfuP2pzSBE3IcRea0L9FcVOwjnXlX9JlD+/MSvo62dH/0gCdn0YYo692oKYZx4d0
         BCdfzHB5D+u3PqFWtmOkZLgsvdGBceNFR7KNnPbQTJ3m8qaae46Lf6CzLT6WN6KH5EvE
         Jh7w==
X-Gm-Message-State: AOJu0YyYnqqecK8KAcClo+Qjgp8cMQHxbdRyK29On+DgaJCBznAkHH6L
	badFp19DFzv/x0d6ngIGOvNZ0Y8brOw=
X-Google-Smtp-Source: AGHT+IH6ycqSGRHzn3M9oiJrYwPpg3JTer9+xJhQ+gCXo/6HovzzRfN0XLMi6RnZu/bhTR5Cr6sbHw==
X-Received: by 2002:ac8:5707:0:b0:425:4043:1d7e with SMTP id 7-20020ac85707000000b0042540431d7emr13073789qtw.81.1702576884997;
        Thu, 14 Dec 2023 10:01:24 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o8-20020ac85548000000b004257bf9a394sm5949511qtr.14.2023.12.14.10.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:01:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] network: remove 'path' from settings_load_pt_ecc
Date: Thu, 14 Dec 2023 10:01:06 -0800
Message-Id: <20231214180110.130991-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path argument was used purely for debugging. It can be just as
informational printing just the SSID of the profile that failed to
parse the setting without requiring callers allocate a string to
call the function.
---
 src/network.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/network.c b/src/network.c
index 79f964b2..41c5460b 100644
--- a/src/network.c
+++ b/src/network.c
@@ -556,7 +556,6 @@ int network_handshake_setup(struct network *network, struct scan_bss *bss,
 }
 
 static int network_settings_load_pt_ecc(struct network *network,
-					const char *path,
 					unsigned int group,
 					struct l_ecc_point **out_pt)
 {
@@ -581,7 +580,7 @@ static int network_settings_load_pt_ecc(struct network *network,
 		return 0;
 
 bad_format:
-	l_error("%s: invalid %s format", path, key);
+	l_error("%s profile: invalid %s format", network->ssid, key);
 
 generate:
 	if (!network->passphrase)
@@ -656,12 +655,10 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 	network_reset_psk(network);
 	network->passphrase = l_steal_ptr(passphrase);
 
-	if (network_settings_load_pt_ecc(network, path,
-						19, &network->sae_pt_19) > 0)
+	if (network_settings_load_pt_ecc(network, 19, &network->sae_pt_19) > 0)
 		network->sync_settings = true;
 
-	if (network_settings_load_pt_ecc(network, path,
-						20, &network->sae_pt_20) > 0)
+	if (network_settings_load_pt_ecc(network, 20, &network->sae_pt_20) > 0)
 		network->sync_settings = true;
 
 	network->psk = l_steal_ptr(psk);
-- 
2.34.1

