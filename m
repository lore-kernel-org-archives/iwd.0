Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8A48CCD
	for <iwd@lists.linux.dev>; Mon, 11 Dec 2023 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXFFW9gD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d04c097e34so37902205ad.0
        for <iwd@lists.linux.dev>; Mon, 11 Dec 2023 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702323685; x=1702928485; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xiCPF/SXyr/2RqtayaIEpAM+K3KkbN24Q8BGpmDfywU=;
        b=IXFFW9gDVWfBBgn9tLViIJ6D7itavfdFUkA6ARuMQy0H4kj1en3q98ah44lZxVaenp
         W0e0UZr9Aggfoa3fE23c2trP7oHZAnOcgtrjzYklZg5P+jqcGgC7uwS8s+iXdAjGVUZe
         2xz+6XTEhBe9opx7tgtWrjAODGNYZN9oSXDFN6/iLvFHH+ZaCFPqYFRiLRNOQKnXbMfc
         GjQ5WJ3+qITtGN4QICj/stXSUuxfcvBTu8ISP819cTsR/QBVD/DiwgK/joawyJGYqS4k
         RiDfVHchU+CXjn62HZYvJsH1fuI4pnY4EAHe+bFYuM+DIGNezsHrabKJnnRqwiEs5PyS
         Nt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323685; x=1702928485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiCPF/SXyr/2RqtayaIEpAM+K3KkbN24Q8BGpmDfywU=;
        b=CDHAfxaFCUgGt3PnQQbcl4LVAhEKfVGYDT3/6siUJ46YJYFKXd0ObRxvFu4JKoa4pA
         R1QrGWTCbUqaydJy0sQGtPK8uR6d5Rh8uwjg0B2nvGNtbZLRPlrgzpWbVRdBtc+L7DbM
         /IpXhOnM7RS1OkMIpZZL+bRqMQtx4x9tEM0WXWrvM5zVh0s9igIiD30ZfkbLO02b66xs
         /RV2rSs0N/28ywJek5DYDvSrLbA65S4pwtLIwJKtc1zHPGgfB9dFKHXX06grBQWFrDvh
         gnpAsmHfuxR6WmhfPbQPhj3+Er7wF1WTF5coagQMlv3vJeVFnzLOpRy80KkyZoIjH6h2
         +pAQ==
X-Gm-Message-State: AOJu0YxI/GB6KjDgNQfIyALfr8v//LiwZtYexrlc8mJCEV+Oa3TAoAb+
	Z01fQ8wl53U6TQOO1YFGVS8VxNtQ3ng=
X-Google-Smtp-Source: AGHT+IFTkrFfgYTKyu43Sj1nQXoKpbr3PD012PkNsBzouotCw1/J4AG05TmGoChLlvYM9HjQ8PUyWQ==
X-Received: by 2002:a17:902:ab5a:b0:1d0:6ffd:6114 with SMTP id ij26-20020a170902ab5a00b001d06ffd6114mr5454733plb.54.1702323685034;
        Mon, 11 Dec 2023 11:41:25 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001bf044dc1a6sm7017394plc.39.2023.12.11.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:41:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix SignalAgent Release arguments
Date: Mon, 11 Dec 2023 11:41:20 -0800
Message-Id: <20231211194120.64625-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path for IWD to call this doesn't ever happen in autotests
but during debugging of the DPP agent it was noticed that the
DBus signature was incorrect and would always result in an error
when calling from IWD.
---
 autotests/util/iwd.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 3f200beb..ddd021b0 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -201,9 +201,9 @@ class SignalAgent(dbus.service.Object):
         return self._path
 
     @dbus.service.method(IWD_SIGNAL_AGENT_INTERFACE,
-                         in_signature='', out_signature='')
-    def Release(self):
-        print("SignalAgent released")
+                         in_signature='o', out_signature='')
+    def Release(self, path):
+        print("SignalAgent released %s" % path)
 
     @dbus.service.method(IWD_SIGNAL_AGENT_INTERFACE,
                          in_signature='oy', out_signature='')
-- 
2.34.1

