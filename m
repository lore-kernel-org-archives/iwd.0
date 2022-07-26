Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD06036
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 21:02:17 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-10e4449327aso2241332fac.4
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RTwOSca7XsyxbkTXVzdZrHV62Whx+OrQYtJb25JFT1g=;
        b=GDj/nwR6nfjMM2EOwqhxVrp4jtQdn1UkrNijFouAU0Mkg6hCjqeC7Ols9T9brE6gH2
         d+YzLg3/m16t9DTb7Lcpj8piQ21ItMo6/Gpw50f0JHTC/hoqX9kXN5OfvjSSm9kC18EN
         wK/vOh8seCCw0fssv3IYXMFpTgOiSTJyyarRHtaYoSB/k8lhhURuDNmP1O6oAqYMZzox
         9/6jb1S0eibpna/T6WoaAI8KHoT7Ud5CzDj1IQ5o0iKYA45lqwSsRy0RsxcxT9NfOau2
         qezkBktPHp2jBDvgcEaxu+cfOlB2j1KwsX+1nPmjpSdzDRfzfpvIZ0ieLolUWk1sLul/
         ZWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RTwOSca7XsyxbkTXVzdZrHV62Whx+OrQYtJb25JFT1g=;
        b=LVNNgTvNozDFNcvS7Yv3I+qAC+6RFK8fnDr9YdEW4gvbWhbjLyVRz7PMtjI03x/NdD
         24wrbg3e+OA8mHgnhk2/8ZBMYSYHkDMivCO5sdUUC6XF7i8JY0kHqclAHRkb1sH0Mmp8
         oFdTCbHO+4wColuJsZ3LpdA7bGAgJ3klgg0QGwQ184AT4tvmvm81Sxh3YFvFB2f7G3ay
         vzfI/C3EO1zKE1LR5BglBkFzNKi4e3CA4U84PQmtvJo9x9U80qGKNJcmCkfoqULiO6Lq
         tW32/F76+rlhpum+5XfX0SAcpAea9V/tUgA558PquFOfO9AWw4Sq6Rhn+V8114Y2Qyw2
         Q3/A==
X-Gm-Message-State: AJIora8OJh+3RpRvGCerpueAIDYetQd6iNCk+Xi+xL6wv2BmZxie5Jfo
	lLswab9GVoeo1l77n0jl/iEYYmfCbls=
X-Google-Smtp-Source: AGRyM1vafCbU0sSH2ban39N3Fhuv5PJ+TilM4SxbJo4/K/pr+7YhHl6z6qcdzuoEcUMjV8dNVSkp/Q==
X-Received: by 2002:a05:6870:89a1:b0:10e:4357:45b3 with SMTP id f33-20020a05687089a100b0010e435745b3mr524003oaq.127.1658869336264;
        Tue, 26 Jul 2022 14:02:16 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g29-20020a544f9d000000b0033a37114eb0sm6550832oiy.19.2022.07.26.14.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 14:02:16 -0700 (PDT)
Message-ID: <570bd0eb-db94-f0f2-2a76-f9bdbc014b3e@gmail.com>
Date: Tue, 26 Jul 2022 15:57:17 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/10] wiphy: fix runtime error from bit shift
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220726170920.15929-1-prestwoj@gmail.com>
 <20220726170920.15929-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220726170920.15929-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/26/22 12:09, James Prestwood wrote:
> The compiler treated the '1' as an int type which was not big enough
> to hold a bit shift of 31:
> 
> runtime error: left shift of 1 by 31 places cannot be represented in
> 		type 'int'
> 
> Instead of doing the iftype check manually, refactor
> wiphy_get_supported_iftypes by adding a subroutine which just parses
> out iftypes from a mask into a char** list. This removes the need to
> case each iftype into a string.
> ---
>   src/wiphy.c | 48 ++++++++++++++----------------------------------
>   1 file changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/src/wiphy.c b/src/wiphy.c
> index 09b99fb2..98bd3aa4 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -707,17 +707,16 @@ bool wiphy_constrain_freq_set(const struct wiphy *wiphy,
>   	return true;
>   }
>   
> -static char **wiphy_get_supported_iftypes(struct wiphy *wiphy, uint16_t mask)
> +static char **wiphy_iftype_mask_to_str(uint16_t mask)

I'm still unsure why you introduce this? Can't you use 
wiphy_get_supported_iftypes() as is?

>   {
> -	uint16_t supported_mask = wiphy->supported_iftypes & mask;
> -	char **ret = l_new(char *, __builtin_popcount(supported_mask) + 1);
> +	char **ret = l_new(char *, __builtin_popcount(mask) + 1);
>   	unsigned int i;
>   	unsigned int j;
>   
> -	for (j = 0, i = 0; i < sizeof(supported_mask) * 8; i++) {
> +	for (j = 0, i = 0; i < sizeof(mask) * 8; i++) {
>   		const char *str;
>   
> -		if (!(supported_mask & (1 << i)))
> +		if (!(mask & (1 << i)))
>   			continue;
>   
>   		str = netdev_iftype_to_string(i + 1);

Also note that since valid iftypes start at 1, we actually subtract 1 when 
parsing them for the purposes of the mask.  So get_iftypes() might need to be 
modified to do the same.

Regards,
-Denis
