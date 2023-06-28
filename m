Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B84C2E0
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 16:28:21 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6b867acbf6dso745378a34.0
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687969701; x=1690561701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCb2Vb0sw1d9TmPcfXH1hgjTZMlLKeDGOqDDjRW5Mpg=;
        b=g0EnFGidduMcz4cur4wPePjVp08LFmQIVh9EkUzEh9ipzvElJNTdVw12bQG5ZG0bn4
         HNhQKMMREfqrhnfHqutFsCJ9KS3XTnDiQXWu3D/aq25q14822ovYBzNO3ogEiZBoUpZf
         0dQAJqtKUD5ARKe8PonDZSmw/lvl0y9ohD0K1nlTqgH1SPfvr5M1IaN19h8+/95xs5TF
         8T7Lh34U3eGFoMDywj9fy0plEqOk3drXmPRXvgzmJ9hdo8z7pacOKxZusrrtCgtHuNNl
         PUG4Ae7xKBwGTl/5hPAo7S/s8QwqhkSympDIEfaUOUppIIYN6rs2XZYUx0SyaZZ+TI4A
         VOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969701; x=1690561701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCb2Vb0sw1d9TmPcfXH1hgjTZMlLKeDGOqDDjRW5Mpg=;
        b=DTmsmcFLOTlyXw5QuVTccQv4M6OFgExFVrGD/1O2dzE0JNAVqTjrc+s5oh9+/DQM2n
         EUaTm5Zalo0m1d4hf3TVuQ7bzqI/AmfJiDyp9i6/kFI+6Q9lmKBrl4zIkXIkY+eQSF8X
         webJp/L5N/rEQpgYuEk3HZEREd2BwbcrrOxl0eMkyOQQN02l0+DfEG5dKuvix/yFC6Y6
         QYjqO9X4bftvsv4BVQ6IfWe1jikODVQA14NG8Zc+Axnq3ZfBM1h8KdU3eCT/m5HrHRk7
         5HBeue3Uid3+3Sjt8UWzF1uu1dOrw8ZXO7yacK6HK1vGarqnBA/KfRm9pNyAuJp6fVLJ
         C6xg==
X-Gm-Message-State: AC+VfDzlKs0b+XuFI1c3A2ohhdII3RbpTSkMtdDXiyNSK79J9qmjOQGM
	LjfvkfDcQ/qTMxdyabE90CM=
X-Google-Smtp-Source: ACHHUZ7OcWTt22K6Zw3ExfiFAyEMeyuvOXgr3fI8PotD5XRF+JFr/5KL2V32h0kc7qQz2+Vw8GJXZg==
X-Received: by 2002:a05:6830:18c6:b0:6b8:6979:3d4 with SMTP id v6-20020a05683018c600b006b8697903d4mr965754ote.19.1687969700881;
        Wed, 28 Jun 2023 09:28:20 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z15-20020a9d62cf000000b006b83a36c08bsm1981089otk.53.2023.06.28.09.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:28:20 -0700 (PDT)
Message-ID: <5b044364-7a3d-7be0-ff18-bcba656e6172@gmail.com>
Date: Wed, 28 Jun 2023 11:25:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
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
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6795644d-1ce8-6937-d8b8-4318f2720289@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>> Unfortunately once you move the radio into another namespace you lose any 
>>> events associated with that radio, due to the PID of hwsim being associated 
>>> with a distinct namespace (I think). So ADD/DEL_MAC_ADDR won't help here.
>>
>> Which events though?  You should always be getting HWSIM_CMD_ events for _all_ 
>> radios since only a single hwsim instance is registered, no? Aren't these all 
>> you need for the purposes of sending packets to the right radio?
> 
> ADD/DEL_MAC_ADDR, which don't come once the radio is moved to another namespace 
> (as far as I can tell with testing).
> 
> I think it comes down to port ID:
> 
> u32 _portid = READ_ONCE(data->wmediumd);
> ...
> hwsim_unicast_netgroup(data, skb, _portid);

Then this may be a conversation you have to start on linux-wireless.  I would 
have thought that there should only be a single wmediumd instance on a system 
regardless of namespaces, but maybe I'm wrong here.

Regards,
-Denis
