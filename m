Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833757C
	for <iwd@lists.linux.dev>; Mon,  3 Oct 2022 15:40:07 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1324e7a1284so4730016fac.10
        for <iwd@lists.linux.dev>; Mon, 03 Oct 2022 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FFvklGZxSbnIQRLxdIaCz3wJXFQfrI4yjpA+MKypAqU=;
        b=WKxJ1D07jhOm3uU/zQ9hKn8Ao1skE73Xpa18xyZ5Mj4O3jxOqXeJ2ig1rYRLedPjCY
         X1NKUQelMzNhRl0RIUedEm4fisk5SJrMxGIEWn61WOVx/UsijQNTFAJYG+Hb2fM7uMff
         +jYKKIm8j8AgWQELOKcsl99QadrDZprAquprzJL+/ZWjT6bd1H4Vfz9XjcOH/GGsvNbo
         w+ASe6H7KytaWSNa89QfNlXnvmMVaC6CNNaRecW1qf/++R3ut23mWHxPMOYFiZ/1Wres
         BJtPqVHKwCI0JiaCRfoMiIEj6vhxI+Kl8BI/g2HScp3KEmWMfzg/1PjtDWJtaICbhvIp
         luhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FFvklGZxSbnIQRLxdIaCz3wJXFQfrI4yjpA+MKypAqU=;
        b=8BW+mlw9EQmgOzkoQWUjKMcZmJgE1Au4zIFlcNk1v4E1SSmDXh5BgAWuzcCI8YMiwJ
         ph0nu1nXdwcRAhGBbJiKH8UOZgZylTesbXwpUDNUT7NTePWyze0qREhCcMeX3iRyeI7M
         6h9LacZxTM230LtEkLRz957DN0bvS4HCFVfwbmdG7eEHd1HgwVQm2hvLyAgCxFsl/rQ2
         n9+Kn5KpNsqhb1DSs5z7IxBjlynXR+0jAxSXOtYoz2iBw8HOba1oZhUkOQLKv0lML6Ze
         Zzb+jpIIWWWTP8wjNFtP22+KLM3HFjIiHZiGXPe+L99iYsDlXmb5BjFjft21DMVxR/rn
         RSyg==
X-Gm-Message-State: ACrzQf2ZXdmHMnz5fzxc13qqUAEZ3wpWunnAAsDrfK3MctGqI64dVQxU
	/e6U+FeRE4U0VZbAJE0IEPQ=
X-Google-Smtp-Source: AMsMyM6XzQUuzFT75HZYCPvTuNBfWDDSBVUgRH3CNwNxsTmPR/yk/X/+vtKx66dNiKMlJHaNas9Vmw==
X-Received: by 2002:a05:6870:d20d:b0:131:75ef:d40f with SMTP id g13-20020a056870d20d00b0013175efd40fmr5483288oac.227.1664811606723;
        Mon, 03 Oct 2022 08:40:06 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y14-20020a056870b48e00b00127fbb7afffsm688783oap.5.2022.10.03.08.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 08:40:06 -0700 (PDT)
Message-ID: <bd9c4d51-a3ca-16c2-5000-7e94afd21425@gmail.com>
Date: Mon, 3 Oct 2022 10:40:04 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] test-runner: write out individual test results
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220930232809.810726-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220930232809.810726-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/30/22 18:28, James Prestwood wrote:
> The --results option only wrote PASS/FAIL for the entire run.
> Instead write out each individual test result.
> ---
>   tools/run-tests | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)

Both applied, thanks.

Regards,
-Denis

