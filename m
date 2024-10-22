Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3F1BDA9C
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618862; cv=none; b=L1zEKpQWNCk3r56IdYy8qlH/d6ioaVRd64pxXGCn/C6dL4ykqy7XZwjOiuudfykt6IrwIjyWWKjfUvdV7+ZhK8Ggghy3++Q8pczSp+DK+SeJgkEt+XorUbYvxW/HBRaxou3zrE8sOLpGMdpJk/+9v6ZBsDw2Vmo8Cr2KckIJrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618862; c=relaxed/simple;
	bh=JfFgpDp+krWmP05lsEupHilzISJZIwTCSSF1zLmdiM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMwAFAuGUg/N4YOS6+B1nrKukVj8agpKr91VzCxCvVy8iYidg6qJ53hdOpI6ByExDNZRZa0axbVuJpqq6OncQYvC5n3/vNk2sjOU8mInCCZIKHjzYAfY7aDBlDkD9C7Xitf1ifdkmoGhiBshGs1Arg9NHeK2CD2F+IutJpQ0Vmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUod3Qxm; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUod3Qxm"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2883e3f5419so2624836fac.1
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729618860; x=1730223660; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7m9Ns0/oPxYDLRfRtWtz84WHe9W5ft5iFOPPMMicO1A=;
        b=nUod3QxmovaxqyDi6aQfnWB+sfkHnoRApOSD3GzDuDhlzhjlkE2JKWm++vadWrYdF1
         +medYldM6ZkHCkSD/wYZL1RUCZxnUVLsPHdP7mP9dF6Y6u5ggkfnB36vc+fV07FJfhzb
         dSJ1CVojvjBosCMoIeYfIenqaBNoluuqM7S/yl9uaUkmFjDgTy6/OJ8dQ00J1gtCBU1w
         cQ6FeXqE/iCRlcoc12o31ogo8otgNqLdux6KJeWCmhAKm+vKHaZW/N+ArPWrlfho6aCF
         iTysmbkncm9vKqPR7jKGT5HDYBbUt9UZUY8zCoghsQQvPiURSe5AIlEupoQ1mvzuLawv
         6l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618860; x=1730223660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7m9Ns0/oPxYDLRfRtWtz84WHe9W5ft5iFOPPMMicO1A=;
        b=OBHrfeVVdnMAjBLvUv08L2/qgS4gnLTfTYS5xLP3AVl4ubRuau3lTzx4MTFkD+72I1
         BM357KDgjU9caWZIer1ccmn3RNweMEkdt4+4FGg19gWHMn0W6H58gy1konHxJGGufqT7
         aU3hrl0FeJ/Wx632rSfJ2SMIdVKJbMM3DwCYysdSBbBsd7kXwGbpJxoTdyaZ1m9gvlck
         /qTCBzWbnFuTcLKOcl6c2HO9SSqZ6o1puSpF4LlNqIvKiMsamSdOmmgPRFEx4yH7F+ro
         pe8WhC5mto2CqzJUCXxjdCPtMYwJFSOqnn9c5GWv6VAaMUQvQxLD8gMnpwyw4D9pSlkC
         ShWw==
X-Forwarded-Encrypted: i=1; AJvYcCUvd4vmkCWs/6G6NtItPAaLV/dDTxi5suA4wnzRw32WGKDXqcu32wCFkwvEoVc1ZsphW6Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsno0fBdp8s3sQnR0wetC3ukWxfDQtr1kmhbZePtSwtu6xFH78
	Hakn2y00YMhTUUAXrtCD994Pl0Bs1E+sjOTpwZPkL2eMBhiHZU84
X-Google-Smtp-Source: AGHT+IGwec3XySGkKB7e3o74xHkHaO2xHbVcvDYhh4aDbspTYyvI+7zmNkC/nCyZlcXcmSu/vBQQ1Q==
X-Received: by 2002:a05:6870:d113:b0:278:222c:98c4 with SMTP id 586e51a60fabf-28ccb510ff1mr34474fac.21.1729618859816;
        Tue, 22 Oct 2024 10:40:59 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a034c3sm300212985a.65.2024.10.22.10.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 10:40:59 -0700 (PDT)
Message-ID: <f1f2b4cc-367b-43df-a637-b380d979e11d@gmail.com>
Date: Tue, 22 Oct 2024 10:40:56 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 KeithG <ys3al35l@gmail.com>
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
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
 <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 10/21/24 3:10 PM, Martin Petzold wrote:
> Hi Arend,
>
> Am 22.10.24 um 00:01 schrieb KeithG:
>> Arend,
>>
>> If there is a patch for brcmfmac to use CMD_EXTERNAL_AUTH, I am
>> interested in testing. The last time we tried, it errored out and did
>> not work as expected.
>
> Support with our current chip for WPA3 and also OWE by offloading SAE 
> etc. to IWD. That is possible?! This would be great!

Have you also checked with the vendor (Solid Run?) if SAE/OWE are 
supported by the hardware/kernel they ship with (even with wpa_supplicant)?

Thanks,

James

>
> Thanks,
>
> Martin
>
>>
>> If the patch can be applied to the current, RPi 6.6.x kernel, I can
>> test it on my Pis.
>>
>> Keith
>>
>> On Mon, Oct 21, 2024 at 1:26 PM Arend van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>>> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>>>> Hi Arend,
>>>>
>>>>> I have not seen patches for OWE in brcmfmac. Looking at the supported
>>>>> ciphers:
>>>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>>> My bad. Always confused by those concepts.
>>>
>>>>> Supported Ciphers:
>>>>>    * WEP40 (00-0f-ac:1)
>>>>>    * WEP104 (00-0f-ac:5)
>>>>>    * TKIP (00-0f-ac:2)
>>>>>    * CCMP-128 (00-0f-ac:4)
>>>>>    * CMAC (00-0f-ac:6)
>>>>>
>>>>> The error message seems to match with the above.
>>>> I've never seen support for OWE in brcmfmac mentioned.  OWE requires
>>>> CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive the
>>>> PMK, so iwd can't support it on FullMAC.
>>> I have never seen any mention of OWE either. Regarding 
>>> CMD_EXTERNAL_AUTH
>>> support I recently posted patches on linux-wireless list as RFT. There
>>> has been zero feedback and so I assume also zero interest. In order to
>>> use CMD_EXTERNAL_AUTH the firmware needs to advertise "sae_ext" in 
>>> fwcap
>>> debugfs file. So if Martin can check that, ie:
>>>
>>> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>>>
>>> Regards,
>>> Arend
>>>
