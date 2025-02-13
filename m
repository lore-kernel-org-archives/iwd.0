Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584C26B098
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460247; cv=none; b=EvM3Srgb3GPTXXQDjaOzFpnNTeb/yFqtDlq5v6INz7Dl2nTsdMj52NRgtLr3OPWL8XNT2LH0JqYYnSxwnrhNIGPPnfe59xjWj0OMHKghTUYWpyG6eJRq7QlJ+BYdHTQGRgnncWyrfmx3xCglxcVFUKC+r55a/z2onexHHkNdbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460247; c=relaxed/simple;
	bh=N5xuakCQAX0zP/PtWcenCK0FcNwI7LcCB7/23ZkvjwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oW8VEKUfmUw/dl0oj7jF1ORUME3IaBLjT1gMWhClZIw2FhKRi/N+I2KZmsse/HJotxCrvj7AEoa0IY2occ+FeNxLhznA86IlcUAOFNLXFrNKyiwzin/M6NTllrSKxarvxwl6m2AgRF4uMIK+5z4M5I43m0gluo1Zj9TIrzrVSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDqgXOCG; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDqgXOCG"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fcad5ee945so435154eaf.1
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 07:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460244; x=1740065044; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kPsEKuOIqCAGUgFvRZzVnpzVt6VcgT3XJAs6fQ4VS0=;
        b=XDqgXOCGWDt1SCqozsHiibfkr/1S0EuCLWwXrtRXSgFjNYPCap00s76MOyaVehJlXZ
         HYBEvd9QY+kZFWWX836aUDMo4ZBr3A4SvKx9WP6u9zQwiOJhBppthW6JviFb3m1wBaIf
         kxW6e1mqMgtZrWgOX+JldRjPVP/EUp7f2rKSI4CgoZkUP1i5SdyM5h006jhyQx53AUjw
         JDKTf9N1ttyRDtqT02hfcggThcKQxrO/8fOvLIEFP1nMFg47tSLUScFo4Kx6egbYnFnd
         saivCstpaOr/AaUDKBOzcZAoKp5y2PadpxW6M3Cdf8Bsi8MrZYpj0FBIsGxcQy0GX6xr
         BW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460244; x=1740065044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kPsEKuOIqCAGUgFvRZzVnpzVt6VcgT3XJAs6fQ4VS0=;
        b=iXII1o13LWQNfdqURO7J29kJ4+sWTM/dHCIge/XCTyihJoLvqlSpBTMrnBMkQwyXBn
         231jUMcm5B1TqFIOGcF9QEHziv/5NPISJKWZcxFYWrEE0/hVIxRdLMoJBT+GmYa3kn4T
         dZP3sE7CqULdJS+4UBu8GA9Q6lqhs/yVsZ+eWTJ09Mgb7n6XyKuIpshluSRIzOAyAFCs
         cdRb55YfgstFtD77XPoR941ezRl1tjYqbQItXrMbkb/4hoWCS18IrDK/13dce3mX4SyA
         lKy8WO5qE0JoyaPAGAQLzi7+BMPOtElu5EtuowE+V2KiRTVeIxVDBtgqvF4/QDYB6Hag
         lQmg==
X-Forwarded-Encrypted: i=1; AJvYcCU00kNFQys6OJusvQV3rOKc7QQKjmNV3ztDGezEn/gXYRc1Owk1LNqvi8tY/S8iXeGqTAE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6VZ7mZnwYf6tM0wG3/2ItiLOLO08XVDwQb+9LwKYahTpYbR6C
	fqcvO6jKu+59ypnCnKge+KJjFllaxx5oRms6QyX5by8SJodNE7R+
