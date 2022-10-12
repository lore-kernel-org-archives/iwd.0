Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60128EA
	for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 16:38:32 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1321a1e94b3so20092091fac.1
        for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbzgRYN7TpcfAd5Aqib0Shqg4wzbxFO9KKYZFxv3dOg=;
        b=i07A4A1ptQQ+dUoGioykBZGxMlXsXVn4D1PJL0sj5xptSwDMup2zl4V5+4Ajg3pkLx
         4o39Jt5CRwdOflDQQUgaxYygAt6msnqbwNgxCc7uMz7yFUaxQsayX8K1zCHbbfHdz1c5
         tUM3nQi4/xbyHY6nLxnSvrhk0T/vLYcMny7J1+vONqTfLFSEI+/7XEu+78Bq7marg/rB
         Mcv1ulaqE6v9ow6tBL4ZgLPhNuQpQt9kjRuxeWYeQsP3+Zx8lzz3HJV8qqV4VS/lU/Pu
         z+kcPV1685xd10fkqBvtJCnGikkIwWEA2JV4vo9gPyH9xVjpKW5m1ypyQmKvLMrutMfh
         ufQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbzgRYN7TpcfAd5Aqib0Shqg4wzbxFO9KKYZFxv3dOg=;
        b=jcX/5EKhIMt+/dp9LCySFLOU1f9L4pjPtxdgX/tNn+KDO94O7fFkdqr5EOYexPUH5s
         zyyzsTtjH697ZiPxM+CJGaP2WiBPauhxh6ByWQBJbLYHGHt3VOXHAILlU8f8OFEeBw3Q
         GsorrgBPv5YhNLVzsRyKAzo0gPzZvZDoL+rbh+GFun/1KPTP48Oo/yLSegYmwZjfMpkY
         DftXFxtbYFClAc/dQi8bEYyTPirzgFb/Ln7zCyr2TpGwvDx9lBisq+VNIi+nQxD4W78F
         MmgR5yvN4xw6iMi0z7msqYACHB0DbBaQyKoAShd9h/heoOHyoVaSlBnQJjmKeu9XM3yG
         wIMQ==
X-Gm-Message-State: ACrzQf0ryoKOtSC5LFYiOv2pXcsFXh5gq0YeSjprfeQ0Dv+Cz6AqqvcN
	Y5LsnRTq+6kVmpsp2VGBiE2qmv1NfJ4=
X-Google-Smtp-Source: AMsMyM5QYdrVDBaBlrYg3BQVly5pOh78cuoos/2gicqhYoATyhzlJDvztSIClMDbseSwimFd2Mrejw==
X-Received: by 2002:a05:6870:a18b:b0:131:a278:7db9 with SMTP id a11-20020a056870a18b00b00131a2787db9mr2871348oaf.201.1665592711437;
        Wed, 12 Oct 2022 09:38:31 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v2-20020a9d6042000000b00661a1a48079sm3230645otj.7.2022.10.12.09.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 09:38:30 -0700 (PDT)
Message-ID: <8b96fee4-5ce0-27fb-ceb6-5531b5214bba@gmail.com>
Date: Wed, 12 Oct 2022 11:38:29 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] client: handle wide chars for table rows
Content-Language: en-US
To: Pinghao Wu <xdavidwuph@gmail.com>, iwd@lists.linux.dev
References: <20221012140256.70306-1-xdavidwuph@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221012140256.70306-1-xdavidwuph@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pinghao,

On 10/12/22 09:02, Pinghao Wu wrote:
> Find out printing width of wide chars via wcwidth().
> ---
>   client/display.c | 35 ++++++++++++++++++++++++++---------
>   client/main.c    |  3 +++
>   2 files changed, 29 insertions(+), 9 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

