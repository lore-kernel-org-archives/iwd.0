Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965D3589D
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO6HN0+V"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce291b5df9so3740247a34.2
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380969; x=1699985769; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtvAWFtc0qgZ1Qk4gnazN0v2UjsWYoXIPtXXHWHktwY=;
        b=hO6HN0+VUcXIGXWG5kpC+ZVBV7rSYUw2FJ4kv1hi+ESu+nNVCArSc8aCSs50UgSV4E
         vtblimpd/+d0nzynsSTTJiOA7MPv/8t6AklxK4+SgAGlbkFNe0XEEOVYPTY22yJbQFAr
         Ca/5G4Ix0ezaYNCUcfaODKPi4zxuU0RKXHlsg6+pXh9L6HIy4uoudFLH9qFUoDISDzAq
         fBOl6piZn+qCYrLQjHFUGMqJHdd9cB3a2Igh4tisGC8mAbT6pXHz5iYyebIIzd4XdPP3
         5JKdKd2/CdMLWGPVG1c1JKaB2+knkrIzJ8pP6gtvirLYyuhckG2e9tLKRU320mwfIYPZ
         /prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380969; x=1699985769;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtvAWFtc0qgZ1Qk4gnazN0v2UjsWYoXIPtXXHWHktwY=;
        b=qB43UpxQ19AiQS4DHfo7qAftllgcnIw3wN9xNI1Pkr4n3/b1hSq6meyZXllxKA8WW9
         OfLQ2gQTtvbySk6XxxIILaDtZc4D6TSIg8ujsQblPj2IS6DDeybO6ImC4NaT1rzEAGuf
         86SueANGTwRbojOrualSBJ4xx6A4o37E1ImcENt160UUtCByzuJJOBnMnyAAZ4PbkDDU
         68bPtupshAtXjcdSxUx5/+R7go3+CRr5Kv8rHVzeeYYfzHseOM9qa16g8lQbZLsipdLF
         OJfaGAI5Ws2kmDmGwDIxusnD8RQLH9vmPBI5g//Snspp6GuDcw9sAgIHVy7h2Dk1FmMX
         mERg==
X-Gm-Message-State: AOJu0Yzvx1mMgg98f2m1db//9oShPuzzYNoZ0puzNJkfiqDMppk1MQ6L
	48d1uj2D+EWTnrfUAPcyk0M=
X-Google-Smtp-Source: AGHT+IEr3mkh1rgjY2JmYzTxBowOt4qzJYkU5poP5TPT/u/hMm+/LZoQCWgjwm9U4h4LsWKRS5m4LQ==
X-Received: by 2002:a05:6830:2646:b0:6d3:1e5a:d935 with SMTP id f6-20020a056830264600b006d31e5ad935mr22987652otu.11.1699380969064;
        Tue, 07 Nov 2023 10:16:09 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g13-20020a9d6b0d000000b006ce32aac3e4sm1692932otp.48.2023.11.07.10.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 10:16:08 -0800 (PST)
Message-ID: <2b2efe83-80c3-4452-ace2-dbf8cea3a561@gmail.com>
Date: Tue, 7 Nov 2023 12:16:06 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: error with commit aff2d4d66f07ed0a1816122d26369ccfce348f90 pmksa:
 Add skeleton
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, daniel antoine
 <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzAu1YwZV7e96cjP+xtn6A24ZCN1AiGW9-k35BWi=6wU_w@mail.gmail.com>
 <6d5103a7-5bec-4526-9ba6-b7ca398c5d4a@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6d5103a7-5bec-4526-9ba6-b7ca398c5d4a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,Daniel,

On 11/7/23 11:53, James Prestwood wrote:
> On 11/7/23 9:46 AM, daniel antoine wrote:
>>
>>
>> Hi
>>
>> I try to compile with the last commits and the compilation failed on error
> 
> TLDR;
> 
> Denis, looks like minheap.c/h wasn't added to ELL when you added the pmksa 
> skeleton.
> 

Whoops, that shouldn't have gone in yet :)

I fixed this now via a force-push.

Regards,
-Denis
