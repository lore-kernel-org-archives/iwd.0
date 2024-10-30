Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553481CFEB0
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318090; cv=none; b=EYQwAM6bFClr6dE1KpH2ZlOtK5UB+4E2h2ZCUiyLGNE84vRu04QdjMXSzXzVjgsBpjBsH7V3BCHC9RJHE8TEhO8UZolD/pxBKz6P1LG11lopfT2bZ0/UL3P6lHHjrXm1CB+6flVHoXKw9G9BnYRE5YE4uHB1NllrTXCHEpFDYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318090; c=relaxed/simple;
	bh=nYp6L6i9xmYrxque/TjjZhTQa+bUrM8B9cpRWH8oHdU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jea/qIZAx8T7Skdlqziaoxv3ci1d7MDljBE2Bo7xPW2+7J1mPwzOng+Yg3ds80lRcPP2/6FtoKgS0bOG0NNdJ3mnEXsWG/U1zJKnbf+uw4CrODcDI9B10d2+zwjhz+2RFqv4F5PLKeb4B9ICy5eDKI9c3VBct6GX7ZDwCGuicRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=fnZ5d+e1; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="fnZ5d+e1"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XdyWb6xmHz9wM6
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 20:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730318076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VbIaiTj2qzPoiHjEUL9oFCb2EaOCdR+JcMht1lo8Rdg=;
	b=fnZ5d+e1t1HD2ZwThO4LOSuEOc/UqbpbBu6Q5xGgIExjDO0qZXo1/XLR+8KySRvPhUhMZC
	G9pcNAN/+BOMp6yWcR7FpNelxEaJbJ2nA+4dpnhZCH066wSZL/NGKYlq6d/bCDa4CCdjOz
	TaCjFuRb3oTLtkEeTKm6RwyYywlNLKHge2mhgwoPzdm9qSLGsnGV86pDha4/WvrKBSZukw
	QZL0uYQ1DkKBrGc0l/+0o99cM43Xwz5kK7P3VdqwnDtddbMEyFZwxO0py9LsFUfbZXo3wi
	SMnaFmRZHdXV8nE9Fnw3TtAw3g3RP8sigi2t7XtM6tgfOBg3lgKMfhAa7VYR2A==
Message-ID: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
Date: Wed, 30 Oct 2024 20:54:35 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: iwd@lists.linux.dev
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Subject: How to disable power save (iwlwifi / brcmfmac)
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XdyWb6xmHz9wM6

Hi,

to disable "power save" with NetworkManager I used:

-----

[connection]
wifi.powersave = 2

-----

However, using IWD (with iwlwifi or brcmfmac) I don't know how to get 
this set:

A. "options iwlwifi power_save=0" in 
"/etc/modprobe.d/wifi-power-save.conf" does not work

B. "[DriverQuirks]" with parameter "PowerSaveDisable=iwlwifi" does not work

C. "[DriverQuirks]" with parameter "PowerSaveDisable=*" does not work

I always get this output:

-----

tavla@tavla:~$ sudo iw wlan0 get power_save
Power save: on

-----

Interestingly, this the following seems to work (but is not permanent):

-----

tavla@tavla:~$ sudo iw wlan0 set power_save off
tavla@tavla:~$
tavla@tavla:~$ sudo iw wlan0 get power_save
Power save: off

-----

Thanks,

Martin

