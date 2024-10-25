Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935F1D356E
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854655; cv=none; b=PIdxUEc8wf5bzywTgeJ5r69dQKoY7x51QOEx2iVJYdW64BngNytA5gpClfFc2gVdeyfkQGR1NkVcOtCX6rXIQxtGp/sbU5ijJfZKrnurufwFtM5EgQCq0IAJV5fb6KUfpNfJMZ/iFzYcLPqH57d674b/fdWQ/V8zIcDhG38dZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854655; c=relaxed/simple;
	bh=VfywsUeBZnF4ol8uAP/136iSCgfDMx6XZFAaz2xi0B0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=AOHWcxStQWMUVBILLJUYisQ01hIO+LO/pYtD4pWbmQVzeXb6+12hG1vnAR01+jUADr42bVCqJeQJM1a/cTGlwNrMnEl+1/Xbv8OVCEEiu+FOjJcDkVFH8QVXnp+eBrazOLaF5oKKzhT4XPLmyNW/HWKWxn0S0TRU6BtVf68i2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=ZVKmR1sO; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="ZVKmR1sO"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4XZg7P0ssTz9x0J
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 13:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729854641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdv/DEdGWXtqrUDlnOOPAr1OnAoTl0f4WpVVsNpFuYE=;
	b=ZVKmR1sOkOWXAVXrv3fmD034DShCIOK1paGm4Zjn+TipRk7mNqNzFrhzSrWjL15e5K6Xj3
	x+v3KvEqGywm61qIetnEXfbHn3rqHnzR8PYdsWie/XLNfREZVL+OFpHR+/uvibS5JECTs1
	/ii+0OoexdWKnHB4Kp5Jr+cbHoGZXgag/t6eBc+S/DrnCWZiJeaj7IEZekH271AF6LycfE
	KpGgZGcbYIiUTfoGbZIjPAyc3iwI3C3ycDtKv1z0pQymIXcw8uhq65Gf4cN0hbjus2Lidw
	9rb11/hCBoq/c8iBwJ/qSf8LCn0p6B3f1pEPVbA6WWTl8EWHmb6Qhd1ntsB/rg==
Message-ID: <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
Date: Fri, 25 Oct 2024 13:10:40 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
From: Martin Petzold <martin.petzold@tavla.de>
To: iwd@lists.linux.dev
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XZg7P0ssTz9x0J

Hi all,

Am 25.10.24 um 12:12 schrieb Martin Petzold:
> Hi all,
>
> I open a new thread for this one: During the last weeks I have seen 
> connection losses for 30+ minutes, sometimes even hours or just now 
> even forever (IWD HEAD with v2 OWE / BSS selection patches). Driver is 
> brcmfmac (NXP 6.1.36 kernel) and chip is BCM4339 (Laird LWB5).
>
> It happens in a) single router environment (WPA2-PSK; Touchstone 
> TG3442DE), and b) router + repeater environment (WPA2 CCMP; Fritz!Box 
> + Fritz!Repeater), and maybe also in the WPA3 OWE Transition network 
> (yesterday lost a connection again).

I lost now again 2 of 10 devices in the WPA3 OWE network (with roaming). 
However, now they don't disappear all after a shorter while. It seems to 
be later.

I also lost one device in a Router+Repeater WPA2 (CCMP) network. It is 
confirmed here on router side, that the device is disconnected. Since 
more than a day.

>
> We have 100% reproducable builds, test environments (testing sites), 
> and web socket-based telemetry. Thus my feeling is, there is still 
> something wrong with the BSS selection (maybe blacklisting)! Of course 
> this can also be something about the driver (brcmfmac) or firmware 
> (roaming?). Or can this be about IPv6 disabled (my configuration below)?
>
> This is really really serious, I (still) lose connections to devices!
>
> I will investigate further and provide logs later today, if possible.
>
> SETUP:
>
> SoM: Variscite DART-IMX8M-PLUS
> SoC: NXP i.MX8M Plus
> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
> Antenna: Laird FlexPIFA
> RootFS: Debian bookworm
> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
> Driver: brcmfmac (from Kernel, only minor patches - device tree)
> Firmware: Laird 12.29.0.22 (loaded via scripts)
> Network Daemon: systemd-networkd 252.30
> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 + 
> OWE and BSS selection patches) + ELL 0.69 
> (7bed251f8020ef896043f008276f41cd13fdd43f)
>
> KERNEL:
>
> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
> https://github.com/varigit/linux-imx)
> BRANCH=lf-6.1.y_var03
> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>
> FIRMWARE:
>
> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>
> From: 
> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/
>
> IWD
>
> -----
>
> [General]
> EnableNetworkConfiguration=true
>
> [Network]
> NameResolvingService=systemd
> EnableIPv6=false
>
> [DriverQuirks]
> OweDisable=brcmfmac
>
> -----
>
> Best regards,
>
> Martin
>
>
-- 
Martin Petzold (Inhaber & Geschäftsführer)

TAVLA Technology GmbH
Im Dau 14
50678 Köln
Deutschland

Telefon: +49 (0)221 / 3466 0885
Mobil: +49 (0)179 / 9220154
E-Mail: martin.petzold@tavla.de

