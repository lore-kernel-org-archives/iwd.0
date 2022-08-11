Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901F33C6
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 14:55:26 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id f3-20020a9d0383000000b00636d99775a2so9217831otf.2
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ezENDX7gErWxYwk9x5oMdD0OlxxDugKv3Jcmtn5uoQU=;
        b=BDmh7rS4R8B7nwU3z8WcYl/yasGp0nOksf2qxiC1byFOTbJIwTI0Qs7iLCsQNfrhjf
         SAKjUbT++KQj86k06J/78L81+gcBY/13gl2zdUptkQxs3f6JgTQeZPyFqnLob6s/B78B
         XXN3zoZMzc6qlNGdLiY29lhBwJ/NXgMmQH7qlxFQc8CyIukBesYeOJOwqlwl8FHqyXFc
         A4L2jSerNSSc81W0MqUSK/ppgLqiqcOMIJMz2+vUCm18SOoGdxRed0ZjhpFF8L9o378Z
         /7dEdo43l9iYuO8eAHy7q3WJA4AidFLWBEe1ntjOgWupd87VQcqJ5RApGKraEObZ91M7
         Ku+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ezENDX7gErWxYwk9x5oMdD0OlxxDugKv3Jcmtn5uoQU=;
        b=zyr62r9XtW3kCuOebPkqtfQ7fJBVCx/buWvaw1UxoHfI/Uupg11qMqnveCS50lKCdL
         grYkeIXEvFpzCYBauwUkZ56hj+9wHL4HTCso+G81pm0FsjG2nk6sTTZ0ThSzWdtzHq5U
         V7TmDWzAO081JNU5HmeOfdyL4KRHesrBaLS0+Gj6MRi4X9Q6xJrKdGQKjNNoxt8bbYiB
         KdJbPJFO8cKHdSjmSJAZ/je6hPR0NHWPPMOkaPaRaAyO1drMckl15vvI4p7i5q67vx5M
         q7wKG4y/yhXUd8TfAx2z43PRCzAQH0AJtCnh6/IrRqImDhmm8Gr4j+q9V/49Ut7rX0zQ
         mlsA==
X-Gm-Message-State: ACgBeo0yFiuPl9M8oIWwvLBcfGqZnSn+pSMYlCSCFl+8C11ZnaP+BqDB
	5nlQZc+17kmowXXOef/LxBEXLHzlmX0=
X-Google-Smtp-Source: AA6agR6400G6qM0VlooI02aWvhviyS08GHSmClBWyoiSkSpJuiZh0MmNcoh/b/r4Z5o/mFKi8mQE6w==
X-Received: by 2002:a05:6830:2905:b0:637:14af:2a82 with SMTP id z5-20020a056830290500b0063714af2a82mr4114323otu.1.1660229725502;
        Thu, 11 Aug 2022 07:55:25 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t23-20020a0568080b3700b00342b6bdf9e0sm1100788oij.11.2022.08.11.07.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:55:25 -0700 (PDT)
Message-ID: <9ac220c5-728a-9936-deb9-9f0216937934@gmail.com>
Date: Thu, 11 Aug 2022 09:48:30 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 8/8] client: fix station autocomplete with multiple phys
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220810231621.372514-1-prestwoj@gmail.com>
 <20220810231621.372514-8-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220810231621.372514-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/10/22 18:16, James Prestwood wrote:
> The limitations of readline required that the autocompletion choose
> a 'default' device. With multiple phys this doesn't work. Now the
> readline limitation has been worked around and station can look up
> the device for the command completion.

So should you get rid of device_get_default() now as well?

> ---
>   client/station.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Regards,
-Denis
