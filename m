Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62567E79
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAtf5m+r"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-425c6157762so35686741cf.2
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 10:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702576890; x=1703181690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17kjngjl4clw+g5Gdna9lJMGodPIyyvLG/4MzZRUlT8=;
        b=WAtf5m+rPWGi6LbikqpymVCYAGq5vITGvrqngGyp7FIfZEHqzMagh2zGjlEB89y5uX
         Tj6s8b9NLT7s4OcRVGkZVCYQmOrQ+1oQdxAl+T2am1VOCeuUB8XRvhMfUS+a6viXh8zX
         SxpEIPIg3iUxJNrF5qLTRRtyePljZqDtt35CmvkrFVP2NMWq90skZdM7XiiKtBC8cHDG
         d7K9mD0cVr283tJhK5ywQoxYoXwfOXSUr3qeHK0ycfqvPEJNa4q6X3YUutBP/4O2gA4F
         7yPCmzyi0DMUrbBGWKHBX0H6jjJgmQ6a4ATw5cMO+FC5R44L2jhG6kwRAZdE2TPpZ8vn
         1oPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576890; x=1703181690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17kjngjl4clw+g5Gdna9lJMGodPIyyvLG/4MzZRUlT8=;
        b=OW4jMoyDV8GaMceUZeZyWOHWQu42KWFBVyqK2R/mG1VxSPZj4xndqAOrNojGXIpKht
         PJ5S/FMAdNwHFCPRJ4CTq2b5OoofJDHlKKsw89a73rJsWbX6YIaq9rgRFd9RLYRqoEnC
         +79iFPsLWDhQaHfHq2p3b2plANhVcR8+GS1/I8dOb2eliklknwuvzP5n+81ulALi7mCD
         MHwGLK/1pULDwEyde7yigjT4cWiaYQkGrBPsdQsId0rmR5O6TrPC+c3M39OYZP3DFWJK
         8S6dznXJrNgU3/hIVoJmOxlhvsybKRZXkq+2b3WSIWfYtNiyc4m14/lElRvnIuOJ3gq5
         evFA==
X-Gm-Message-State: AOJu0YwvT0mVb73nfs4B4wzAT/NqSJb8m8yKRuiDhUuEa+rF34p0h9aX
	izOSnNO6NEstzs4ul6m6u9uZSaTNrKU=
X-Google-Smtp-Source: AGHT+IEEWNig1Oya+zwTU+UVTzrZPk3vh+oQQXt7hzgayHOwPXIr16K+Zljt407+sls0C66bCzChaw==
X-Received: by 2002:a05:622a:1a16:b0:425:8f15:bccd with SMTP id f22-20020a05622a1a1600b004258f15bccdmr15844519qtb.89.1702576889817;
        Thu, 14 Dec 2023 10:01:29 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o8-20020ac85548000000b004257bf9a394sm5949511qtr.14.2023.12.14.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:01:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] auto-t: increase RAM when running with valgrind (UML)
Date: Thu, 14 Dec 2023 10:01:10 -0800
Message-Id: <20231214180110.130991-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214180110.130991-1-prestwoj@gmail.com>
References: <20231214180110.130991-1-prestwoj@gmail.com>
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

