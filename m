Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD128DA5
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyu6FG0n"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbcebaf9a9so421874a34.3
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704391106; x=1704995906; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Vy38w71FQsbYWVQDsEiMrMH4ElPAmSi1GRWxJoBktM=;
        b=Uyu6FG0nnwTusVzj/VwORxqz0jNSMgvV70KAnDE+yu3J5ingUeKgoMZSi8cAQH4kw7
         wdNpNyDPiQStLDh6Ijl9TZmQYuaBL76I8pEehp76+HHRWwBAumOWfVr0+vBK3pwdPwa6
         yiA6KBLD6sfuV3zNeEYLEzcHcZIiuxr692euNi1/OGiA9hQH6M+jDhjxGkgom2k/Kbvc
         YXU9S5yxYibbmYNiyC1hIzPLg2elJPfocNprp9rFOrM1vhtBWgR0KI0BKhLvbJLMiHc3
         H+o8Gz4tVlY/bOeLivzdmUNZfLwRU9tLmqv0kU3wRWM/KeG8snPTIDvqorEQSj1Lq09v
         1exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391106; x=1704995906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Vy38w71FQsbYWVQDsEiMrMH4ElPAmSi1GRWxJoBktM=;
        b=JivdYmet9wiRzTQndP8v7KJANx1aDg/j0vBkgjEuJ6sEapS2JAWkzaP9hfOY9uLUyk
         weHpfHwkItRAXgKZvaX7RXtW5xQK8H3KJNtWVMoOCxQcqeEukapkOlCDGce7wOsZh7SM
         GgrL/02XLU13mfmqUaOnWtE1JYmCJ6w1is7csPKZWS7sivk+WHogTsjbaMrV8l7KrxN7
         8j2WELWmp1FOqgRYO7ENdQwCswdgPvb6R+OxaW9oMqgAGmaaqjcJiWbENbgTxzn0OMF3
         pidJwX+OhHK2DAIBwJbrkcck/X1L02CIroDJV9bMQfUmbPYJCCwXLcA2SBS6O1UGK+4I
         vhPw==
X-Gm-Message-State: AOJu0YxP8BQY1+TjaRN4oH6/VFyMGCTib5qHgGpJ5frX33D1SKnoBQpJ
	J9fQndxGuEMYLd62Qew6X9Q=
X-Google-Smtp-Source: AGHT+IE/cUemI3izCfzqhmYUUJ9kb6022c5ph1HkRpz3lFvl/HN5Ws4bIvBnY9jBjtCVVdIQzyp2TQ==
X-Received: by 2002:a05:6870:bf0f:b0:203:e18c:5b2b with SMTP id qh15-20020a056870bf0f00b00203e18c5b2bmr1075024oab.32.1704391105715;
        Thu, 04 Jan 2024 09:58:25 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id te11-20020a056871880b00b001fa3c734bc5sm6484012oab.46.2024.01.04.09.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 09:58:25 -0800 (PST)
Message-ID: <baa9c8e0-6e96-470c-8cbd-b457a47181fb@gmail.com>
Date: Thu, 4 Jan 2024 11:58:25 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] auto-t: update roam test to use new debug events
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240103184638.533221-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/3/24 12:46, James Prestwood wrote:
> ---
>   autotests/testPSK-roam/failed_roam_test.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

