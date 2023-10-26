Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72552EAF8
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj9aIk6Q"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce2ea3a944so614255a34.1
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330790; x=1698935590; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TD0w7yKcocELL5Y2T6dRDbIkvpTTYgqBBb3PvU9MCAo=;
        b=Vj9aIk6Qj2tsVYc1CJn/vQuw78fkvQYX5EyOd9LbHQwYCFFdx6QuQSqEHccSb2DWaF
         bJPuMSJ4oG9o92tnZwgpEIR4+qSoQwVXtoY9fvrSG8/azNAHT+uxzNxexQFXxBu5WaMw
         N5WMWP/5w2o+rmC+vxQmIu7B/8qiVzXWOghxvUkGdFXV0+14GPDZVUjFvukQNCQYK+H7
         Hfx60cf3GiyzeRUjNo2pmNXWqi7J3kWrd4F6HWlkLWrxPBanCOcu1jGwcVUC1TmxIC8U
         e9bNpNjnc/+ndoQqQFxYdWQniUoyvwMgJnN2OsAM5kg2VYj+wptB0j5G0UhFHdOC6fxR
         XUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330790; x=1698935590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD0w7yKcocELL5Y2T6dRDbIkvpTTYgqBBb3PvU9MCAo=;
        b=lufZk2j7Co07EmcNE3w4GRab9NL4TV2GXO7rgbnw/GlW3f84UDCfUezPZr7QVh0hke
         a08jReEbT/HSInGKYwlagzXokWWqjCGymoe9dNHEARloXIYvfPKwXsX/8v1pkjChCHGd
         Z0DTWm0G2euWWOMpA/L/hf2uhXpXJZEe0Naj0IPLWVdyj4Bk4hXv+mLeDcauxH0MlLbh
         TiCWUf7htFY9A5qOvnBqSanxilOS3PPlYm6FS5AqmrhVnbX1p+2p5CkRPX/KiPFV8kcs
         ULL6r8QRBUyQwKVpFId7RW6iQjvqnw3T9X0pfZ+f6JD1w25r5DU5I35mMdBq6jN3iRq+
         tcOA==
X-Gm-Message-State: AOJu0YzNjJsuAMUsO8sRWgPJRKnGdyE4lkQWm3BOC5GBKAsKjDpA52UC
	PREHlswwo/spmiDN33cSl9g=
X-Google-Smtp-Source: AGHT+IFA4eMWkDVrKVhWPdl0aVzSXiuQK/L7qWSH+yCrDVTX97KTZ9gRcZshny8dMsfXolaJqv38vA==
X-Received: by 2002:a05:6830:3106:b0:6bb:1c30:6f3c with SMTP id b6-20020a056830310600b006bb1c306f3cmr22150577ots.0.1698330789982;
        Thu, 26 Oct 2023 07:33:09 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bt33-20020a05683039e100b006c61c098d38sm2673406otb.21.2023.10.26.07.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:33:09 -0700 (PDT)
Message-ID: <ca49a6ae-c9e3-43ac-b99e-dd84cb3caa4a@gmail.com>
Date: Thu, 26 Oct 2023 09:33:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unit: correct memcpy overrun in test-dpp
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231025224224.321013-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231025224224.321013-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/25/23 17:42, James Prestwood wrote:
> The memcpy in HEX2BUF was copying the length of the buffer that was
> passed in, not the actual length of the converted hexstring. This
> test was segfaulting in the Alpine CI which uses clang/musl.
> ---
>   unit/test-dpp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

