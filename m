Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3F37144
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efr4L/pP"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1efabc436e4so9550fac.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881210; x=1702486010; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNPynM1JykHxjWrDfcZ6RZ86tyum5XkB3V7+wqzjofk=;
        b=Efr4L/pPqew9nG+0hmKRjOSfbDu3hfKgz/u4pwNynx1zCZldkJqf18U2wGOEW+UaGX
         A0o+iUuLpSo424fciwjzQMuTJ8tOVtFbVFkP0c5FJG5cxZ2wJvbeMc3LnNwdU7/EY9al
         thaMbOiV7AvP/Csz0m6yANp7LluMQ+TFix85VXr5n4Y2WxHF6XrQ6hW4/DuIJ/IzwMbF
         K6atZAPD0dGrzcEyE90b9AYiKTF6xdDtvB61lYlpRp+e6nxitjck0wTvcxAuCcpRUChN
         yuw7SfUitanlO01OwgL4VcDnVS3J6lVSe9/q+f5MjGIoK/DZwtN8RzR0ixmLLIkoVys3
         exuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881210; x=1702486010;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNPynM1JykHxjWrDfcZ6RZ86tyum5XkB3V7+wqzjofk=;
        b=RIdijlf3aC36MAWI0MP6sUmi5u2gUtL3C4JyLPLuNNHbstoXcc5eTFRrdsMqetuIkJ
         NOKaD8v6ujEyPHLjwZHJLcl3//bZJcGn9zbz62Fid3d0/lhopdz5CRmwg2/TmdEWcxCM
         F8dqGhRl3q71wxFBIt31H6MBlHFuhou/xokvgW5DtuVqlKrdtPcvVzKuFzrKggy8co/g
         sFKIKKjzYHcJyIU0/siUAF4un/1kvT8QNAlBuw4y69uY6YOHyt9gUM7kbdJatAA9NC+X
         T1a5ldNAxbmiZrKCHZF+/M9tZTO3H4aGtkuI9gj4YL8IpxdvF5JPOSMtwMgfygYovL/Z
         TKdw==
X-Gm-Message-State: AOJu0YxtaCBieWaF5HfGTaydsGTIMs+iufDwJHjpL7BmQnUhu0cFZlcm
	awa68FHOMvjr1v1lNNK0RlD93kS3KS8=
X-Google-Smtp-Source: AGHT+IF1Orb33hpRZPHTNP+clVsGbowlb6GdZ5c78gHYPyiZ0WVhSctqj4g8UDpVHcBlJwSnYonCnQ==
X-Received: by 2002:a05:6870:3b8f:b0:1fa:31d5:5382 with SMTP id gi15-20020a0568703b8f00b001fa31d55382mr1233851oab.33.1701881209851;
        Wed, 06 Dec 2023 08:46:49 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id u15-20020a0cf88f000000b0067ac1c30e80sm100537qvn.120.2023.12.06.08.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:46:49 -0800 (PST)
Message-ID: <fe03174d-bc4e-40d5-a69d-b1f2c240f974@gmail.com>
Date: Wed, 6 Dec 2023 08:46:47 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] ft: add ft_handshake_setup
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-6-prestwoj@gmail.com>
 <91f80f30-b4aa-41a9-b134-b3632b4ea7ed@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <91f80f30-b4aa-41a9-b134-b3632b4ea7ed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/6/23 08:38, Denis Kenzior wrote:
> Hi James,
>
> On 12/6/23 09:07, James Prestwood wrote:
>> This will be called from station after FT-authentication has
>> finished. It sets up the handshake object to perform reassociation.
>>
>> This is essentially a copy-paste of ft_associate without sending
>> the actual frame.
>> ---
>>   src/ft.c | 32 ++++++++++++++++++++++++++++++++
>>   src/ft.h |  2 ++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/src/ft.c b/src/ft.c
>> index 358a4594..738e08c3 100644
>> --- a/src/ft.c
>> +++ b/src/ft.c
>> @@ -1276,6 +1276,38 @@ int ft_associate(uint32_t ifindex, const 
>> uint8_t *addr)
>>       return ret;
>>   }
>>   +int ft_handshake_setup(uint32_t ifindex, const uint8_t *target)
>> +{
>> +    struct netdev *netdev = netdev_find(ifindex);
>> +    struct handshake_state *hs = netdev_get_handshake(netdev);
>> +    struct ft_info *info;
>> +
>> +    info = ft_info_find(ifindex, target);
>> +    if (!info)
>> +        return -ENOENT;
>> +
>> +    /*
>> +     * Either failed or no response. This may have been an FT-over-DS
>> +     * attempt so clear out the entry so FT-over-Air can try again.
>> +     */
>> +    if (info->status != 0) {
>> +        int status = info->status;
>> +
>> +        l_queue_remove(info_list, info);
>> +        ft_info_destroy(info);
>> +
>> +        return status;
>> +    }
>> +
>> +    if (L_WARN_ON(!ft_prepare_handshake(info, hs)))
>> +        return -EINVAL;
>
> It isn't quite clear how this case should be handled?  Would you still 
> remove it from the queue and destroy this info object? Or destroy all 
> authentications for the ifindex?

Hmm good point. If that fails we've already wiped the old keys from the 
handshake so I don't think we could even try and roam elsewhere. This 
case wasn't handled prior, we would just send the associate without 
deriving the proper IEs. So I think we either need to handle this in 
station and fatally fail the roam, and disconnect

I don't feel like doing it at the moment but we could create a new 
handshake object too and set only after everything succeeds.

>> +    /* After this no previous auths will be valid */
>> +    ft_clear_authentications(ifindex);
>> +
>> +    return 0;
>> +}
>> +
>>   static bool remove_ifindex(void *data, void *user_data)
>>   {
>>       struct ft_info *info = data;
>
> Regards,
> -Denis
>
