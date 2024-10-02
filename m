Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07F1D173D
	for <iwd@lists.linux.dev>; Wed,  2 Oct 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890809; cv=none; b=EEvziQsVLFOLUI+h3XwVO/QCcjzOLfHGlG/yRjfiDs552jwKJ2L2r8AHzQK/vlaGhQuimaHHXsqyMzvcwrtiraIuHhfAmgxJjxIDrPtHi3yBBMzdZEtD9spDPDmpU8315lcs5bJj8aZtTFX87nd5Ns4/xt2TwCIVEMGFy47TDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890809; c=relaxed/simple;
	bh=12p4W3sD1z8jcbg7XCEbEz1NBq1Fe07zHMoZEr6Mr38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zr7qzOblLfk3c8qOkrA0ICCQgPi26xX+tDkVW4ldbmPKgjkiCvyyDJla1feMq19BnmpUE5qRS0ziIdV/YOgE0gTfQTMn2rYGhANTZoW9mi03AdeDRYAOoPLl/dVcNnJolbnqXK5L6G9olOV6qcoloQFM4qRigitX6OPFa3RQMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de8u35sq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de8u35sq"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7ae3fcec5feso7892985a.0
        for <iwd@lists.linux.dev>; Wed, 02 Oct 2024 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727890807; x=1728495607; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLa7dUBQOrNTbSNU0JY/ShelyTu/XIgRHrGRB/6SLvM=;
        b=de8u35sqRPtiOAtiNOBmXNYEY6las//HiBVoHTwv2NfIpe+Q2cv/7BwTkIfxWHLq4J
         xobO3ZBqp638NcvCwQkCEatkZ09tsAFXvt1D8Vtv/zUdo1znLJwdghf4VgnBJ7ntpKIy
         n3tyBJrGrHMwS2NbbrQ+shq+MaFS0NkIGeGj08Pksf6lwxFJK3gDFT6Q3mseiJUcJ+zw
         il3QnhPFfJAwywuiJe0Yc5yHwEOMrI0M8gH8HOdd2fnoWv59DKVwBJN0OtvVc2JAF4S/
         +EwnYxMPPF3Lhj7/WNZYf8zE1Mb2v0sxPAUeZ/lpcuv4RKYyln2md+lNMOzlF/NHAA2A
         Cu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890807; x=1728495607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLa7dUBQOrNTbSNU0JY/ShelyTu/XIgRHrGRB/6SLvM=;
        b=WEqz6K1tFrtOYCKcunfiR+jHP4T0cvVL6nMUhVR0KPnysceHn5UhIKX3OvGUgFvCUl
         K9GBAk2fLCOmQ7Hw9hHtXAi4xM0OgYOz32U80TviEzzfOPb+EUIoiUuF4cjB2V4URvy7
         RGvaWx/WBa7JBGitkEOQAiX7jyPQhMp0y5LmlD7f73Td1FwAhkauPpBw1FXLNlAhPzu2
         IzR3ag86+ysJDpDQjP6m7Wt6W35mozLDLmrdKrZJyJHp6JCKSHFQQrOg8U0PaoB6y23J
         pfuj6wt8Yw12jHXGEYzDhSXfYux5hGwqDlzv8yGx49AyBREzx9RI38oEKW/p072k60+k
         vVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcO3qer0nnyJL9hDy8QQFyNqdK0UB2uzRcD5AQcghEPtg0TwXA7yNR3KJznf9+gVfNlXw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxTcdvFVKMT3vIGjHCvOJOyiX1gIIo/wsT7XI3rt8U5z/cg6M74
	VSkVB2J0UWtfGBu0md8JOLuIzBdUD6ku9J0vF5BtarYqU31YAwTy2ynlzQ==
X-Google-Smtp-Source: AGHT+IEDrebAKPKPZ7AJgS4hHTH/r+eGmM1gzYZHwttS3qyokNGym2J5QuupMRfAMznDcmppN5USKA==
X-Received: by 2002:a05:620a:4310:b0:7a9:9ed7:b49b with SMTP id af79cd13be357-7ae626d4017mr650658585a.30.1727890806914;
        Wed, 02 Oct 2024 10:40:06 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d786asm634342485a.53.2024.10.02.10.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 10:40:06 -0700 (PDT)
Message-ID: <028dc380-a65d-4e4e-aec6-a298318892cc@gmail.com>
Date: Wed, 2 Oct 2024 10:40:03 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interop problem with Quantum Fiber WiFi7 pods (duplicate RSNXE
 IE)
To: Vivek Das Mohapatra <vivek@collabora.com>, iwd@lists.linux.dev
References: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 10/2/24 10:08 AM, Vivek Das Mohapatra wrote:
> Hi - we've had reports of an incompatibility between network manager and
> the wifi7 hardware mentioned when using iwd as the backend.
>
> From what we've been able to tell:
>
> validate_mgmt_ies() fails
> cause: disallowed duplicate IEs in the AssocResponse frame
>
> We appear to have two dupes:
>
> 221 - IE_TYPE_VENDOR_SPECIFIC - allowed

This makes sense.

> 244 - IE_TYPE_RSNX - not allowed as a dup.

This does not. The issue being which one do we use? The first, second, 
Nth element? This is definitely an AP problem.

>
> We checked IEEE 80211-2020.pdf couldn't find specific details about IEs
> that can be duplicated vs the ones that can’t.
> [ Sections 9.4.2.1 and 9.4.2.241 ]
I don't remember there being anything in the spec that dictates which 
IEs can have duplicantes but IWD has this restriction for all elements 
except those that make sense to have duplicates, like vendor specific, 
neighbor reports, etc.
>
> We've tried various devices and software combinations (linux and non)
> and it seems to be an interop problem with iwd specifically - we think 
> adding IE_TYPE_RSNX to the allowed dups list in validate_mgmt_ies should
> do the trick.
Denis will have the final say, but I would say if we are to allow the 
RSNX element to have a duplicate it should include a warning indicating 
the AP is buggy, and a comment in the code with the specific AP/vendor 
information so we know why we added this case.
>
> To summarise:
>
>  - nm + iwd (v2.14) cannot auth against a Quantum Fiber WiFi7 pod
>  - there's a duplicate IE in the assocresponse which iwd is rejecting
>  - we think that IE should be allowed as a dup
>  - nm + wpa_supplicant seems to work
>  - we tried some non-linux device and they were also able to auth
>
> Does that sound like a reasonable fix? Do you want a patch?

Thanks,

James

