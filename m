Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCD46AA
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 16:36:41 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id u69so12711206pgd.2
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AyRGKycpPWdRLjuC6nbJno10yBdQV0z8McSGx2OKtx8=;
        b=SSM0jGyjUi1oil26W8aVHGflY2RW0p+MOdeXHXrLhwguaq6fQysXGxo+qxILqRqD62
         pa6RfkATIQfmLQ97cDyX5E9Aj/StAOh7IKYs6XmfLXjZW8yOXuUOk4Fok7+BQhFVIAgO
         WLZudwkFS1edF69AcREnZGRMzCr+bjrO6TcAIhg2e/yWwdI+oZ9iRWkir9/Fr7dkQHuf
         IG98FuTr1Q7ynt9uPVQP7W8bJrNs3TrFn69Q4++QHZTp/w7TfEzJaZs0X4V8qYZtNJwW
         54KQzjkkiZmhrasJ0Sib7PhFne5WoL5Ghoacr9kfeanZwp9Q380S9oSvA35XUHzP6vsd
         b2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AyRGKycpPWdRLjuC6nbJno10yBdQV0z8McSGx2OKtx8=;
        b=5qQkdTv9PEi+YrhnA5bvjI+X5OtmtbZH3GecTSFg29rrJPek+krUPghl6F0lasUYtC
         pKyeFTUMNniFneO6p9e/AGvAaetFnt5PSUXNFs7RsZnvw9C7J9DMIQ0iCxGpFS+MjQlp
         Dx3niioF7KwVq5E0LElgIQumEI09LESslX9Uth1rX1/WxKuHtf7AouTmVay/cAohIG+0
         Wd8MpKnIAsHGmllMJILu6notra6ZX0AiQSCgzw+SA8KZ+HtqGHpASRji83idqovbnlsO
         R3nYVT9Jm4IpZD2xC48abh5/mWSrAvrp/6sNdzEVCjZ03PkUEhV2VMfdbs26V+wQDZZR
         qd/g==
X-Gm-Message-State: ACrzQf0tIzht/bH2pNqSrCBYO2a+3EO8WBbEvkbrdidrvsSRhhq3uQ4o
	tg+5S+WWPzpxHG0AoT7gFkKR0pbYB1Q=
X-Google-Smtp-Source: AMsMyM7RlL7DBO1s1UsXjjHY0U8RHHmKNSR1ecY/3evXko92sb3pOb1yceio4ISRwsknQFjpOBLb2A==
X-Received: by 2002:a63:4752:0:b0:439:5dcc:fd78 with SMTP id w18-20020a634752000000b004395dccfd78mr29022655pgk.104.1664383001225;
        Wed, 28 Sep 2022 09:36:41 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm661184pjb.6.2022.09.28.09.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 09:36:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] auto-t: set disassociation imminent for bss transitions
Date: Wed, 28 Sep 2022 09:36:33 -0700
Message-Id: <20220928163637.344656-2-prestwoj@gmail.com>
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

Allow the caller to set the disassociation imminent bit when
sending the BSS transition request.
---
 autotests/util/hostapd.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index d6c13e2b..bb27686f 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -199,7 +199,7 @@ class HostapdCLI(object):
         cmd = self.cmdline + ['remove_neighbor', addr]
         ctx.start_process(cmd).wait()
 
-    def send_bss_transition(self, device, nr_list):
+    def send_bss_transition(self, device, nr_list, disassoc_imminent=True):
         # Send a BSS transition to a station (device). nr_list should be an
         # array of tuples containing the BSS address and neighbor report.
         # Parsing the neighbor report is a bit ugly but it makes it more
@@ -207,6 +207,10 @@ class HostapdCLI(object):
         # string could be used in both API's.
         pref = 1
         cmd = self.cmdline + ['bss_tm_req', device]
+
+        if disassoc_imminent:
+            cmd.append('disassoc_imminent=1')
+
         for i in nr_list:
             addr = i[0]
             nr = i[1]
-- 
2.34.3

