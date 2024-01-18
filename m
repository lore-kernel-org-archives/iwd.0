Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A9249E2
	for <iwd@lists.linux.dev>; Thu, 18 Jan 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580296; cv=none; b=S634uVrBTYlWxJiwKIWK3uZf+lSycJrLfm3g/SJ0D99ElutnrqKqkI6V7ZNedpjuD+qe6jI70IcaXCWt7MQ3wdDllI8jnojVKKi1aBSTrQucwkw51CZaTKyG7qo7qrpRs4oWuCkYN1ap3/Wh0yCUOVdqcaZdS3NyqNjAm48hjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580296; c=relaxed/simple;
	bh=yZRkbG32spl0vBcQjWkMckK28iVrC/p53FF8Z4VfCHU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=rn09rHD+9pxngSZJHkIUCPnfyfq4qNJiX4pk2HyYU2U0OssLWp2Ja1EegcUf7PRyUaAaLM0m3dx0GeCuWir3JlPekNquutW5uQDoCMfxYN+KatUtF8rcbXicKxhgKu8FY9Rb4YxuFzw7rfCZ8uePTehj9p++WoV38cJwqWlS9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db7xyywy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db7xyywy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68174a6a8a8so15275886d6.2
        for <iwd@lists.linux.dev>; Thu, 18 Jan 2024 04:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705580294; x=1706185094; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFbVtjU3VGEY6f7W7RM00GgjCI3yTWYOFU8nSg4IM7M=;
        b=Db7xyywylGD5jzendJcim5FhZrWOqV8W/v4xVkrIZjJ38wkavOylgdRgxyzTvyajGD
         yNKFkMlrUcMVHmoBAO0PlB2beZ2sIRZoLplvoAi1dJyMItijAwTjd2o7FQ+b/nrng6ZZ
         aVXpgdAD8MHG/W9qiK/f/qoWwqPTbMHQe47NzkkPYE41fIs0a+4KmFOVAQA4EXuw981a
         ZjeOG6JJH/YvY7PYj4HEMQnQ+5dyQdkgd2yA2//EXFRrPReS8YssFt4DT8QNsP5A+pet
         0ndphgN5ZrYHAzKR5cTtGfTWs56o8VnqdC245vaJdwGjtg94edvqQpz9MURnW/eeifiA
         eXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705580294; x=1706185094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFbVtjU3VGEY6f7W7RM00GgjCI3yTWYOFU8nSg4IM7M=;
        b=Nc3UKdi6Y7gF7TRJItj4IEYEVtvwhVm8DJwicxCL8EIt4r6PR4aIJr5MP0po7LeaW3
         m1RQqe4LKAfaD9m1o7Um0JY/OEogsdS6F1CSyQ49qqdjdfreBMskZfMCVdr/6VahhxCR
         uSxXLH6/fLoGsSc8F0wwvT/TBSiGITRK52qVx3c0DVjCHK3GLeNnO1egJpmq/qxGYPEQ
         ooERsmo2+D30vEnwqGw8vrcnY8zCl61op0cjUZGXK7bxvxKdiaD5Us04tHb+ZV3o5ABb
         ss8npeoxJ+Od2DVJ2Ky6H2CkMpvO5tdpe7EiaCoftRMHyB3im/rjKMl7xugBcMLBtq0S
         4F4g==
X-Gm-Message-State: AOJu0YxTulazwrPQ193gN4lIqPTS88Ywap3xDGBdpojpOyEwwfri7wbG
	s4dSryQFuZb1CFoiakRMFj6KmNezUQivZnTVGoBqW9WHl40cwCUE
X-Google-Smtp-Source: AGHT+IEvE9gQjJboplblbMiHoqY5A63TBLBcVIMaRNgV2Ngvz7LWiR9QX3IvVRTy/b6HJRef06F+Lg==
X-Received: by 2002:a05:6214:4008:b0:681:7a1e:e36c with SMTP id kd8-20020a056214400800b006817a1ee36cmr590999qvb.72.1705580294154;
        Thu, 18 Jan 2024 04:18:14 -0800 (PST)
Received: from [10.102.4.150] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g16-20020ad45110000000b0067f839f073csm5848442qvp.40.2024.01.18.04.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 04:18:13 -0800 (PST)
Message-ID: <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
Date: Thu, 18 Jan 2024 04:18:10 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to Autoconnect Two WiFi Cards?
To: Fabian Herb <fabian.herb@xtonomy.ai>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/18/24 3:51 AM, Fabian Herb wrote:
> Hello James,
>
>> Without implementing a new feature with per-phy profiles about the only thing you could do would be:
>>
>>   - Create a network namespace (e.g. ns0)
> Thanks! I’ll look into that idea. At a first glance it looks quite cumbersome though. Maybe this could be done with LXC or Docker...
Yeah I actually hesitated to even suggest it :) Though once you've done 
it its not _that_ bad. We do this in our autotests framework to simulate 
networks, and run multiple instances of IWD. You may be able to do it 
with a container as well.
>
>> What exactly are you trying to accomplish by connecting to separate SSID’s?
> That’s for redundancy. The machine is moving around quite a bit, so there’s lots of roaming. Reception can be bad in some areas. And with two WiFi connections and 802.11r Fast Transition if possible, I hope to get network interruptions close to zero. Redundancy itself is done on application level.
So this very same thing is being added in WiFi 7, called Multi-Link 
Operation (MLO). It doesn't help you now as IWD doesn't have any logic 
for it but just putting it out there (and maybe AP support is also 
needed). They've been working on this feature in the kernel for quite 
some time now.
>
> Best regards,
> Fabian
