Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBF23A1
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 17:06:22 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10dc1b16c12so3565745fac.6
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OFhk5VP+yyUwC2+Y8324x23AJk+bFjsqmhDhcqC7lR4=;
        b=lSdRlomY5wlFcqozr9kw9dozWsPFuQSTYSg+Ei0TofPXEy0rP+vqpOxBvJjD50QR66
         clxm2uTIoEnZuIBHkvUQVbHp1gmxNVZfKjt7ACT9ADfh2HHN1dma6xJw4LNke1o1BQ7v
         YLvVLAxtkH9nPRkDlrM+ctoli1WVI5Ex6kNEBhtrBFOiMHY0lWS7fceM/TKguhWRTpLR
         XBsyjb3vLKKYvWKnhC6OOyvhcrgFb4GLGPblZ2PjtlyRjRhsrKf+SWIjZGAh31Z6r914
         HllKUBXNNdOB9aJDvS4Qo2mckgjiCuroEsSy5CsCa6NKiau80/oCzf/ib4dj3e8UuXS1
         tpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OFhk5VP+yyUwC2+Y8324x23AJk+bFjsqmhDhcqC7lR4=;
        b=dg8UB+/TLx9zxhiu+kP5wHh9u1MqOfP70uzAJ20o8ESWx/Cizy9o7oeqhqKswDchMU
         30fylC+eNzeSGLW1esPKOtGzGzkpZVlBer/klopntrWEWrx0055ejcPeEhzLOJWx6n1+
         fhKxBhlnooYpj3ikDBTsT1ROfqDcyuoZrdEEdV1hsVs7sm63XqNxx5eWy7Pm2Vk1A4o2
         zFORy2+jICHee3EBJq2Ll3wJZfofYUwsx5BcKv+hmO85M+sgmDrF6dGWvXrpHbvi7FU6
         Rwx01ySFVd6HA8mBCiHZshsTwbh7X69SkkIUS+3m9lBdpspuUVaMK5nZTMOno8SpCKrt
         jhZw==
X-Gm-Message-State: ACgBeo1iRLd0PRjjWqaMzTG9IlGzQl4VjrF4IEprI/PJwEn4nDDikHPe
	5t7deZNcIDzh7MvB5fRgdts=
X-Google-Smtp-Source: AA6agR7M7iRcnjpzphlhzZwFQl5/csSmTrpILDNVF7IaJ9kkrbNX2g8j6bcmYIHP1UqMK9mMzbGbvw==
X-Received: by 2002:a05:6870:430b:b0:f2:ca00:e775 with SMTP id w11-20020a056870430b00b000f2ca00e775mr7277619oah.288.1659719181891;
        Fri, 05 Aug 2022 10:06:21 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j13-20020a9d768d000000b00618ecbca69asm781398otl.74.2022.08.05.10.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:06:21 -0700 (PDT)
Message-ID: <66f0e017-d0df-c0a3-1871-d4e80c7e8bae@gmail.com>
Date: Fri, 5 Aug 2022 11:54:55 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/3] util: add scan_freq_set_copy_bands
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220804220249.508207-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220804220249.508207-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/4/22 17:02, James Prestwood wrote:
> This creates a new scan_freq_set from an input set which only contains
> frequencies from bands included in the mask.
> ---
>   src/util.c | 21 +++++++++++++++++++++
>   src/util.h |  2 ++
>   2 files changed, 23 insertions(+)

<snip>

> +struct scan_freq_set *scan_freq_set_copy_bands(const struct scan_freq_set *set,
> +						uint32_t band_mask);

I renamed this scan_freq_set_clone() and applied, thanks.

Regards,
-Denis
