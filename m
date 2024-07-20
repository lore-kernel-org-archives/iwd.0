Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521F3201
	for <iwd@lists.linux.dev>; Sat, 20 Jul 2024 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721454376; cv=none; b=p3Feu7CrssrOdFhdw2zfhbf9La5wZ0IE6AOS/l5RspbuwKhLULUuqBgEhvry3Pwp+UCkIswLfFjq18cWOa6sl688Bwtb9ZmpGCunlJJWFy9WS5D9hSzBZfnmK5YU1Glm+z5RdZko3r8X0SbiFbj8U3nj/tmIFVo2y23Wb2iR4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721454376; c=relaxed/simple;
	bh=VNjpjAMk5Ztbn9TxStfpI/AdrLUz0s9LCrZfy5b0ebw=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=KaGzQxRR9xbVzx8s1PJhOcDaGb8G0Skjpe6Xv2qwCVxvHCuGDAE5kq/I3sVxlFea4bJxLcknLfIqWPzp9bVRsf1KSADUmGCd/F6Vl9/k7YXA+NjrSjGNOn6DJr+jL+9p9VM2Kn63kJRwQxXIbuQlOru3BDAJunKKwJOypmV7C+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gTD7/Y85; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJjzh6Hw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gTD7/Y85";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJjzh6Hw"
Received: from compute9.internal (compute9.nyi.internal [10.202.2.228])
	by mailfout.nyi.internal (Postfix) with ESMTP id 29324138006B
	for <iwd@lists.linux.dev>; Sat, 20 Jul 2024 01:46:14 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute9.internal (MEProxy); Sat, 20 Jul 2024 01:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1721454374; x=1721540774; bh=WbqPGWYDa81ql3l0NpsipjmEAs+nYBWu
	llH7geJx+2w=; b=gTD7/Y85vm8yy64c89ZEI7pgvdnRs9S3tqW0sLr7zfEjFm3W
	62lzBT96P1+2W38WHaDGgmt/Akwe8YyCf98kGWP/dMinBnLjeBhtv16pM0iOuNmy
	ywibH5FUPcZvckzhTZdxfRgc+iCa8Z4EKxASHvK6j0Tqss6Ux8aVdR0IjvXl/FjX
	DmrDLuimBkQ7Z+bUhJ5Q6GMDUMJj4+VTvmUVs/XoDrz/nU0yOQ0hne2Jx7jvlUBi
	IJT39PU1pL4TbM3RfvNYDS+RPWNI1lWRD68ZfO8Nyi84Gz0Dv3bdthEuuw9tqw7J
	0/TEkUs+Jbn0fzyD1v5l/0TcNUpJa/UxjWOI1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1721454374; x=1721540774; bh=WbqPGWYDa81ql3l0NpsipjmEAs+nYBWullH
	7geJx+2w=; b=GJjzh6HwmZsr8Sb43gTHRVWGqsKkbrmIX0MlWqTaiARbZ9lwvnh
	I/XXoV2L996SKUMpZCiGLPw0uGl+/LKD76p9w4g7p4k0jV0+w29aat2c5K/QEM5P
	KIwDMKke3w/oS87IWA5ZZb4QdQj4wmH4/Y4FItS7f5oPA5dBpumgKYPETI4BpzhF
	MeKledeM3G6wEOu3v8D2AhSkYfjTOrCbqjCWuSxLSjOCVTtRzlKDb32CRGKNIHvD
	i7T7A9+woDz7sJi5se9Ag6QOUVOV9HGX7iBwWkUY/5wD+XjxO6PtAFEv5VLf0Hip
	yJ8GZCuOtEcAP8ZxA7NvzDRTYVZz01BqE+Q==
X-ME-Sender: <xms:Jk-bZoWKlKX2J4WA3R4_W-LoDh9maxKCbNL4MR1uAhMpdHWI-5SRCA>
    <xme:Jk-bZsmUREVX4Lpy6rf2QHMm-vm3zbdWYVgh4Nx_KAT8XIcXNCW0PK7ijupbPYJeo
    f5_zkMeCJ97MD8f2pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedvgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfofhoghgvnhhsucflvghnshgvnhdfuceomhhoghhjsehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepteeujefhffektdefieejfeduud
    ejjeehkeehvdefjeeuveduhedvkefhveduudeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepmhhoghhjsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Jk-bZsZHjIpJgKRxig3Ytci8JgSypgAA7VD5uGxD52_zMRfOQh14qA>
    <xmx:Jk-bZnXfoSkwQoTqF399416IFPx3-Or3zYU0K6X71SKDzHBC-SKn2w>
    <xmx:Jk-bZikHz9pXgn9uKzALkwWScotmvScOCNKgMHMT9h_erxGdMqCD4Q>
    <xmx:Jk-bZsd-R9OErWmqHb4Gaf8N-TL1jm2Av0uUiXwSB5V-HtpPHl3Jbw>
    <xmx:Jk-bZptXlH5E_H-9V7jKBUBjeudx3KCV1U8HWJL-WVfbMklas5J1SONo>
Feedback-ID: i9549465d:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 00921A60078; Sat, 20 Jul 2024 01:46:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <3554030d-7309-459c-8e91-ee34a0fe677b@app.fastmail.com>
Date: Sat, 20 Jul 2024 05:45:53 +0000
From: "Mogens Jensen" <mogj@fastmail.com>
To: iwd@lists.linux.dev
Subject: iwd 2.19 segfault?
Content-Type: text/plain

Hi,

I'm using iwd 2.19 on kernel 6.6.40. Yesterday, after booting the
system, no wlan interface was found. I have never experienced this
situation before, system had not been updated recently and no recent
configuration changes.

Following was found in kernel message buffer:

[   13.585766] wlan0: send auth to 00:16:3e:21:cf:ab (try 1/3)
[   13.585997] traps: iwd[2446] general protection fault ip:55c8166f5107 sp:7ffde5888d90 error:0 in iwd[55c8166c8000+ea000]
[   13.613989] wlan0: aborting authentication with 00:16:3e:21:cf:ab by local choice (Reason: 3=DEAUTH_LEAVING)

Rebooting system and wlan interface was missing again. This time
the message was different:

[   11.623212] wlan0: send auth to 00:16:3e:21:cf:ab (try 1/3)
[   11.623519] iwd[2443]: segfault at 1411 ip 0000000000001411 sp 00007ffc64376348 error 14 in iwd[55e26592f000+3000] likely on CPU 2 (core 2, socket 0)
[   11.623558] Code: Unable to access opcode bytes at 0x13e7.
[   11.657372] wlan0: aborting authentication with 00:16:3e:21:cf:ab by local choice (Reason: 3=DEAUTH_LEAVING)

Rebooting system again and problem still persists:

[   11.981208] wlan0: send auth to 00:16:3e:21:cf:ab (try 1/3)
[   11.981515] traps: iwd[2442] general protection fault ip:558bac8fe107 sp:7ffdab42aca0 error:0 in iwd[558bac8d1000+ea000]
[   11.997438] wlan0: aborting authentication with 00:16:3e:21:cf:ab by local choice (Reason: 3=DEAUTH_LEAVING)

After a third reboot, the wlan interface was available again and
everything works as normal. I have rebooted many times since, but the
problem has not occured again.

Any ideas on why this occured out of nowhere? Have you seen something
like this before?

Thanks in advance.


Regards,
Mogens Jensen
