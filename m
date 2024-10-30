Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006548C1F
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730316204; cv=none; b=mMR/mAVJdtJ0Jarl9tL+/0zqSTsjCmdYh2Gtf+C5N5ZphNhjyt+yowty1SGtgiV3ZU1xR7v3fQr9BV8LfeoGeb6p++bqA7DkMpzbs6Ai95qpOwfvgVTYwr1TeBZtgtHVwRTY/zaOij3ubT9zS/Oo2BE+u3Wt40Xh7KfHc/3LS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730316204; c=relaxed/simple;
	bh=EuIhsIq8WoYzMqL9v52uKudbgayMkF/rZA0QuYBoQ/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpCsVmBQg7HrO9mNAynu3i2zZL3AuIusKX1bb9afXu0dnOuc4Te4nsEOp1iul+10xJPmlYN41jB3zRyCYqF/blxgh9X3N51OunQowBIHUlT0o/khFMuaVgvIO7IYwZKPpUjTyqBnOu5udVFoWgzcfuomFH2yrBxovYFVSz1Vxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5W0mTfh; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5W0mTfh"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b8b34be9so657805ab.2
        for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730316202; x=1730921002; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twNemUZszr254HiskuOGoEaaM6j2TQ+ABmuIt638ujs=;
        b=h5W0mTfhNiBPmKUNVfrREv/2DdwI/Jtj0EdJDxWHDomdfjbVpl1N+5MDunRSN3uAnm
         DB1p65aYyd8RtWHswgMdQcdMtWST3PXG8U4Y+DUX30jOXfX9pxl+zijxioDwMsh+Zhwm
         e0AVGFqUagJSU4w3FeKxS5WQpSvwFE28nO0yt8u1qF2xjr4RtskcGneMwH4TSQoS8KMb
         uuRBFCKMTaOBwjX8//QoOYimOZcEsYi07t9op6sqd0dz0BB2HilJ4ZrXmG2nc7enWBlA
         z8mEGYFWTwdAHAEgxVgrV+dJRAUUI7qw1VggayZlvBAK0WPzgNqcHim9tUE7xeYpb3wy
         7hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730316202; x=1730921002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twNemUZszr254HiskuOGoEaaM6j2TQ+ABmuIt638ujs=;
        b=I8w+Q9Lmz2Oh7iSZ7ua8goL5tPhyTbyQ+Zx2o94dEbnFNR6jAVOENDtTjP2BTBDZnV
         oHIiilO0c1rsTvqQ5o+jFIfA5BSzmCEniN0YAxBfLHlKn2ZtBj6Y7yb1NZ6hevZqYRsk
         iU94jXbm94ygapUwPh6YwFuDobCtAktEpqaxAVs8aXDt0ANjBYa2N4e3PVsKE7VziWE5
         2zXVcxhXsoNfClcGOZBsYmh1I26jOHF8+/u85Q2fc/2ajb7CoZ175O6JB/cxeOVF74+B
         lVwKfEY909Oq3KtB3K+QtF3vnZvj8qbxFbK/L67b0r8Qflew5sn5QLL4PGCOTt85q4Hc
         m6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV8Rpi7LKl5p9yzlFisGHbfLcfbea3w5YOBh2xtjhtOXpdv8P5l/NmyOQ3DVKtVLNswUD8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxvr+osr6UqME0INSsVzYLPUcC0tY++AOHuq8R9Ystu7s3SiCKf
	aUPTQccRYktnNTHHMseIZU8VBWxUqnpDV1J7Ey+Z6uSkj8Vbxgqy9tONcA==
X-Google-Smtp-Source: AGHT+IEnTrr9gliysvx/71oE1RelqWazZeu3+lADULSAavmEXseiHhh30J0Jt4uA4W9nnha5YkFBQw==
X-Received: by 2002:a05:6e02:1c89:b0:3a3:76c3:fcb0 with SMTP id e9e14a558f8ab-3a4ed36b723mr154643065ab.26.1730316201991;
        Wed, 30 Oct 2024 12:23:21 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eddc19e368sm6647657a12.14.2024.10.30.12.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 12:23:21 -0700 (PDT)
Message-ID: <6ee4f461-45c5-4be4-899f-61ae080689ee@gmail.com>
Date: Wed, 30 Oct 2024 12:23:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <69cc8b13-e6b4-43c5-8ba3-7877a75f0581@tavla.de>
 <717feddd-8756-4271-8c05-5ef46ff9e8d2@tavla.de>
 <e27b082f-15eb-412e-b1a5-292b17080cc4@broadcom.com>
 <afddc14a-0806-44ea-a2a9-a6cdda694a1d@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <afddc14a-0806-44ea-a2a9-a6cdda694a1d@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/30/24 12:19 PM, Martin Petzold wrote:
> Dear James,
>
> I am still investigating several things. Also it seems the related 
> roaming environment is quite a challenge. Maybe if we manage this one, 
> others won't be a problem.
>
> Am 12.10.24 um 13:51 schrieb Arend van Spriel:
>> On 10/12/2024 1:06 PM, Martin Petzold wrote:
>>>> 3. If you say roaming can be handled by firmware (driver?) OR 
>>>> daemon (IWD), what is the best approach and how to configure it?
>>>
>>> This question is still open for me. In general the question, will 
>>> brcmfmac work with the laird firmware and IWD stable (really good) 
>>> also for roaming?
>>
>> In general it is best to let firmware take care of roaming. You can 
>> try using the module parameter 'roam_off' and see how well IWD takes 
>> care of roaming. I have never used IWD.
>
> What will happen if I use 'roam_off' to switch off roaming in firmware 
> (I understand roaming is done in firmware and not brcmfmac driver)?
>
> Would you expect it to work? And IWD taking over as it should?
>
> Additional question: Could there be any power_save enabled in my setup?
>
> (btw. some online sources tell the parameter 'roamoff' and not 
> 'roam_off')

IWD is not going to be able to roam because full mac cards don't expose 
the ability for userspace to control that, or didn't at least when 
fullmac support was added to IWD. It seems like this might be changing, 
but at this time IWD likely won't roam. And if the driver doesn't 
support CMD_AUTHENTICATE and CMD_ASSOCIATE its entirely not possible for 
userspace to initiate a roam on those drivers.

>
> Thanks,
>
> Martin
>
