Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0620B80F
	for <iwd@lists.linux.dev>; Tue,  1 Apr 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523703; cv=none; b=J3uBwna0wtZYhwumcMjyPtsXpDJBZ3U8d2ZLbKD6Sn6oX9SMLg/rD8NQqzCEb/ajHuFpp5k8aSUuJRTF9d4QOp77bK7ZFdyu53RARbfXpN1WBdedmeOkHyDRo1fIaHJt0A+qSpvvm4SHsOc0QZeIe2HZi1T193Fj2Akml9Fs5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523703; c=relaxed/simple;
	bh=pOZFix1hk3AewbB5yxAkKTfb3aFM975nTC27rBtH6n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tLaErPKcz0G7NfmBqaWY8FdkQvmb9maGwaJQD10x3E3+moVwcw2Cib9b9KUFISuVQu51RP7jjb3xFtSK0Nzx015+42M3AsH1jDl7/xIdJVP37vGDiBHfUI+tD3PTmhOoojk81otQmjIAstiRDuWRKbpfkUW7Zjkxnp2xq6esvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2bPdR9O; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2bPdR9O"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c76a1b574cso1773019fac.2
        for <iwd@lists.linux.dev>; Tue, 01 Apr 2025 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743523701; x=1744128501; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uk6csq/UGFR8CqYrAui/C6VmG34AvAswA5ClWCt7pj4=;
        b=k2bPdR9OyT95d6K8F4d3WUlyTP20PsPH5MZzkAhoX4dejVPq99GX0GbshKaOWGL3f0
         G3YW0GrvW8HBSJapVFtTCpj2TmrkCsOQZ2UAFfSfJjjgK7U/FaNxEdq3vj3CK/rjrHHf
         mPN3j2iFAIprAJ60qhbHlqTaGGcGAJNCM37peljUG2I/e20LTVLbDW0x7SrXjhbRnq6d
         PUsHpkvCgklFA7bAb25bUPeG53fmRHpx93JVFZ4qb75N/42hhaUBD5brtTzD/VlKuUMe
         7vbelIOLLkC2Q1AkR4Fmy6d0AASmcpKgNl+QGhD9VPo2vbhvoNpDUXs+W/BUVjt7xk62
         fM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743523701; x=1744128501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk6csq/UGFR8CqYrAui/C6VmG34AvAswA5ClWCt7pj4=;
        b=KQO3e+l+P5TAYc6GryRKSsQ74ZyEUDKNe5c92UnZj+Q8053sQicFLYenrPfNFpOd7O
         eZgO8hh13Vh7IxrTl1kz+yMCKFM+nhcO16+SzGkVnSiSRt7+mUDn8MALRTJJCxW+wLpb
         pNlOo2PHOzqz1FT/vl5fBt2pnxofMf1jXorFeWOnR0zIcBk+BVIzNN632WjkZGJO9A02
         xocpuerRRUO3VnchVp+jqb7nBT5IwmWA1Q13ffpO0FhBN8JCuyxpd3gVP2BZtgAd+HYA
         5Hn0viuInhRUqJPea2ujqwK7geHbGkorPraNgQu47JEWq1rWUPeLdoELIbLXGBP1cDmm
         AUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOmrnTK9LZnMfXdOyBO5LkrdaQ38Eu1HZr7bQqqrPZobnPHGiUmA0n4pRwwDvNCUOw1Jk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv4GceQ6Rk9wlBxCxGfvWjLGHFV1WL5MP2WEW9BcR5ZTbzqFEZ
	nijhGKZkBynS3yAEAKAT4MNHv9AA/z2xPaMyvoHvOKpWJ6RIQ1TU
X-Gm-Gg: ASbGncs2ny8sNRn8PMYkrkDl7ST9GYMbKIdsxTPLlIuuehKkmaisaoW2Tj3MNcuSeRF
	Tn8slxHUBku/lUkgIKI2BbprwDuGJSLgKEd+jqmjH3gW7SkFQglEiYxPIhEAyHUwR9CxJ7p42Aj
	LfI+sF8yFnIwvDOoDNME2n+9QLc65UgM5fhjnL5KsOLFacSS3txgVIY4YDnErMWbVIa9HdoUDVq
	nFgIfn6IdgHTarchTHCQS65SMpBAw/gVsCbp97vckrITG0+WYeUC6kdirL25Z50q6mQLuu1aRLl
	EBJleTYL1HHZ8Q7JShAa2h4W2nB3qQ+MRklgJHkngy5Hv8zxcMAE9OsLmAjZ2adZ4tFAOt/zmys
	DF5d+0aToAw==
X-Google-Smtp-Source: AGHT+IHV2780vOqSfZZ1Grzrj6k/U1ffcUPXcoDIZUecvMe15V3hlbBYewA+IwH9B9R0b6dmLwBZnA==
X-Received: by 2002:a05:6870:f10c:b0:29e:766d:e969 with SMTP id 586e51a60fabf-2cbcf4ef188mr7486310fac.10.1743523701148;
        Tue, 01 Apr 2025 09:08:21 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c86a3ef951sm2410095fac.1.2025.04.01.09.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:08:20 -0700 (PDT)
Message-ID: <c5a170cd-fc55-4a7f-a5fe-af7f9cb731ed@gmail.com>
Date: Tue, 1 Apr 2025 11:08:19 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] station: roam blacklist BSS's, and consider when
 roaming
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250328144253.421425-1-prestwoj@gmail.com>
 <20250328144253.421425-7-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250328144253.421425-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/28/25 9:42 AM, James Prestwood wrote:
> If the BSS is requesting IWD roam elsewhere add this BSS to the
> blacklist using BLACKLIST_REASON_ROAM_REQUESTED. This will lower
> the chances of IWD roaming/connecting back to this BSS in the
> future.
> 
> This then allows IWD to consider this blacklist state when picking
> a roam candidate. Its undesireable to fully ban a roam blacklisted
> BSS, so some additional sorting logic has been added. Prior to
> comparing based on rank, BSS's will be sorted into two higher level
> groups:
> 
> Above Threshold - BSS is above the CriticalRoamThreshold
> Below Threshold - BSS is below the CriticalRoamThreshold

As discussed, I amended this to read RoamThreshold since that is what patch 6 is 
returning.

> 
> Within each of these groups the BSS may be roam blacklisted which
> will position it at the bottom of the list within its respecitve
> group.
> ---
>   src/station.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 69 insertions(+), 6 deletions(-)
> 

<snip>

> + *
> + * For an initial (probably naive) approach here we can use the
> + * CriticalSignalThreshod[5G] which indicates the signal level that would not

ditto here.

> + * be of an acceptable connection quality. BSS can then be sorted either
> + * above or below this threshold. Within each of these groups a BSS may be
> + * blacklisted, meaning it should get sorted lower on the list compared to
> + * others within the same group.
> + *

All applied, thanks.

Regards,
-Denis
