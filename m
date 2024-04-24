Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C815AAB3
	for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960363; cv=none; b=qKXd5oNqa3I6QgSymq3WYBA50XIOVl/MnBwl9uLlzdS7eT/oWPwEG6+L0BtyCkiBjz6haLZcokknxar3A6omJE1Fei+k2sm9De0PqTMSrZ8yzvkjuBhtZ82mDeNNFSEqHMHNHb8ABMltuwkhVs1VkyFZEkLDip1llHRDKs2qkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960363; c=relaxed/simple;
	bh=yBAiTw21g+F7pENNxahuz4wfRmxtvTKPS7a5LXQ+Aik=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ex2GWbqaaOIv8KqSxbymHqKnjdBosJ/ymvUxCUE94HoOlIW7FBTqukRsYDgvXaWD8pUb2zHRFW4D/+kBE0VXW3sKQv98Gc/xMIeGGSLdpyEcPwRt4KQIZN3VEXk1J5gi3vm6Eh96WmoLLFdmL0sTND1KgiJmVfcAc6+ggrnkdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWlcJiiu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWlcJiiu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78ef59a369bso478562285a.2
        for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713960361; x=1714565161; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6W1p5069DQxfRMJnazxDe8KW1SHIiK/hJO2/WdUI00E=;
        b=cWlcJiiusvlIHBXF0e/iZX0cCYLQfl60lVcpXftoZjkJy+yowIZTIGo2H6b1EA7eSR
         8mg2leJ+4G6BFeXvYDMv5amLd6oecuiAZtWPfPIZWGKjFwzjmzQDU7e6kdsGTJnCz5N4
         wpEn2dRnjD82ibQYPCxTo6Tv6pP8MncI9OinnkTOalv7RMax8dDCYy+jspQTpv1+tHjf
         KZEU6u0+5E0ZuLRLTv3M91o0gRh6rQpDBkGJndbyK6wdjk4LT2EgTjYfCLZ7aIUoPzxK
         Blj4ms+QkoRDufOdwRYh8DeZKNQuewNOrgGc3gQ0y/UlYvg8bm4e+n+5nJ/Lsdag/aHe
         dG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960361; x=1714565161;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6W1p5069DQxfRMJnazxDe8KW1SHIiK/hJO2/WdUI00E=;
        b=R7u9r+WoU+9J6QwW1dBb4DvxMJNmVbyPlpSQ/NULjkT2JVh/1BWCDs07pAcHHdQ2yv
         RH+Yv2/6d89IL4OIdkNYeMH9mCN4DOhETGbfzQG3xmh99xWb3NOCMq9iEvZ+ehCLYJvA
         SS4e30DSRLczGQpGBVffsI3zS0WQjg2HdiGxeER14QxYk22XMF3gJeCTzqTil+PWzPDD
         6C25OIMwiCHFaQL70ynHAKU3RAyF8dZ5sLlQXuSdG9NGZ2czyzNx1sNGUoDrMeKbtrql
         KEaVf27hKdqHj9Bv41PK/1ZnF/4SLCaNGh62IbyZphOyAqAPRH98HdGQCtNHFyypjpXR
         erlA==
X-Forwarded-Encrypted: i=1; AJvYcCV1zUv7LbGcnXK6eaw2PMo82Hm1H5d0UzFwI/WxUC/jCTlEz3RhomAKNpDd8lub7vIBKSNtsD8soAqIV0S3DJiyoL/t
X-Gm-Message-State: AOJu0Yxmge6M4Rdn39edc+aM2yqXCmfR7LmYdfPW0981YwfEDh+g9eMR
	jWskRMuATVpTFTpZq36kXN3WtnollpOm21ae8q5Qa1QxOSGvRt1+
X-Google-Smtp-Source: AGHT+IE7KzJScPyvvY7+sKbPEoY4TJh8OW3pf/5M4YBC+jczbkunvYd0VNuBHRIm3bFsPI3Cb07BHQ==
X-Received: by 2002:a0c:e6e8:0:b0:6a0:6bf1:446f with SMTP id m8-20020a0ce6e8000000b006a06bf1446fmr2612886qvn.48.1713960360701;
        Wed, 24 Apr 2024 05:06:00 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r15-20020a0c8d0f000000b006a045780b77sm3393748qvb.51.2024.04.24.05.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:06:00 -0700 (PDT)
Message-ID: <b6a5cd74-57a4-4d45-908a-ed7894ce950a@gmail.com>
Date: Wed, 24 Apr 2024 05:05:59 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] sae: add function sae_set_group
Content-Language: en-US
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <20240421125050.6649-4-brandtwjohn@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240421125050.6649-4-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 4/21/24 5:50 AM, John Brandt wrote:
> Refactor code by adding function sae_set_group. This will make the next
> commits easier where basic SAE support for APs is added.
> ---
>   src/sae.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/src/sae.c b/src/sae.c
> index bf9fb0ff..c133386f 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -148,6 +148,16 @@ static void sae_reset_state(struct sae_sm *sm)
>   	sm->pwe = NULL;
>   }
>   
> +static int sae_set_group(struct sae_sm *sm, int group)
> +{
> +	sae_debug("Using group %u", group);
> +
> +	sm->group = group;
> +	sm->curve = l_ecc_curve_from_ike_group(group);
We need to check if the group was supported. For this set it doesn't 
matter since your only using the static set of groups, but patch 5 uses 
the raw frame which may be a bogus/unsupported group number.
> +
> +	return 0;
> +}
> +
>   static int sae_choose_next_group(struct sae_sm *sm)
>   {
>   	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();
> @@ -166,9 +176,7 @@ static int sae_choose_next_group(struct sae_sm *sm)
>   		sae_debug("Forcing default SAE group 19");
>   
>   		sm->group_retry++;
> -		sm->group = 19;
> -
> -		goto get_curve;
> +		return sae_set_group(sm, 19);
>   	}
>   
>   	do {
> @@ -182,14 +190,7 @@ static int sae_choose_next_group(struct sae_sm *sm)
>   	if (reset)
>   		sae_reset_state(sm);
>   
> -	sm->group = ecc_groups[sm->group_retry];
> -
> -get_curve:
> -	sae_debug("Using group %u", sm->group);
> -
> -	sm->curve = l_ecc_curve_from_ike_group(sm->group);
> -
> -	return 0;
> +	return sae_set_group(sm, ecc_groups[sm->group_retry]);
>   }
>   
>   static int sae_valid_group(struct sae_sm *sm, unsigned int group)
