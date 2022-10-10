Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D302F56
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 18:42:47 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1364357a691so6902232fac.7
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSFUMo7lRYHbjtORr7uk8gfW9sgah4zX3gesekcNZto=;
        b=agcWzcd+7D0ObIIwFjKeHU8FeM6yr+bNfzrW2VGo4viBfwyk4EmxiHXtSyBM4E2zP5
         +VIb2Bs2VaRaLQg1Hr6U5+Tp9hXr2Sx+sb8n+o5wTDa9bNj2lB291UauaWP5X/mdaSri
         HHUeNIBuWBK6OlyDbAJYpPC8e/BgPgill3xJXFmzzsBWT8K7zOlsnmK8ljeOLm2lmCje
         xU0AVgLsXwoQlHMeq9ixg18djcKL9jrQvwCkNf2oTJPS8AnNQiqL0V9IeNr/T8gffmc+
         nd/sHzrX9zi1kfCV2+fNhToceO/c52e0Vj1l/Zyf4e3cMzZ7jCC+af5THozTVUiPDXgE
         yxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSFUMo7lRYHbjtORr7uk8gfW9sgah4zX3gesekcNZto=;
        b=04mV0D8uOEoXKd/DtbrwqVf7qgW8k+TvADAr7xltxnDaK+Jo2KmLc82/kKI0Wy/sMq
         eH8WzQvKqlpyge5pdlHI0EccZZLoZieEU2idRWv9A+pUmlGoJziZ6AwVz8GlLqcidBXw
         KR9nbeiH9YGRkdue8LT5nAbhL0KFQwEvesdzo1SubHd8q2fvVgz5jfb8ZER2uAp1EXs9
         WparrKAbpXimDNDfuaVeyV+17+KpNb1cCOq3ow6CJywMbNwlXrdCpws09+G/YqauTEtj
         GGVEVGZEHb8I06NcfrNgSdWZWJCfydZ7d39EBS3MqUiI2gJhIGqADaFNE/9AH9F/mLI9
         UEuQ==
X-Gm-Message-State: ACrzQf0wtgzHPa4en726pe/wzf4G5XppCKUNGy752JqjsxnoL9Dqh3P5
	R5i9ZreAy0NqEVH5ppKYlMeTw/MUEog=
X-Google-Smtp-Source: AMsMyM5rq9mgQ058UiLkWVrtcDk/dsaLMPHvO5ggHHT+k6iiNxr+ymXXNgOkbvN8MBCyoGnZp8yU2A==
X-Received: by 2002:a05:6870:c14e:b0:133:14d6:cf57 with SMTP id g14-20020a056870c14e00b0013314d6cf57mr12387385oad.155.1665427366292;
        Mon, 10 Oct 2022 11:42:46 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h13-20020a056870538d00b00127ba61535fsm5514133oan.15.2022.10.10.11.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 11:42:45 -0700 (PDT)
Message-ID: <bb04c207-6e8c-79e1-be29-7aa930cca8d4@gmail.com>
Date: Mon, 10 Oct 2022 13:42:35 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] src/station.c: remove excess if clause
Content-Language: en-US
To: Peter Shkenev <mustela@erminea.space>, iwd@lists.linux.dev
References: <20221009132744.8998-1-mustela@erminea.space>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221009132744.8998-1-mustela@erminea.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

On 10/9/22 08:27, Peter Shkenev wrote:
> No functional changes are intended.
> ---
>   src/station.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