X-Gm-Gg: ASbGnct7uBW+Iqp8Xf93j3NRd6mSoqyVYrX6KGeu8zofMztqBpHC12wdZ3yx8t+KGyl
	i61mghP28Zo2XfZ352P36Yoc4H/QPWu8xQlUFOe39iarp6V7V7RKQwgP9Nl65Uf/3s+Ht2jOQKR
	yEVW0Nerr25pLbHKPiicsmqr3p7EO3DTwV/5bf/r54Lpilan0pwbVlMHcNW+NhRgcDepAeW10Ce
	2a7ENtMJad687mWc9Q7JP20bKalDo4betqxE8n2C9A7ycR1UrMiWI1nNjDjnDHPfyNAYxvaAPk0
	zusP5Gd6gBJr2KK3pjq84xF8mR0AUwXqItlrcYGEqDO9fZaG4AmXJk9H
X-Google-Smtp-Source: AGHT+IH+/zExbo01r/+2xJ7aIVL35pst2ua9zkrd11mYOEoRpdw1wjzWAvMcAa6AAm3Nk6w15GMU3Q==
X-Received: by 2002:a05:6870:c49:b0:29d:e45d:dc51 with SMTP id 586e51a60fabf-2b8fb13cea6mr1951095fac.2.1739460244431;
        Thu, 13 Feb 2025 07:24:04 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-727001cdbfbsm649594a34.7.2025.02.13.07.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:24:04 -0800 (PST)
Message-ID: <9eb9d215-8a21-4d82-9da7-50077dd63e13@gmail.com>
Date: Thu, 13 Feb 2025 09:24:02 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Roaming questions
To: Alexander Ganslandt <alexanga@axis.com>, iwd@lists.linux.dev
References: <7b7d342f-0487-423b-86d0-fbbf5987ecfd@axis.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <7b7d342f-0487-423b-86d0-fbbf5987ecfd@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander,

On 2/13/25 9:01 AM, Alexander Ganslandt wrote:
> Hello,
> 
> I'm looking into different roaming solutions and currently evaluating iwd, which 
> seems promising so far! My use-case is a device live streaming video while 
> moving around large areas, and the goal is to do so without hiccups in the live 
> stream. I have a few questions:
> 
> Looking at station_roam_failed(), it will schedule a full scan if the previous 
> limited scan failed to find a better BSS to roam to. A full scan on our chip 
> takes about 7 seconds, which is often enough time for the signal to get low 
> enough to deauthenticate the station when you're moving. It seems to me that a 
> better approach would be to schedule a scan for either the "known frequencies", 

The idea is to use neighbor reports when possible.  If neighbor reports are 
supported, iwd scans the frequencies in the neighbor report.  Otherwise the 
limited scan uses the frequencies that iwd knows the network operates on.  If 
the limited scan fails, then iwd falls back to the catch-all full scan.  The 
hope is that falling back to the full scan should never happen in practice.

> or all non-DFS frequencies (since passive scanning takes extra time) or some 
> other popular group of frequencies that won't take long to scan. If we're lucky 
> there is a good BSS in that scan, otherwise we schedule a scan for the rest of 
> the frequencies. In the worst case, this should be identical to a full scan with 
> minor extra overhead. Do you have any thoughts about this from your side? Is it 
> something that could be accepted into iwd or could it cause issues for other 
> use-cases?

If you find that full scans do indeed happen when roaming, then introducing 
intermediate limited / non-DFS scan(s) prior to the catch-all scan would be just 
fine.

> 
> Another question is about the "CriticalRoamThreshold". There seems to be a 
> config for this and some functions for lowering and raising the roam threshold, 
> but I can't see that they're called from anywhere? It seems to me that only 
> "RoamThreshold" is used, or am I missing something? There's also a hardcoded 
> delay of 5 seconds from the point where the roam threshold is passed before a 
> scan is started, is that just a "hysteresis" to not immediately start a scan if 
> the signal temporarily drops, or does it have some other function?

This is currently used with the Affinities property on the Station interface. 
For now it is only useful to lock the station to the currently connected BSS to 
prevent roaming.  For example, for the duration of firmware upgrade or similar 
scenarios.

> 
> Thanks in advance!
> 
> Best regards,
> Alexander
> 

Regards,
-Denis
