Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19366E8
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 16:18:20 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id x23-20020a056830409700b00655c6dace73so6533931ott.11
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jxzIs/NOMHUMQ29TG3sG3pl1tw6gP/uDeTdguhrXedw=;
        b=LJAFS8XJ4qHmjeZTF9gVnRNuU+s+7sZFB94jtUZdcxXMBHA2W2iXqw9MFiEiZN1pGl
         4oojHWc2ajS4ZYmGLvEJNwDwoK/Pywx3RtX6bTWemELu04Txl5h+1Q71EQDxQOXwcTle
         toqWbX3aSeXwdwol8+cx48kj2WQbIQTDvzqd34+mY632ZFOs13oIOKlzT6Z/7MDGb4k6
         cU2kIT5t5GuRJ0KQQz8PA5Xc/nj9fpSTMiKmDSEu75y41mey3AsKun9as/KLrI1dEF06
         m8tx751wblQEpdfye2jsdGdHzwtAbBUg/8OV6hv9jvTzZkRqMj1DtGddcI0S41ZKQ6mu
         6QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jxzIs/NOMHUMQ29TG3sG3pl1tw6gP/uDeTdguhrXedw=;
        b=b2P6pYga8+eK3yDO6tXsjhiWhgylxFMu/Fcd94rviL3Xghafnw9p5bJ9dXW5XD7yZq
         853fTfXglBeNShxqkYUM78IKclR09mJLhZzcLuihYjReI4YLb4kHa8cj7LfTzIfAMYUg
         kfHAayqHmioLamHa1QCBerSU3Fwwl0wAzuUgLyJcUP5e6NzFUv9Cc1c8dK39r0hP4chK
         PTYzcEvoS26LVqT7aKCNe12zKPhCnu3Edm0Oy+HhUv/FN3buuMtKBk0XXCjxK394wjKu
         PrMhcyBBe048iz3Azd0Pell2xfSRgFX2vBkA3oxfdZaBmzS+AR0cks1n1358G8a7JR+i
         pzZA==
X-Gm-Message-State: ACrzQf2CZVYheaaIvZqfIeCYTmOq3peIyz/wVpyEAHGq84c31INql3rP
	uOGTUILU60c9wc43Ki9IrLE=
X-Google-Smtp-Source: AMsMyM7Ii24Bq4PvtnXczivFoxEZHiyA5YAdeiTyWKB1huIia3g2LFRsolkx3ixBYhFZt+tiWjMA5w==
X-Received: by 2002:a05:6830:2a0e:b0:65b:d5a3:ef8a with SMTP id y14-20020a0568302a0e00b0065bd5a3ef8amr2026289otu.93.1663863500110;
        Thu, 22 Sep 2022 09:18:20 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h2-20020a9d6a42000000b00637032a39a3sm2863411otn.6.2022.09.22.09.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:18:19 -0700 (PDT)
Message-ID: <50ac31bf-7c7e-706e-a7d0-11132cb7ab12@gmail.com>
Date: Thu, 22 Sep 2022 11:18:18 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 05/15] ft: netdev: prep for FT isolation into ft.c
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220921223158.704658-1-prestwoj@gmail.com>
 <20220921223158.704658-5-prestwoj@gmail.com>
 <258acf4a-457b-4154-9be1-f78eb0154bdb@gmail.com>
 <052453327454f732c39f4bdeb888a737eca53cf5.camel@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <052453327454f732c39f4bdeb888a737eca53cf5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> True, I guess I could do l_queue_peek_head() in the while condition,
> then pop/free if the ifindex matches.
> 
> I've run into this a few times. Would be nice if we had an API to
> remove/free multiple entries based on a match function. Or if an
> l_queue_entry loop allowed removal, maybe it does already.

We do have this, l_queue_foreach_remove().

>>> +IWD_MODULE(ft, ft_init, ft_exit);
>>
>> Does netdev need an IWD_MODULE_DEPENDS on ft now?
> 
> I don't think so? Since init/exit aren't using any netdev calls I think
> its safe.

No, the other way around.  netdev (maybe?) needs a dependency on ft, since 
netdev invokes __ft_set*

Regards,
-Denis
