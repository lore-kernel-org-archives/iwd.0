Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF73B7BC
	for <iwd@lists.linux.dev>; Tue,  3 Oct 2023 19:24:59 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso9919775ad.1
        for <iwd@lists.linux.dev>; Tue, 03 Oct 2023 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361099; x=1696965899; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tcCDOTf3PNNvGiaBmkAX8LZIzSJxLFQimrYvQ/sOs4=;
        b=ZOPX8gOluJmmVSf6P5K5+PHXCwetmrukXmdGxXyPCOPCBLSzj9gpkpz04D5V7YUhVs
         E3M9Nutn+jRjcT1xgFBur9dGJok/MEVocsUzKOd6OsxySiT8t/Hc/oFXrJrWJqtqaCxc
         LDHad/ISFcTsS0CfWYk9tZR9s5F1W6WabL84X5ZsKdBp5xoR7ErknxtwUpX3amdSGuYj
         L0f9xLzWnXOTNQOAxf6ga4WaLQHhd+b7XaCEJJzb7uDYHFRTeje527RBVK87c6TkM7av
         i07IB8n/+VDZ6YnUSE7UFC+Wt5/WCk2/jyjv/qPTdlhscjd9uJkOLGvHD8qjUrG2pRh+
         5Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361099; x=1696965899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tcCDOTf3PNNvGiaBmkAX8LZIzSJxLFQimrYvQ/sOs4=;
        b=SNDOQTa7fF3pU9d1dAKMY8H+yra62VtXWS5dPRojOpoRREceivxDsRH1wuU0UNY1xf
         S9uoJhiAlSzvYBrPXyml11TOC7OCbaM60A1fsjioFnL/g3xXlMwnv23T6quWtgNBRfF9
         MTBVd2OiLAfynC4HSLRhw8J1kWPUDoyWUtpqG7nI/fzbE4dK2r1yGMDWZwtpBy6jOpWB
         TR8a6L2Gm03h4v9F++J/UNIASRKOgve3by/ewftZ8naLCRJg2P/FfMTOhpb5nIfZK+G+
         5BEkijW52a3V0XnTswznViJ1LhEwf0U/t1D/O+ZuKUbF4Fdl/ohH25Fjmd1SSo5xZvwd
         QVcQ==
X-Gm-Message-State: AOJu0YyCLVSNHSZe59/XU2h0cHpZCnowLB4bYNXm84Tqxcn+I6qbtrue
	C2c5IdnhSzJ4csJyeTFnNDE4k0E4mWc=
X-Google-Smtp-Source: AGHT+IHWSIjmuJ9zZHii6rDEIHLN1Bk5r7rT2sXjQbavmB5qJisnQ0r70ZCJLzyfZIbK+/jKiUV6Ug==
X-Received: by 2002:a17:902:c40a:b0:1c7:5a63:43bb with SMTP id k10-20020a170902c40a00b001c75a6343bbmr732214plk.8.1696361098852;
        Tue, 03 Oct 2023 12:24:58 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b001c75a07f62esm1982533plg.34.2023.10.03.12.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:24:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] build: install iwd-decrypt-profile
Date: Tue,  3 Oct 2023 12:24:56 -0700
Message-Id: <20231003192456.4038590-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If profile encryption is enabled its not out of the question that
somebody might need to decrypt it. This isn't a problem building
from source but IWD as a package likely won't include the decrypt
tool unless its specifically copied out. Add iwd-decrypt-profile
to the list of installed programs like iwctl, iwmon, etc

This also fixes a minor bug in Makefile.am which was building both
iwd-profile-decrypt and probe-req if DAEMON was true. This should
be TOOLS.
---
 Makefile.am | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2e962153..ebabcf1c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -378,8 +378,9 @@ man_MANS += wired/ead.8
 endif
 endif
 
-if DAEMON
-noinst_PROGRAMS += tools/probe-req tools/iwd-decrypt-profile
+if TOOLS
+noinst_PROGRAMS += tools/probe-req
+bin_PROGRAMS += tools/iwd-decrypt-profile
 
 tools_probe_req_SOURCES = tools/probe-req.c src/mpdu.h src/mpdu.c \
 					src/ie.h src/ie.c \
-- 
2.25.1

