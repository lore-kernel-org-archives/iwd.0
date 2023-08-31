Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E110FA
	for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 02:09:44 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-571194584e2so234855eaf.3
        for <iwd@lists.linux.dev>; Wed, 30 Aug 2023 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693447783; x=1694052583; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oi5SUObz5/diC5XBk5yleSfqZr/aF2KwjsXdjg4PKr4=;
        b=U0jXR64KTK4jz1GYSlxAKPrECe/56mmUdRmMptAMQIEWjG3AIxL8bgKvri8U8j1fCt
         l5QA/W6fPJhp5yTCwXqNy46jlAHvvIcKoYLKpsU08jVrhmrxh/CLe01wDm/Z32Yi3Nq4
         iVzkhn6gu4ZTqWi/NUIALvlJkrX3Rld/fTXlCouppXfANmUCjQR/x2ifIE2W/Lmo9Dno
         hQsxDb+0Viy/YCaIIMK45wzAX7VZ5GGMDwBEd5bNjqZ6IP69w0Ur0GNOfZbZ0CT1NSBh
         1t1ijxfehKKA74TnCquP6g4zbcnPrXmpy2eMzji7sYyUgVWRL/2mQV1+29dgqjaq8rJc
         6JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693447783; x=1694052583;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oi5SUObz5/diC5XBk5yleSfqZr/aF2KwjsXdjg4PKr4=;
        b=F9McEsrfSzGvLE/mLrmQ5i+WoxkZ0n1dhPc58A+MdeTiHqovsVcP/YxxdHHi+mCj4z
         WxU02sTBroR7x7+zQMRD6wkyx5FPbhjbkGnMGv/lGph4ln86ZFXjQWkz221CL8cdIsSX
         qC5q3SzxsiC8kZYME306CoDKJMAbUjOz/y3S8nKVhQkW8Vhy6gqpVdatwAcu5R1U1AHU
         SIJ2UEMBOBvliPMKuJ7coDXUur3UtxutuIOlQiRwolD82Y4A+T7P/5Tp7dAjc85bip8q
         qe1vCOhuGhEM72tzZc7jDqVYMQfR6304wOtZcGDMTRHOU03QAviNoLWiiqTkcYhyoNhZ
         6XMg==
X-Gm-Message-State: AOJu0YxqJaMiWQGESOFlS2AOTr8UTRHllACa/dOGv6JX1mSKhhH3yjtN
	FxQ/jn6lrnA+zzsokZ9KNOY=
X-Google-Smtp-Source: AGHT+IG1szz+GVW7gRdataugYI7M/I9Q7RVmli7OC5QdEvZqJ3FukOIVJVu+1EKj1zq7O2rtz/A2bw==
X-Received: by 2002:a05:6820:53:b0:56c:7428:4a35 with SMTP id v19-20020a056820005300b0056c74284a35mr3440841oob.7.1693447783501;
        Wed, 30 Aug 2023 19:09:43 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h187-20020a4a5ec4000000b00565d41ba4d0sm208864oob.35.2023.08.30.19.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 19:09:42 -0700 (PDT)
Message-ID: <22494187-b18d-38d2-6c56-92be7ec743d6@gmail.com>
Date: Wed, 30 Aug 2023 21:09:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] ft: track FT auth/action response status
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230829145116.279949-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230829145116.279949-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/29/23 09:51, James Prestwood wrote:
> Certain return codes, though failures, can indicate that the AP is
> just confused or booting up and treating it as a full failure may
> not be the best route.
> 
> For example in some production deployments if an AP is rebooted it
> may take some time for neighboring APs to exchange keys for
> current associations. If a client roams during that time it will
> reject saying the PMKID is invalid.
> 
> Use the ft_associate call return to communicate the status (if any)
> that was in the auth/action response. If there was a parsing error
> or no response -ENOENT is still returned.
> ---
>   src/ft.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
> 
> v2:
>   * Remove 'parsed' and use the status instead. Status is now
>     initialized to -ENOENT and only set to zero if parsing the
>     IEs succeeds. If a non zero status reply comes in this is
>     returned by ft_associate.
> 

<snip>

> @@ -527,8 +528,6 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
>   		return -EINVAL;
>   
>   	status = l_get_le16(frame + 14);
> -	if (status != 0)
> -		return (int)status;

Hmm, this should really be kept since we shouldn't be assigning ies or ies_len 
in this case.

>   
>   	if (spa_out)
>   		*spa_out = spa;
> @@ -541,7 +540,7 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
>   		*ies_len = frame_len - 16;
>   	}

Maybe something like:

if (spa_out)
	...

if (aa_out)
	...

status = l_get_le16(...);
if (status)
	goto done;

if (ies...)
	...

done:
	return (int) status;

This would also match how ft_parse_authentication_resp_frame() works.

>   
> -	return 0;
> +	return (int)status;
>   }
>   

Otherwise, LGTM.

Regards,
-Denis

