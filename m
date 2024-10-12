Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B11F5FA
	for <iwd@lists.linux.dev>; Sat, 12 Oct 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733905; cv=none; b=J4nXcN0wOzesJ3hoRZ7+Ll2Wi566WS01NQ3KJyBrzjvBEpuV9Nn4f1Mr2JlJMx2HpjpXgtMP/u6tnNnMpMM0B/0tfUbNTD2rdVg23snhDuxja1h2KsxEkaSFF4Yop48q/2THshGuGDEJIaVfH4ElDNaD9bZhHVNSGR/UBXZSWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733905; c=relaxed/simple;
	bh=S9qNqygpnmFEjP5IDqOPwjt36kq2betntRpxb2snp4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWnctOqpstjqJJtS1Uggf3/J5EsuaIesO3/rjHKz+LpK9/MPwrrNtan/Pyz1HrGOg0Y/PFGfp+jR4R/0lRFDqRFVfy5DRxUue/4XlYbqfKqVrJdhxzqf+qzs/Zic07I+yY3VdLraMBwUTsN0cMj5+cDKFMGh0ksSesQJmhHYpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UdT6IK3+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UdT6IK3+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c70abba48so19246965ad.0
        for <iwd@lists.linux.dev>; Sat, 12 Oct 2024 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728733903; x=1729338703; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SQlZR2GQqKrdmbs/F4SwP3BjbEWk+MoHNKz1PJor+aw=;
        b=UdT6IK3+L4IdGSQwz68luTIVRtbpLWfTJZYk+Gmvt9hqJinRC6F2C1IIRNgHTTCvTb
         iu2iqJM7gCmrxj6m34pi6opgBScUpDbMorRgMcp5b/GXTHDpiqQitLQcK8WcXBODLELs
         gj6Q/BlecJBoZLMfB1GJ4h/QjrvagJjkT5018=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733903; x=1729338703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQlZR2GQqKrdmbs/F4SwP3BjbEWk+MoHNKz1PJor+aw=;
        b=vyaGB5kuxb/W6pNp/DUj9tiTA5jM/i7CXbDlzCe+sou1KA10Ial21tTxFLKH+Ov8D5
         LEC9urwqWC451MoOFngibn37ya1O3VA5dYlaTGbo4MRGIAGCB2Hy7CWLAtgi5obZKM1Q
         8a3+Oa8IrLRrDXVwmmO9npNxCbbPslpssoNiLTyqLM2DGsyjOskR4fh0D2I9WX0NlVro
         rWsGlLKeSZOr19rjJ5aVnI2MHpUfUNlyCFAhkJUi0wWbbqxnV8Oexp+/7qtfaz2Z/4/A
         ByX3CRBs54U9s9cmJyT3xnVYiVoTPMkM7ij5FeYu0MxDpqoYj5x9XILQ8hDGOSIXWZvZ
         c8zg==
X-Forwarded-Encrypted: i=1; AJvYcCXBYeHE9ndLiMQmeYWnTEB7wOIRe+nceqvqM0fnRgIlQ0YzNNSRuN5kXN5pW85nnIkxHdY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxisrHqGd7N9g310iDifdDc8/xiSGQp/hHoYdE66AZk2XyxEZFz
	FChM/NDmb0UGBupXrFx9euzUdceoswmulJRf16LHmPvhKdks4NLLN4IHoKjeFw==
X-Google-Smtp-Source: AGHT+IGLLxIl4V4J5AnbIuIv7Tf6mEPwiafiOu/MZ2aQM3T6TGqJ91oSL1doEkIzXqbmg09ustZ5cg==
X-Received: by 2002:a17:903:4410:b0:20c:771c:b5fd with SMTP id d9443c01a7336-20cbb27a7e7mr38838325ad.60.1728733903231;
        Sat, 12 Oct 2024 04:51:43 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad32d0sm36228465ad.46.2024.10.12.04.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 04:51:42 -0700 (PDT)
Message-ID: <e27b082f-15eb-412e-b1a5-292b17080cc4@broadcom.com>
Date: Sat, 12 Oct 2024 13:51:38 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <69cc8b13-e6b4-43c5-8ba3-7877a75f0581@tavla.de>
 <717feddd-8756-4271-8c05-5ef46ff9e8d2@tavla.de>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <717feddd-8756-4271-8c05-5ef46ff9e8d2@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/2024 1:06 PM, Martin Petzold wrote:
