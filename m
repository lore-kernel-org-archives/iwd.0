Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DEAD5C
	for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 21:53:47 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1322d768ba7so18511121fac.5
        for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 13:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hhh9Wq5KOL+za/X4umdElE5bVTTjv7zEQeBbrp8obuw=;
        b=qV5WRmGGAC81DkLuwFZlwyGhkMMt7aoTfC+YSdzxQsUW49tBf6xqiohznattSXwpJJ
         1odrydLvZDiILvSzvo0Qm3f3Ns/PfpYgk5fCh/gNSj8VoHgmx0VKiUMXG0Uf3PCGyJz2
         WEIOUf3nqhbsEbD8H9gXh/MXnSpOBb7gJBzfjKSJm0T8bawrKOApQgN8DcqehieafeuL
         sI9OnulYWo/z200KjCrNpI2DloPGaRhGF9ZMe3eHSW3//YkjuX3lRGMfblyu6W7Kvm9r
         Ohw3nwkInC/m3rV4jMV/NTB35qJAdkUuSVRCuP8GkP2K3sNfR68P8oMY1yqr/2uV5a7v
         KvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhh9Wq5KOL+za/X4umdElE5bVTTjv7zEQeBbrp8obuw=;
        b=xab5wy0FznuQx4woH8I75/4+/aIuqMI+6EL/KLG3PYk54feNvgj058No4+UIky7ceK
         VZCoKCgetX+n9gXtU5Hi/zstG8O7zlNrzV0F0oVW7ayBhPPmDKtF2ln8s/HZdOeCWMmK
         5lnbaghYE5bzHEYZj6xmnNJUz8JLf6tGOJh3Tymdcitq29I7idIPFpwfAJ/P6v8+uToJ
         16msD6dtU7YmxIv5Fnysv1rmLq4vC9CRN0WywF3nVzttjXrc98mKKavqEwgBWFKbMyYM
         nGhRUTn6g7qhz+BPXBZ09zszXvuy8WO2qi7v1JXeUa5k0PIK/syIdO5u8aVERmgFJVkO
         pIsQ==
X-Gm-Message-State: ANoB5pldjzPYjckGRFmDgm1MNaL6XOHqk0D6VIAaUVaX+HmnZjZNGu6+
	dkz9aD1aO42LpL9LzvDhvO8=
X-Google-Smtp-Source: AA0mqf7qZcLmtt4Yr9bfZ1kDBOkXKXsC87JJbqJZLE7i5xXjKy+0Qg3zTqTPJjSvWuM5gYB0DK5i+g==
X-Received: by 2002:a05:6870:3b19:b0:148:2c02:5322 with SMTP id gh25-20020a0568703b1900b001482c025322mr9325210oab.26.1671054826997;
        Wed, 14 Dec 2022 13:53:46 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id en1-20020a056870078100b0012763819bcasm3275375oab.50.2022.12.14.13.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:53:46 -0800 (PST)
Message-ID: <67c5287c-2154-95fc-1e49-80f34bd36e6d@gmail.com>
Date: Wed, 14 Dec 2022 15:37:55 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/7] util: add scan_freq_set_remove
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221213203624.1423277-1-prestwoj@gmail.com>
 <20221213203624.1423277-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221213203624.1423277-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/13/22 14:36, James Prestwood wrote:
> Removes one frequency from a scan_freq_set object.
> ---
>   src/util.c | 22 ++++++++++++++++++++++
>   src/util.h |  1 +
>   2 files changed, 23 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

