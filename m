Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D97B
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:52:12 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id r83so17224964oih.2
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNSq7HTtVUpx0zvT05DFi6U6HIRtIJ9zZ5ECblV3n5g=;
        b=TAmi55sWYNQoZ1sgHOYTjrxc/r57WG1GEAojU6+EvQ2JGo1QYACjwdPbwYsra/36IT
         bOqk6rfAeHmh6Os3Vi/Na6to5I9jD6FyzNJbXE73oijky62Rzz3VYYkAAjwrOV92sVtN
         NInhmTJhGBVxrT7bn1PioQ4VXG0nzC5cYEv24/Ae0lbS62RZLYLY/RqLtB/KQh8cZU9d
         iWYBgteKTaFOFQTR410pj2RUY+1ZSbjzvoTCrWgnmPPl+N5yBSJszRVCvhO+UyTX8Gas
         IndXg7MFhkuSvLK1vUbUA0iWDaLsqGh0COZm/txQ8DfLPILl0/3H6BpG6i4153ri6X72
         w9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNSq7HTtVUpx0zvT05DFi6U6HIRtIJ9zZ5ECblV3n5g=;
        b=dL28lCJqUk1FURtpv7fvVfhuFWN4V4gOpyerNi5pDCEw7ZtWJMV2BUBxowIXpuWGXO
         TFHmrp7IYEk4S3xAhAhJ7jGeDxJD8dhnS0nJ/MpoXvPik0SYgUf9Zp9ZEq6FS5gaMKwI
         9TndMN6KAP3ujL+z7flWE9zI8PVg+NvWhtjAxCCgV7QfGwf+hHp+3rAUtCeLbtckITph
         uoMJloQThNHsdioEF3ajBr/7y/LtS2dBVzoQNFpDssqRhAPS4SgASFPiaVtsVtRkTz7N
         mujyWYejfN/yAo/ZTWuDDy62R9+qwQ3KLjh2CgVO3dW8vU3a1qCtUALiavAWXmNDfJ2M
         eZEw==
X-Gm-Message-State: ACrzQf1bGix1BKtUTfHxiJtJHBTjaWl6g6FSQv7Upz9MJfuDq/8ccD6y
	NHkxxgunlpgF6c5SLt1qbj0=
X-Google-Smtp-Source: AMsMyM530mEj5gN0nbr1j5zs1FiOiv92RGXeB3qd0HQa8zo3kRiViuBY9LnONWE8HXT/u+xCS1bP8w==
X-Received: by 2002:a05:6808:3098:b0:359:fa5f:234b with SMTP id bl24-20020a056808309800b00359fa5f234bmr8969767oib.272.1667335931608;
        Tue, 01 Nov 2022 13:52:11 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x16-20020a4ac590000000b0049bd7d1f21bsm1923599oop.46.2022.11.01.13.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:52:10 -0700 (PDT)
Message-ID: <40c89f57-3ae1-4c47-36a9-72633947361d@gmail.com>
Date: Tue, 1 Nov 2022 15:52:09 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/17] auto-t: fix testAP-no-support disabled ciphers
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221101201747.143379-1-prestwoj@gmail.com>
 <20221101201747.143379-12-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221101201747.143379-12-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/1/22 15:17, James Prestwood wrote:
> The disabled cipher list contained a '.' instead of ',' which prevented
> the subsequent ciphers from being disabled. This was only group management
> ciphers so it didn't have any effect on the test.
> ---
>   autotests/testAP-no-support/hw.conf | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

