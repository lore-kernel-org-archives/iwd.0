Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC369D2B
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176465; cv=none; b=OJeVIqljG3Ra6pyxRUVGMpW7E4n65qPLFpa+KIQjnBB/dlA9AbDaWTojdQh2RVfL0lexZToR5cBm/96QbwtH0TIREljPSMeX6XGF8kFpOM1xxWcRcXQ9mQKRnW/jWLqfW3LB7p3h6foNiWLOLfsCbbHE8tkDKFtXwHwVyRB+Kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176465; c=relaxed/simple;
	bh=Cy1rDorTJHY174NUEJoQvQ+LBlX+Y9Q2gGCr5lqd4NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GxsXYJBXBenbnVXX4Pm80GGFQx9ukJwZ8K2gwhID6RjrlOtVdA985kUJFfGSpyEuFq4tIXPFZtuVUHlr0Fvy5NNRPn6EpIN9SXUqdlmxLg2NspXuP87bAzq5JnhePxwPSJeGmyNDxQ6Yxgk8nZhKH61ea+7GaIsUywL3vtRMR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFP1IDlL; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFP1IDlL"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29e70c9dc72so7335780fac.0
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736176462; x=1736781262; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LzlTrWcniDwEBPzNapBA2UUsao7udXuLtVfHaLzSJ8=;
        b=AFP1IDlLboyeS6BjZHASLm1y9rjXM6qKsMqd1813yxRXVS49U+w3Ghb0H8HI1NoYGp
         D93M3y8dNpudqUif4Ebmk6xZwAFRTXdrL3IzIIlJdM9cB1lpJVmQaI4cby9tbAb61+hD
         pW3pWto9W4Lc8WxEqDhKTcka54OtFHlRaeMEx8/bf2jNCTRVcteQX87TzyyhXg5JTTY/
         SzjjCD4tWMyToj05GVeBbk4Bd0vgfN8dByFvwbbMywqj3xNuYHorTWMtSz9kk33JWqE0
         pF51X+JKb7dziv4AbdCgE3bBzMlJSwwBaZ4rRkGjdgyWnNUzVbOU/ztFSBgLIsmJdCpy
         iEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736176462; x=1736781262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LzlTrWcniDwEBPzNapBA2UUsao7udXuLtVfHaLzSJ8=;
        b=tSq5nrezy6SGDYH6sswV6C1e4q1JQA65su0UN/pMliFyM4vynXdx49VCcQ66nKCNLN
         qmD3toHRXshFpD9w+OeeRnkeIk5QUuidnLu/Hq+2+/eq2QtnQO3CaV4XEBMrt/KA3Flj
         kY5BGEeR8tQBP/TwGMravBWUPCBJBDneBkjF6UwABUtwBYxhQAI0gv78flwckot8mH7L
         P4np81utCdT67TfeaASIZ5vPhs8Q9djeF1Oq5SU6Fg4OS2r01bNEkbkIYEI2SHQdyxpG
         fV5oV54ekl8eTUoQGIF+pzRlN2Di+b+57KLX0YihWKAq2Ps8c4NkYUNSRWTJDsOwGFvK
         oz2g==
X-Forwarded-Encrypted: i=1; AJvYcCUVBVy6WAJPb+Fs/ucBGiV2lUjFXe9l4csmuvNzANlZvAgeJ27XW76MzUzfqIiryEgoiLY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzpDJJCAwMetVA+7BlzFGOO6A/c1cfcmg+GxoCMHjSwRb+Fst/7
	oWsws0bekS+vTfDU7ywRyDtbY28G3o85QPbifkd1EABpLrV5nKwx
X-Gm-Gg: ASbGncvF1750afOd6dnM/oMSPc82gKYSKaaEodY2dlXCvCCAZQcw5o9SR84shnN1RSK
	hv+Zds818JLnGAbVg3BcrQDdD7wpYlL2fUab0GSTjtdTo+cs/siAnwvX6L5mAVwcBAzCw+4XsZY
	wIwxEq5A4Fbj/YBonrXw64gnaKX3O4Q2sxSL4FS2ITvz/lYzMgWzMi9NWG7GRc+1wMMVK4AoTNe
	7DZUCv2DMqcXbBXAXMoS8cMR8U94nuZgYixRPVJ6k3X0x43CfH7KheNUDF1J8KuR6odF1uiRL9h
	EAqbDW779nyr71m0KdSwpQ==
X-Google-Smtp-Source: AGHT+IHGHl1kbycPDLKVm725yBJGcp98MAWgFdz8yyLEyMRrKAVLh4/5FoBY61YDzYVuPJoGtBBLtQ==
X-Received: by 2002:a05:6870:7a10:b0:29e:9dc:8ba with SMTP id 586e51a60fabf-2a7fb30d5ddmr38505131fac.27.1736176460689;
        Mon, 06 Jan 2025 07:14:20 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5f64c94d37fsm7827846eaf.44.2025.01.06.07.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:14:20 -0800 (PST)
Message-ID: <9bbdd1b7-8fc4-497f-8ac8-80871df4a8dc@gmail.com>
Date: Mon, 6 Jan 2025 09:14:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] handshake: don't print NULL pmksa pointer
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250106134606.115334-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250106134606.115334-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/6/25 7:46 AM, James Prestwood wrote:
> This is undefined behavior so if no pmksa is found don't print.
> ---
>   src/handshake.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/handshake.c b/src/handshake.c
> index f73f91d1..bee76b26 100644
> --- a/src/handshake.c
> +++ b/src/handshake.c
> @@ -1272,11 +1272,11 @@ void handshake_state_cache_pmksa(struct handshake_state *s)
>   {
>   	struct pmksa *pmksa = handshake_state_steal_pmksa(s);
>   
> -	l_debug("%p", pmksa);
> -

Why is this behavior undefined? Would it not just print 0x0000...?

>   	if (!pmksa)
>   		return;
>   
> +	l_debug("%p", pmksa);
> +
>   	if (L_WARN_ON(pmksa_cache_put(pmksa) < 0))
>   		l_free(pmksa);
>   }

Regards,
-Denis
