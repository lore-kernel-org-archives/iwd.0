Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5068BEF
	for <iwd@lists.linux.dev>; Wed, 26 Jun 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394266; cv=none; b=cL0JEJc5U1G4xY0zmoEfeMsMYP7v3gekOgp8jIEc9s/ABYiohJoUGT2Nf68Q5UdEsaUthmTcHrnWFHWoVlY5BL9pbIkYNsXEubH8fK5G0u8edxfM2XpM2pD2jQXl5TTuv/xw+62dqtPvFBLoFb12hTVK3b3P/zCj9k/CJlq0reA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394266; c=relaxed/simple;
	bh=R7sxcrO6X5ggq7JF7PSruq1Sn6Sfwd2w48fGGqoQRRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=h7Mnowp9NH64R2oCA9SLgXUvCBOm/J5IvxcQSQP8oZBCxq7He87A9FG7c8EPiNjtrDZWGG4xPCvSnPF5fqJ0lQZzgzhllujij3tAK7v9NTTqzw79nyPXHD0M727olOPeMS/OREED/SjGQ1LIISqemAVC6R2ic2UtUNK8WmM89vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=CnpkyDda; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="CnpkyDda"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4W8GW625QSz9v2d
	for <iwd@lists.linux.dev>; Wed, 26 Jun 2024 11:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1719393890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A/f4gHgs7AsejHpyLZnYy6Nv0FSi8kTmE41yUTUAyqY=;
	b=CnpkyDdaQbpJc7bqifCJf2z2r/g22cseMGte3ZkEgz9tknBEkuUKOf93Fyhp7CYY71PVHs
	E/LPhXH++3fmjg13xyancJXNLlfnpSaAT4S/FISlaNjSNA0omZDjPT0yq/Kq06RO2B84H4
	QJAgRR/z43W8V1BKuW1ETzDjQH8KBV9F7clNLIL5W7NZbILTFXdIez0bfOZXxI5wNsQJlU
	WkY0lSnCzui3xCuuKhvpnYcxCTW5mHyoCA7nJnWPDhTCr3SuPc2JQeu8DJWBw2LHwLtZH3
	06QYXfQkDZDVp9rioo4C6vN8FpUxP6OlU5rPU+Dta02y3vz73W9woeiW0rK5Hw==
Message-ID: <e088f7e6-c455-4635-9edd-a51c619654d4@tavla.de>
Date: Wed, 26 Jun 2024 11:24:49 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
Subject: No re-connect using systemd-networkd and IWD
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear all,

I have some serious issues with the Wi-Fi connection using 
systemd-networkd and IWD. Our devices are fixed at a place and have only 
a single Wi-Fi network configured. There is also an Ethernet device, but 
no cable connected. Wi-Fi configuration and connection work well using 
iwctl. However, some of our devices lose the connection to this network 
and DO NOT re-connect. We have seen this with several devices and 
different routers. Some devices also do not have this problem. It seems 
to depend on the stability of the connection. But I am also talking 
about this issue like 1m away from the router - for such devices only 
rarely.

SETUP

SoM: Variscite DART-IMX8M-PLUS
SoC: NXP i.MX8M Plus
Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
Antenna: Laird FlexPIFA
RootFS: Debian bullseye
Kernel: NXP Kernel 5.10.52
Driver: Laird 8.2.0.16
Network Daemon: systemd-networkd 247.x
Wi-Fi Daemon: IWD 1.14

CONFIGURATION

-> Blacklisted "brcmfmac" kernel module
-> Enabled Kernel "Networking support > RF switch subsystem support" 
(but as far as I understand the Laird driver does not support RF Kill)
-> Added [Scan] and [Blacklist] section later, problem still exists 
(however, I could reproduce that re-connect works better if I switch 
on/off Wi-Fi SSID)

##### /etc/systemd/network/20-wlan0.network

[Match]
Name=wlan0

[Network]
DHCP=yes

[Link]
RequiredForOnline=no

##### /etc/iwd/main.conf

[General]
UseDefaultInterface=true

[Network]
NameResolvingService=systemd

[Scan]
InitialPeriodicScanInterval=10
MaximumPeriodicScanInterval=10

[Blacklist]
InitialTimeout=10
MaximumTimeout=10

#####

OPTIONS

A. Try "IgnoreCarrierLoss=5s" in systemd -> but this is not about re-connect
B. Switch to Debian Bookworm (with systemd  and IWD ) and NXP Kernel 
6.1.36 -> is already WIP
C. Switch to new Laird firmware 11.x

-> Which option could be promising?
-> Do you have any other idea, how to address this issue?

Thanks,

Martin

