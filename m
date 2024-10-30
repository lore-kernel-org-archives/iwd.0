Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99B1D1E69
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320510; cv=none; b=soSVKsCKBRdcUVicVxq3VZHhbSZCb4ac3o0kyCTyHNPvgC6iZkCHdv4pdiBWAW3+Lw7gfn5su2DRThpAQiWStgSxX/TWXA/2U+9PawReXqmKPQqIo080ltzscLlbosg8gatRPuMiWu46/WcTH2g34qy03ypskWnBIsAS9tV03QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320510; c=relaxed/simple;
	bh=nm+u2p8/E9EdTobWotaSCbua4n4weOoPGqQg4Fp7Kds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIwZk5nOIHkWWTyCwPY8/zXMRXMHp7XTQoMDwZWQNCpH3i0cKAovkJAZJ/FSKXxKkhwMdqG2oxFZBL1sv9D6cCnp8yF9/T9+DR4tlyRS1CAMlmdD/SzUkjI4LZNiOLdYBz7dwTRWO8Iytq6eeLujB5JC0Pd5xjXuDbL1/xmevUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if26d+eK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if26d+eK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so173679a91.3
        for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320508; x=1730925308; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ury1G0RGBmsw6a5AeCUJzaer5rgE+5qkXjG6QJuktBw=;
        b=if26d+eKEh+Q0FfPk6UwmFQJj+FIeEoRDrLNevkdPmc+uuv+1FBeyTO7MGh9trtsf3
         l9Rfn15CnnhtKYM/BmeAra/TbqXB5kKe0Dtde2hi7w+jssi7llu8dYzy6kt+rCUszjJl
         tF0p23zPA0CisBV8jd/AwF7DQkMYtNjMB3by3qAMfAAtqPE2IpEzrsVeYiSih8Ri9MIq
         5xD7206lqCQJOB3YpNhGOSwYjyc1TKDX9peYsuv4S0ckA+p+SgsXB14f13n1+Zm6YDco
         tSTF0WkAuiVgMZJL8VNM55FackjJgMMEBgq7y4Futgy+FpL8cC9lyojpKR45/aEkiegn
         f7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320508; x=1730925308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ury1G0RGBmsw6a5AeCUJzaer5rgE+5qkXjG6QJuktBw=;
        b=sJ8M85e8JazXUGXkbWsmUo1BcZJFOfL2fSO6t7f5P6s3BNMsxZuYUNmr+lbzbNKoMc
         QquhQiYnp6WmASDT3b6XCTK2MJWzD0EQrCn3LiWVEng8ItEPLsctNj7tati0T06uPOdM
         HtUBd6oU/5wWcMgyJG2dPhqcUiI/+M82uG1R4UEL0e0NvPIZZ3hUZTYdepSoySPpmz6d
         6KZJtb4ClrvOvQ4KXq35yD10Vi14SpYEA6i/JYKROJV/gk+lI3PCdiIt/t84z4BmKSDs
         Wo1oHUdtXBISFJfaTQoLK7gcmnk9lG628GMISwQa1prJuyueOGFTG5DsKPAzFLBVseeX
         NVPg==
X-Gm-Message-State: AOJu0YwZ8j/XR485Nzne6sQi56P4H23SF8HF8ISRhLdEaBqFY97zW3OA
	Zr7BZFx3kswD+CBRZ45NutXBMYciBOQ9g+NSuFco6tmQXZGPpS/eEVPRgg==
X-Google-Smtp-Source: AGHT+IHQz7XIPPo50IlcGRlH73oJBj55t75daBhSwGrZ8elpN3q9uhP00/qMzs3/tzmu8ZAO52+6IA==
X-Received: by 2002:a17:90b:4d05:b0:2e2:c6c2:b3d5 with SMTP id 98e67ed59e1d1-2e93c14e8a5mr927977a91.9.1730320508288;
        Wed, 30 Oct 2024 13:35:08 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac4f1sm64859a91.15.2024.10.30.13.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:35:07 -0700 (PDT)
Message-ID: <a68ea32b-e960-45cc-9e2b-193e624908aa@gmail.com>
Date: Wed, 30 Oct 2024 13:35:05 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
 <bc387186-dbd6-4ab3-adfa-2a8d0f7bcc71@gmail.com>
 <629def8d-2c7b-483c-8e2d-d73467a14486@tavla.de>
 <b134a703-6747-4b1a-a022-b61f7e282bfa@gmail.com>
 <5e9122b7-dcee-4e98-8b8f-9c623276a5db@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5e9122b7-dcee-4e98-8b8f-9c623276a5db@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 10/30/24 1:26 PM, Martin Petzold wrote:
> Hi James,
>
> Am 30.10.24 um 21:15 schrieb James Prestwood:
>> Hi Martin,
>>
>> <snip>
>>> Okt 30 21:10:43 tavla iwd[1212]: Wireless daemon version 2.3
>> Your using IWD version 2.3 which doesn't support that.
>
> Okay, thanks. This was another machine (Intel wifi) with not most 
> recent image.
>
> I have tested "PowerSaveDisable=brcmfmac" option on the machine with 
> IWD 2.22+ and it works as expected.
>
> Is this feature actually a IWD featuer or rather a kernel driver 
> feature? Does the brcmfmac driver have something like this, because 
> with modinfo there is no related parameter?

So IWD is just calling a kernel API to set the power save state. Its 
driver agnostic (though it wouldn't surprise me if it didn't work on 
random drivers). Network Manager and iw are both using the same command 
IWD uses to disable power save.

The driver options like for iwlwifi are different, these are disabling 
it at the driver level and those options are driver specific.

>
> However, on the Intel machine I also wonder why the following doesn't 
> work also:
>
> -----
>
> tavla@tavla:~$ sudo reboot
> [...]
> tavla@tavla:~$ cat /etc/modprobe.d/iwlwifi_power_save.conf
> options iwlwifi power_save=0
> tavla@tavla:~$
> tavla@tavla:~$ sudo iw wlan0 get power_save
> Power save: on
>
> -----
>
> Thanks,
>
> Martin
>
