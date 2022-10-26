Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A34AD23
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 20:00:00 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13bd19c3b68so11004528fac.7
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WW54wRNDG2q86ugGGt34vbHZBtc0JZfUiVvafLMxzbI=;
        b=RsmYFH4Qb0NisS9qTRrcQH3WKB6NT/hmUkel+Z0dDtYBHA/pJ/tHIrDaZgTKhD9/3F
         fxa9VDT9qhBfy3vznXv+VO3ppMHpHK4d30StKfydL9UvmKoT6mGOz3qfs00zWIaDyHkQ
         QRQ/MdDNmLUgoxFUFnkNvEKJknh/mZ5u+lA6lytHM13uW7SX+Q4SFfbof8wesc2iDgaM
         xBQGntXH6/PLpz+5M5oKZVA/RdMF8knMbPH4+p8KDmPH7tNALbkV3rrwzwR/4MRhBF2X
         2sUohL8Cpv4YtpJ4bDe97V/NYH/KkB068BrHSwtx6XWncQzkC/txygnBFfWflxrxVx1y
         xAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WW54wRNDG2q86ugGGt34vbHZBtc0JZfUiVvafLMxzbI=;
        b=hkA0NP0/VbdJOqM0QxD0tigH+DzZc7yNnHxi8AIIHYVVfIM3p46XltYrFsGYgDbllR
         LFZhXNhpiGdQ87QXZspMi3Y5jVgveOm0+90mLjcd91Ah+b3s/p14qHQJoHR9iKPdF6E+
         rYwPCrAK/Z1IXhaIDa7DXAv8fDD6NLoByzq7ze3f/Pgmkbjfle+CMEoMB5Ltzg/1tFzz
         DdEupDfLjY7/iZ3jMXfZQ+BcR71yybioQZvDGl1zKRi5tUGIJBDJY8D3bW+oIhbUj5ZG
         qJp1nzWXmN91iFiKRIU2S8q5QbRXCLze1wf9anEJm6B04iWl++kHXoNeVN74Ol2KriNr
         N3UQ==
X-Gm-Message-State: ACrzQf04o1Iv/yPEWvhjHBdCu3gCjc+0iKRK88fi93Ebt6+g81r/acyw
	7LFL2YW3Oquv1yLNSJy2Um+jGb0Hfz8=
X-Google-Smtp-Source: AMsMyM4Jzz7BCDTXFArN0sWKbOCxyLi31y5fk7bwh4kLViv2v2CfPUe81B5k8sebwHQ2OQl3kSZ+ew==
X-Received: by 2002:a05:6870:d0c8:b0:13b:7dd3:307d with SMTP id k8-20020a056870d0c800b0013b7dd3307dmr3313363oaa.92.1666814399905;
        Wed, 26 Oct 2022 12:59:59 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p13-20020a056870568d00b0013b8b3710bfsm3615449oao.13.2022.10.26.12.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:59:59 -0700 (PDT)
Message-ID: <d523993d-0e30-e1eb-b8bb-3299b45c7d98@gmail.com>
Date: Wed, 26 Oct 2022 14:59:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] monitor: allow parsing pcaps without -F option
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221025160356.217578-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221025160356.217578-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/25/22 11:03, James Prestwood wrote:
> The -F option is undocumented but allows you to pass a nl80211
> family ID so iwmon doesn't ignore messages which don't match the
> systems nl80211 family ID (i.e. pcaps from other systems).

So should we remove -F option then as well?

> 
> This is somewhat of a pain to use since its unclear what the other
> system's family ID actually is until you run it though something
> like wireshark. Instead iwmon can ignore the family ID when in
> read mode which makes reading other systems pcap files automatic.
> ---
>   monitor/main.c  | 2 +-
>   monitor/nlmon.c | 6 ++++--
>   monitor/nlmon.h | 2 +-
>   3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor/main.c b/monitor/main.c
> index f0b16bbf..30aa06d2 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c

<snip>

> @@ -7261,6 +7262,7 @@ struct nlmon *nlmon_create(uint16_t id)
>   
>   	nlmon->id = id;
>   	nlmon->req_list = l_queue_new();
> +	nlmon->read = true;

did you intend read = read_only; here?

>   
>   	return nlmon;
>   }

Regards,
-Denis
