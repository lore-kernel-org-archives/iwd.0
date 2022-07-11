Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BA4411
	for <iwd@lists.linux.dev>; Mon, 11 Jul 2022 16:13:57 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-10bd4812c29so7221962fac.11
        for <iwd@lists.linux.dev>; Mon, 11 Jul 2022 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9vjyLfjJS5zopS/gtYQ2haaBihRp+b5TdLI8T6O1Zy4=;
        b=Q9Jzw/x9Ekc65rSxaqahqotg04kM4WUD0BUO92JLPNSpSdICw+59TU+I4GWumkAXHX
         SumLhDnicewb1yXpAklWU5tyWRBlpjV7foYZGMPNq7gWfb5330+/xXFcLde3vD+ynWKj
         fUmzzV6+1/cwXCfzn6MZTcXyt8hWs56ohEtN0TkAlXxux9kUuJFJXd5z1IuDpx112rHZ
         0oOUvsm9szR3A1E6Q+sdfajbhn0NrA+IRKDs3u2RLLhvRTKYcXWB5WyKCuMlm4VIuJ/o
         Uav+SLYGw/TQ+4XfcZfwUjkMQFLIJMD4AhEk1lhmlO+cSlZeiPlRi4Z+o9flOIdffePL
         TGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9vjyLfjJS5zopS/gtYQ2haaBihRp+b5TdLI8T6O1Zy4=;
        b=3Jt0INCKo/zPcI4een4YPqVTF7P4ufoZkRjVS7b5W2I92+VS+YMkMPWn1Hu2VRSwLv
         gZtTRSY4yoE1pdoQnzxSVv9/0Vvj8rWaKDLn4UUjT7ZerLaERk0gu9UTR0qY4O4NmXiR
         CESkECoE3LBDeDyKCh+FHl6WXh7iFdKd2Cgvdoa2hOgD9rlqVaSXKIlu3v0HdxZRe+g/
         9ujiFH56FYYs9CWqI8Ni9u3NuXDXiYZtCtWRyML2Wc12T339LCqDC+gQG7qSbWcfhSKr
         kUssi64lsyam0+SXUOt3ck7vFZramHok0fFc1TMwkMBRHPoAqT5ofubL5Iwj0hTyaMQI
         mRZQ==
X-Gm-Message-State: AJIora/XgnOcHGoaedpGeK+FhQOPe04Q0CdQAS06o9LrbUeOUf4BiTce
	JjsV8Dg+y2vEm3iUSW6cLEs=
X-Google-Smtp-Source: AGRyM1v3AAzeXnd1LNKpzmDuCZ8eXR5EvznUOjwnSlSWRjKfLPII+k9FlnIE01OXu8BqXO/powkNgA==
X-Received: by 2002:a05:6870:c5a0:b0:10c:5a7f:1e1c with SMTP id ba32-20020a056870c5a000b0010c5a7f1e1cmr8123048oab.250.1657556036502;
        Mon, 11 Jul 2022 09:13:56 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id y15-20020a9d460f000000b0061c514a3b7bsm787424ote.10.2022.07.11.09.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:13:56 -0700 (PDT)
Message-ID: <ec060bfd-8ba2-605c-3979-60a220194920@gmail.com>
Date: Mon, 11 Jul 2022 11:11:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] test-runner: run prepare_environment with --start
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220708190054.299224-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220708190054.299224-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/8/22 14:00, James Prestwood wrote:
> The --start option was directly passed to the kernel init parameter,
> preventing any environment setup from happening.
> 
> Intead always use 'run-tests' as the init process but detect --start
> and execute that binary/script once inside the environment.
> ---
>   tools/run-tests |  7 ++++++-
>   tools/runner.py | 24 ++++++++++++++----------
>   2 files changed, 20 insertions(+), 11 deletions(-)

Applied, thanks.

Regards,
-Denis

