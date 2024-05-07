Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2E15B150
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087116; cv=none; b=pqUjCJG+nFGglwmHNuB2rJhJ+8XDZS42aYftwaNy5VhMm30xGooVkhnahM2MX9DCTIpDfuWqPBMqAfjXCTET8uUImrWqCP3i+YuiMTLqE4odRjCuIl6291kNa0NhQzyNOWe6sxGg3SLAEhw4OwGkQUC9bC+punxZJlq5cK/c7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087116; c=relaxed/simple;
	bh=bAbewbmkoJs8Zbf4ngLlz1O6CJT3kaBK4HMsmd+PpRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AKJg/UQ1xo+lY6thDAvTFmci7y9qY2/ENgSyy3YHPSJTFQWtshmiW1h2K/ZAijsHeAoq/FsYxmFbhF4M08EcoXznE/RyC5OjshUCNJIe3Digw7G4zXCgAaaKBfJlIsoETqhQk7eB8Psu54s9kQyB8eskpB6l7agIoZYamTmG2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kspnqYUk; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kspnqYUk"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7928c5be3deso249366985a.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715087113; x=1715691913; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEmeLU0OVtQpXezs8He8zRTp1+KLtRW8eXGJ7Hgm1ow=;
        b=kspnqYUkzsIwgqWKuSW0bXvuGWEsDYVxGbtEzwgV4IOWP/PtZtiNrYEyoElXX/aQxE
         mR00pAGt8kxMmHQs7s666B0zn0+ZKmF4mXc/DgWx5OPEX92syrVMj9UMtXiukYjO1QQb
         PJ99yWkHsCKs61CGLONPvhhCjXdqzMt/SaRG2I4uHv1ZKiG+1mKBKnbpB0l3NzwQOcsh
         /nhJ4YmcnJfa/Rkjcr6TzdUh0SnRiaTlrLObF2IlKuHTgNzTQQcMcO2mXXOEoQzUt2vy
         3/agLmIr9qMj4A2QiVp1SgIQKYfTq6vZ55saXpi8zMNaaClY7HguK1YnGY3zizw5l5Sf
         hkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087113; x=1715691913;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEmeLU0OVtQpXezs8He8zRTp1+KLtRW8eXGJ7Hgm1ow=;
        b=Cvs8Yh/iaRZwUfEILlm1isHcqbv7gI7llpVdo2nP3zyOCbI2iM0sS1WfoiyPLBaoGa
         VC41Qh9ilJESHU6+JBtty7XwBLmdWCUcq+UUGwpYERTRWgJitMxh5viD66/7dgI0QuAv
         4Z8618awPpZgq082cYsun3KlB9jyBB5eC0I4k0rln4kUfe1nVn6FTZg2xqO012rG+eFV
         RAyGKYY8ZTngENFOjDvrGg3BGHwbtfwFDNSgXRo7LtLyoJr/wMcOC/ARZlWOlp3iZh0g
         NNXqgofgPmGw9o3KbhkdO30ceokC7XK34bz/U9fQEmNGJ4vqRo5fxjFmX2iZWzPaSp2o
         l8wA==
X-Forwarded-Encrypted: i=1; AJvYcCVT48LEhORsHuFBsclSNGLnGlTdUmkhKY26rAIqyC45Y+q70zE9yE3qE4gevqdGVC8tUFELrf0Py1riZVoxQD84j5or
X-Gm-Message-State: AOJu0YxHWUIZX+G6xe0HM8OFVkB0UQyxh/yzrBu6Z+5ImcBqiExRpVmM
	SlSGdJHref8sYeKHbYsQKW2+gGZAKRdHEu2K8ktw27WI3nhvcN11
X-Google-Smtp-Source: AGHT+IHlgGAzDw6WGw3pHgoYdehfYQ+AM9wb1tk5+knXG2fyBdTGyoP2vYdKBCMvd7EKgh2zR/15Ow==
X-Received: by 2002:ae9:f70c:0:b0:792:9f1a:869a with SMTP id s12-20020ae9f70c000000b007929f1a869amr4133131qkg.16.1715087113463;
        Tue, 07 May 2024 06:05:13 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id f2-20020a05620a408200b0078ec0e6188asm4870975qko.89.2024.05.07.06.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 06:05:13 -0700 (PDT)
Message-ID: <1c0e07d2-4090-48b2-8e21-48ebda227ef9@gmail.com>
Date: Tue, 7 May 2024 06:05:11 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Getting list of found networks
Content-Language: en-US
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350F79243154C9930EFC4BEAE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
 <e49f9a7f-5d4c-453e-9dc8-1a7667383912@gmail.com>
 <LV8PR08MB9350989BEB22ACB3B9C67DF6AEE42@LV8PR08MB9350.namprd08.prod.outlook.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <LV8PR08MB9350989BEB22ACB3B9C67DF6AEE42@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 5/7/24 5:49 AM, Michael John wrote:
> Hi James,
>
>
>> Hi Michael,
>>
>>> Hi,
>>>
>>> I'm looking to better understand how the list of networks are collected  after a scan is done and get-networks is called.
>>> How long does a scan run for? I am assuming the scan causes the radio to go through each channel and listen for broadcast beacons to find available APs. I have noticed when calling scan and then get-networks I can get a different amount of found APs, like either I am not waiting long enough for a scan to complete or there is some other logic that dictates adding a network to the list (too low of an RSSI?). I'm also wondering how much of this is really controlled by IWD verses the radio firmware and are these simply request sent via nl80211?
>> For a DBus initiated scan IWD is going to scan the entire spectrum,
>> 2.4GHz, 5GHz, and 6GHz (obviously depending on hardware support). The
>> scan runs for as long as it takes to scan these bands, and that is
>> hardware dependent but generally takes 100ms per channel/frequency. IWD
>> has some logic to update the networks it finds throughout the scan, so
>> if you call get-networks too soon you may not see ALL networks that the
>> scan finds by the end (there is a scanning property that gets set
>> true/false to know when the FULL scan is done). Its very normal to not
>> see the exact same scan results per scan. If some AP has a very low RSSI
>> it may or may not show up from scan to scan.
> Can you help me understand why a scan may not lead to the same scan results per scan?
The beacons need to travel through the air. With 
distance/obstructions/interference this signal degrades. So an AP very 
far away may show up sometimes (if the beacon reaches you) or may not. 
Anything can degrade the signal, most of which is random and out of your 
control. If your seeing an AP very close not showing up in scan results, 
that seems like a different issue than signal degradation.
> My understanding is an access point will send a broadcast beacon at a set interval and that
> interval is usually configurable. I'm assuming sometime a broadcast beacon may not be seen
> during that channel scan, hence causing the difference per scan. Are there other scenarios?
> Does IWD cache seen networks, or is this list fully repopulated each scan?

The beacon may not be seen but likely this isn't due to the beacon 
interval. You _can_ configure the beacon interval but I'm not sure why 
you'd want to for interoperability. Clients expect ~100ms beacon 
intervals, so that's how long they wait on a channel. If you increased 
this interval its more likely clients would miss the beacons.

IWD caches for short periods of time, but prior to each scan the cache 
is flushed.

>
> Thanks!
> Michael
>
>> And yes, all requests are sent via nl80211.
>>
>> Thanks,
>>
>> James
>>
>>
>>> Thanks
>>> Michael John
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
