Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633E30322
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxFi7/kZ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-66d76904928so42703216d6.2
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699456464; x=1700061264; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGMDocpJnwzjAhEI1Z41Tt6gypD5w8QLfaLKbnrCQyg=;
        b=ZxFi7/kZ377HkpNgDt0At9yeYWa1MhNi4oyARgV8vBbFilNYSqnZGeFZqyK9UHXraz
         Z9D3RGTGtTOJQH4tXTrmnKEyg7EizAggyDzlJJJEqYlXwTPLBFfuvgro/xZpXmv7a2lb
         5I2WRSUc72g0I0ddM+resR7mOKOKj5aUberZSG4NimibFjM7NX2890XELX0PTpMfJ2bA
         rpvC7FJB9TU1uEpDqd0jKV68q0DLhihrq/glSWnrezSWCHKaWQmxNWa5eDyY6tyskMMJ
         kktLRTxmyn/fSy1FW8MkWrR3+tOUcClS9rs7VxeZutRz9hDo91NILyt4rLOg6mmBfirJ
         FTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456464; x=1700061264;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGMDocpJnwzjAhEI1Z41Tt6gypD5w8QLfaLKbnrCQyg=;
        b=E4FnF73sMhLEo95KxGAzNudeS1SJ0exCLkWPx7//War8flJQsZyCklA+n9sqa1bRRS
         ZsaicBiHBfGxwuUEqdFoJ/BKZ2kVxu8E+sNmT7E2oJcsNvEnkCZPP6OvkLT2PutMpTKv
         Y1jCdX1+PVc0YVY9K3p2hrkCUvJ8x+VaQdfjMm49uqZcWTryA0BfipfNvTtHQC95Dy8e
         D20u7+yiYX4QuBof8HeMwJ7jG0Rqfc0mFYYYd+dwTrD7ghoQota5V5E6RbIf0H8u9607
         OnIOU/+UChpOb724tuqT2okx3OgBQXGpLf3UXWjLfeVBvvUHGMatyqRu9ZC9wMitZ6I7
         2rvA==
X-Gm-Message-State: AOJu0Yztri7E7ULQ+Tzq3l1f+qVuVBwz7xkN4j+q0OdSudiEbtYGHL6K
	n6+jtKd/bMdWY8rPkKrQz4kBWll2ESM=
X-Google-Smtp-Source: AGHT+IEC8dHLhNoQIc34Azm/98BQcyPu2rvkacRjOOZlJNKWfCRaUUHa8dceYYEg+mAyZ0nZRRVfdw==
X-Received: by 2002:a05:6214:1d2f:b0:66d:bc21:814c with SMTP id f15-20020a0562141d2f00b0066dbc21814cmr2400702qvd.65.1699456464282;
        Wed, 08 Nov 2023 07:14:24 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w12-20020a0cef8c000000b0065d0dcc28e3sm1155655qvr.73.2023.11.08.07.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:14:24 -0800 (PST)
Message-ID: <030ba167-35a5-4095-89fe-6be875c709d7@gmail.com>
Date: Wed, 8 Nov 2023 07:14:21 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dpp: initial version of PKEX enrollee support
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231107170629.1831655-1-prestwoj@gmail.com>
 <20231107170629.1831655-3-prestwoj@gmail.com>
 <a9c1e09e-97be-47cf-9ea5-b595ac979b2d@gmail.com>
 <c93871c0-f090-4e7c-9e59-6298113d77bb@gmail.com>
 <6e709910-ad9a-4681-83bd-759a4e26e53b@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <6e709910-ad9a-4681-83bd-759a4e26e53b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/8/23 7:07 AM, Denis Kenzior wrote:
> Hi James,
> 
>>> Since you're sharing the DPP state machine object between the two 
>>> interfaces, it seems like starting PKEX on the SharedCode interface 
>>> side-effects the state of the regular DeviceProvisioning interface?  
>>> I hope that's not intended?
>>
>> Your right, it does. Once PKEX finishes it starts DPP on the 
>> DeviceProvisioning interface. This was intended, but if we want to 
>> keep the two isolated I'll have to change gears and think about how we 
>> can do it.
> 
> Ugh :)  This is something no-one but the person who wrote the code would 
> expect to happen.  The interfaces should be kept separate.
> 
> Internal implementation wise, I think you probably can get away with a 
> shared dpp state machine object, but you do have to track which 
> 'interface' the state machine is actually bound to at the time.

Ok, if your fine with this its much easier to implement than separate 
objects per interface, i.e. store an enum that corresponds to the 
interface using the SM.

> 
>>
>> May have to create a dpp_sm for each DBus interface not 
>> per-wdev/netdev, and find some way of communicating which interface 
>> the property changed calls correspond to.
>>
> 
> Well, there's always dpp_find or dpp_pkex_find.
> 
>> Apart from the string/cast comments the rest seem to revolve around 
>> the shared state between PKEX/DPP. If separating them is the way we 
>> want to go I can do that.
>>
> 
> I didn't look super closely at the spec details, but what I saw seemed 
> reasonable.
> 
> Regards,
> -Denis
> 
