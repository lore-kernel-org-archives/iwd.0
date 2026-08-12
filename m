Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F153E7145
	for <iwd@lists.linux.dev>; Wed, 12 Aug 2026 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526268; cv=none; b=JesmuU3qJmQLzUlTj4jUETqgGsrGwWEpn+277us2NqPUMh7mpZ80m6afCR7tnld9ehXTkNpqFzgBpQIWSjHFJMbwnwok+co1oKiw6jTm/24y5HpyHCT/axWdYEagx5qSwuYNYTTfOmWufISdENBtwQ5fImZMnq4Xxrp5qQ1/mOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526268; c=relaxed/simple;
	bh=iwOHiBIiqcwC+j9H/boH9St8bpI/IihGzSpqNNICiSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QeSvN+aY6T22YWZhEpuieAWWjt8942RvFS7rcoZT65tkzCqdV1qPxvbs+SH3LWV14p+rA4IebR1Eb9atWms/kAyPhKRRYCCSnggNoW3OED1bhXixb4tfecXkWguoR0Xou/ELhkKeBqfRZValgsoF6EABn0Gw/jrxbKJhimYTg8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDHX2vex; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDHX2vex"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso633375e87.3
        for <iwd@lists.linux.dev>; Wed, 12 Aug 2026 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526264; x=1787131064; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tZ9c/J8gFE55Jh465XXvh3XiI3Gne3H+PLK0oZWvkc=;
        b=bDHX2vexj4pPrSnPAXZXrIOaafrulUaGT+CmMuwtu8VjnJqc36jy+PpFGToUvjNxzY
         w6A2bGNPgzpygG+xo+bLPDfAkYQxkFZHXrcqMasgIrQ+mkqR4xYcTrEgtnq3kack6s0s
         qKORdI+73rUsfHn7r8mubuIgVt24Lrzy7yrRCJBwLV6LdXpQj7vy+/KYteAArfkaEK8h
         Wvq/n98pMyCWW7nL1iZfCOpn7ZkrKm/b9HVofbuFssszur56hZcWn8R9SMBa5taQKV0S
         JTwSrvy3u4VeNYbudSR4S/i09G0nD8IG1qKgEbrfim6vQLy0LJB+rW0pMziXcOzIpplj
         mi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526264; x=1787131064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tZ9c/J8gFE55Jh465XXvh3XiI3Gne3H+PLK0oZWvkc=;
        b=gkhxmNWDIMpt8j10KTcoerc+e+XQmBZZtxSg2Jh4m9IxGnHZlRHvbLM1zzfcrIbOR8
         WxhaunCUPLH7EOMHsmKM6x+ZRUokl+9xhgrKO5W4DXFD27tke6tXPPRvfSvuZkdlhmN7
         EsMey9Hu5yg2kt0t6L6sZ1IyPxPbDekC2nf7GKDFqBCVhvW3rmpfHjXwTV5+DD5VR26w
         /Mp6Hk9ysMLuqyWo1bDvATacNeBb2/AB9VdPJgdfZwoSxXhQ2bzSXHgqVHMkz4vZyjNw
         bEpE+nZ34MA3GVl6P++bTVPV5pDlzCQfMSbOyjA93fXlW+tm2R4lS60pJWiAfj8HTlx1
         0Rbw==
X-Gm-Message-State: AOJu0Yw+z6kaDjmJmQlXl0xaun7ptT6YMPVd0Cr7hbW63EnCYJRPlgCm
	P6vrgo4Uj9uHHkl+OgYOf8sAykm95pzhT5s1iPtTMy1yy7wvd8S8qo6nc6hAwRYA
X-Gm-Gg: AR+sD11YSHq4q2EnGyGdRIamxn/yPD9Oc1C7CbwN2Gh05NKt5RRUhY3rnmrEi17lBTV
	igwtVYsawhqMIjA9ny5CxwezNOjD3ioSV87t6TfvGzs8Y2quMPUAgr6kgshjPay9po7j3Ig3R/o
	a60LdaaeFef9CLdY1hO2+0xun70REoo29i6ecFb2go4k114OqPQQPSDhhU0eCC3wfMhspWhqgwJ
	ZZeQeZIIkrRG3dwesNNiM0lfoqRZw1WW1FrPMRZ/N+GbH/PgYez9UI8PMgjSYie6Q6BSuakItL/
	euQKHhoRNQHJ7iTAF9BtxHvehjsFRM1OhI8gM3tpO6cjbnj+Jynm2WnBGKUZ4N0vMj4BpQtunSB
	XlQduD3jwEKFyq+1HLFcyo/7grefXAFXEVfKfSEmoxtUHHnGeXc3vYMomsv1eGEoDcflxpU+Otr
	tSwSmu7/TrLOI6+8TEW2dnPUjPCrHyMSI4TJj7woSXzCL9GCGmEsZBgIWMgDcZGD6ZK3C8f6YOl
	g==
X-Received: by 2002:ac2:4f0e:0:b0:5b1:5f8f:bc1e with SMTP id 2adb3069b0e04-5b44e2d05f4mr561217e87.3.1786526264489;
        Wed, 12 Aug 2026 02:17:44 -0700 (PDT)
Received: from aai01 (dtuguest20.nat.net.dtu.dk. [130.226.71.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44d024cfesm370474e87.45.2026.08.12.02.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:17:43 -0700 (PDT)
From: Inti Manuel Yabar-Pagaza <intimyp@gmail.com>
To: iwd@lists.linux.dev
Cc: Inti Manuel Yabar-Pagaza <intimyp@gmail.com>
Subject: [PATCH 0/2] Fix two crashes in the agent request path
Date: Wed, 12 Aug 2026 11:16:50 +0200
Message-ID: <cover.1786525748.git.intimyp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both of these turn up in one scenario: an 802.1X network whose
provisioning file leaves a credential out, so the daemon has to ask the
agent for it, and the request is not answered before the 120 s timeout.
They are independent bugs in independent components, but the first is
what made the second easy to reach, so they are sent together.

The client bug has been latent since 2019 and the daemon bug since
2021; both are present at d003d0e (Release 3.12) by inspection.

Patch 1 - iwctl aborts with "free(): double free detected in tcache 2".
display_agent_prompt_release() destroys the stdin l_io without clearing
the file-static pointer, and the creation sites are guarded by
"if (!io)", so the second prompt of a username+password request installs
a read handler on freed memory. A side effect is that the credentials
are never sent at all, so the user sees a two minute hang rather than an
authentication failure.

Patch 2 - iwd segfaults in agent_finalize_pending(). request_timeout()
does not clear agent->pending_id, so after a timeout the daemon holds a
stale id with an empty request queue; when the agent's name drops off
the bus, agent_disconnect() pops NULL off that queue and dereferences
it. Any agent that exits after a request timeout reproduces this,
whether or not it hit patch 1's bug.

Both were verified at runtime by building the same tree patched and
unpatched and running the identical sequence against each: the stock
binaries abort and segfault respectively, the patched ones complete the
prompt and stay up. Tested on iwd 3.12 with ell 0.83, kernel 7.1.4,
MediaTek MT7925 (mt7925e), PEAP/MSCHAPv2.

Heads up that the analysis, patches and commit messages here are largely
AI-generated (Claude), reviewed and tested by me.

Inti Manuel Yabar-Pagaza (2):
  client: fix double free in agent prompts
  agent: clear pending_id on request timeout

 client/display.c | 2 ++
 src/agent.c      | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.55.0

