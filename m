Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAB81F
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 16:36:43 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id l65so12981805pfl.8
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AEvbJjgzgE4XK7dtsRBv4s1iv2Q0MrizOimFKL3smz0=;
        b=AFDsOa79B8CJl9uPPotM3UePDiU3OvTlXstQ7ltFK1HV6C/IjgwkXCrTv790n1rBwf
         Zi6z+6pRMDJrZI0zZ5u1VqEpXfz9fw0oSZ5k+KD7evGS3kN7qyaRMMvY++Fbwko6pSeH
         j2YGzgifl5z3UVChVc83a/7H8KvZgTYzAkwp0FiVd/61TikCO44YfpLM415HOEFGO2+w
         54AP6qQiUNbDgpYlVc0I4qW7CyOJ9R6Sldrghjixt4KuevfG8U9t6ep9FPQdfJbtn46s
         OQGffbDPHpRQ/duswdNn4jFqcV0vJAds54Id6xvHtSywe9uVoPPL1w7hRySnRGTSo/oS
         gBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AEvbJjgzgE4XK7dtsRBv4s1iv2Q0MrizOimFKL3smz0=;
        b=Z7gHc3Lki9AStzy8sucKb746LiXJuQKv5WeYHXXqHjGk89QpaoF3W40BUNpEcUX7m+
         ajJLGcrVSP1ewwBm5Q6p6j9Bt1o9OfcZDZKXbCe9FU9PmBZHJkX+F8lgc9sXtTY6oGJs
         yDaZpVd7RvIIvgi+vs+nxw4mt4N/rVDJ+Gdx9EwHfMpA/nHYw7UzyK/8YRNVcP+ysjCv
         3gwELTa+cvDNns0GgPbZI8k411scTVf/azyJ/GoJvc03Ir8x6Safl/MAugLBpuYqS1Ff
         sUR2H60vKdTE6t5nzacnLo3I3TQkZ1NSV1AJfq2sum6aF+6oiCODALQcNDnkb7Jhb9NC
         dpSg==
X-Gm-Message-State: ACrzQf0AYWqv6FJW463VXwKTjrrmkiDdYKoocDhbIh6Q6JU1KBB8zO8t
	5GjE5mzyjXRCFDhLXT4UYJauCz0zFWA=
X-Google-Smtp-Source: AMsMyM75B3QEhXOfUbh2ojzDGfTalWm1XJHoUCEjhQE/4sXwpS7pRZSXGHyJYou6H2e5g66z5sWMTw==
X-Received: by 2002:a05:6a00:23d3:b0:548:45c:4f9f with SMTP id g19-20020a056a0023d300b00548045c4f9fmr35571899pfc.62.1664383002524;
        Wed, 28 Sep 2022 09:36:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm661184pjb.6.2022.09.28.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 09:36:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] auto-t: change wait_for_object_change behavior
Date: Wed, 28 Sep 2022 09:36:35 -0700
Message-Id: <20220928163637.344656-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220928163637.344656-1-prestwoj@gmail.com>
References: <20220928163637.344656-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of requiring the initial condition be met when calling
wait_for_object_change, wait for it.

This is how every caller of this function uses it, specifically
with roaming where we first wait for DeviceState.roaming, then
call wait_for_object_change. This can be simplified for the caller
so the initial condition is first waited for.
---
 autotests/util/iwd.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 5f5699df..a9df0dca 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1160,7 +1160,7 @@ class IWD(AsyncOpAbstract):
 
     def wait_for_object_change(self, obj, from_str, to_str, max_wait = 50):
         '''
-            Expects condition 'from_str' to evaluate true while waiting for 'to_str'. If
+            Wait for 'from_str' to evaluate true then waits for 'to_str'. If
             at any point during the wait 'from_str' evaluates false, an exception is
             raised.
 
@@ -1180,9 +1180,8 @@ class IWD(AsyncOpAbstract):
 
             return False
 
-        # Does initial condition pass?
-        if not eval(from_str):
-            raise Exception("initial condition [%s] not met" % from_str)
+        # wait for initial condition
+        self._wait_for_object_condition(obj, from_str)
 
         ctx.non_block_wait(_eval_from_to, max_wait, obj, from_str, to_str,
                             exception=TimeoutError('[' + to_str + ']'\
-- 
2.34.3

