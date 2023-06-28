Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1C322E
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 16:47:33 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7658752ce2fso316743285a.1
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687970852; x=1690562852;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CklGcWb8foJm3AwyzRXc3XvQb6xdi3lo+p1ttkwEso=;
        b=avXA3Le6eCK7qqsuGCxtmdMdvEDEPLn4vFylIy1w0kXiYAF0Da8y0lDReRs5c2VG/v
         /IzsJr79wyGhPy2dhxQ2HsM9p5fB3SXuSKgq1seLdJOOWmt0+gVmwt4zd/hOGQnBazfI
         OCP25pBfAJla4yBA9i4bwU0sD4ajNLpLlDM0n4jRD20vkeXcY3u0C/pF+sqCY7GUFrUx
         z6D2QPlYRaSh8N9LpxcaeAi2CqE6FPoGjg9vp/wOcV1srXglWC00aoOkCNXvz8sy1PEG
         8JxuoLhWMI9qFT2/yIh27bdlF8eZmw1HsflcTRaIie0Hk3x7N/21w9gHrCsDnkWk2GMI
         UArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970852; x=1690562852;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CklGcWb8foJm3AwyzRXc3XvQb6xdi3lo+p1ttkwEso=;
        b=NUtANye/qUJ0R4SP1gzWikem5VWomw+LUHHkV+b0+tz4CSzI06gpWWU+8CvIgUjc2J
         0TYTvHz9YncqRGOhLfpK3GAYRlqqfOXcVDWFAt+WhazdeRUEwNadwfj86wIz6eNKtNMT
         PihuzpnWQgI+ZFSa2DiAwW9VWw0iZjDBSXJDSpviL8XULi4oFTxvchah+ils+HSSxhhK
         k+90OgPSmYFzKPFnRJYM5aaMzxUoOU8CEZdwUiWuMFpGprUtfsmlKkhq4vMwA6P4uxZj
         7gQ8Fl27T8kbUHlm99bLk1bQ7M0EGRFYOokC6UTQYwLdvFDWFSivn8amwXxKdhle9mrI
         QJyg==
X-Gm-Message-State: AC+VfDyBh9us+eyhafMAuBzfOTfQUz3lAOKeCVEIn9+YpS57nfa49+Mc
	2K0nQCFPdyyieM4wQojIzVg=
X-Google-Smtp-Source: ACHHUZ5gqaXyItztVRNmvST636PEXHMySBQoLWHB2QJxAQ0tTF70AwpMfBqlvclGr87ooHIy1lMKeQ==
X-Received: by 2002:a37:f90f:0:b0:765:84e3:aa1f with SMTP id l15-20020a37f90f000000b0076584e3aa1fmr10974553qkj.14.1687970852317;
        Wed, 28 Jun 2023 09:47:32 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id 26-20020a05620a071a00b0074d60b697a6sm3792331qkc.12.2023.06.28.09.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:47:31 -0700 (PDT)
Message-ID: <1069cde5-2ef9-657b-77a2-931615fb2104@gmail.com>
Date: Wed, 28 Jun 2023 09:47:30 -0700
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
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
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
 <5b044364-7a3d-7be0-ff18-bcba656e6172@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5b044364-7a3d-7be0-ff18-bcba656e6172@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/28/23 9:25 AM, Denis Kenzior wrote:
> Hi James,
> 
>>>> Unfortunately once you move the radio into another namespace you 
>>>> lose any events associated with that radio, due to the PID of hwsim 
>>>> being associated with a distinct namespace (I think). So 
>>>> ADD/DEL_MAC_ADDR won't help here.
>>>
>>> Which events though?  You should always be getting HWSIM_CMD_ events 
>>> for _all_ radios since only a single hwsim instance is registered, 
>>> no? Aren't these all you need for the purposes of sending packets to 
>>> the right radio?
>>
>> ADD/DEL_MAC_ADDR, which don't come once the radio is moved to another 
>> namespace (as far as I can tell with testing).
>>
>> I think it comes down to port ID:
>>
>> u32 _portid = READ_ONCE(data->wmediumd);
>> ...
>> hwsim_unicast_netgroup(data, skb, _portid);
> 
> Then this may be a conversation you have to start on linux-wireless.  I 
> would have thought that there should only be a single wmediumd instance 
> on a system regardless of namespaces, but maybe I'm wrong here.

Yeah, I'll do that as well. This would simplify things if the namespaces 
didn't come into play.

Nevertheless, was the distributed hwsim concept something you'd be 
interested in accepting upstream? Like I said, I'm already doing it and 
I'm happy to re-use hwsim and extend to support this external socket 
concept.
> Regards,
> -Denis
