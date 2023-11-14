Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE635EF8
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc3nlXO7"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77896da2118so384820985a.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992666; x=1700597466; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJNAd2xjWiHMB1DKuaU41oVGjG+6nCQx5IjLJprlIUA=;
        b=nc3nlXO7vDWFTL1xWUrKRajUTw+d+/+517/vCVRDG7k+KS+zjKjEhC0csqo1E57LvC
         MBTorhD/3Rxvp0m4oFcjcebP+81fLXp25miUD8vBiHo03fomT3JlroFEsAve6UEYXmf2
         lDOlwuj40ONVtbOFmGlDrO/RZM4xyqp0CDvstZhS38zf+R6PH40WKxy3lZENuEmIrW0C
         jOQ3+ns2xUtbZsabDmj+KBggQiaZILSG6CGhPNE7hxLEKRCK1WPXabB6G1LVX7secQGk
         hGxbNAAFLFs+U0Ac3tZ9WX5uJ6AJ3spLWcp7OguOxOTKkoerdilgdOZSOZrxXJL4ktdE
         wLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992666; x=1700597466;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJNAd2xjWiHMB1DKuaU41oVGjG+6nCQx5IjLJprlIUA=;
        b=cKpKkBMM3Y2PAI5ku7ek+gDsh+ODyyjCT7W/52v0raPJ437JBpptttYG/IFFTbWV3n
         U8rLQ6tAH/xI06ObhL3hl+eX/AY+qjzCNvEGyJGx0oWV5AG/OZ3ZjHAHvUZvJmKt+Uba
         c1VC1x8GzmXO72njFU8sNXLu3WJH5oWtMQhK4GXHUgQFaMFi3uk7xFEFiGoAGue78Ply
         seCOczw6QtOTy5yd+b20oRQYQXdVv1lJLNO/xs+8JKdplCMabagL93Y1wW1LSsk+cicU
         qCycX82anIwqpP9oiKgPqSgRk7TOPY/uLxBkMaQWkIWadK0VbWy79Tu4iC9ok5pJxb8w
         qVCA==
X-Gm-Message-State: AOJu0YyX6qEwvEtw4A/7Giju/ynSnFOjx1kutE4Q2PuODuqkgeNS/Rkh
	eMVVo1VPwYuqqtdVYuRKDwo=
X-Google-Smtp-Source: AGHT+IFQR021hVYV+qlSeev7KfxbuqeQ2FCBn9iIVG5aYIi+bqycb1fak/VybVbW5gd5ed2h/BP8sg==
X-Received: by 2002:a05:620a:8c82:b0:76f:1268:9e26 with SMTP id ra2-20020a05620a8c8200b0076f12689e26mr2686550qkn.24.1699992666328;
        Tue, 14 Nov 2023 12:11:06 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id q26-20020ae9e41a000000b0076f12fcb0easm2893634qkc.2.2023.11.14.12.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 12:11:06 -0800 (PST)
Message-ID: <0df08e70-12e7-45ed-a4db-132b4d5237d1@gmail.com>
Date: Tue, 14 Nov 2023 12:11:03 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] netdev: disambiguate between disconnection types
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231114171455.1108856-1-denkenz@gmail.com>
 <20231114171455.1108856-11-denkenz@gmail.com>
 <a9b81f8e-a0d4-4b1d-9afb-a33cf9d27767@gmail.com>
 <890f50a6-ab69-4081-973b-17559ac23c1a@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <890f50a6-ab69-4081-973b-17559ac23c1a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/23 12:09 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 11/14/23 11:39, James Prestwood wrote:
>> Hi Denis,
>>
>> On 11/14/23 9:14 AM, Denis Kenzior wrote:
>>> There are generally three scenarios where iwd generates a disconnection
>>> command to the kernel:
>>>    1. Error conditions stemming from a connection related event.  For
>>>       example if SAE/FT/FILS authentication fails during Authenticate or
>>>       Associate steps and the kernel doesn't disconnect properly.
>>>    2. Deauthentication after the connection has been established and not
>>>       related to a connection attempt in progress.  For example, SA 
>>> Query
>>>       processing that triggers an disconnect.
>>>    3. Disconnects that are triggered due to a handshake failure or if
>>>       setting keys resulting from the handshake fails.  These 
>>> disconnects
>>>       can be triggered as a result of a pending connection or when a
>>>       connection has been established (e.g. due to rekeying).
>>>
>>> Distinguish between 1 and 2/3 by having the disconnect procedure take
>>> different paths.  For now there are no functional changes since all
>>> paths end up in netdev_connect_failed(), but this will change in the
>>> future.
>>
>> I'm guessing the future changes would be to handle a CMD_DISCONNECT 
>> event via the connect callback?
> 
> Possibly.  Have not made up my mind completely yet, but we do it both 
> ways right now and we need to stick to one.  Wanted to get the easy 
> stuff out of the way first.  Any comments or should I push this out?

Nope, it looks good to me.

> 
> Regards,
> -Denis
> 
