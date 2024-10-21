Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA51EE006
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531248; cv=none; b=fR1VHemro2wSWsEdKJzgbbisg0agztwLysa2ioyv5FA25Goy9SoLgDCQgcA0Wyi8DYX1bs0/9yCWLoz2Y6eOVGID4ziptLl9p4i0kdFCnCam6HeimCQMYvMSrjW5W21SDMU5nqDa38sYC7jJ7rgoj7KxrZbE16YUC4L5pKOMIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531248; c=relaxed/simple;
	bh=kE7VeWxcVwba0e8heZlVxqI64yMHHXkA0SgIsUPDrRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IF3p9ryy+h2DBh7W1EUW+N5qqvJu3pkoATZQETZoz+P1r8lAJt16NpVBRzoXtj+cMIiDnvx8ABfJaxSfSCcBXwUEDsqKci4FwT8ZqGuJGJjU7FaYUWyMh65LcutbBZ3IKu3i1+wfuzGM+HoL4c63dfyhdGDwgtFyptK98wRsCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=bs0wkQVf; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="bs0wkQVf"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XXMX91qBxz9vbw;
	Mon, 21 Oct 2024 19:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729531241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2078Ndvjc90rWMPFu6P3kA32bclWLiewMc+z9PUkd8=;
	b=bs0wkQVfNkqzTsFpOniLcerdJLaER5EwY6wDjvtqUgw7hN5ineVLzdrxlcvD9Zh/Ft3yal
	Bap9D1XMwpCeayk/ZHZPDNjhoIPOLsFhCPc6dEjyzObsb6eNjMQZ90N5AKEbLSzI3a+Sr8
	ff7EL0QblGDuf7dfSdmxY6dGm+p+tL6equqfNT6CF06GvXVsWyjf6fUzC04MgHjA+5VkyR
	grGoPuGYCULJ3bOgne/JWGR0j1mlN6zZwdBYKD/J1Acl6nlxM2k5tc8lae3O/UhQx1HLBj
	N9Xz24jbFpW2kp8RproQ8bzbUZ/qWJbY96TESuK6yiSr+kPvPoQe3XiFB/u8fg==
Message-ID: <48a03547-1a11-422f-9fdd-2631213e76f1@tavla.de>
Date: Mon, 21 Oct 2024 19:20:39 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>,
 Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXMX91qBxz9vbw

Dear Arend,

Am 21.10.24 um 19:08 schrieb Arend Van Spriel:
> On October 21, 2024 5:23:14 PM James Prestwood <prestwoj@gmail.com> 
> wrote:
>
>> Hi Arend,
>>
>> On 10/21/24 7:40 AM, Arend Van Spriel wrote:
>>> On October 21, 2024 3:34:46 PM Martin Petzold
>>> <martin.petzold@tavla.de> wrote:
>>>
>>>> Hi Denis,
>>>>
>>>> Am 19.10.24 um 16:41 schrieb Denis Kenzior:
>>>>>
>>>>>>
>>>>>> This is a more or less common setup for embedded environments. Would
>>>>>> be glad if you could double-check if this could cause wrong initial
>>>>>> connection (weaker AP).
>>>>>
>>>>> We can't help you unless you provide logs.
>>>>
>>>> We are now in an enterprise grade Cisco roaming environment. Initial
>>>> connection to the (open) network was possible and routable with
>>>> connection to our servers (!). However after like an hour or so the
>>>> connection was lost. And then re-connection was NOT possible (both
>>>> autoconnect and also not manual connect via iwctl fail).
>>>>
>>>> Please find attached the log output: logfile_tavla.txt (with brcm and
>>>
>>> The log output is not hard to read. The brcmfmac indicates it does not
>>> support the requested akm suite 00-0F-AC:12 (Suite B 192b).
>> This is actually the OWE AKM. The last byte is 0x12, not "12" in base 10
>> :) Does/should brcmfmac support OWE?
>
> Thanks, James
>
> I have not seen patches for OWE in brcmfmac. Looking at the supported 
> ciphers:
>
> Supported Ciphers:
>  * WEP40 (00-0f-ac:1)
>  * WEP104 (00-0f-ac:5)
>  * TKIP (00-0f-ac:2)
>  * CCMP-128 (00-0f-ac:4)
>  * CMAC (00-0f-ac:6)
>
> The error message seems to match with the above.

What does this mean. There is a WPA3 OWE network, and the firmware does 
not support it? Or does the driver does not support it?

Is this a case which should be handled by IWD on initial connection 
(deny because of missing support)?

I was just wondering, isn't there maybe usually a fallback configuration 
in case WPA3 OWE is not supported? Connect to different BSS?

Thanks,

Martin

>
> Regards,
> Arend
>
>>
>>>
>>> What capabilities does iw command show for the wifi device? Maybe the
>>> driver announces something which the firmware does not support.
>>>
>>> Regards,
>>> Arend
>>>> iwd - no debug) and logfile_tavla_debug.txt (iwd with debug and manual
>>>> re-connect attempt).
>>>>
>>>> I have now enabled "--debug" and it would also be possible to 
>>>> remove the
>>>> network and do another full reproduction with initial connection.
>>>>
>>>> SETUP:
>>>>
>>>> SoM: Variscite DART-IMX8M-PLUS
>>>> SoC: NXP i.MX8M Plus
>>>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>>>> Antenna: Laird FlexPIFA
>>>> RootFS: Debian bookworm
>>>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>>>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>>>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>>>> Network Daemon: systemd-networkd 252.30
>>>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411) 
>>>> + ELL
>>>> 0.69 (7bed251f8020ef896043f008276f41cd13fdd43f)
>>>>
>>>> KERNEL:
>>>>
>>>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from
>>>> https://github.com/varigit/linux-imx)
>>>> BRANCH=lf-6.1.y_var03
>>>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>>>
>>>> FIRMWARE:
>>>>
>>>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>>>
>>>> From:
>>>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/ 
>>>>
>
>
>
>
