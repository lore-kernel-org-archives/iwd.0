Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5816F8E9
	for <iwd@lists.linux.dev>; Thu,  3 Oct 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957841; cv=none; b=GRMcCS24zyC/4XD0QeCJyEJYn4zSMhPt2gl102PGpKLZjG+CExO0eLKcs4E74l+1oXEW73gEOtfstjFJ9Kdr8hegaLNNezuWXODK/O9BvMA9JOmehgnUUGdA3IKIuIOBlWXiWFghAiyMcsjBq31RIm9at/p2yrgsUyF0KCmwjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957841; c=relaxed/simple;
	bh=sgddDUiO/ZHG5hgLxiZcD8NaSFZUITQuTlL18w6YWmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WtYh54Jf6QqVJn4BBRS/HA+QDVe00kjh/FUjaZE3wSLWqb3X/W2vB6RV9CZBf/v7kESh7CmhttsQVdh0lawdSBpxIs8Dtr1tnJrek2ERsL8Xxhxo1s9vcLtf8tuGz/SEkN4MwNL02Y8NjT2eOe6xXpyYHvS3y0+76XxyM5WgBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpw4WTPH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpw4WTPH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb806623eso7154115e9.2
        for <iwd@lists.linux.dev>; Thu, 03 Oct 2024 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727957838; x=1728562638; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBFo/iI3DdgZe7XW0yB2kkvmFK+QmYO3z7pIwYmvT9A=;
        b=Mpw4WTPHfYQCCw7mV2nLHEawqYdVzA9nUp476t/HcxLqm9kv3Yc9021yuyz2IIV96m
         IcC+hbGWG4hEdC8PdZTRIQWE3C4ijvC8yjJdiCLPAQfL4zFQZfYJvVQBr6zZL8bhenrL
         2k1693C+cM261YTdd4baNjNwJM6j0lbPTEsoRagOmCvnjejYvsdxdHCG/dSYSdua1L9p
         00lp5Z3hy8aVQADmLYKb5NQGo8dq7RH0m6XdYhpLvdeoM+rvEUYRj7doElrdytX2ldxH
         CXZZrAiY9sCwWceN1oMuEratVghvWnUEUWkj/CzNRU5UtX28cAds5z03hxWnNDPKv1d1
         c6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957838; x=1728562638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBFo/iI3DdgZe7XW0yB2kkvmFK+QmYO3z7pIwYmvT9A=;
        b=PJJfbdZ7alGodv/lLV9V90meaXmPSqttrQPCif18zDkpLISSaf9rZ8yOfZzrRUaFq/
         hNEl3Za5o0ojBA9IQvk26aYpXuZ2UkW7wt2Z66A7+Xsyxoe3ou/7qgcYeUH6GXl6JiTP
         tQYdjPhqPwo4C5p0Tl5OzcaY8zQcXb3YxzvUVFFAXkEaQIylk/g8uSRU1M4N7xpaSlY8
         gEQcu/tUs5Ejmuoy/brvnHaCURBQ+Acf/jKWnnzPCXlQVeSLqPfO2iDMhxS4MhDt+9Cb
         v/Qu1kFDBeraD/4vqaFj+LtSlL3xbV5flr6x8Z2NGIH/3Lt0B5fW+QBAY3vLkjU4+qLK
         723A==
X-Forwarded-Encrypted: i=1; AJvYcCXnNTmhhv51CxK0hLe4Bsac5TPe7/CyVymoYptnYFVB4x/CFmA9/Us8J1+Lvim+l5bP074=@lists.linux.dev
X-Gm-Message-State: AOJu0YzbWQmHJnqyA0lHEHaqUG2/KxeRtuhpzCwBeI0B9LwSn3v6GH2u
	wjryNFDUF4WQy9qXgnQaimb0QpswNVyrhNx2Zz4sZvMuY+2axRsS
X-Google-Smtp-Source: AGHT+IE4nofDRxIITFa9O01Mk+ZGWPPU9CKjlwk1LpIekDQkK/tPgpwsBSe6uvMfOR5/EdGyLVuUxg==
X-Received: by 2002:a05:600c:358e:b0:42c:b1f0:f67 with SMTP id 5b1f17b1804b1-42f777ed42emr42616425e9.27.1727957838021;
        Thu, 03 Oct 2024 05:17:18 -0700 (PDT)
Received: from [10.168.3.25] ([81.145.46.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm14302015e9.31.2024.10.03.05.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:17:17 -0700 (PDT)
Message-ID: <a6e3a5c8-2f6a-4af4-9433-2e3a3c74c1e8@gmail.com>
Date: Thu, 3 Oct 2024 05:17:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interop problem with Quantum Fiber WiFi7 pods (duplicate RSNXE
 IE)
To: Vivek Das Mohapatra <vivek@collabora.com>,
 Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
 <f234b143-63f6-4184-b97a-bfaa082d8cf6@gmail.com>
 <f8703c80-14fd-42b8-bf8a-d06919b0db6e@collabora.com>
 <c400002b-ce76-4cfa-b5f0-c51be00eb9cb@collabora.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c400002b-ce76-4cfa-b5f0-c51be00eb9cb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vivek,

On 10/2/24 2:55 PM, Vivek Das Mohapatra wrote:
> On 02/10/2024 22:41, Vivek Das Mohapatra wrote:
>> On 02/10/2024 19:14, Denis Kenzior wrote:
>>>
>>> Why are the elements duplicated?  Are they the same or different?  
>>> If different, which one would iwd use?
>
> OTA capture:
>
> I've linked 1 file to this email:
>
>   * 0926_qfiber.tar.xz
>     Size: 5.2 MB
>     Link:
>
> https://www.dropbox.com/scl/fi/i573yehaenpvkgy29smwb/0926_qfiber.tar.xz?rlkey=sxhhiwhmqppyic5wsc446h88r&dl=0 
>
>
>
So not only is it duplicating the IE, but its also violating the IE 
ordering which is actually a spec violation (Table 9-35—Association 
Response frame body). So I suspect even if you allow RSNXE duplicates 
you may still run into a failure with the ordering. Is there some route 
to reporting this to the vendor?

Thanks,

James

