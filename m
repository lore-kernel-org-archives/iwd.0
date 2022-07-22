Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BB4A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 17:22:15 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id bb16so6202291oib.11
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tJZgIB/gWZe7Mmt1eE8T+/BvCGkPhtkz7WjzNj/Cc74=;
        b=ZUfJgCz36tFglAFgxwQ64ZwBwEFtT+t8wd8wELgjAOsZYhgxGg2m3o8vTMPppPabuQ
         ZKY4C/lrTEcbzLTMzWw53KbWMpiZ7D6xxQ6GVizirdIdbcLjMUcBFoCeJ5sm1n+2Ly3i
         NyV4A1MZBWdfpp3yEQTaM39SQJkwdaFv3J/CQxE1yt9PlM++zXhxR+bc4fU/KXOMs4xL
         W+fAhGQDKsWR6h0c82JWs/+YH0XXICi9f1dMMrSQwAb7RzLRoSRWtO5i9n7vyx7WI19N
         9tAjV0CujeymxVEooLKQg2QNYu2yLY2ggT3C/h+bWFGNLkNmao9U6rw3gKZ5lfd7g4qg
         3YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tJZgIB/gWZe7Mmt1eE8T+/BvCGkPhtkz7WjzNj/Cc74=;
        b=ARw3aMXEV1JYIeXmXkd5bEa9OM6RfBNuIvfTDaKDgB9qDV+tm36MyyQsUDsH3dDopO
         z2f7zsskcsFFzmSI1zlziT9L0Avnyo8JDYW9kTkEQAdx/4dgt7fVdl1357MqQinoLBFe
         aOuiEpvRwub3SUzPMwqZoRv757lYj8Pv0ySCkw193UT5G4NY7oJAIKpYzjRfspUVx+xr
         cvnzKLOFdIbg9vsWc/m8IVE/IZd9ft+4Vn6xqlOd8kYSVE392bG2urSbaZQKgMAuMz8J
         wS22bQfcsRrUTTUG+T6bVIEWlttXrzFtB9Ej30Va+dn/E6uWRYhrw8Ih987dLNYukCcZ
         3UQw==
X-Gm-Message-State: AJIora9xd1jqRcodSR+EsJzmQx9CQLYNGic+Rf5Zj1aaJG5mMcg0rxMV
	vDn8QIIpFVTHteBkCnTn/Og=
X-Google-Smtp-Source: AGRyM1t+Rvdn5WDplp10jtMutKrlyf4h2SGIkXNcYq5+ajv9D0KYvBrp0f+bEwkjDAIrG60qiIL9Ig==
X-Received: by 2002:a05:6808:209d:b0:33a:8b99:f7a3 with SMTP id s29-20020a056808209d00b0033a8b99f7a3mr360658oiw.119.1658510534166;
        Fri, 22 Jul 2022 10:22:14 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id i17-20020a9d68d1000000b0061c4d5a5616sm2158711oto.63.2022.07.22.10.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:22:13 -0700 (PDT)
Message-ID: <e144ecce-eaad-0156-4f9a-947c0b01b555@gmail.com>
Date: Fri, 22 Jul 2022 12:04:21 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] wiphy: fix runtime error from bit shift
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220722163417.1119334-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220722163417.1119334-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/22/22 11:34, James Prestwood wrote:
> The compiler treated the '1' as an int type which was not big enough
> to hold a bit shift of 31. Change this to 1ULL to fix the error:
> 
> runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
> ---
>   src/wiphy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/wiphy.c b/src/wiphy.c
> index 09b99fb2..4b9e130a 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -957,7 +957,7 @@ static void wiphy_print_he_capabilities(struct band *band,
>   	uint8_t width_set = bit_field(he_cap->he_phy_capa[0], 1, 7);
>   
>   	for (i = 0; i < 32; i++) {
> -		if (!(he_cap->iftypes & (1 << i)))
> +		if (!(he_cap->iftypes & (1ULL << i)))

That seems overkill, wouldn't 1U be enough?  Or just make 'i' unsigned?

Have you looked into using wiphy_get_supported_iftypes() here instead?

>   			continue;
>   
>   		if (L_WARN_ON(s >= type_buf + sizeof(type_buf)))

Regards,
-Denis
