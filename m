Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4E14D441
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615502; cv=none; b=ext9uUaL3ZdzkvDwXZVSqN3hoBqHyWGT+5EBTMqmE4rhO+UvPtSwZzgQ9ZFqt2b6oiK7VYy01EOrXm3XRW/ezZwu5B71uQaFf5OMtXP4xRnKoH/0wE9B646hRCb6qydAU2HeBOBJwBrWMblYwj7yf/IpFXlJSrpCTE+upnVgqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615502; c=relaxed/simple;
	bh=dwQbPdnc1FNTeX+J9KjgqKHbfWmrO57tWH3a1XkdmfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5c0Oq/PzZ+R+/WZN4q6ou0m4Z05fRdyC50YMKuPBngqbmSs9RH5O9EBgwc8tCGtd1WmzhyNYq0hGfaGFEviIlOs5JFaKdvJKUggRTa0zR30ogZMVeXkIJwt+BpxyfXgjRzH6QzGswfbpVzqLjB+i7SAc7PtuY+veJL79RKf8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AseBTpHo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AseBTpHo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso24894485ad.3
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615500; x=1709220300; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AplTx8lk3ahbEDq1TvxC/vGihZ2iHC2LpbAOxobz3ZY=;
        b=AseBTpHoa1DCTD5zYyGpo3xAq17flyJQWrjpRFN4qPo4Z9G2wSo3flezx2Z8IqZiWB
         iIzG5AeQ3cbaAsh/VThWzOpmDN0d58FpPugzDcTzhqR42kBcXOYPK4kYtB/s1R9GgIbO
         LpqYN1gC4QD7dCVPqR6PxqkXX895T3VELK1MkMQrnmULcXRc9JaluNat/Ek6sBKuIxkp
         Y+bZOcJ+sAo9/lqFE3FMQoUisc+qB4yE2LPQDO2N+VA3be/4fw2XSspOL44F5P0r9Vt8
         MywAq5T6Ncv2z/B1b3WCvhYmeYfuQnf6LFAtLO0ryknwyRkZrDeFWcIx+qFi1tRRBXBU
         +UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615500; x=1709220300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AplTx8lk3ahbEDq1TvxC/vGihZ2iHC2LpbAOxobz3ZY=;
        b=FhBAzSzne9fbqYCU46DfHPkWq5buDWQczX7q8C7hAgBF6ts+Dd0h9VsgUWSI6PR3Ji
         kiJ9PKfIPN8ZxUytPJg9F24UYCImDghbNr8ZufLLKu3Kf+rumVlD+L0CqodnJ2uw+m3Y
         ACrrelpyD+XCzlBkc58SxvMNYf6rx+bQRJFeEl/eFTVPvkT0hYGwGvwQCBtbz+A9NQ8K
         hwnRzkil6fXR3bZZzYe9dDuKhgq8qJAvuXAVstCkMN80ZeOvui7tXhaoOGiWoXGMqke2
         Q68qmWuJB5sZrquFCOcsmVbu31LqXGnkQ9B0NIx5uot2gNBDNDYgUwrEMNjd/2Nwj29Z
         mwWg==
X-Gm-Message-State: AOJu0YwdA1RhACIm44Y3oytibh8ziEBiwW03na7wQ3M2tAOAZmnPrx2F
	a1qhttiGxL8whusQYWqn/biSV5Cugb3xc2takBeeSnjans8txtaOdC7GEWTE
X-Google-Smtp-Source: AGHT+IGMjPrP1rD9LlmO0vdfZZr1JK+JgqTo+kWQbPd2WW4PA6QBmFwbZKeJC4NXGRKpJEUVC+YdlA==
X-Received: by 2002:a17:902:d315:b0:1db:e089:745b with SMTP id b21-20020a170902d31500b001dbe089745bmr11050683plc.6.1708615500091;
        Thu, 22 Feb 2024 07:25:00 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm10044873plb.184.2024.02.22.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:24:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] auto-t: fix failed_roam_test to pass when run on its own
Date: Thu, 22 Feb 2024 07:24:45 -0800
Message-Id: <20240222152451.1541682-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running this test with others the hostapd neighbors are already
grouped which lets the test pass. On its own this does not happen
and it fails.
---
 autotests/testPSK-roam/failed_roam_test.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 12e439f6..8cce8bb5 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -221,6 +221,8 @@ class Test(unittest.TestCase):
         cls.rule_bss2 = hwsim.rules.create()
         cls.rule_bss2.source = hwsim.get_radio('rad2').addresses[0]
 
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
-- 
2.34.1

