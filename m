Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887F4A1E
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:18:59 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id j12so12704664plj.8
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzqkttZ3kngl+YvPKW8HkzNlryZ+F8utjzVq1sveBv4=;
        b=qfaNLM8FLzyOkEe2SMDNYu0oAp5iXz0flyoyaDiULe11j7AGRupTc8YGJi2+820eOp
         LZ5DPr4YdVxd+PIdGYPHQ3/1QqZE6VpPYdlvFKlbo70DRqO7YYceqS3vqLGWMttksj3F
         jNkVDEMSDccMjkbO31xUXp5xXBakd0+/xawMQXkmnxpIZHE+5q7j3DrhHqPrxpgJ6pDk
         M1FPBJ8WBMxW6DarnMgBhl9NM1Vi+zqhLjFSfW2PH/Na1CBbysQhrDe5gKbOtImt6PuE
         4yZ3JDZFx4UP66RGF4SXWk2ARadLEDA/oTlekojDT/9ebJhsK98fYe5ucjaqiBKLBw7g
         YlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzqkttZ3kngl+YvPKW8HkzNlryZ+F8utjzVq1sveBv4=;
        b=smNpU+tLyCuMVr3+ugibt5okzln3jY0oEUwsRojW4INRjEk1oEZlIjj76bJgEqO2lQ
         snngGgYfo1bo0Iut2sqA9ttSW2f2G8XKEQTpxnCIxlP0aqBAbRW1vXHMfA88Y7fp8u70
         XEvJDrgBMwOe+EnJgxxqocZ0fjFeRFRBg0AygcTccFENmRLDiQf3pVgdLZr5kLm09oSp
         gCP/sdGEXWVZIgICTuc/vbWM2gDkV0VNZrqoCeV3+JufymJuBhG8rNwfqh/9/6VrN7WQ
         cqmJ2tnGqtgP3Db7mlpvPOtg0N9atOtHH/z3kCDfQmjmGYGx1ekDtoI/edXDynvQRxfN
         yX4Q==
X-Gm-Message-State: AJIora+OTqgl9TypBeNGCWBHR5pwBfDbEHm+1+JUJtU1C9m+YOvL0gB3
	hZw6m9oyRVNKfQABWidhmfeysW0JFSc=
X-Google-Smtp-Source: AGRyM1u/DyKlsb5IoiFpwj7By1U40FH//gfa2lhag8jQaChQweI0DWgUH4VGyb4I9e/CnFggY5NbZQ==
X-Received: by 2002:a17:902:f7c7:b0:16d:b03:2a18 with SMTP id h7-20020a170902f7c700b0016d0b032a18mr4477653plw.171.1658254738616;
        Tue, 19 Jul 2022 11:18:58 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b0016cdfcdcff2sm7658467pla.19.2022.07.19.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:18:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] test-runner: allow infinite process wait
Date: Tue, 19 Jul 2022 11:16:45 -0700
Message-Id: <20220719181647.452178-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

subprocess.Popen's wait() method was overwritten to be non-blocking but
in certain circumstances you do want to wait forever. Fix this to allow
timeout=None, which calls the parent wait() method directly.
---
 tools/utils.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/utils.py b/tools/utils.py
index f3e12a85..156f8ce4 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -246,6 +246,10 @@ class Process(subprocess.Popen):
 
 	# Override wait() so it can do so non-blocking
 	def wait(self, timeout=10):
+		if timeout == None:
+			super().wait()
+			return
+
 		Namespace.non_block_wait(self.__wait, timeout, 1)
 		self._cleanup()
 
-- 
2.34.1

