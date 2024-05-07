Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD915FD11
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093612; cv=none; b=fYDnqjNmIL44aghtnp3YjKv6yiv+eK8OoI/snhCl4lgjOObNFFFL3sh65w8mNNrzLfkKXg6xPHCiBES7TuMWirlKF7Qs6FeGCZoU0hS1WpKfm5SxraTD+Zvyuu+uT+Ha7FUF500acfLy3QpvAcjV3qLeHSo+5/jY4T9Oddc3TRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093612; c=relaxed/simple;
	bh=bm0nsvl28LRAKicVqvZL+961H0coKr+1t3jl00bE41E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jh5tYt0LIbJwwRTs85EiQ7qVo953rV8Ot33HRB9dJdPpEn/dVM5fK6p50ZvskqY+24hRcJro1N1uXXYqZlfwwLdzBTAA1fz3codSy0HY5d0gqoG/O4o34FGMiRg4NWDAJ8JarBb5d6eirtf2oDXhdgJYeE6dn7U3iINVOjUkmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMqCv0Gz; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMqCv0Gz"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b1ff50e8d1so1764284eaf.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093610; x=1715698410; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/Gfx3iFHMNsKjfQkOqc8PgIR3jj8zwkwgupQWnsaZ0=;
        b=WMqCv0Gz5HNqjjJVf7f3mCD+un6BCrWK6qlHpgTdgsHSt9KW+z3V589h4bjVeF9Az+
         S6b7fITwlgssZm0PyZPU3Xm3DiVwr3WlKC4y8XpD5nAElGgbw0j+h2LWdBkAG6KZxiM5
         vrP+QdtAuvaYfnPw+ETU9t2WY9wMeCag7p8zl93Bjno+PmMT2NaNTtPBiUr7mUuNFLi4
         MeadLR+KMJu4JZJBc5JeOyB30x+5Dj30oO8+2nXZNItk6CMjAbFCbji8Ri48QN+D3AXX
         pdtWz0ukvQMPu3FemnDHVcgSWFJxzTVgj5UgKwHaSDg+Kzr6UUaxMY9owUv2ss+LIyQl
         lkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093610; x=1715698410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/Gfx3iFHMNsKjfQkOqc8PgIR3jj8zwkwgupQWnsaZ0=;
        b=QBIrBDlRLunb6jf5Hg3Db+UGUf2Qsj109J8+NqkKO/lTuHpvK8U11UJgVaUYItT26m
         E+VmofK2BbzNIMxUmHR9Y/A5ZjXG3Ajrk0x12mTBV9M3opCD06GAT736BaSrBclz3NUB
         84ilIytOmcjqVWxtobG+y7V2gEzWFl1cx1zZ1gUhZKvjWD5rnfXHmj2mIph8rv4Rm1WU
         KDuaPxmB407S+l3TeDb5BiSVsUQZiuZmNGmSDaF808cj64Z7XPIR54MknbxcgiB+kfYb
         /3ByPTL4K65mZ04dpdJB6gtt/C8vNYa5S++amgGYYUMzv10AduLw7EWozli8UsZC9kk1
         ijpw==
X-Forwarded-Encrypted: i=1; AJvYcCW7VszGFeKLd1erycYlmpJSClWAlQXGK7gkDl2zWcFcmC8ftpMtZUvKsUr0OLD3qo0TptmQtnoXRxSaY0em5gDGA2or
X-Gm-Message-State: AOJu0Yw/6gR9GCaHWbIkiA9E35iWTTdxbu5bR1jGKa4SN8VZql2w4rXl
	XDR1Tz/jTUFJI18KuVWs0n86Ay0BxOlLHBeH4Vni/Fdyzy0HaQ5E
X-Google-Smtp-Source: AGHT+IEsmQ791N1+Av3sZgadr2R2O8zPsHPUC/isJxc6iM3a+5mQm9hDkBnKMoMfeEvb6fU//Rpg7w==
X-Received: by 2002:a4a:5441:0:b0:5ac:9f22:2686 with SMTP id t62-20020a4a5441000000b005ac9f222686mr13109315ooa.5.1715093609884;
        Tue, 07 May 2024 07:53:29 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id gp2-20020a0568204c0200b005afa74ceea0sm2453586oob.11.2024.05.07.07.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 07:53:29 -0700 (PDT)
Message-ID: <9ba20058-7bcb-4ebd-89d4-c15310de4a0b@gmail.com>
Date: Tue, 7 May 2024 09:53:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] sae: add function sae_set_group
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-5-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-5-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> Refactor code by adding function sae_set_group. This will make the next
> commits easier where basic SAE support for APs is added.
> ---
>   src/sae.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/src/sae.c b/src/sae.c
> index bf9fb0ff..4e0b73d8 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -148,6 +148,18 @@ static void sae_reset_state(struct sae_sm *sm)
>   	sm->pwe = NULL;
>   }
>   
> +static int sae_set_group(struct sae_sm *sm, int group)
> +{
> +	sm->curve = l_ecc_curve_from_ike_group(group);
> +	if (sm->curve == NULL)
> +		return -ENOENT;

Could we avoid side-effects on error by doing something like:

const struct l_ecc_curve *curve = l_ecc_curve_from_ike_group(group);

if (!curve)
	return -ENOENT;

sm->curve = curve;
sm->group = group;
...

> +
> +	sae_debug("Using group %u", group);
> +	sm->group = group;
> +
> +	return 0;
> +}
> +
>   static int sae_choose_next_group(struct sae_sm *sm)
>   {
>   	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();

Regards,
-Denis

