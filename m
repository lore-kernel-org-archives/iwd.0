Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCD37D14
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgzwSssJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so3749524b6e.3
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 10:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703009312; x=1703614112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17kjngjl4clw+g5Gdna9lJMGodPIyyvLG/4MzZRUlT8=;
        b=XgzwSssJv2+gcioEaBmEJoQK/FJlVxVyxxGWak3v/h6chrsV8wc3t2+SewDsV+jqHa
         NFwYJXxE3p4xyTLu8bguwQCdZmqDi48CFBHYo4lH0A1SwWavIlhzk4b51fv4ZDHwUCbb
         YKpfchjh1fDXzKKz1pniFFmjtTSW4E1qonlV/e+l13v/45J6k6nlGbJM6Id13bVffWkE
         qHliwsundwrYH7k8N2/R/hMhhAH0yzithbBx8b1/ie9RXNEFdaZcFyZ2E9PpfFxR+wCN
         7EIygXRnKej0KKwiJFAAw1I4PTS/ZL8egf1w10u7cl12e+M1LBgjEUl+86eVW9LNGXUt
         oMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009312; x=1703614112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17kjngjl4clw+g5Gdna9lJMGodPIyyvLG/4MzZRUlT8=;
        b=D6ABse00s5B504fTtDoEpwLElWDD1GCUOIDYMarNd2wTCbyOzLcehJByQ8VUQdcOnc
         Hpfisi27BqTkkhJFYwR0oGmQfzvrpifpOfPGO4GAHnaCBqAAFGEAepBFeIqn08wCfs/o
         xemgJ3LRi9Bdp1DFEEg4P/d1l0Ol9WjTtlBmziJqr6wVjJ8bAw75d2UGPWYstM4PmsQm
         6k68NhTKVO79TCywpgdIz1ckFdj82LIVXL4m9x7zl8+jTUSW4V6oc+NU6/JfgkjlFuQ6
         J2gwkS6+5yR1ho3P19RHV5xaFP5/ULomohlIXTQnvdZvakqPx/gsScWn9NoXmsOiNbST
         Tlww==
X-Gm-Message-State: AOJu0YzPPTVXbKhWVmHrCQYpOSTsik2oUw7vMiXmi6jKZfeq4n6/0VVJ
	O3yU+rOxFOI7QAHVT+Rw4QxeH67r8WE=
X-Google-Smtp-Source: AGHT+IGxeNVUWCfrSBiLYjtjy6OsZ0zM1GfIS+uehFEPaDIxpHjm6TqSXvyRNi/9u+81TfG0HfOaHQ==
X-Received: by 2002:a05:6808:e87:b0:3b8:b063:9b7b with SMTP id k7-20020a0568080e8700b003b8b0639b7bmr21743694oil.109.1703009311912;
        Tue, 19 Dec 2023 10:08:31 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id z25-20020a056808049900b003ba322fa9a8sm2095130oid.43.2023.12.19.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:08:31 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] auto-t: increase RAM when running with valgrind (UML)
Date: Tue, 19 Dec 2023 10:08:26 -0800
Message-Id: <20231219180826.201540-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219180826.201540-1-prestwoj@gmail.com>
References: <20231219180826.201540-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was done for QEMU but not for UML. Running more than a few
tests with --valgrind will generally thrown an OOM error pretty
quick.
---
 tools/runner.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/runner.py b/tools/runner.py
index 03f44611..e50ba9c0 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -552,7 +552,12 @@ class UmlRunner(RunnerAbstract):
 
 		kern_log = "ignore_loglevel" if "kernel" in args.verbose else "quiet"
 
-		cmd = [args.kernel, 'rootfstype=hostfs', 'ro', 'mem=256M', 'mac80211_hwsim.radios=0',
+		if self.args.valgrind:
+			ram = 512
+		else:
+			ram = 256
+
+		cmd = [args.kernel, 'rootfstype=hostfs', 'ro', f'mem={ram}M', 'mac80211_hwsim.radios=0',
 				'time-travel=inf-cpu', 'eth0=mcast', 'eth1=mcast',
 				'%s' % kern_log, 'init=%s' % self.init]
 		cmd.extend(args.to_cmd().split(' '))
-- 
2.34.1

