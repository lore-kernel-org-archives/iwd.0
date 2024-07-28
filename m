Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179874E09
	for <iwd@lists.linux.dev>; Sun, 28 Jul 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722193354; cv=none; b=cZs2/cdZRGEmF0BFI9QUfzMjAhn4UU/V5fwtxECD3EzLFwQ6s5YeNSFuZ7f6MJ8BsewIvAkaAn7APu/zG3x5Efu1GN/gWSr0IW1CMlLApCidcBZabXQu57U/6Up+LiPFf54oxwP7Q3+Q9aEuKI7pLoXbxZQUjKqlVDjEo5rbfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722193354; c=relaxed/simple;
	bh=R1F093Xcd+qDlCsH4VyaHbynQrwRNeR+9GXeOCxbGUM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jPLAgEEckwsGdPobTgItRXqELLh/SaSNYTRpSEvSth3IOC3LqABX+99/ZrDLNVGyz864YfJJ2V6mTRUp6QI6U/SPMbjexzOwRpFXPxFA7cQNd9CkeUSOXHJNg4Sw3ZsCv1UKgFH5xZe/nsdu28KUY6y70yvAlUiiitYcOeCvuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=nd4f2TJA; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="nd4f2TJA"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4WX9cW6hlMz9v2V;
	Sun, 28 Jul 2024 20:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1722192812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5799kyGAFMeP66AXn7R13V0r8Y03zrzAGqLYGmhRuE=;
	b=nd4f2TJANvm4w7w9hhHwxtHNl5SMD8dFU0AOyUNkAlxlz41pxgtOd8NE3q/IfDILnp7Yg6
	f7hn6UoSmCDeQ6j87FLSzOT5SVVvbC5Vixy5qsX2i42VtDnkxQh4qt9UpFvRQ3og2CSflm
	o4/H8FAmqFvJcp+QZIsWKTSxTGcdU3dR7UCFOnqqX/46z0qZ4+rV7luQCpwdcTVgayTahV
	EVyE2L2G1scQ2i9R/DLFVgPXveapMcD73c8zOlPw6qGQTEhjj42dGTdf8tyn8aF5m3q/Eu
	X+0goirxhPNPlFIt00iEL08VI2wikviKHwoPWbNqOdwaQpEa3wvz8gmgxJZZJQ==
Message-ID: <85ef594d-d928-4d12-8741-b3d897c008fa@tavla.de>
Date: Sun, 28 Jul 2024 20:53:29 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Subject: Frequent Disconnects / Roaming Issue with IWD + systemd-networkd
Organization: TAVLA Technology GmbH
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Cc: Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

this issue is related to my previous issue, see [1]. It seems quite sure 
that BSSes are blacklisted and, therefore, do not re-connect or 
re-connect after a long period of time and then lose the connection 
again. I cannot tell the exact reason, still working on getting some 
logs from these devices. Changing the blacklist configurations helps in 
terms of the devices coming back, also adding "IgnoreCarrierLoss" in 
systemd-networkd configuration seems to make the situation better. 
However, still really bad!

I have now updated to most recent Laird firmware (11.x), IWD 1.27 and 
systemd 252. The problem still exists without any difference. Of course 
our customer now also investigates his AP infrastructure, which also 
could be miss-configured.

This issue is especially present with multiple AP with same SSID 
(typical roaming setup). But also present with single router. The signal 
strength of the APs is usually low between -60 and -80 (and may change 
also over time - closed doors etc.). We still have a stationary device. 
Maybe it is jumping between AP and then blacklisting these AP.

1. I wonder if the problem could be related to systemd-networkd managing 
the network interface and DHCP?

2. What is actually your recommended management configuration with IWD + 
systemd-networkd (1.27 and 2.x)?

-> Like everything should work, especially Wi-Fi and also roaming scenarios.

3. What does IWD do using the "RoamThreshold5G" value of "-76" and with 
two APs and same SSID (roaming) with slightly lower or changing values?

4. Is the following configuration correct, if I want IWD to manage the 
network interface and DHCP, and still let systemd-networkd knowing the 
interface?

-> I need the *.network for wait-for-online triggers and also because I 
am reading out the network topology using networkctl and there is also 
an Ethernet interface.

##### /etc/iwd/main.conf

[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd

[Scan]
InitialPeriodicScanInterval=10
MaximumPeriodicScanInterval=60

[Blacklist]
InitialTimeout=60
MaximumTimeout=3600

##### /etc/systemd/network/20-wlan0.network

[Match]
Name=wlan0

[Link]
RequiredForOnline=no

#####

[1] 
https://lore.kernel.org/iwd/8c7ff992-2f03-4e4f-97bc-36eab3727d44@tavla.de/T/

Thanks,

Martin

