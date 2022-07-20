Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2601C3C
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 02:54:24 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-10d6e8990b9so6418217fac.7
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 19:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=8seT1FwLr9TxQTZNiMnFYG5GcZ7e1CQc95xXQAUhrKs=;
        b=HBBqw6rL93niZvEzLpxxmIExJnnjBCdV83HscpoMWnDKU64ya2oFaN5d1C9HXy96KH
         noymtI8J5qdNJmZC68pvzpu0ZOuRP3zLWLCqz2JaciMYiDbmi70EPWw9byxaUPOU3Ns9
         U/TQaXNQ0qowE8U1jZSAUhbeQ2hzxMTaAmEXZA2fyvYBIJQPndoJjaN6KQlE4VfKYoT4
         aBiuLSunkh/XVn6zawWuhwBbCxbsfpxxby7/zvYDvG4MDv7H3ZsOzmZD9EPFlHAdoDfN
         gP4sp1SWxG+nErxuwph72iVVhIjc56H3tjOigTZAVpv8BSj+ii6/VXJbqUG+mPtQlh5Q
         Uj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8seT1FwLr9TxQTZNiMnFYG5GcZ7e1CQc95xXQAUhrKs=;
        b=hOfXalhlEn1qKom/sta/L0KSe3MPEFHZS4u1jLAWEys1kdpII7twzwJCCRZXx4LTBk
         KHcdzvzhr8qJ5qC37qyuyM5jnoV6pjqiwIqLn3IP+s+FFIHDE3ghMYv5Feuloxj4S7zo
         XDO0v2CwEg0RXpL6rrNuoL9k6knbdB8i5465/npkqHiSCtLZccnc0Uqc9AWYCS9KreNm
         sE/ylI2S96HnWOCcXBcVYFnWHj2lLGdTtRIAacvS/Z4YvEuWNXgtvag38BsPahA2e5aO
         yhC1XV9Af0VU4+dq6+RE40rJwOHwqoBw3yZSm3NADGh7mqM+HOaCZhGE6eaFvojNWV7k
         WbjA==
X-Gm-Message-State: AJIora+uZt7J1kd2yZNZrjM4+LDpGqiS3SY2QJQVM79xsOcKWlqw6BGp
	sfkjbaTK2tGsDNbkE0nfBLYRZUEuWAI=
X-Google-Smtp-Source: AGRyM1u0TJ1p/Uti8b080dOjEHroGhtk9tl/Jb9SCux6Q1jqR3yvJ7ofwg6gxl5fVKIrBBifO2vhDg==
X-Received: by 2002:a05:6870:c1cd:b0:fe:1295:6e34 with SMTP id i13-20020a056870c1cd00b000fe12956e34mr1364946oad.137.1658285663919;
        Tue, 19 Jul 2022 19:54:23 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id bk22-20020a056830369600b0061c731fc92bsm6816460otb.64.2022.07.19.19.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 19:54:23 -0700 (PDT)
Message-ID: <a71a3bae-6a9d-71b8-1cc5-df1f71bdad11@gmail.com>
Date: Tue, 19 Jul 2022 21:37:53 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] doc: Add "wep" to network type list
Content-Language: en-US
To: Jesse Lentz <jesse@twosheds.org>, iwd@lists.linux.dev
References: <20220720021226.242780-1-jesse@twosheds.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220720021226.242780-1-jesse@twosheds.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jesse,

On 7/19/22 21:12, Jesse Lentz wrote:
> Document "wep" as a possible network type.
> ---
>   doc/network-api.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/network-api.txt b/doc/network-api.txt
> index 77536e28..2032faad 100644
> --- a/doc/network-api.txt
> +++ b/doc/network-api.txt
> @@ -42,7 +42,7 @@ Properties	string Name [readonly]
>   		string Type [readonly]
>   
>   			Contains the type of the network.  Possible
> -			types are "open", "psk", "8021x" (EAP)
> +			types are "open", "wep", "psk", or "8021x" (EAP)
>   

Would it be a good idea to also mention that wep isn't supported?  We can detect 
these networks, but can't connect to them.

>   		object KnownNetwork [readonly, optional]
>   

Regards,
-Denis
