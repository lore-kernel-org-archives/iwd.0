Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35066FCC
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 23:28:32 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-765a7768f1dso8530085a.0
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687994911; x=1690586911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8Pbyv6FHTkd9L5EWuC/zF4UmuRjVoCLdhHzaQZcXzQ=;
        b=a/Ja4lBRRvnzZr+3szh/m2FuBlsywRkJjzXVVN1b/ayKkpGOgz+7QiUHLMIEstJbit
         +zGI4/6G8zH/Cs1ruemJD0vN9IKm7vnTqcjyDVESLykdVHdgZsUf+9o1stxPjL0no65S
         BhOjG7Zt7pLlqvQZwjadzIKucKXv07zPDSTgl2F/+rMeaxBCj6mbOeE2P3x/FAA9+MCA
         GE1pUbR5jxu1UVUtEbjckgMAB62bvk64l1/uyjtZ4KYLP8ASPhFrMn0fz7yg8IoVpWuv
         CkOXRX0USY4hvRco1qE77kelWJxQ6D8BTgy3GvPQLHbl9fO+4jtEEb4GPbTz8vxBa1p6
         Y/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687994911; x=1690586911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8Pbyv6FHTkd9L5EWuC/zF4UmuRjVoCLdhHzaQZcXzQ=;
        b=jf10CQCEy4vDF4+ZO2kL6qG+MNPZeFVpn7QO+alh7V2HRFc9s/qvxyj6ulaAJqkvh3
         CXRW6jaMdPs6rtku809LeU0wdDkW76ujZ2WmpDK/y8YIjeIKYjoouiNVss4d7iP4lxAP
         w7rEWmVvlQBKRL+9PaZyjNl07BRT5Q4Wki7K515146dSjeEz5QSUZhEHA+8ycx363n+5
         zI+BaWRhxChONcbkzV3/nBBGqCjkdbSh15KNwimlYLRjMjFMtab65nP1kpDOHKt4teTd
         v10UUPc78s5iYYkADTqT/lly/TwehbUvUlgbNbzBP8QyldgX8aS+m36+wxzpaOEwT1HT
         6yaA==
X-Gm-Message-State: AC+VfDxB3AgYU4YPwrlr93KaN5TLuyDCv/B+xqJb529d7L1uk9Uks1CL
	YFPkCAz/AdH9Uv6+fHeMt1pBtaAfXZo=
X-Google-Smtp-Source: ACHHUZ4xwz/tazp2J8sxfbpEyDhH9YF3jSwac+XPib5eRAGiToHAEA7O53VkzQPoU7+6jbetvjiMUQ==
X-Received: by 2002:a05:620a:4456:b0:767:2984:607d with SMTP id w22-20020a05620a445600b007672984607dmr2722595qkp.63.1687994911205;
        Wed, 28 Jun 2023 16:28:31 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j13-20020a37c24d000000b00767209cfbcfsm1109420qkm.78.2023.06.28.16.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 16:28:30 -0700 (PDT)
Message-ID: <0615f06d-ccee-4d09-0353-8da17a010b21@gmail.com>
Date: Wed, 28 Jun 2023 16:28:28 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
 <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
 <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
 <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com>
 <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
 <7c2ca71d-5cba-c067-04bf-75a9341f3db6@gmail.com>
 <6795644d-1ce8-6937-d8b8-4318f2720289@gmail.com>
 <CAOq732Jy-7694fPsHc5ZOuGxxE_yx=-RnsegR0+DXE4UJsaBMw@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAOq732Jy-7694fPsHc5ZOuGxxE_yx=-RnsegR0+DXE4UJsaBMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Hi Andrew,

On 6/28/23 4:19 PM, Andrew Zaborowski wrote:
> Hi James,
> 
> On Wed, 28 Jun 2023 at 18:14, James Prestwood <prestwoj@gmail.com> wrote:
>> One other potential (but much more complex) solution would be to use
>> multiple hwsim instances that communicate, making a sort of distributed
>> hwsim environment. I'm working on a similar concept which could
>> (partially) be upstreamed, at least the hwsim parts.
> 
> Another option would be to occasionally dump information about phys
> and radios in all namespaces.  While this is complicated it may be a
> little easier than having multiple hwsim instances because you can
> move threads in a single process into network namespaces.  I.e. you
> can, for example, share an l_queue between temporary threads each of
> which moves into one network namespace, opens a netlink socket, dumps
> the phy information and exits.  Or you can keep the threads alive to
> track netlink events but locking becomes more complicated.

Its good to hear from you :)

Yeah that could work too. I just already have this concept working for 
other purposes, where the instances don't share the same kernel. So it 
makes some sense to upstream this and have the communication be 
generalized to an FD that could be Unix, UDP, TCP, etc. It may not be 
useful to test-runner, but since I used hwsim as a base for it I feel 
like it should be upstreamed if possible. I'll be sharing this soon.

For now, and purely test-runner purposes, watching for ADD/DEL_MAC_ADDR 
events seems to be enough.

> 
> Best regards
