Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E51363
	for <iwd@lists.linux.dev>; Tue,  2 May 2023 08:48:41 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1683017319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=npNTX4N7lyPcjqdia9otrtBWCsPaYGIyYXvwZvmSr58=;
	b=DLKhEcaF+xMJBNg6tYRH7B5uww92j9rJzA6rg0UrIaWUbDFgHFSAsipmBgZVxiiooJrYJ4
	Yrwa7TRyyiYuuBF7IvTnoB+YOAWAjvF0qWiVPUBLsa4wdtdDRhCEvJJKu4CzARk+1wfYoL
	43afVdCMxGZRMimDnuG5TGWXqj5GMxw=
From: Ronan Pigott <ronan@rjp.ie>
To: iwd@lists.linux.dev
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH] client: avoid segfault in iwctl quit
Date: Tue,  2 May 2023 01:48:31 -0700
Message-Id: <20230502084831.60016-1-ronan@rjp.ie>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

iwctl quit (running quit non-interactively) isn't a useful command,
but it shouldn't segfault. Let's avoid calling readline functions if
we haven't initialized readline in this run.
---
 client/display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 59086642c273..8b06ff58384b 100644
--- a/client/display.c
+++ b/client/display.c
@@ -890,7 +890,8 @@ void display_agent_prompt_release(const char *label)
 
 void display_quit(void)
 {
-	rl_crlf();
+	if (command_is_interactive_mode())
+		rl_crlf();
 }
 
 static void window_change_signal_handler(void *user_data)
-- 
2.40.1

