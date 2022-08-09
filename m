Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4046AF
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 21:09:55 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-10edfa2d57dso15563499fac.0
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=agcOZlvAYjWJ0861S8WrkZ+baiRwxxWpHJGs0fV5E5A=;
        b=iRtt3fEJGk0OO8mW+j8MjCUcuGu2P5gMgCLhTyiLhE5U0PI0wL6KwAqrr/rtcqAuRN
         r+Hv2SHS6vBV7lGAgU6R5E9qhywIywqe2q3iyaZVCtNSrrTKH4yttHdGSg28HZ0zg3qk
         1h6vqDS9PqryT2JeV/b+JyFL5/wjF35MJEfq7mFj7ldFHIuKuKb0eDoeLkf3nXXjk9ey
         fWtupz4tv90i+8HwU8VLtalFLHexPqqlzXW+7QsVKOcBXHf4ypJdRD8Momknlhm7Zj8Q
         4Ba++lWyDPQkhyS/IP1QyC8NNYD+Y1JH4mlBb3HC+FIJ+K2MbMZSORHC6Wag5Xu4yq8B
         H6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=agcOZlvAYjWJ0861S8WrkZ+baiRwxxWpHJGs0fV5E5A=;
        b=BwBIO07ACNE09I4i/vwZlJXjZ6bW4FXNwxkVjmHDxel6cGWSJ35SEASbUbWGQCNT78
         pGuzn3M/u57BN9wIcuoVjZIN24tvwRLDefixq95OqI4dRwl3C8YNpAuhzlCjL2Pb9jXx
         i/1xTpTBWiip4txLSYkmuWoX5gVDIbyCv79p8g9u9th3qkrtlajDcVOEm01NB1POgJt5
         vS8/DQnRufLrC/GqpeSM9nzT1kxWs2yQSpfGHrbjSLtWp7/euk1uyXBNCsiVHnOuzOl4
         Mz68Qmt1t+oRd9rkIMXT2ESjvejh+hfgbt0oBaiq9xeO/PYrH/FIxMAckIeJNSXh0hIg
         G+8g==
X-Gm-Message-State: ACgBeo3tbLFU3yTZwR2au6+nBbdnuN7m1pJJLSTj4MBHsO5mG9vtCKEY
	sS5hWAyvE4OZAUyId9qLUVk=
X-Google-Smtp-Source: AA6agR4uknuoSFxkdLXH5IK87b83SeY12VF8kCJLOcqbUu2hU6F4kde0loBtZ58Oywf/hcaQABnJdQ==
X-Received: by 2002:a05:6870:2490:b0:101:d94b:c9fd with SMTP id s16-20020a056870249000b00101d94bc9fdmr153278oaq.73.1660079394561;
        Tue, 09 Aug 2022 14:09:54 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x139-20020a4a4191000000b004357ccfc8bfsm224624ooa.7.2022.08.09.14.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 14:09:54 -0700 (PDT)
Message-ID: <4e8c0c08-9704-9985-6b76-501a251c6aa9@gmail.com>
Date: Tue, 9 Aug 2022 15:49:21 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] monitor: add better array type support
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220809210449.158256-1-prestwoj@gmail.com>
 <20220809210449.158256-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220809210449.158256-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/9/22 16:04, James Prestwood wrote:
> The ATTR_ARRAY type was quite limited, only supporting u16/u32 and
> addresses. This changes the union to a struct so nested/function
> can be defined along with array_type.
> ---
>   monitor/nlmon.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 

<snip>

> +		default:
> +			print_value(indent, str, type,
>   				NLA_DATA(nla), NLA_PAYLOAD(nla));
> +			break;
> +		}
> +
> +
>   	}

I took out these empty lines above.  All applied, thanks.

Regards,
-Denis
