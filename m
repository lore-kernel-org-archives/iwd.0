Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAC3B7BD
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzMFmM3X"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c9b95943beso12148045ad.1
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140918; x=1697745718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NhEb5VyeaKuqNo3M6tifHE8ID/CEvzX7Rf9chPzJ9E=;
        b=VzMFmM3XfeeSJEYes3tXCYsF7lalHdS7oNQ7rEzNEg0JMDtX8dKZX+ZKIlUqk1BAHE
         hGOqVh5hH5aSVDyYeCis81tzMzrnZvou4RHTEjDeBA3wRENLk2FeSzKoEJDtNAFn7k8Y
         J/f2zqOh8jt009LPSgNNHPIu3uY0hcwfMNnVWvAi2jZ0UwKvMvGNQjV83NdZMMr4A8mT
         Em4ynGa+DAfqWbZdvp8SFnnZEPk3KPQKYTslyy1+728LGPS+ulCC6wmYQxgwbZfisDc5
         zu/WevH/3sxKK6pdayfsWhHh00mg3K6dX7bhCtTSkgFo79ZiljL+KO4n4SnnbdA9X6AR
         9gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140918; x=1697745718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NhEb5VyeaKuqNo3M6tifHE8ID/CEvzX7Rf9chPzJ9E=;
        b=JA3UpM1rYaiYhcK8fSkHtUpmxbkV/L/Gnpx9GEeQyGiEQoIDIaRJuI06bulrnkXkrY
         3Qvn6hRZDAVI1w9YsS1A6b99smZpm8f+YwRlxBF/n3FE1/quiAPx1w2zL3Z1SGjoM4No
         CnPADrP8CxcoSwTC0z8uY0EBhZ5GnUxAFgHTaTKYyM/Gwe2qSfEZZpzhUAQD+/UsWGC3
         qMGgdzge2pMJiqKdNNgLHCI1r6/Q4CIZ6uRSCrlBjNkPw0hK2qn7tiVDblkYJIVP48S3
         fQELyuLrkt8pMOGK4s8Zi7ycR6OFubL14Zl8xjEfrmdRagSI/znlDu2wJ9JBXFYLdvAK
         FVTg==
X-Gm-Message-State: AOJu0YyZ0f1IPfMBAMiGVwHtS/eaQAR8QtZJH+/z6dh/6zJ0YwtN1bfK
	LZ+lwUFhpxqO4cvE0bLcOHp/nI/lezo=
X-Google-Smtp-Source: AGHT+IGCk65TZuL5vJDogRUxS9iWAES0XzKfr0MgsaG+PuyJoFhRcultHjtkh6h7ulycD4JfSOUGEA==
X-Received: by 2002:a17:902:ea0a:b0:1bb:598a:14e5 with SMTP id s10-20020a170902ea0a00b001bb598a14e5mr32701824plg.43.1697140917995;
        Thu, 12 Oct 2023 13:01:57 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:01:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 00/21] DPP PKEX Changes
Date: Thu, 12 Oct 2023 13:01:29 -0700
Message-Id: <20231012200150.338401-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wanted to get a lot of the prep work out of the way but I sent the
entire patch set to provide some justification for why I needed some
of the changes made elsewhere (offchannel/crypto etc.)

Feel free to look at the PKEX stuff but I really am just sending this
for patches 1-10 to get them out of my local tree and make the bulk of
the PKEX review more manageable.

James Prestwood (21):
  crypto: remove label from prf_plus, instead use va_args
  dpp-util: fix typo "COMMIT_REVEAP_RESPONSE"
  dpp: rename auth_addr to peer_addr
  dpp: rename dpp_presence_timeout to be generic
  dpp: move/store max_roc setting into dpp_create
  dpp: fix retransmits if on operating channel
  dpp-util: allow for mutual authentication in i/r_auth
  dpp-util: allow mutual auth in dpp_derive_ke
  unit: update test-dpp with API changes
  offchannel: add support to issue multiple offchannel requests
  doc: PKEX support for DPP
  dpp-util: add crypto for PKEX
  dpp-util: add __DPP_STATUS_MAX
  dpp: support mutual authentication
  dpp: allow enrollee to be authentication initiator
  dbus: add SharedCodeDeviceProvisioning interface definition
  dpp: initial version of PKEX enrollee support
  dpp: initial version of PKEX configurator support
  auto-t: add utils for wpa_supplicant PKEX
  auto-t: add APIs for PKEX
  auto-t: add DPP PKEX tests

 autotests/testDPP/hostapd.conf  |    2 +-
 autotests/testDPP/pkex_test.py  |  150 +++
 autotests/testDPP/ssidCCMP.psk  |    2 +
 autotests/util/iwd.py           |   93 +-
 autotests/util/wpas.py          |   40 +-
 doc/device-provisioning-api.txt |   30 +
 src/crypto.c                    |   24 +-
 src/crypto.h                    |    2 +-
 src/dbus.h                      |    1 +
 src/dpp-util.c                  |  238 ++++-
 src/dpp-util.h                  |   41 +-
 src/dpp.c                       | 1558 ++++++++++++++++++++++++++++---
 src/erp.c                       |   19 +-
 src/offchannel.c                |   55 +-
 unit/test-dpp.c                 |    6 +-
 15 files changed, 2062 insertions(+), 199 deletions(-)
 create mode 100644 autotests/testDPP/pkex_test.py

-- 
2.25.1

