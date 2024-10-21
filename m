Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94001EE029
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530502; cv=none; b=eq60wja4MRlEnucfTCQJ98ZTXzVRcy5OuIUXsm3/7enzUhj4Tju74njyV0qimCdAmMb0YD9Jqn8PjcLyaXyiiF8DAftDd+UZoBuWG0xt2CbIvoJOsb3GAFkVkKvfPGw3eiAnjKmmz2USFntXVUdk6yWHMRQ/I7JWDrsWDtnBOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530502; c=relaxed/simple;
	bh=CSi01+w3weIcD2YDGSMrzTs+rjad3aUHkvS4CZpQkQY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PZLNwefOjJbCQHTX/T1lS7++Mto+CLi/nHLEQoeqXmz5rYLEFdgG0pwqkvW/ZgcUtPTq0dYlFrC6tuTq5Hj/ruy6jYp9725HHt1of/mJLJoMOvvi0Dwrr2lIKyZVy61y1YvN//mdwLVYrRJSKUkiUgz7b8O03cB4b3lsMvk0hGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J2HycTQv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J2HycTQv"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so3863616a91.2
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729530498; x=1730135298; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC0y5QdS8TAPIYkxU4CT6TJVk7jfXzmAp9cQIKMYHQk=;
        b=J2HycTQvkR2F/kF8SXlPmma9FIm1xdNo2zLNnK4ScOSn6wfFsu9b2n+9Rc4GdbRaxw
         SjCSVFqHLP3TtGa726veUC1Dg/eAsV/hxX5+hQSsmL3O81NU9MDunZdCRfRM92hTyz3s
         k+W7Al/PQFmtteL+5Ll+nKUXO8F1ufTB1zxBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530498; x=1730135298;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC0y5QdS8TAPIYkxU4CT6TJVk7jfXzmAp9cQIKMYHQk=;
        b=NUWcE4NYrYlOiBoezmZ9G2vqNqxITuOLgXmXbORlGiy5hwOkY/rLxOkGxcz1IR/ge9
         wGivCWkm1RFeKQ3LX/J5/h06isQjz8IfjYsMVzdDnx7GyQC9sLO4Fxrvy2IkymtZ00Jb
         A3rXc32N2Ba775dVbS2v2LkbYiEOpkGh7Vk5FREH/z72LWoa97OHiWWiY28fubXgcbxy
         iHda65bsODQSIp0joA1pePrdb6es4b/9TqyLHIFPXOTa0Id+uYROgkkV4YP4PGyyaSC/
         NwO1hWkXynIpKbZMC29JsPIWnklD2W3gkw0kMDeRHDtuUDkQ1WuxXusp92jI9sq/ixKJ
         I/Kw==
X-Gm-Message-State: AOJu0YzHstHYbczOSutGiiW6SRxdSYlV7frDqUoIsKaXmo6jy08S2qR5
	F4fKvksjUuQybznr61pJm8S+X8548xVW0EKqPK3pjiMsL/Y/ZD67zVltomOeyw==
X-Google-Smtp-Source: AGHT+IFQ983lpMd0pJ6RlhDSmgbYDiuSsSNqiygNAQX6dxtNYa8U+ZIL02dNUw72eCVAL7YnozmgBQ==
X-Received: by 2002:a17:90a:b38a:b0:2e2:c69b:669 with SMTP id 98e67ed59e1d1-2e561a0119cmr13253853a91.27.1729530498588;
        Mon, 21 Oct 2024 10:08:18 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad4ee3b0sm4105080a91.42.2024.10.21.10.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:08:18 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: James Prestwood <prestwoj@gmail.com>, Martin Petzold <martin.petzold@tavla.de>, Denis Kenzior <denkenz@gmail.com>
CC: <iwd@lists.linux.dev>
Date: Mon, 21 Oct 2024 19:08:12 +0200
Message-ID: <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
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
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On October 21, 2024 5:23:14 PM James Prestwood <prestwoj@gmail.com> wrote:

> Hi Arend,
>
> On 10/21/24 7:40 AM, Arend Van Spriel wrote:
>> On October 21, 2024 3:34:46 PM Martin Petzold
>> <martin.petzold@tavla.de> wrote:
>>
>>> Hi Denis,
>>>
>>> Am 19.10.24 um 16:41 schrieb Denis Kenzior:
>>>>
>>>>>
>>>>> This is a more or less common setup for embedded environments. Would
>>>>> be glad if you could double-check if this could cause wrong initial
>>>>> connection (weaker AP).
>>>>
>>>> We can't help you unless you provide logs.
>>>
>>> We are now in an enterprise grade Cisco roaming environment. Initial
>>> connection to the (open) network was possible and routable with
>>> connection to our servers (!). However after like an hour or so the
>>> connection was lost. And then re-connection was NOT possible (both
>>> autoconnect and also not manual connect via iwctl fail).
>>>
>>> Please find attached the log output: logfile_tavla.txt (with brcm and
>>
>> The log output is not hard to read. The brcmfmac indicates it does not
>> support the requested akm suite 00-0F-AC:12 (Suite B 192b).
> This is actually the OWE AKM. The last byte is 0x12, not "12" in base 10
> :) Does/should brcmfmac support OWE?

Thanks, James

I have not seen patches for OWE in brcmfmac. Looking at the supported ciphers:

 Supported Ciphers:
  * WEP40 (00-0f-ac:1)
  * WEP104 (00-0f-ac:5)
  * TKIP (00-0f-ac:2)
  * CCMP-128 (00-0f-ac:4)
  * CMAC (00-0f-ac:6)

The error message seems to match with the above.

Regards,
Arend

>
>>
>> What capabilities does iw command show for the wifi device? Maybe the
>> driver announces something which the firmware does not support.
>>
>> Regards,
>> Arend
>>> iwd - no debug) and logfile_tavla_debug.txt (iwd with debug and manual
>>> re-connect attempt).
>>>
>>> I have now enabled "--debug" and it would also be possible to remove the
>>> network and do another full reproduction with initial connection.
>>>
>>> SETUP:
>>>
>>> SoM: Variscite DART-IMX8M-PLUS
>>> SoC: NXP i.MX8M Plus
>>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>>> Antenna: Laird FlexPIFA
>>> RootFS: Debian bookworm
>>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>>> Network Daemon: systemd-networkd 252.30
>>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411) + ELL
>>> 0.69 (7bed251f8020ef896043f008276f41cd13fdd43f)
>>>
>>> KERNEL:
>>>
>>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from
>>> https://github.com/varigit/linux-imx)
>>> BRANCH=lf-6.1.y_var03
>>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>>
>>> FIRMWARE:
>>>
>>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>>
>>> From:
>>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/



