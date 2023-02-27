Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB9746B
	for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 16:29:01 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-17264e9b575so7908485fac.9
        for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQgUSd2E7/B8rSPM6QIPWCmro5PTPU4dRsXjqM4KAPk=;
        b=WP0D2QZKzWePm/39O8a3IBWGeabGJJSbsPcqQ7bVStXRzs6rRw/YfN6uIzS/AZ9a/A
         BZuSCV+TiyKLvQ+2ThcNE7h+XHj64ne6flBubK8EDjkPYaYs/P1mFb3ojvDwQvPuLG8Z
         R8bV+EQdMwvD2/LvE1Kz7exwCQ5wQRmXI/EAsF/U9Gp2yVU2X/Fs/VD6HTXfdaZ3gJ7o
         q0lMuZm7jKmCtlNeI3U9UqHEz7VHmE2IEmm3J5pO5hdMxkOS2GZMNZTe4atGwcRmAz2H
         W/DeJpYqRxtqlDnvg7vzU4qqIoiZaQQ66yHxJJ/9apof/VFQmKnkDFnnVzQiiZ+9r389
         3k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQgUSd2E7/B8rSPM6QIPWCmro5PTPU4dRsXjqM4KAPk=;
        b=hOFvvrkHH8x7wlNgFY0v/OhvlYP18dxUVAYtEKNd5te7ZgRzZA2pvdJWYyx+r1E2rY
         06gqYmFEyl3gCgbCyFvH1erOpHLvZjA97q1+1VUzgXR5nQDJHxQnejwOYueL7TQ3+tkH
         Bdv+gCwKpCzIM3ftlt+qrZuF82PByZ+f4SsEj6kvy5oqxMcm8M0yFE3Bzs9nqzHg5MIG
         fSZG8d6UIenrjLPHBMK281i8Z58v22uxjjqiN5AeZanwvHLHMaEL902euMIvBq3hUCEq
         lMT72SrJB9fwPlg3fN01ZarhOEoIr98+/RZ0ijrf5zeyuKNFaOnFTDqHGiflVQq1wXeC
         A7/w==
X-Gm-Message-State: AO0yUKV3EGeE5gx/KUQAvCkGcU/g96i6SnAZAme4N1kzJoleZDOAM3b1
	J8auO+iggbvnFWHy26wDrKc=
X-Google-Smtp-Source: AK7set/c7l9vZDm7WwUSHIjntUxDjlpmgGOV/xMu8cIF27x+KfWlVD3jz+y9p7Zzl/4mLleFgP0emQ==
X-Received: by 2002:a05:6870:e2cb:b0:172:899b:92c9 with SMTP id w11-20020a056870e2cb00b00172899b92c9mr8102319oad.29.1677515340746;
        Mon, 27 Feb 2023 08:29:00 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u18-20020a056870951200b001728d38a41asm2426256oal.55.2023.02.27.08.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:29:00 -0800 (PST)
Message-ID: <253088fc-6b45-1dc0-9591-959e8c9f6de9@gmail.com>
Date: Mon, 27 Feb 2023 10:28:59 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] ap: check FULL_AP_CLIENT_STATE for NEW_STATION
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230224185147.1462945-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230224185147.1462945-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/24/23 12:51, James Prestwood wrote:
> nl80211 has a check which returns -EINVAL for NEW_STATION if this
> feature is not enabled and the mask contains Authenticated/Associated
> flags.
> ---
>   src/ap.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

Both applied, thanks.

Regards,
-Denis

