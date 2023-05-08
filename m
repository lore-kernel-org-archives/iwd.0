Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422BAD25
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 19:04:56 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6aaf6fef215so715342a34.1
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572695; x=1686164695;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7b4xMqDIjNuPIfUuj3jd8KbedIYcDpJ9SXypF2Sjgg=;
        b=GvklJB2Xz1nCwsJAu24zFSQQQP/uyJCNcF8GpzzlVN6n6ZkNwaM1rQtlf/aGpWEHr1
         2evqeucSeZzNdk+09KJ9+s5jBemyL8h0fSHyW6VmzRy5wqMP2gpL4bPf096AyCgpYyR5
         norpLiovwq+QuKqgGSYnp263ybuOiYPMRHwDW6b6UwSkWS6myxPK2lTmswwBbzD83CbG
         JuCC/qzw7Rk7Fl04bEN2MCxt1c2DR23sZioE95GX/Wfiv5pBaokykuamRMoEyr8RecXs
         /3mlqHWIu4rmSiC8KdItV+QgC1b3Pu45fdlOP+ijnmJzW/jPeTw5r+5Kbxl2Zq3d1bNq
         LEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572695; x=1686164695;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7b4xMqDIjNuPIfUuj3jd8KbedIYcDpJ9SXypF2Sjgg=;
        b=b/ra2aId2amsetsrlWmQWpXJLFV7+Cse/lU5YQcLXMyCPS1khLNKrH4kI5j5flSxuc
         cunseHFgO5M11T9AHGLbK2HKY9jjrWy+oGXgsDP53sPMKfac+tTi5HJc2GVlYWE4I5Vn
         9kbOUqduyMlsb9IvyjP6m1MqJOHpk+/Vw5AzKhXf3iN4lHSP9DmgVaBg4qOqWxekJT6b
         KR5LxHeUAoi8wxzYRBOYdQXeJ/vJrdLbnBpJ/2NPfKhnYh/deLRmzL4iTJmWC7zro0fl
         8FGFZw4u3aVp9kCgyJKz7WiAWVbrqEd2jqHnZ4FZgvxNn3kEsb5DxuVJr0z355ABOH3X
         kPGg==
X-Gm-Message-State: AC+VfDxBsuJAN8HH9cp3D5e+ANQ7pdXgJFKgGI/ijvPTzacUCl0SvwFr
	gL+mO9ni4yknrhmt8fnEFkU=
X-Google-Smtp-Source: ACHHUZ7+6CSbVZOP2corBSTGoBSD8b23Hwj75X9K9FmsT7PfFJpOxSjWQH85ORbe4ybojVyZ5vptzA==
X-Received: by 2002:a05:6808:48a:b0:38b:8d27:ff52 with SMTP id z10-20020a056808048a00b0038b8d27ff52mr40526oid.53.1683572695290;
        Mon, 08 May 2023 12:04:55 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r184-20020acac1c1000000b003926e3328e6sm346676oif.8.2023.05.08.12.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:04:54 -0700 (PDT)
Message-ID: <b3f47044-4be0-40ae-d0d6-d868de07fdcf@gmail.com>
Date: Mon, 8 May 2023 14:00:01 -0500
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
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>
>> Suppose we have a setup with a single namespace, with 3 radios.
>>
>> Radio A with address aa
>> Radio B with address bb
>> Radio C with address cc
>>
>> When a _unicast_ frame with target 'cc' is seen by hwsim, it loops over A, B, 
>> C and compares the addresses.  If the addresses do not match, then no 
>> HWSIM_CMD_FRAME is issued for that radio.  So we'd only issue HWSIM_CMD_FRAME 
>> with Radio C's HWSIM_ATTR_ADDR_RECEIVER.
> 
> Ah ok, I see where you're coming from now. I overlooked that part. I can re-work 
> this and if the destination is a known radio then only forward to that radio. If 
> the destination is to an unknown radio I think we have to forward it regardless.
> 

Well, that's the part that is unclear to me.  See below.

>>
>> How does it help if namespace A receives a frame with target 'CC'? It doesn't 
>> know about Radio C, so how would radio C even receive the message? And if it 
>> somehow does anyway, then it would seem like the above dispatch logic is bogus 
>> in the first place?
> 
> If a client in namespace A sends a frame to target CC then the hwsim instance in 
> namespace A gets this frame. It doesn't know about target CC but the kernel 
> does. So it forwards into the kernel and target CC receives it.

So suppose client in namespace A sends something via Radio A to Radio C.  hwsim 
instance in namespace A will loop over the radios it knows about, which are A 
and B.  A is the source radio, so that should be ignored.  So with your proposed 
logic, hwsim in namespace A will send the frame to radio B with the target being 
Radio C.  But that would seem to be pointless?  If sending to radio B regardless 
of the target address is fine, why do we even bother with the dispatch logic at all?

Are you sure it isn't being sent to hwsim instances in all namespaces?

Regards,
-Denis
