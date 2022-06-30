Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF27B
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:06:00 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so230017pjz.1
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtGZToBq6FGjpXuT2wG0YMa/oqd0RIE4ptaHo29vJYI=;
        b=b0e9ouKm6T/7CJl2qJsyiqmPIq7aXJT4y236SVCHIIdB4yq8Xo8zdH4wVtv7W13N4r
         N5tbtv9Stpt5sez4zKOTc+3EgoiaH31BBeZ0HQR6CMBjC49gRBGSYAeWA2CAzMAWHmod
         lqHNf5U2Yh50v+Uuv0Hghcvf5GRcse4ERDSz7qm8L1VCWavilCX7773JrP2SaGQ2p4vs
         /NauX8OLWMnLPQHAeBkHr0Crjp91+/qHBNtYhZ6GU+RRQ6pb2IsYUwv0896OogW3uC89
         QyxNjjLeevDX87jI7Vaj2thf3EzJkDT30QXitczbFh2a6WrCoRcaoPYNI6HiZydu8lwn
         5jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtGZToBq6FGjpXuT2wG0YMa/oqd0RIE4ptaHo29vJYI=;
        b=uLkYsGxHvRpE+Y3CXWty74QJ8J01Da8S7RRRk4AVdLvMH5CcbIkRl4djByhzRIiByj
         gHFaLvk/SkWV4mwYgSLN41+13X/1d5JB321R0C9XgNWiGpHFINohVSmldABcfdJPWU7y
         lDf7Fs1MRWNjodm+cxi8Ob2EBA6qbpSeCTtf2lAunLFHQ8e5V8HFYAFfhsedsb/wuOer
         JS+BosJk/emDe1DhlmezcB282fD2aV41pha7v3AEggx+AT94NmfsF2ospFtWmvn+x7xi
         WTMAv69/CJVcbYaCF35hbtZtVo5haaknCVpO2PTHG9vJaHzbUI5eEC/Uu5ovW0QYD1MU
         YSpQ==
X-Gm-Message-State: AJIora+gGIlEXtIzQ2KMb9qNM+smDpp557ECjofeXYQGnbULmONTbiuX
	lex32TSgSbS/akpVVMx5lPFAC0U3CNw=
X-Google-Smtp-Source: AGRyM1vyYIy1UY8/N/+2KEEXwS3ChN+qBuSB11QzoHIyPWGIYZfIz3CswaT03yVIpahUblg/yDx4hA==
X-Received: by 2002:a17:90b:1d04:b0:1ec:f898:d863 with SMTP id on4-20020a17090b1d0400b001ecf898d863mr13579494pjb.79.1656612359536;
        Thu, 30 Jun 2022 11:05:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm13777187plk.137.2022.06.30.11.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:05:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] auto-t: iwd.py: add DPP properties
Date: Thu, 30 Jun 2022 11:03:25 -0700
Message-Id: <20220630180331.206419-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 5591d7e1..df310a32 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -294,6 +294,18 @@ class DeviceProvisioning(IWDDBusAbstract):
     def stop(self):
         self._iface.Stop()
 
+    @property
+    def uri(self):
+        return self._properties['URI']
+
+    @property
+    def started(self):
+        return self._properties['Started']
+
+    @property
+    def role(self):
+        return self._properties['Role']
+
 class Device(IWDDBusAbstract):
     '''
         Class represents a network device object: net.connman.iwd.Device
-- 
2.34.1

