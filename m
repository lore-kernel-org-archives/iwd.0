Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339B79FA
	for <iwd@lists.linux.dev>; Thu, 29 Jun 2023 07:56:53 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4Qs9cd2wJLz9tny
	for <iwd@lists.linux.dev>; Thu, 29 Jun 2023 09:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1688025073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VLL05i9dQmw0EtdLopuAnCuN4ukcwMIT8qwXhQvSCLk=;
	b=LlYXi1F/6l8VVGdFkFihtoPplTbnY5TP7NwkkqtLHa4wxr+4SGh8GVlMYWyAAItTChHlzO
	I/a0jxIaZyJhv9vq4CyVUufkXvCWO0cHpZkCLbyGJOasyAhj8DYJOT/I6t4P7npz6OqD3I
	iadUjUO1qpzQosmp94pSc4k4JSmcFKA+rS42WJtpXB5fGXJPfgArLxjl1xnjXotLECYQ+0
	I2/1Yo7qjHIfLlzR/ED9k96lywzZLb5bcBudJRDG/cfmCyfsXF5YXZ951CC59myMj+Z47h
	eFedBSQUyVLV26Q76QzsRmTGSnQec+2Yft7npP6mt0d6mBh+BnP40ZNOXEPttg==
Message-ID: <0a6ebf72-8cbd-21a1-eade-b2aea4aab572@tavla.de>
Date: Thu, 29 Jun 2023 09:51:12 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: iwd@lists.linux.dev
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Subject: IWD network state directory
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Qs9cd2wJLz9tny

I find it very uncomfortable that I cannot change the IWD network state 
directory using symlinks (most probably because of the monitoring or 
integration with systemd) or parameter at "iwd" startup. In general, 
there is no option documented to set this directory. In the 
documentation I only find "the configuration directory specified by the 
environment variable $CONFIGURATION_DIRECTORY, which is normally 
provided by systemd" [1]. However, systemd restricts the 
"StateDirectory=" to paths below "/var/lib/" by definition [2]. I am not 
sure how I would be safe to overwrite this environment variable still 
using systemd.

Because I need to move the state to a separate partition I was using 
bind mounts, with maybe some issues (still not sure about the actual 
cause). Now switching from bind mounts via systemd service to fstab. 
Maybe related to something specific with systemd (see my earlier post).

[1] https://man.archlinux.org/man/iwd.config.5.en
[2] https://www.freedesktop.org/software/systemd/man/systemd.exec.html


