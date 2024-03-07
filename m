Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F3EAD4
	for <iwd@lists.linux.dev>; Thu,  7 Mar 2024 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784653; cv=none; b=r/vN3HALAqnG8U6K5ioudQ8eWWmlh66/MJ5P/R7bma0PPfTa5dq7Km8ryutHp7mh/+DlkJdXRI9J2tqPm9tykHpbtwjCYrzCFIPg8yYbAiFIEYyUo91LIne/Q7STfdEerGucapFLUbYHM4dicOV07vXwEDKtigN1/Z8hiZ5Q9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784653; c=relaxed/simple;
	bh=WsLryTbfZ4TmjUm30ga1WTUjrY/lMN3Z60WhmjvjLUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcr9Rdl0xrySDwwxrNZLpyYDidCGEmcn6FA1LOupd0PTFOGRiJDCy0fKT3lxsScm7Ia1ISqI03rzAum1A7R3/BLA7oHHT7TXFuLMMw1Eh5EZe8gpHs5UNJlES73FnceIH1aFFb88I+lpmBte82k6EpkW7ouFZRIRANrBIdgmj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpEf+llJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpEf+llJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dca160163dso3968255ad.3
        for <iwd@lists.linux.dev>; Wed, 06 Mar 2024 20:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709784652; x=1710389452; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/DUnVWETDtzXGNsdW2+Hh6Xh0WjRBPPe7PWw00hVWE=;
        b=kpEf+llJlOWmklSRJlbyeXoi7R4lOWw3Lk1d63U+oqFbp8UXfI9LEcGxzbGvwcXuTu
         K3FWix6+1EHBGK6d1hu0ry2LWohriSuyhamtMSg/nkuHA5prfeF8xeB+buw/mUBwsLnU
         uHKQNnA7P3c6nHQmVaOG0f/LjH/ak6l5s5YcX/1qbFz6KWfthZqC+mq8cZ8M0c00uXmn
         grOFZbZ94UzCZ4U0oQu7HRfR0ebYZittYkWst6f+IjMizIs4qhrRG+OyO0MeX+aQ6Mwh
         /lGKUWVReQyupKx8pgtjq9IXWX/VPFdj/kxLzYxIoAXLaJmshgZsWRcCuQI8G1lsxQdT
         XM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709784652; x=1710389452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/DUnVWETDtzXGNsdW2+Hh6Xh0WjRBPPe7PWw00hVWE=;
        b=WaBPL5oF8u/6QXwGmlQAVeS8bC3DAghJgTS9TMMYV0Fxc/W5V/kxljfYA+SxWCAHDK
         8O48aHwZ4ZIyqI1AXOF8twuIkK0Jnye+wJrQANUgV9lc+An2/TuHceFzzzLYWdO1qYDy
         Pbsr4J/n8DcndUXuFauxvx860mCzyRTeAZZbAxFKJ3o+XImGw2caV/B+hpGyJ45a4gL2
         QDxgtXFOFNsbxXZftl2Olobxbae0pn9/3NLrpWOEkjoBteHZbZKs5mOP5D1M+9wyjdfr
         NAQRilDVzAaxBsHhPKLKVRPgviGC/uM4qdQ7rVdkPmigEN7fss9UAghEQOEPg7akET8b
         HPfw==
X-Gm-Message-State: AOJu0Yzbn68x5XBer2eMM7W7S889Jo06LY+C7L6kFMklxxG+UNfs/IPy
	NiJnTUo8lPIhkhPKRIxVFJVWnHYN7PwyTOcGZdNAppBeOHN+xQsl
X-Google-Smtp-Source: AGHT+IHfBXaHkFqvjnhaiDGb5pRTbbgTKBAaz3KUus59b76t31Sc2g+8AAbZg03/yn0BgIrxsfu6/Q==
X-Received: by 2002:a17:902:748c:b0:1dc:f913:797c with SMTP id h12-20020a170902748c00b001dcf913797cmr7629806pll.51.1709784651723;
        Wed, 06 Mar 2024 20:10:51 -0800 (PST)
Received: from [192.168.10.12] (M106072137096.v4.enabler.ne.jp. [106.72.137.96])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b001dc391cc28fsm13349666plh.121.2024.03.06.20.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 20:10:51 -0800 (PST)
Message-ID: <d458ae0e-7930-4192-a72b-9527eff2cc47@gmail.com>
Date: Thu, 7 Mar 2024 13:10:48 +0900
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to connect specifying the BSSID?
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
 <1aebf48a-0ed4-4605-a03b-5f6e0706ed71@gmail.com>
 <CAKbf6aw-So-y=NuHTo-GqTRmjPR7pN1j8UOmHOvvRETBM-3XoA@mail.gmail.com>
 <0f64f742-4fbc-4493-9fd8-bd0afdc9f4a7@gmail.com>
 <CAKbf6aw-YXxxtPFKrQW-42jrzUW5dBMdW-RjQqf4tAr-fkdaFA@mail.gmail.com>
 <435173fa-ab58-4216-a53f-8ce66ee5b561@gmail.com>
From: Kentaro Yamaguchi <kentaro.y@gmail.com>
In-Reply-To: <435173fa-ab58-4216-a53f-8ce66ee5b561@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

Thank you for looking at the log.

After creating the profile, I executed the command and was able to 
connect to the specified BSSID.

The cause was that the profile was being deleted when connecting to a 
different BSSID.

Thanks,

Kentaro Yamaguchi

On 2024/03/06 21:14, James Prestwood wrote:
> Hi Kentaro,
>
> On 3/5/24 8:17 PM, Kentaro Yamaguchi wrote:
>>  Hi James,
>>
>> The IWD log is as follows.
>> I have confirmed that it is possible to connect to the same BSSID 
>> using a combination of nmcli and wpa_suplicant.
>>
> Thanks I see whats going on. There is no network profile so iwctl is 
> using an agent to ask for the passphrase. Once the passphrase is 
> obtained IWD still chooses the "best" BSS to connect to. This is a 
> test API after all.
>
> You could drop a network profile into /var/lib/iwd/ then use the debug 
> API and it should work.
>
> Thanks,
>
> James
>
