Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780E2F3F
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:42 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id w11so6423676pjh.5
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hArjwqjm8uvKKDh33K9XYZ+JumZH7EBR+8Fdq6BykaA=;
        b=Fiy2IanFT12RVrwcS7onQm3HMVp7eQzSjgRZiFLrMqClSRdFFogYxcFe4H45XsqVFf
         4P/v/vT6eiJeutJwNIpec/iUPar0psqjVJNBPCbmMniyvbEi1025wQi5DCiYKDHQmkRz
         JvHUoOO+rHNw6mikxdFJxqPGe26t6TavuKVH7aM5W1da7UzaX12Zjq+UzlEzyeFtGOiE
         sjjIf+E5NyOO3BvAvf7g7XIRLVqoJXwJLwvSZjJvHcFjSAPyL2dPif4FF3z+wRY2eZ7K
         0HrKb2PrKgvjI2zkJLXwhxfd2S5X6YOyZSZHWIFEeydPqnk+grMVl01B9BdtEbchXEFV
         jUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hArjwqjm8uvKKDh33K9XYZ+JumZH7EBR+8Fdq6BykaA=;
        b=dz8bkiESo3KdZTgaVJtN9V4ChnpW0FMO7F+q48evNaeEjnpCh7/TjfRoIHnuy6TbY7
         /VEQ3uuWnakXm5k9sBTz4JluXDDx3XDyGiM4iyBGaFRSL2Y9AV8wOZvEkTWCp3YSiDoR
         wauOMGBfnUr6QYTLQKLD2OCZyiRjSgBrxOphIGUu1Rg240XlZ1z7bGWDiMui42rlGs1X
         BX8ZUUhr/GhY5COcNbH4hk4sQ6UABVfRV9fZL7eQvxFFBBu8+YrLfHpyfZXQAOny69Ct
         2zMfWv2pOc+B6IA7cTBQmd2ouFBSUF4t1z3ieq8Ia51ay9OjwyA1/cujLUmdGL1L9OJS
         83tQ==
X-Gm-Message-State: AAQBX9fnChEpaTuxuMxgb12tEFPRzSomnaxYGH+DWpmZS38hMH80hhrg
	Bvo2lFQw6SJeBLop323d7+V78G4sDbACnQ==
X-Google-Smtp-Source: AKy350ZyWD8JyTknh2j5okWHkb/7krmSudk0hHHblT7tLGmhqce9S+JyZ0NOLeYhG/2RPnOqEVGeig==
X-Received: by 2002:a17:902:c401:b0:1a5:898:37a8 with SMTP id k1-20020a170902c40100b001a5089837a8mr18354228plk.18.1681164101249;
        Mon, 10 Apr 2023 15:01:41 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/9] Support FT-8021X-SHA384
Date: Mon, 10 Apr 2023 15:01:26 -0700
Message-Id: <20230410220135.373872-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When investigating PMKID derivation issues with older hostapd versions
it looked like SHA384 was never supported for deriving the PMKID. This
was easy enough to add, but in order to test it some AKM needed to be
used that required SHA384 and still used the normal PMKID derivation
APIs (i.e. not FILS). To do this support for the FT-8021X-SHA384 AKM
has been added.

James Prestwood (9):
  crypto: modify crypto_derive_pmkid to take the hash/key length
  handshake: include additional sha256 AKMs for PMKID generation
  crypto: add hmac_sha384 support for PMKID derivation
  eapol: add support for FT-8021X-SHA384
  handshake: support FT-8021X-SHA384
  handshake: remove hardcoded kek_len for FTE decode
  common: add FT-8021X-SHA384 to AKM_IS_8021X
  wiphy: add FT-8021X-SHA384 to supported AKMs
  auto-t: update testFT-8021x-roam with SHA384 test

 .../testFT-8021x-roam/connection_test.py      | 18 ++++++-
 src/common.c                                  |  1 +
 src/crypto.c                                  | 20 +++++---
 src/crypto.h                                  |  5 +-
 src/eapol.c                                   | 13 ++++-
 src/handshake.c                               | 49 ++++++++++++++-----
 src/wiphy.c                                   |  6 +++
 7 files changed, 89 insertions(+), 23 deletions(-)

-- 
2.25.1

