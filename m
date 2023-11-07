Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BC168BC
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL4GXW/a"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a82c2eb50cso65173787b3.2
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699376794; x=1699981594; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03+F6QUGBeeHFsyB0PO6qLm9CEVx00FdtKNyOdhb0xg=;
        b=mL4GXW/aZ1bFPo9AoRsKDOoIJSLSYwRRWWGtpVosfqR6MYzXXIzwc+E4+aNew+fCpI
         BXa6YkV7mnLoYmK0UIoQ4w+JZgjU9uYlGdYjdRlOf7FUw6OulFDIYh1VUbKgyktZsUcf
         WvJ2fbirTJBsGzFpuwVRBNL4T+CuVm+YCcBxkjMo0GFT0g3j0j5oCPEbgyy7ITltgQTK
         II9U4Xod45Q972JCccjZqdtUExyjvxpEHUw8JMpU/c638pOAkVz2f09r0SR+jZCQibDj
         eHXeifAIRIfRHH8ayEbSxq2EfxCoiXQTZ0n7EFTZpKRnJZ1PZms7Pe4btCMQRmCJv277
         4fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376794; x=1699981594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03+F6QUGBeeHFsyB0PO6qLm9CEVx00FdtKNyOdhb0xg=;
        b=wwzyzwGW/gsWWLx4SVzZXKRPBO+qbbzX2S+TATeJvcux0gT9m2jhONR5vfySsFlrSR
         j3ef1qI/pSPt9S5W8zQstTragpGV9UB1go/N2Kk6izbhRXBOPOoT0rti30lwF2mPeGND
         xYb0f2kZ/APlitQ5vPX3UM+ORc6PYeNU3oXxPfiMauVb50MgifuBTvvQkTR5sGqWO1FE
         F05Gb5N1jSW+SdAyG7uXDddtMpu5SsFeiLCqGjQs5K9O43MuRhOIvkhwDeioNp4xxMGm
         sfCmgKhBbD6kR01qr51RyetVUBSou5e0MZN0KuxYDIo2FUpEA+cyX6f4fHJeRO17QqB1
         6Xmw==
X-Gm-Message-State: AOJu0YypLXLPP2o5Wy//kjSUBaW+hAzOV79d5iJyeW58TAm5I2jdNuIE
	jVqocisL24fdkK49/9JNygRi0xCcHm0=
X-Google-Smtp-Source: AGHT+IGezKD+5YLsdsSmxW0twX3NEnHJKxxlJ2VKWV6WFZFWZepUqbphZ7rUu74EX9hfCvZM5pnRYQ==
X-Received: by 2002:a0d:d744:0:b0:5a7:dbf4:6a1e with SMTP id z65-20020a0dd744000000b005a7dbf46a1emr10117199ywd.33.1699376793877;
        Tue, 07 Nov 2023 09:06:33 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z127-20020a814c85000000b005a7db2a0dddsm5790475ywa.3.2023.11.07.09.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:06:33 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 0/4] DPP PKEX Changes
Date: Tue,  7 Nov 2023 09:06:25 -0800
Message-Id: <20231107170629.1831655-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 * Fixed minor documentation issues
 * Documented Stop()
 * Removed Register/Unregister agent APIs, StartConfigurator
   will now take the path directly and unregister upon PKEX/DPP
   finishing.
 * Reworked patches to be more sequential:
       1. StartEnrollee()
       2. ConfigureEnrollee()
       3. StartConfigurator() (agent support)

James Prestwood (4):
  doc: PKEX support for DPP
  dpp: initial version of PKEX enrollee support
  dpp: initial version of PKEX configurator support
  dpp: Add StartConfigurator, PKEX agent support

 doc/device-provisioning-api.txt |  142 +++
 src/dpp.c                       | 1658 +++++++++++++++++++++++++++++--
 2 files changed, 1726 insertions(+), 74 deletions(-)

-- 
2.25.1

