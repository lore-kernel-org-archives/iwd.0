Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B26FCC6
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B08RfE0R"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b843b61d8aso3334337b6e.0
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 13:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813198; x=1702417998; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68MMp77X86aZselVJa6cWzy3qgsOCYBnrB7fTy/+DrE=;
        b=B08RfE0RxSr90bNuvxSP62nycej7M8NSU/zP6mDRwavNAXfAu8+hRZff2YteT0GLsh
         DL35WLxy42+SwryBf19h/3lRerGdjPgc9UmKAMO69ydmeq6J9KeBk9iWBiBTVYMyfyyd
         NiR0QAe2iz+pQS1Oh1C3QFqkH7qb8iv6ZuN2CFya5oWofEEGCsS4iVsSl3VQsTvIeXDA
         gjcqyMDJLvtvSLpnNqxLL8WsW0IQltxNH0tKX8xIe1XcUDlPvPp0zEKpqWc/gSG6jYeh
         9uncJGbJjAraWtO47+/9wbX5A1kXbilKmm9h0jyzKHdS3APBfjig3d4Ps77EX40OW8sa
         9lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813198; x=1702417998;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68MMp77X86aZselVJa6cWzy3qgsOCYBnrB7fTy/+DrE=;
        b=XYGnrkr50FhdjWY2ECLCR59e7wo1ky7lkUQQaFx29FmPyrZaWR2zIgSOhw56bNGyLy
         SsL82eyNDyB/udvdA2etHbIkw2xK47IpSPaeZUr4jAO97zFInfoV7iJGCE9tHJ9xeX8Z
         KL8ewKzKeIac3JYMfMGMhVGprqLiyNveH7FSa3kwKtIb90T/QOFWs9X0eOvCo6JikYO2
         PwOUMB+zC9uL1iErRgKVp5P/xnsm9lzWXDWo2f6Cxs2t2kzRGmeCw9Ws8JL+KveORaST
         +T6cwAwz3l6p8BG7T5UMAConDPZWZvikd9j1Ryp8ZIVS4derfhmlea4CWZ3ul5Pk5GeC
         /Z4g==
X-Gm-Message-State: AOJu0Yx0WUF+0LpUznjD4s17751gS0o76iC6vsKvk3gNDjzTHBQbRV8T
	M3gcZxyJxiil34AfmHfTElQWaLeCngg=
X-Google-Smtp-Source: AGHT+IG4ivwbKIcKpPT0+GBH1pajaAbaK6qdVdpj+BWmdRE/vLAbAMQ61Y6f0lKVwBW3M7yRz4qe6A==
X-Received: by 2002:a05:6808:148d:b0:3b2:eab1:918 with SMTP id e13-20020a056808148d00b003b2eab10918mr7391985oiw.29.1701813198183;
        Tue, 05 Dec 2023 13:53:18 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o16-20020a544790000000b003ae51628725sm2307760oic.13.2023.12.05.13.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:53:17 -0800 (PST)
Message-ID: <556a0e66-675c-486f-b02b-4b75e5294187@gmail.com>
Date: Tue, 5 Dec 2023 15:53:16 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] netdev: hack back in disconnect event
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231205175203.1935692-1-prestwoj@gmail.com>
 <20231205175203.1935692-3-prestwoj@gmail.com>
 <9b1a1ce7-16eb-4e37-8b7b-2750d0ed66fd@gmail.com>
 <2f2871a4-faed-477a-b327-33d4355ec55f@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2f2871a4-faed-477a-b327-33d4355ec55f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> They don't (only auth timeouts), but patches 1/2 add an associate timeout test.

Ah, I guess I should have looked at those too, whoops :)

>>
>> I wonder if we should make ft_associate use netdev_reassociate?
> 
> So pass station_connect_cb into ft_associate, then to netdev? That seems 
> reasonable.
> 

Yep.  Probably need a few additional checks to make sure we don't trigger any 
offloading behavior.

Regards,
-Denis
