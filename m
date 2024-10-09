Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F9137C2A
	for <iwd@lists.linux.dev>; Wed,  9 Oct 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467538; cv=none; b=EhbcElZ+H9u/yDIK4Dgul7xx8SFwppv/7QzITXUVekS7NuAQvBl4sq5BtO61SzZ+NRdZBi7O22lO5C8Q+DWVWeR4wDEJNJDXhoi9oHmgpI3HrpfOv26wlIyyjKrcLue/NJUs9MXci0heCfCp/nKpgdPQlzVHngjW2IF1D6N77xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467538; c=relaxed/simple;
	bh=mzpOn628u0VXpAGoTS8PsnzAvc6wIRqN2MEcSMBv9Fc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qorIkFkEpCJA/vgZGMXsjF94sJ+u56s1k46hLyZkCrZwKNi8rXWigk4TeZhhsM7ZyQZHYnUNAV1A8LQhS1cyC9GwIMb3qaUw7snHNghRWXc5/a/NwzRA5/9DAzehYwZ0bgLA7ai5E9dm0JKLpmHEBqiMMC/XZ/4KKQ7Z4yBDcFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=PIiql6Zd; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="PIiql6Zd"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XNny00QYjz9v84
	for <iwd@lists.linux.dev>; Wed,  9 Oct 2024 11:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728467000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aKUPw1+Edm65LuTQApSg1NrJHo3IlB2mUolyHZ5kLrY=;
	b=PIiql6ZdZvvyGH/ztJxabyUNbll5zfB+HqYItK6NPBpuLYeuAuG8k2UJrbsumVYqn4lRIA
	0LcZb5xaUPc0y3DXdulKHPnGpx2J4NqKwbF1tKUkYlsA/3nLHu9lE7hGlp+J7LKwklG6pY
	epuZyY/ywXO02zmtwhL7zi25X6AD0mWWg5ldVV5OnZKwDlycpJRfRq5EDvADBJMZzNLH9a
	TXD5PwfxXB+AH6SQ7VMKRE75ZzRyjT1z2PKQ9DwPhCbdrY64/zS4758gL2x87xAaBYomHx
	bD8Sf7nt4VIoohN/Pmp9uHUcBC58m5AlguaWzTDfuAjsjubNk9m4P0bsyHf4zg==
Message-ID: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
Date: Wed, 9 Oct 2024 11:43:19 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Subject: IWD 1.27 with brcmfmac not working for roaming
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

PROBLEM

We (still) have some trouble with IWD together with brcmfmac. We updated 
firmware for the chip (Infineon CYW43353) to latest version 11.171.0.24 
and also IWD to 1.27. The situation became a lot more stable...until we 
tested roaming setups. It seems that for IWD 1.27 and maybe also later 
roaming is completely broken (at least for brcmfmac). It does not 
connect (No suitable BSSes found) or it connects but with wrong AP 
(poorer access point) or it just looses connection and does not 
re-connect (maybe even blacklists somehow wrong). I have also found 
several related issues [1,2] and also there are related change logs for 
IWD in several versions, up to 2.22 [3].

Will we actually get IWD with brcmfmac running?

SETUP

SoM: Variscite DART-IMX8M-PLUS
SoC: NXP i.MX8M Plus
Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
Antenna: Laird FlexPIFA
RootFS: Debian bullseye
Kernel: NXP Kernel 5.10.52
Driver: Laird 11.171.0.24
Network Daemon: systemd-networkd 252.x
Wi-Fi Daemon: IWD 1.27

POTENTIAL SOLUTIONS

1. Switch to Debian bookworm rootfs in order to have IWD 2.3 -> however, 
this is only 2.3, will it solve all the roaming issues?
2. Update somehow to IWD 2.22 with Debian bookworm rootfs -> how can we 
do this? (IWD 2.22 is in sid/unstable, but required newer libc6 version 
than in bookworm)
3. Build IWD 2.22 from source (maybe using Debian sid source package?) 
-> how to do best and will this work with libc6 version 2.36? Missing 
libreadline8t64?
4. Switch back to NetworkManager (which is our actual legacy setup) -> 
would be a pitty and there we had issues on boot with systemd-timesyncd
5. Any other option?

[1] https://lore.kernel.org/all/6679878.YKXMNv7jBj@mmm/T/
[2] 
https://lore.kernel.org/r/all/07f49420-74e8-4954-bd87-9ae3290e86d3@app.fastmail.com/T/
[3] https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/ChangeLog

Thanks a lot!

Martin

