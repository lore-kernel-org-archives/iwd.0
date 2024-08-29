Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185C446D1
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937977; cv=none; b=L8uLZ+6soxmw/hpPQhUxhgvjTRxAHbtkSiv0fE1lsH8avocIOJX0i/LUA0GEW+/eh/sWQOdxFEcFyTKAxr4t2OqHVLm6Mi/LfSm8+cPxkTeM/6fTYJfj8/QKoVwXImB8EqxWn57Nylcp6btWO7FVTKNpTkSH+y1RL//CnUTW5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937977; c=relaxed/simple;
	bh=KF1FBHsx3a6QLVrN9PrFg0a2tpWWxa9dXECVSmFGUgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I1qUefwtMPZSuqmn9GDNlQlx4TgsR9d0ENarQvQM3C0doCWyG/RKPd0fLxv55fb0/M2yKhQm8qVhprpk7pkClC+GvvPGcJchbzjm1y+c00KRuz+eRKU5UtrTK6wJssgghmaNjz63gprJ87i0VA/9Bx9fZ/wxdrYFJHrOj8ofpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXd1OZMR; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXd1OZMR"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2703e8d3f7bso333719fac.2
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724937975; x=1725542775; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prtdVcY9kAPB6PbL5itaUDMGYptmzWKiH8LELROGZME=;
        b=bXd1OZMRuzzcEWBqp50ZOc9uMOwVBQj7mTW/J8FEukLI7ESzDIeIkpzuXGkhNqeRGw
         accodbZCyt0NB2dBXRpPCCOgzAsLa6caxLEh+fs+jz30/5U8mp2UXUse9DMmqngJ8rS3
         AehdGPQ8Qk+e3oGA5EdYrxR+LNW3HQaOpUT0Jf14oBfyQg5mkmgHABuJcDv53wFCfuR1
         ZW/2PbpFNl32CnWoIfjhwzYm/vKW/oGIGRpsm/huCs6bjj2M/vXrk17O12VKVG4dqF6a
         OBY4xvxKzTmvptgOXyeyzR9JKhIOOYIAn7WAAmehV+ov5oBIwojg/vdEjhERsa7kOO9c
         tBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937975; x=1725542775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prtdVcY9kAPB6PbL5itaUDMGYptmzWKiH8LELROGZME=;
        b=Xah0j2BboipnAVAsNyiL5GeCFwFNhsEGNEpm3D3GLUX25xyN8bNnfIno829pBj8Efk
         KLyJ/bLNw3ETZbrgvOnaSqnqkYkNKa/Qn0ISJpKU4WfH8t6mfbGeSocEvti2k9VWMobw
         obdI2JVHYYtzCPbvb8x0Yu/g4fjboTLeSQ9qI6vXWbPZ/0F7WVcKGJqYPCNWNtTdEBcf
         WakAJV+5DLN9d7LdcyC3G/PdIT3ua+tAr/5uh3IHam0g67r/t8i7HZ6/wg8C+zH8e5y3
         cKSE7SNw6OhZKC1lxPjZZWCU5YL9uYmBRNAieLMbHIsGjapI41MiY2Py4eMmPgnZOWpz
         tfOg==
X-Forwarded-Encrypted: i=1; AJvYcCXENGCPSCGTY13C6ksSQc/qWVcO7Lq1fYRpRZEbgPTG0jtCU10tNYs0+g1QnB/kgXnnmHw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzY/NYNpBSeQQeuWfJPhq4CH8w1D4nl6v7c6b0sh+RiQary1aiv
	swofFx2NpOgRVOzpKRdxHX9FEeL9lt7d0km/IWbu4r3vi9w0aodf28yj0A==
X-Google-Smtp-Source: AGHT+IGVgJUNxVzojL3Xu1gSS5+QefcpRNEA4NrX6CrSIGwipk64Kpz8xQ0JoLE2A6o68BlRxbaxHg==
X-Received: by 2002:a05:6870:1c9:b0:270:3120:c55b with SMTP id 586e51a60fabf-2779036810amr2677915fac.50.1724937975169;
        Thu, 29 Aug 2024 06:26:15 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bf75e4sm50964585a.11.2024.08.29.06.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 06:26:14 -0700 (PDT)
Message-ID: <d10b9c12-25fd-4e58-9ab1-061af4a3b09f@gmail.com>
Date: Thu, 29 Aug 2024 06:26:12 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build failure with GCC 14
To: bbhtt <bbhtt.zn0i8@slmail.me>, iwd@lists.linux.dev
References: <520f3ed2-79fe-4b91-9442-b219cb00732a@slmail.me>
 <eaa91b3f-b8af-4c6a-bf40-6613d80d4ff5@gmail.com>
 <172493751485.7.2131554893827444665.418884701@slmail.me>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <172493751485.7.2131554893827444665.418884701@slmail.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 8/29/24 6:18 AM, bbhtt wrote:
> On 29/08/24 17:15, James Prestwood - prestwoj at gmail.com wrote:
>> Hi,
>>
>> On 8/28/24 9:13 PM, bbhtt wrote:
>>> Hello I'm seeing a few build failures when building with GCC 14. Not 
>>> sure what would be the place to report these.
>>>
>>> ```
>>> monitor/main.c: In function ‘genl_lookup’:
>>> monitor/main.c:328:30: error: passing argument 2 of ‘l_netlink_send’ 
>>> makes pointer from integer without a cast [-Wint-conversion]
>>>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>>>       |                              ^~~~~~~~~~~~
>>>       |                              |
>>>       |                              int
>>> In file included from ./ell/ell.h:17,
>>>                  from monitor/main.c:43:
>>> ./ell/netlink.h:34:59: note: expected ‘struct l_netlink_message *’ 
>>> but argument is of type ‘int’
>>>    34 |                                 struct l_netlink_message 
>>> *message,
>>>       | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>>> monitor/main.c:328:52: error: passing argument 5 of ‘l_netlink_send’ 
>>> makes pointer from integer without a cast [-Wint-conversion]
>>>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>>>       | ^~~~~~~~~~~
>>>       |                                                    |
>>>       | long unsigned int
>>> ./ell/netlink.h:37:58: note: expected ‘l_netlink_destroy_func_t’ 
>>> {aka ‘void (*)(void *)’} but argument is of type ‘long unsigned int’
>>>    37 | l_netlink_destroy_func_t destroy);
>>>       | ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>>> monitor/main.c:328:9: error: too many arguments to function 
>>> ‘l_netlink_send’
>>>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>>>       |         ^~~~~~~~~~~~~~
>>> ./ell/netlink.h:33:14: note: declared here
>>>    33 | unsigned int l_netlink_send(struct l_netlink *netlink,
>>> ```
>>>
>>> Thanks!
>>
>> Looks like you just need to use a compatible ELL and IWD version. 
>> When APIs change or are added in ELL and IWD depends on that we do a 
>> new release for both. We don't really have a table explaining 
>> compatible version, which we probably should.
>>
>> Thanks,
>>
>> James
>>
>>
>
> Ok, thank you. I was trying to build iwd 2.19 with ell 0.68 since that 
> had a new
> release. I did pick up 3 patches regarding l_netlink_send API from iwd 
> main
> but hit the above issue with those 3 patches applied.
>
> I'll wait for a new iwd release.

As of 5 hours ago, we have IWD 2.20

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=1ac3915641c9fc986cf71fc8de2740104da6a96a

