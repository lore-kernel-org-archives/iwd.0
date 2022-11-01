Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E42F29
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:17:57 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id q71so14382742pgq.8
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hOQw+JM1kFwufhWmlhEirrnvCVU7Fu5LUTGIzej0To=;
        b=Fe24rWl9vs7HOdMB5fvsIEFqmcmdfNrmGp82P4kDT9Aw7q0n+Jw8slTNsuPAS1NGtQ
         sE6sYte3roC6fYbUuXCfAB3DcRSvr736rKpZASNxAf8FQPxK3XeORBLhwEfeRu7E4dqi
         bGRdehVm4rjti66slxhyTqvOSvCl9IW9nSLsMjmi9gQGoPkHVzTwSsH6YwZg7AU5fL5S
         2EdU1y54zv1IbPmZJU0Av/TEE6Qn6eY8/O1AnUkOtmC48GpiDmr/VTSPYBIId93SoKup
         1kUPq1wmVLk9deEcrEwkj9mxsQpkZKmsi925f3cAj+o+4O2vP+CagxJzxmbcF+hMilUN
         TGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hOQw+JM1kFwufhWmlhEirrnvCVU7Fu5LUTGIzej0To=;
        b=GPIIK0w0FeYXiSpptbWmCyXQGe5opB1S/lB2DfuNex6gcFy1zxgGIcjxgWJY+rerdk
         ZbkoknqGexaqwrjrV0NOqZrukaa/PEEdsB8Uai1Y1ADsuQpxIeRgLTJkASrbXmuCPIR4
         dhSlO+tPNbJV9L/4o3fCGwzNbpCe3BQgiuRV2ML0RdcFNaZ51hqIm6NOxBobpDkyS0Qx
         FaMTnKRSn2GOTrKzxrS4m89f7GWi9dEN34/LAkgJjXD4kbDdn+L4bbDhaN8uHmqVjzKi
         4e602s2MdHvWxSSFwma6hNk34T64kmVt5BZOayZQ8hAqcus+40GJ4z7A0sWjdM8s/DcG
         moYQ==
X-Gm-Message-State: ACrzQf36SWkGTtf0pSM45Z/93+pX3DC7/FvsnpmIw/jzS8u0U1F0PnVG
	PoL8dWAKy5THJ83es7Vufp4BSUEoa4g=
X-Google-Smtp-Source: AMsMyM6QywjAYFc+70LUhHO7uQPVUtZHozob3yHaI2B++zMEeyWNnEqMR19WOqlek9uf+j9WFVBaBg==
X-Received: by 2002:a63:5319:0:b0:46f:c6e0:661 with SMTP id h25-20020a635319000000b0046fc6e00661mr9910797pgb.571.1667333877196;
        Tue, 01 Nov 2022 13:17:57 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/17] doc: document PairwiseCiphers/GroupCiphers AP settings
Date: Tue,  1 Nov 2022 13:17:35 -0700
Message-Id: <20221101201747.143379-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 5fa23179..ade09e07 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -82,6 +82,21 @@ configuration.
        Processed passphrase for this network in the form of a hex-encoded
        32-byte pre-shared key.  Either this or *Passphrase* must be present.
 
+   * - PairwiseCiphers
+     - Comma separated list of pairwise ciphers for the AP supports.
+
+       Values can include: TKIP, CCMP, GCMP, GCMP-256, CCMP-256
+
+       The underlying hardware and IWD's AP implementation must also support the
+       ciphers listed, currently only TKIP and CCMP.
+
+   * - GroupCipher
+     - Group cipher the AP uses
+
+       A single cipher value the AP can use as the group cipher. Values are the
+       same as pairwise ciphers and the same restrictions apply (hardware and
+       IWD implementation must support the cipher)
+
 IPv4 Network Configuration
 --------------------------
 
-- 
2.34.3

