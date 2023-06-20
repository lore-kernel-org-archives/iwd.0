Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA52AB3F
	for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 17:25:41 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6300afaa43bso25849746d6.3
        for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281940; x=1689873940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FqNqpbiyzni4ceCI4rxbHhXN8gexS7lan1DRHYgqXk=;
        b=GuyhA9V+0QiNO2Gql6UYzmegbHB6EAHvs8962sILzbve0rdY8+GdBFnmrVF5XegzkL
         hBJGA2yVJx/BJsdy4/XpsM59uD7A44NEM6OxRXRir1AdZ5XQV7TuoVKRPxx80lFj9mNJ
         TmfqcdZSkmfCvrrf++5/hC9KYEMxfJbfrHSM/UD0LcnmPSNbtsqSQrMJmdtKe2iDkdK1
         I/vHGwhxHcT/JHsngXZYDb33P8tLpVtsjapIbFLwXA92bWh+KJKXlzbu12uw2hrxy9/Q
         TvnV+7B0LfjJWLYEmF61s+VKeL/ynMp2CzzN3YyKyjBcsdqPiMfdfktrACRgqyx9Vnzl
         jxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281940; x=1689873940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FqNqpbiyzni4ceCI4rxbHhXN8gexS7lan1DRHYgqXk=;
        b=aTvBjUR0sR18gI4ATVO6uMvQ4dEzKn66fXVnjfXI8RYiKBSEeXuV4JVBl4fbQt77na
         F4zTO17UhxuCDd0KCoAOy6MesJ8fSzfs2h8xPrtvGlrZsD2PPdxCzIt/aUBW7RoJE9ss
         F0Tl6ama6L5KW7T1zETlEt/DLpIX4/KcT+LnPrvEQb5hTAG5mQBFKY0wxm/xsaGMXcHP
         u5u686H5FR7w/b44gxAr+7PSrsFO8Y+QyEgHQOfWpLFUY6VTz+5XgKvtmG2109NI/kAJ
         8xUzs6lVb4MNyckSA1ebP5M9mP9RZValEyaE/ggFST6HzFlnOKiEFU6/1YrDU3GtTl7T
         MZDw==
X-Gm-Message-State: AC+VfDw4qHMxh1qQZ1FHp9lw9VhlZyZE8sdls+jgEXE9vNYjH68sFTU2
	HUviLTVoR00k7Wb+OeHcLX3pXB1/AjNuCQ==
X-Google-Smtp-Source: ACHHUZ5/YLzgtJ4vaYMEy+si5ggR6HQV3K0mwzREmeoLLceguowNT0hyCxK6l1tPHtCGTA8Ct6cTNQ==
X-Received: by 2002:ad4:5fcb:0:b0:615:29ab:e4a8 with SMTP id jq11-20020ad45fcb000000b0061529abe4a8mr18048790qvb.31.1687281940108;
        Tue, 20 Jun 2023 10:25:40 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g8-20020a0cf088000000b006261e6a88c7sm1475913qvk.36.2023.06.20.10.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:25:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/3 v2] PMKID changes
Date: Tue, 20 Jun 2023 10:25:30 -0700
Message-Id: <20230620172533.727504-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 * Pass checksum type to handshake_state_get_pmkid
 * Added back in comments regarding AKMs and SHA sizes
 * Moved comment regarding preath/SHA1 into station.c
   where SHA1 is passed directly
 * The older discussion from past patchsets about preauthentication
   was mostly left out as it pertains to when you choose preauth
   as opposed to the SHA sizes that this patchset is about.

James Prestwood (3):
  crypto: modify crypto_derive_pmkid to take the length/checksum type
  handshake: split handshake_state_get_pmkid into separate APIs
  handshake: handshake: add FT_OVER_8021X AKM for SHA256 PMKID
    derivation

 src/crypto.c    | 10 ++++----
 src/crypto.h    |  5 ++--
 src/eapol.c     | 11 +++------
 src/handshake.c | 61 +++++++++++++++++++++++++++++++++++++------------
 src/handshake.h |  6 +++--
 src/station.c   | 10 +++++++-
 6 files changed, 70 insertions(+), 33 deletions(-)

-- 
2.25.1

