Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A62C1594
	for <iwd@lists.linux.dev>; Wed,  3 Dec 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800371; cv=none; b=N027PUGY9q89AjiO7WW1QVpUnaDt3VZQo5xzuraOMfeYQETg2Ren4nnhz+Iayb9f/drYiu5dKJzSznGa8Ys8bjE8rJGf14MiilpAfdGno/RRSPqKUh5ZbvKsAAqfoZjMq9D9Yopn2KuAi/YU/aX1X1LExoxhHAmcaSvNKluTQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800371; c=relaxed/simple;
	bh=vhoW/2e29tyx9IUhJHhtI7SBHZAmjnUfG3p/+sSQWDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lajy3Yz9y+94QtlX8rH5f2pLs5T7XcsJA7tdtJ+1vIDE19itMbp2NWa5v2ISt+MsvoVIVl3+dD3F5DZOfvoVrvqEhIYO2oWE3m8InrKzzeK3TRtL/+wX1Ip4HaElwMewd28VYLkBoIJ1HGVg9q4tt7YY2dwH2XnBxvnwlFRb20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELUKR0jb; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELUKR0jb"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c75387bb27so134156a34.1
        for <iwd@lists.linux.dev>; Wed, 03 Dec 2025 14:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764800369; x=1765405169; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lM3pvjDbJ+AsfnWaKjAUAoGa4NKseHAmsXNqdHzV75s=;
        b=ELUKR0jbqi1GvRR/v8DxiOLaRNSJsr15zymX64hs1aVDwUj4wPCDeWxuev9SwlsjUH
         7lz5qKvkOEblCFTHXywBozBGljTgTAQJf+ue0bsts/FXmiqZjjkoO0kOSSiUER0hlxiK
         oXL3BU1aHqSsPc/KzAbgvc8pCkqKuP+6MfRwUzQxfaeu2K1gbrZIFECqWGS3yTuUChIk
         4w3dKb1yvNlwS80Jknfm68rJFbkbrYyo6SKZUtuCvF9DzykT+imXHK7MAlTWXKV12x9L
         iV044lQd0t8RwZirTxxt+TqAVIuq8Z0Ke6G+Z3i44pyHroEfyOlg9MdMGzQtbxhgXNdJ
         EGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764800369; x=1765405169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM3pvjDbJ+AsfnWaKjAUAoGa4NKseHAmsXNqdHzV75s=;
        b=dYdU9erEghmUIUw4Y6kRwd8rl17/sa8227u0Y5cVgM2CRPO5lQqjmaWvsSE3KOPCD1
         2pVU6FS/wFWzcXbe5bFAuS1dWpUh1A2ky5/lYOPtPU4Qxs8zuyALxbq4+PIBJtesPWal
         2mg3Scz/n+IB8vsmUwVLOnld9bQCGdCedJN5FSw1FatGd1fSIkxInUWmy5w+VFJu0J0/
         bvjEyC/1AhLDbHpYLKnd9aJI6I/fSRc5P/Q35YhVANM3pSOL9YE/5JaeaJsBr7xM92/W
         HA5g1A6/0laRR0tT9cko++/xmCAntnPRTkbMM36bS70WTckF7vC71u+FP4wPqV5FVNTH
         up0A==
X-Forwarded-Encrypted: i=1; AJvYcCV4mOJHYPoF6Tv9vZA31cqvn7wOfYmDjwAjebx/mX/aW0Z8J11nnvuSJxVH70fV16/1Cr0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yww/4RdHGM4Ckk4e727yw50O9JEqWZov/2yimXzInCd8EC//Llq
	kAZgU+yQeEpBDCUN8fzX9kwk9r3q11Noa9qWWmNVeAzub/TVImKd/+PL8qpYMw==
X-Gm-Gg: ASbGncu8ojRo7F6OkfrhE+1fRe+JfJPdS4IFhX04TOzukBk1GdA5Lw2sER5mQLeQKyk
	We+4HGKxgG+f+Mk5t0AiGaWNvH0krEFuXzhU7lfXpdLqTXR+tCYXh8lk6aF3zB/V8TEPIupX6we
	I1MhTKAFuYpLhqB6+3sdp+U57xRwAP90UWE7lQCIxIoSZltHXUmI2r+ehhNCoKspsgWmuGFXqvb
	zJgum00rjfONgg+8Yb3iTTFuWTg6lY2EZDwFjeINFIps+osIT6Rc3iE6TWEuoJnGdQgMFtjt6JR
	Qjv8V9IsrumgDVIJ1G7rz8WViATn3kwQmN2hV8afSgM0qeQ4LgPAOoo+bp9aUSRHOe5S5iv3iki
	rx6RGp5ipEx6HmeHDIRDzeM5GlRhYAHKhyvtMiOMtJ8urnUgHsfaE2a9s
X-Google-Smtp-Source: AGHT+IF1wQiZNqIO/Uxs8fV52mQStzJEOySmg00hz4SIFvBVNwfV+43fSYlu1Gh1kf6rpVuK/2VpNg==
X-Received: by 2002:a05:6830:441e:b0:7c6:e92f:41cc with SMTP id 46e09a7af769-7c94db2e9d8mr2521142a34.21.1764800369402;
        Wed, 03 Dec 2025 14:19:29 -0800 (PST)
Received: from [172.16.49.130] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7c95a8f99basm20371a34.6.2025.12.03.14.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 14:19:28 -0800 (PST)
Message-ID: <f1fe54f2-8205-477b-8237-506da0e7260d@gmail.com>
Date: Wed, 3 Dec 2025 16:19:27 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check return of handshake_state_set_pmksa
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20251203150321.916124-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20251203150321.916124-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/3/25 9:03 AM, James Prestwood wrote:
> If this fails num_pmkids and pmkids would get set, but to an
> uninitialized buffer. This would then fail to build the handshake
> object later when copying the PMKID.
> ---
>   src/station.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 50997f5f..6c9e8d13 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -1378,9 +1378,13 @@ build_ie:
>   					bss->ssid, bss->ssid_len,
>   					info.akm_suites);
>   		if (pmksa) {
> -			handshake_state_set_pmksa(hs, pmksa);
> -			info.num_pmkids = 1;
> -			info.pmkids = hs->pmksa->pmkid;
> +			if (!handshake_state_set_pmksa(hs, pmksa)) {

This seems fishy.  Are you sure you're not masking the real issue here?  Would 
this possibly be related to fast transition re-using an old handshake?  Maybe we 
should not try to use or set the PMKSA for FT ?

> +				l_warn("failed to set PMKSA to handshake");
> +				pmksa_cache_free(pmksa);
> +			} else {
> +				info.num_pmkids = 1;
> +				info.pmkids = hs->pmksa->pmkid;
> +			}
>   		}
>   	}
>   

Regards,
-Denis
