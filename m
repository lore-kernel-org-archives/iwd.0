Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D81D54E1
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851146; cv=none; b=Voohp19q46ksyWf2Rct/1+dAtGMt3/UNZitkNJ3A0OlqjHlxV6pyHp7UCe8JgsnouyaoPr9LSP0ohTDPhDr7yMXmBHl42H6OqqAQPkK0e/g4Ub7ChOi7rmFWj3vfgxPY/hiaj8MJtPmrpXmCYZARLinQTeMvaVmPG0NfUVHK/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851146; c=relaxed/simple;
	bh=Rs6YotloxEbEluLLzLeplITV1plMQkoJJtrrWL4wTX0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=ua9IYDU5NPCxMBgGbB2a/gkjk22Go6qKs5zDRbTo+o/x/Vm6ggr4R8Qc501/szBAa0TPQh8gWUwUyxdkVLq9oczMyxvvYkMEsCQ+TJ1k8aHh6biAM7K9D/Ft6t/+//ei5cJMz8jntM+oNaNRBb9aFh9bNwrdyu3TK5Pglr80yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=RKDNP1++; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="RKDNP1++"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4XZdqx3cl0zDsv8
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 12:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729851133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mXOPGSrsqatV8RJDjjc3ChAogytfGZbcm27v8GFQ/o0=;
	b=RKDNP1++j65QFpAVzulnloFjLKpoY/zeCvU+4EDXkp9oNcRkOdWZidzrsRhfvtHI8rWX38
	meZhvAou1RnOtPQw8fyYJiu7HzRDYJSpOXnr11jcUDeORKQHAtuIJjejgFFYLzFqwz5Hs9
	T3NnG47F8+NK5N8UMjPeHD+868RxWfZMTiZwtb5pEqEnVnkR3AzkAd4g3iWsBy6rofWBql
	rJix8D6cwUCHqpW0m6AU5clokgH+RPXwav4qcKaAVi6EQMCj9S+t/lz8Km51pOAzzHdf2a
	0iF/1veWzcThrcpclubKX0bGJiOZMq3K4i5BO4raffVPiz9p+K/XueFIt71MjA==
Message-ID: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
Date: Fri, 25 Oct 2024 12:12:12 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Martin Petzold <martin.petzold@tavla.de>
Subject: Connection loss (IWD HEAD with latest OWE / BSS selection patches) -
 brcmfmac driver
To: iwd@lists.linux.dev
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XZdqx3cl0zDsv8

Hi all,

I open a new thread for this one: During the last weeks I have seen 
connection losses for 30+ minutes, sometimes even hours or just now even 
forever (IWD HEAD with v2 OWE / BSS selection patches). Driver is 
brcmfmac (NXP 6.1.36 kernel) and chip is BCM4339 (Laird LWB5).

It happens in a) single router environment (WPA2-PSK; Touchstone 
TG3442DE), and b) router + repeater environment (WPA2 CCMP; Fritz!Box + 
Fritz!Repeater), and maybe also in the WPA3 OWE Transition network 
(yesterday lost a connection again).

We have 100% reproducable builds, test environments (testing sites), and 
web socket-based telemetry. Thus my feeling is, there is still something 
wrong with the BSS selection (maybe blacklisting)! Of course this can 
also be something about the driver (brcmfmac) or firmware (roaming?). Or 
can this be about IPv6 disabled (my configuration below)?

This is really really serious, I (still) lose connections to devices!

I will investigate further and provide logs later today, if possible.

SETUP:

SoM: Variscite DART-IMX8M-PLUS
SoC: NXP i.MX8M Plus
Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
Antenna: Laird FlexPIFA
RootFS: Debian bookworm
Kernel: NXP Kernel 6.1.36 (with Variscite patches)
Driver: brcmfmac (from Kernel, only minor patches - device tree)
Firmware: Laird 12.29.0.22 (loaded via scripts)
Network Daemon: systemd-networkd 252.30
Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 + OWE 
and BSS selection patches) + ELL 0.69 
(7bed251f8020ef896043f008276f41cd13fdd43f)

KERNEL:

REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
https://github.com/varigit/linux-imx)
BRANCH=lf-6.1.y_var03
COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98

FIRMWARE:

summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2

From: 
https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/

IWD

-----

[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
EnableIPv6=false

[DriverQuirks]
OweDisable=brcmfmac

-----

Best regards,

Martin

