Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679C11188
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 19:08:42 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1960539df06so1186294fac.1
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572921; x=1686164921;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSHpVcBoOkpjloljBAdlqRhISieKeT3YIizHxz7dIds=;
        b=suuEKgv0LHnkybfoOyemQFVglFxJMGd0B+kJm5skk19P8Jak1GQ04TnPrbDJ70fttz
         Z7UCOauJDUAuIcnOH4gp/nBZAByWYGmbQnTF9B4kz7L3igSd/+8RUlK+f1BdCiJRkj2g
         3pTVUBKTeTXUT8qpGpaMPnDuU5GZlo6V1n8UBlMQr79/CwzDNsnHUqhpyqFxtHPyXA4q
         lGDhpZ+8fGwfxFbJmiBiPAnulooq+XyA6u3o3ULnYGMsTNH70ASgrE2Zeer/iuQuXICR
         tdJWaLLqbfKDq8C67e0zhIvNZjGMQlm4jAyjSgsAd/5N+mjCpJQcwFpUE/twSK5TJQMD
         DnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572921; x=1686164921;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSHpVcBoOkpjloljBAdlqRhISieKeT3YIizHxz7dIds=;
        b=GY52dIr4JIgCOXPUbkZo3iWZZd9AeEcGyG+qIXgMXb7qLjpI5t2EdqY7BbMNnbO6XF
         scunUfKrJCCgkpO9gcN8WCdKrhbZuTn3du3aAtIoMbAYE1I0Nc5XzqT+aYA0QALhdrmB
         +ApHJALvKvOU9pI8WHf2VGiH9EofgEBBgOsWJSlr/XX7ithr+aWOxl86OGig93zU8px1
         jIJqP7i/4P67VjUC5Avd76A0RWTt7IW1B93ePyhvXZSGY/5lAELk7dAN+f062W/g6MrI
         4T3EG1zWLx/f7TVabvU+crc9THHvlHj4gTRfYWa+mKIsg/rLWyLc4QU2+ttUXDvUm3Q+
         CtcQ==
X-Gm-Message-State: AC+VfDwoO4PMbrdOOLfaVcYj9wznLvDkrF9ULlHI2zV6OtkWjpAtlsbf
	oeo49i9xiyjvkTDzAdmW8fk=
X-Google-Smtp-Source: ACHHUZ45UdSFCbPppKz4sMPz/wxbgxHb3syoqApFmbNnOvKnG7xySuol8I/K8zSxhb4hwnLOV9ouFw==
X-Received: by 2002:a05:6870:e281:b0:18e:fb6e:1ae5 with SMTP id v1-20020a056870e28100b0018efb6e1ae5mr5717902oad.53.1683572921585;
        Mon, 08 May 2023 12:08:41 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q7-20020a056870730700b001777244e3f9sm5267191oal.8.2023.05.08.12.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:08:40 -0700 (PDT)
Message-ID: <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
Date: Mon, 8 May 2023 14:01:09 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> Ok, actually I see your confusion now. Removing that block of code would send 
> the frame to all *known* radios only... So this actually should not work, but it 
> does.

Yep!  Exactly.

> 
> Its like the kernel is disregarding ATTR_RECEIVER_ADDR and just looking at the 
> frame contents. Anyways, I'll investigate.
> 

Ok, great.

Regards,
-Denis
