Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F53E003
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgjfsBep"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57bc2c2f13dso90263eaf.2
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697752036; x=1698356836; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqlvKT37O1nR1ktKSi7mFu1IVYZymjL7A2t5GQRdDX8=;
        b=XgjfsBep27FwfRCgy22FIH0EAqqIHD3qxx0Es41b5MZZQRPtP9x4k7kHZbnuFlE9Rg
         PdAVYxgHU00Y29VtYXlYzhuqhmXKYx4vFP6kj6Tr25aID1Yti2bSiYlbu98Bza/ZbBuA
         TWnCV5oIxnMLW1wCOHxmYQq8aViTT44/pRHr1pLOCMXV2aXnS/R4SHBmanJ1cgKGXErU
         uDcJ43yGIddp1TVLpm/vqQnWo0LbN0TC+hmXERlC4U869V1osb32k9FSemful9+G04Ci
         /NxeQzEKLFkfTnHPLXVAlhka5kpSBxiF0z7UE8Vd5+qDq5fXaqeJwN5tPjbXXiI59q2D
         WdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752036; x=1698356836;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqlvKT37O1nR1ktKSi7mFu1IVYZymjL7A2t5GQRdDX8=;
        b=aBI03OB3/YYXsKtZnrw245CokYWGONqugN5d4VLmogqtwwUN/W387NC9kIvtMXWJM9
         6ReE2YVWi7X0wneX1CxbPJA7PitX/OIN/OSOZ3RdWRZ6exRTC/w3wUMUuQUTLqTS1KNy
         09UILVdRoLvRSSMgKDZcNsUxWFysdrepZk+bi3PFYcrsCZ4P8l/kNL9xTS8idFDH7Xrl
         usrF0USH3I4fzJyBql/a+Vz/Q+qmVhVUYrHHVzt1+YNQBR3xgFK9Wy7SqtCMnjsweRIS
         7meHd7vuQZ2BmXj6o4LRlKXYCsaWKTnbA78SM9Yt+fQ1xDOyWyxCbNKFJmjZ6lxUc8RC
         sUsQ==
X-Gm-Message-State: AOJu0Yyzt+D0+mNl4eiBMdOh9SMnDn76Fu8G02hHJfbIfaWJMPYshMyR
	mUdAFV6EJpfIWCsdOhPcB3c0maWMC/Q=
X-Google-Smtp-Source: AGHT+IHDOeEZrBwkr0N1dv/0xfhF+qQnCEGn1J+Sj91lHuz1m9+27Dzl6LPd5cJxKW5MgIdugZnmoA==
X-Received: by 2002:a05:6359:5e18:b0:164:8d78:258a with SMTP id pw24-20020a0563595e1800b001648d78258amr2894153rwb.20.1697752036552;
        Thu, 19 Oct 2023 14:47:16 -0700 (PDT)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id x26-20020aa79ada000000b006be5af77f06sm248857pfp.2.2023.10.19.14.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 14:47:16 -0700 (PDT)
Message-ID: <832c2b23-f009-494d-b497-b1c4075f3caf@gmail.com>
Date: Thu, 19 Oct 2023 14:47:15 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] offchannel: add support to issue multiple
 offchannel requests
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-11-prestwoj@gmail.com>
 <9182f9f2-4752-4737-bbf7-d308136d47fd@gmail.com>
 <78efd011-8851-43fe-b1b7-adf42a23ff68@gmail.com>
 <dda44204-e322-4802-b1dc-a2a61de83a3d@gmail.com>
 <6395c614-451b-42f5-8918-7fc3773c2134@gmail.com>
 <e5ddaedf-b334-4d53-bd88-eff92d250efe@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e5ddaedf-b334-4d53-bd88-eff92d250efe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 2:42 PM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> It wouldn't hurt, but I think we were always under the assuming that 
>> the ack would come before the event so I never bothered using a 
>> callback :)
>>
> 
> My memory is fuzzy now, but I think brcmfmac was very weird in this 
> area.  Which might explain why offchannel code is written the way it is.

I think Andrew sorted much of that out in frame-xchg, and I think there 
are comments about similar behavior of acks arriving late. I can dig up 
a brcmfmac card and play around with it.

> 
>>>
>>>> src/offchannel.c:offchannel_mlme_notify() ROC cancel, cookie=1
>>>>
>>>> # Cancel ROC is correctly waited for before starting the next item
>>>> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
>>>> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
>>>> src/offchannel.c:offchannel_work_ready() Issuing ROC
>>>> src/netdev.c:netdev_mlme_notify() MLME notification Remain on 
>>>> Channel(55)
>>>
>>> This seems fishy?  What else is going offchannel?
>>
>> No, this is the same event as below, just netdev printing it.
> 
> Ah, ok.
> 
>>
>>>
>>>>
>>>> # Then immediately we get a Remain on Channel event
>>>> src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=3
>>>> src/offchannel.c:offchannel_mlme_notify() ROC started prior to ACK, 
>>>> setting cookie 3
>>>> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
>>>>
>>>> # And finally the ack comes in
>>>> src/offchannel.c:offchannel_roc_cb() cookie=3
>>>
>>> Yeah, why is the cookie 3?  Shouldn't it be 2?
>>
>> 2 is the work item, 3 is the cookie above.
> 
> Yeah, I get that.  But shouldn't the cookie from the kernel be 2 and not 
> 3?  Or is the cookie also being incremented by CMD_FRAME?

Oh I see, since it jumped from 1 to 3. I would need to verify, but I'd 
guess yes the CMD_FRAME increments the same counter.

> 
> Regards,
> -Denis
