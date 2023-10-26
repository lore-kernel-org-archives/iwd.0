Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EA156CE
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7NpFiC8"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77896da2118so99917185a.1
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352025; x=1698956825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CUjuIke0flnX2VKHp3ig5RH0HR9McZhH66dBhM3Qe0=;
        b=g7NpFiC8OtEEKYyQB0BCQdY4KY/VdgS8Pt6hhHcDz1DEyVRKcvRhWnyN9dfKan+f1Y
         7lL6Us8AOvb1P4+91LH5nZzguNGvaMG2GVph3clIDIcM5j/MghooPzNemeWZVZw+dYR4
         DcdnJQuF9nywxnMqH/zCGn6QCne6KMMAL704u6zO+y6KzC2mL361kwnIxTKt6qCcw3Xo
         4693LuLb6Pxsj8iAS4a3r6XWRf9doIIlfWiAkcOoO9VapqdxCudZigxm4pnyXubGPU4D
         KfcxVYDgkBXPmXLoHQ0A4K7kGkJLz3BkaVdA8brVIchnKYjOexcAEPYTnvby2/+j8cF9
         QVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352025; x=1698956825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CUjuIke0flnX2VKHp3ig5RH0HR9McZhH66dBhM3Qe0=;
        b=Q+ShmGMCl+/l8u2NVh81+h7tpZAYPB6evsQoxjMOF0ZMKXISY9erettUO8FACbbkfc
         RPYoZEYQBfcQTjSwEjGTBKyYD0DZdy4agBhULqr2UVpsGaftMiqatWgaIercNphPEmvc
         IaKPgQFtOk2l/wWJhexub3f/DStUQLwxpEEVtnFj1vfJWcgFbKVMZhXmu+tkEVRMDiKt
         jQxP0Z2HUQLS1Zb5hRZ6bocdTMM8z4FWfXB10o95CA3s6Bvy/98GsoFhxEa5E94Vtdhj
         83Nwsdu8x/FD+mRg3pGi1zMFSVmQnysjP4AtzqFvfOR0nfq/HHyI+vn3m1lkcArf29CJ
         YsXg==
X-Gm-Message-State: AOJu0YwTc9Mq2j4MTNPSl+IifyL6VhgIfJntyc+n4NCe9uPqYDYpYDnY
	fCycNwekjoK41bz1u8hOj3uc9jdFQ88=
X-Google-Smtp-Source: AGHT+IEnTJPbdhlEcoHZJ4iGLDLmBO4jSffDeBfi7Vdav52/wi8hsXkKj2oRE0HBv1N701SnUBEFXw==
X-Received: by 2002:a05:620a:400a:b0:777:65f4:3468 with SMTP id h10-20020a05620a400a00b0077765f43468mr465984qko.67.1698352025488;
        Thu, 26 Oct 2023 13:27:05 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 00/15] DPP PKEX Changes
Date: Thu, 26 Oct 2023 13:26:42 -0700
Message-Id: <20231026202657.183591-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 * Mutual auth/PKEX unit tests
 * Several more prep fixes:
     - Station state issue post-DPP
     - Config request header check problem
 * Reworked DBus APIs

James Prestwood (15):
  station: add station_get_autoconnect
  dpp: remove connect/scanning and resume periodic scans after DPP
  dpp: check configurator role in config request frame
  dpp: make the protocol timeout more flexible
  dpp: fix config request header check
  dpp-util: add crypto for PKEX
  dpp: support mutual authentication
  unit: make test-dpp key derivation test more extendable
  unit: add DPP test for mutual authentication
  unit: add PKEX DPP tests
  dpp: allow enrollee to be authentication initiator
  doc: PKEX support for DPP
  dbus: add SharedCodeDeviceProvisioning interface definition
  dpp: initial version of PKEX enrollee support
  dpp: initial version of PKEX configurator support

 doc/device-provisioning-api.txt |   67 ++
 src/dbus.h                      |    1 +
 src/dpp-util.c                  |  275 +++++
 src/dpp-util.h                  |   35 +
 src/dpp.c                       | 1705 ++++++++++++++++++++++++++++---
 src/station.c                   |    5 +
 src/station.h                   |    1 +
 unit/test-dpp.c                 |  349 ++++++-
 8 files changed, 2243 insertions(+), 195 deletions(-)

-- 
2.25.1

