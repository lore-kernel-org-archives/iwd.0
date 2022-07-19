Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC364C79
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:54:34 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id g4so14333289pgc.1
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXH3OzZkLBPR6ZmtGWLtpJEAWfagUWw8oGir3M1fMoo=;
        b=qvKLBw69xkHfrg8+dcJFcnVSN1Ye91oVo89/i+wQBAIrMzVK/eaEuuANx8d8RcO5Tj
         pfev0YuEnPuMpVSFQ6zUPIxPLfh55PaqwTsobBiQkN/vfO0cUIBQMdkAfAE3LIuNFVst
         AwYOdG3BZxMf5/TIAplskR8Q8qH4Rc+Kp9aR0l4bcJ5x7VUPkaAS7gFiKv+zTE/YX4Am
         8gYbfBW/nju/02gR2JzeIngTWC928jRxjdxcLCeFvkjG17SaXsQBeYK9pa0BHUadjVaS
         QWJIZz+L2IuuyKzgP27j6og87o8J4HJpMtm3Otuxp3KszEGFzHqd9tMOUqRyIICsBDyt
         0sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXH3OzZkLBPR6ZmtGWLtpJEAWfagUWw8oGir3M1fMoo=;
        b=EcpnY6g50l/M5EH/11zqZ92p72/EwFdJTlv8EUsl9/kK3eOKLYFUCUmPOGOukSviT4
         7GxhT2CiXIJJpUprJ7HII/0A1bZ5vI0685cmwaqLhjLwLzu8ZiMR55JLPmadpOVDjzMt
         9wntnhbc+S0lYoE9YVlkOnA3Nby4QzS0cibA5CVebIqn6Y0qsdFp+ysdhmY/PMHz+npG
         K1ZwNr7S7I2+6/w2dLCmXHW5K22cNclKww3LHloiovTMr9JwPK1SvXOxIaGxpr9u/r5h
         JhIE0mxOz+nkOqqu/TjU7IZAGydn+uBeiP622BNRVQrCrA/4znVqitd4QQaxrNABRblF
         6ifA==
X-Gm-Message-State: AJIora/gFh78M+RiV+QIU7cbP2V5zGYLWPNKAPvYEqblzzVdB2HwQZvH
	f7ihq3T4v15Pfrqmkhux1I4Wcz9jneQ=
X-Google-Smtp-Source: AGRyM1v08xDGNuS1hAr9HgOUdsJisbDP+M4uYdcIiuE2TLAM4nhyTQkN2r0QGSR/aKb7Z8l3+Gjsng==
X-Received: by 2002:a63:4722:0:b0:40d:289e:8637 with SMTP id u34-20020a634722000000b0040d289e8637mr30017582pga.362.1658256873379;
        Tue, 19 Jul 2022 11:54:33 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id w24-20020aa79558000000b0052af2e8bba3sm11851616pfq.37.2022.07.19.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:54:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] test-runner: start dbus with --start
Date: Tue, 19 Jul 2022 11:52:22 -0700
Message-Id: <20220719185223.456197-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185223.456197-1-prestwoj@gmail.com>
References: <20220719185223.456197-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starts dbus-daemon as well as sets the right environment variables
so IWD can start (and any other dbus services).
---
 tools/run-tests | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

v2:
 - Rebased so it would apply cleanly.

diff --git a/tools/run-tests b/tools/run-tests
index 8f84c844..e45ffe46 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -1037,7 +1037,12 @@ atexit.register(exit_vm)
 runner.prepare_environment()
 
 if runner.args.start:
-	os.system(runner.args.start)
+	ctx = TestContext(runner.args)
+	ctx.start_dbus()
+	os.chdir(runner.args.testhome)
+	os.environ['DBUS_SYSTEM_BUS_ADDRESS'] = ctx.dbus_address
+
+	subprocess.run([runner.args.start])
 else:
 	run_tests(runner.args)
 
-- 
2.34.1