> Hi Arend,
> 
> Am 10.10.24 um 10:06 schrieb Martin Petzold:
>> Hi Arend,
>>
>> Am 09.10.24 um 18:50 schrieb Arend Van Spriel:
>>> On October 9, 2024 6:07:16 PM Denis Kenzior <denkenz@gmail.com> wrote:
>>>
>>>> Hi Martin,
>>>>
>>>> On 10/9/24 4:43 AM, Martin Petzold wrote:
>>>>> Hi
>>>>>
>>>>> PROBLEM
>>>>>
>>>>> We (still) have some trouble with IWD together with brcmfmac. We 
>>>>> updated
>>>>> firmware for the chip (Infineon CYW43353) to latest version 
>>>>> 11.171.0.24 and also
>>>>
>>>> Ugh :)  That stuff is known to be problematic.  You might want to 
>>>> involve Arend
>>>> in this discussion.
>>>
>>> Is this specifically related to WPA3 or in general? The version does 
>>> not tell me much and I don't have access to Infineon firmware to 
>>> examine. I do know there are two variants floating around regarding 
>>> WPA3-SAE support: 1) supplicant in firmware and 2) using EXT_AUTH. 
>>> The latter is supported in  downstream repo on github, but it has not 
>>> been done in upstream linux-wireless. I did post patches for testing 
>>> last month. 
>>
>> I was able to migrate to NXP kernel 6.1.36 with Debian bookworm rootfs 
>> containing IWD 2.3. I will try also to build IWD 2.22 later. If this 
>> setup / configuration makes sense I would go to roaming environments 
>> again. However, I have the following questions and please find the 
>> configuration and logs below:
>>
>> 1. Why does brcmfmac report "Using regulatory domain US" even though I 
>> have set "ccode=EU" and "regrev=116" in /lib/firmware/brcm/ 
>> brcmfmac4339-sdio.txt?
> 
> I had an entry in the device tree (laird,regdomain = "US"), which seems 
> to be stronger than the value in the brcmfmac4339-sdio.txt. Can you 
> confirm?
> 
> Now I don't get any output like "Using regulatory domain ..." any more. 
> How can I now be sure that EU (ETSI) is used?

I really have no clue. This is not in the upstream driver so I assume 
you are also using some Infineon flavor of the brcmfmac driver. That 
device tree entry is definitely not in the bindings specification.

>> 2. Is it the best approach to use firmware for Laird LWB5 / CYW43353 
>> from their Git repository (laird-lwb5-etsi-firmware-11.171.0.24.tar.bz2)?
> 
> Here I switched to newer version 12.29.0.22. I assume this firmware is 
> the correct one and should work with the Kernel brcmfmac driver 
> (6.1.36), right?

Sorry. No answer to that. I have no knowledge about distribution 
packages from Laird.

>> 3. If you say roaming can be handled by firmware (driver?) OR daemon 
>> (IWD), what is the best approach and how to configure it?
> 
> This question is still open for me. In general the question, will 
> brcmfmac work with the laird firmware and IWD stable (really good) also 
> for roaming?

In general it is best to let firmware take care of roaming. You can try 
using the module parameter 'roam_off' and see how well IWD takes care of 
roaming. I have never used IWD.

>> 4. Is it valid to always use brcm-patchram-plus to load the firmware 
>> on every boot?

What is brcm-patchram-plus?

>> 5. I see the following error (more log below). What is going wrong?
>>
>> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
>> load for brcm/brcmfmac4339-sdio.variscite,imx8mp-var-dart.bin failed 
>> with error -2
>> Okt 10 09:38:19 tavla kernel: brcmfmac mmc0:0001:1: Direct firmware 
>> load for brcm/brcmfmac4339-sdio.clm_blob failed with error -2
>> Okt 10 09:38:19 tavla kernel: brcmfmac: brcmf_c_process_clm_blob: no 
>> clm_blob available (err=-2), device may have limited channels available

Nothing wrong here except that it does not find a clm_blob file.

> What about the "clm_blob". Is it required in file system for 4339? (I 
> don't want to have limited channels)

What channels are reported if you use the iw utility?

Regards,
Arend
