Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EED46A6
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 23:04:41 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id ha11so13104678pjb.2
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=u4T7AewowHyqfnU5vUNHza3np1O24U4OanDwhVm8YJs=;
        b=qfE41injFL242GcyluBfn4MJV4S0DmQB6RmZkGMBr2Plb/j3raa2j4eOEiNbofBxWt
         KDX8oruiddM/x5Nuv5q8jdaXaILGXEs/xGVovb43eVOUzTJPPKzYb9TOPKQ2fhmDiyP9
         giz17RwbjExhizpS2VbYsJao187l+/c2Zj8iTUw8wrxK/fi9eQWGkBG4d71azuVz8j2P
         wtFczxCY1/bbeGzbdX29IDZF8pljskZrIbEekv1YTulsIZnfKepMEgo7+KTAnY6ws+UD
         9UnWwEr5jgip5XkaVTiZ29td4USwQsXikX3FhjMcibjqgn09GxbAxVIK/ES+fp0UUV1o
         UZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=u4T7AewowHyqfnU5vUNHza3np1O24U4OanDwhVm8YJs=;
        b=dyjKKBkc9O8vNHVM18MoWCWaFq57B50xZNnp6zpAQVQG2gvkZCHnV1wnVcjyDNiMpN
         Pa5FFmwcw6PGhZAG+VdDbUgDUAaoUdk8ajzBATJ/Eq9wls5bp7JNMuF9H/nUZUKxU0Hv
         UBKBQQfHhuyP0Pc3gNEFBd4Px2ASJ06u1HwVvL11ftZfRTTk8mlwnZJ3LhXvPt+9JPts
         4lgmSDfzuXAgqlW3++QAmsAclY0BsihWpexOLVRKNXgJ8cvOPLMV65iiJt/ewUvzrDUh
         1128PK0z8w+ugjAv3KEux9mLYtnDEQQwOfcngAzR4ZURg1c4z2dXwKEqdgN2aOEE5qhh
         P4Hw==
X-Gm-Message-State: ACgBeo16wiuzbs7eaTpRIRpOIyL3gzDKEb46pE86e8KxfN9y+Ohb1hiq
	uDF7RhuD5mw3jjkXw/5voS4rfavMhoE=
X-Google-Smtp-Source: AA6agR7ALpiGRirYmGer7c3IdEhxwdrf3Y8oEutAzlEM/085bznSkW5W/QX8r01mB1YcukeXk9wgLw==
X-Received: by 2002:a17:902:f70f:b0:171:2572:4f5e with SMTP id h15-20020a170902f70f00b0017125724f5emr4444164plo.40.1660086280937;
        Tue, 09 Aug 2022 16:04:40 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w13-20020a62820d000000b0052d748498edsm459063pfd.13.2022.08.09.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:04:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	mjohnson459@gmail.com
Subject: [RFC 0/4] Roam based on packet loss event
Date: Tue,  9 Aug 2022 16:04:24 -0700
Message-Id: <20220809230428.215970-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few weeks ago a user (CC'ed) reported that his driver was not roaming
as expected, and would get disconnected before any CQM RSSI events got
to userspace. He did see that the kernel was sending packet loss events
which should also be a good reason to roam.

These patches do just that, roam based on packet loss events.

Sending as an RFC so Michael can (hopefully) give this a trial run. I
can simulate packet loss events in a virtual environment, but testing
on the driver in question would be best.

James Prestwood (4):
  station: react to (new) netdev packet loss event
  netdev: handle packet loss notification
  auto-t: add generic tx_packet function
  auto-t: add packet loss test to testPSK-roam

 autotests/testPSK-roam/connection_test.py | 46 ++++++++++++++++++++++-
 autotests/util/testutil.py                |  7 ++++
 src/netdev.c                              |  8 ++--
 src/netdev.h                              |  1 +
 src/station.c                             | 39 ++++++++++++++++---
 5 files changed, 90 insertions(+), 11 deletions(-)

-- 
2.34.3

