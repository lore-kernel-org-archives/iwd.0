Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84646B8
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:09:55 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso4117736pjh.4
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBV4hQEgPqKcyinKv7psJB0197D8SzSiAL8wt3qxwKE=;
        b=g2RhhkE0+XQjgM1j78vsECIZJDnnNsGcQIEC+R4c6loUYCyg1v39vWzlT6GQQ/WbcA
         3WeiO2GgueAGNW0AUAWbn1PYDJINzH4MMlBlLCG4hRMBf/AA9saaif4fMC8um3wT1vNu
         XegbtNlrUTDWUrcQmGhWTARQR6Xltiy5JOCfVShGyo9iu80sqt9wkxDYTahKlRYqUF83
         bNHJoVWvmqRfTpFl1lmNautkY/kehdfDtKCyM8UOrNRSpQMYT8E2BddYfhWe9p9Qnwfa
         lI3OBrawpNAQ8mSmddxQfEJzgQhKip7C8dZXw1w9KV2c7cvRORap8ue2sRObFUvYkW3I
         /dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBV4hQEgPqKcyinKv7psJB0197D8SzSiAL8wt3qxwKE=;
        b=5rGUJTaWHH5f9aoYzYIQUWUag1oJin0wO/nU1HYWkz9UY5JWEX3fkckisZ7eCVUdIM
         f8YvB+kaZbHgdV4iYilXo711bT0RBibgJkuJN1wDztDNpmY+oMbf6QEvKClhy0EWbCSq
         F86N/sfgXh2v+lr6zs+nCJLMXc16S7AEMpiLLhWQw6tgB1dvg95Pwq3xYnDA+W5SJL7X
         2/Ni6MrbGqFby7v/VQFY1BY/yTBkTPq9gz3KUHb4xTdfekJKS3F0v05xpH3pagAcfD7R
         aJdk6oi3pmLotyK7hcmK8qkTYakmthfc3V9EfJT5w78fWgCJ5DqPwIVhtSvvOygLhjY5
         ldHg==
X-Gm-Message-State: AJIora+zvPRnBIjWr0PXUiJSGlnuUaMEi0RUC5m/LWSEnJmEqmJShtuz
	KswZcHO2zwmvPjqsK7O0ez2rprX2pn4=
X-Google-Smtp-Source: AGRyM1tFgWwGpno6OmXvDzWxFWzyvLgNbre0e4zMVrDP1xfEjai+JCDnab0j3XyGhflJjUCqIKQtsA==
X-Received: by 2002:a17:90a:f991:b0:1ec:92c0:595 with SMTP id cq17-20020a17090af99100b001ec92c00595mr1347815pjb.145.1656112194881;
        Fri, 24 Jun 2022 16:09:54 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] test-runner: make is_process_running more accurate
Date: Fri, 24 Jun 2022 16:07:35 -0700
Message-Id: <20220624230741.1957863-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624230741.1957863-1-prestwoj@gmail.com>
References: <20220624230741.1957863-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function was checking if the process object exists, which can
persist long after a process is killed, or dies unexpectedly. Check
that the actual PID exists by sending signal 0.
---
 tools/utils.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/utils.py b/tools/utils.py
index 857aa1eb..7272c1f9 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -342,10 +342,24 @@ class Namespace:
 	def stop_process(self, p, force=False):
 		p.kill(force)
 
+	def _is_running(self, pid):
+		try:
+			os.kill(pid, 0)
+		except OSError:
+			return False
+
+		return True
+
 	def is_process_running(self, process):
 		for p in Process.get_all():
-			if p.namespace == self.name and p.args[0] == process:
-				return True
+			# Namespace processes are actually started by 'ip' where
+			# the actual process name is at index 4 of the arguments.
+			idx = 0 if not p.namespace else 4
+
+			if p.namespace == self.name and p.args[idx] == process:
+				# The process object exists, but make sure its
+				# actually running.
+				return self._is_running(p.pid)
 		return False
 
 	def _cleanup_dbus(self):
-- 
2.34.1

