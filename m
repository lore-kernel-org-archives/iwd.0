Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A285262
	for <iwd@lists.linux.dev>; Tue,  2 Apr 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071658; cv=none; b=Ib048YCxkk0D2364B4I1FkOXp/SzpKCQmiwjs7HjaknVnuBtqNWVbFEtTlNnm9Kpbotuy3i+oEh7EWmKsGzhV7OdVrag8JBt0lm4IOTg7gKUn+hK63TyzJ/8Mn3xVgAolN7WCTsWicsPHzoRLr7fqXMXwLSyzGL0IN2Ihd5zuB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071658; c=relaxed/simple;
	bh=v1JACeXODdz3BYiz3DOxwMNgzfuP9g+g1EV0WYLy12M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iYcaCS0/SzjkPQA5guLacOcf97N0jjID0og33Vuhwfdsl3q8fiD9fTQpF3ECLzfb9+GcYYdxXZ0kdsq485UmFOqWIDpKoepJ7xVLHRoediltDlX7YkcdlGMVauAXf2JFiHmyDQnbZjW31lG4u1LPzjruHzVSHx/A2/K66zPwPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pthcr1eE; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pthcr1eE"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e695b7391dso2663842a34.1
        for <iwd@lists.linux.dev>; Tue, 02 Apr 2024 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712071656; x=1712676456; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vayd4avTYFUKs5b508mG/WQSDXRLkORysOW4FNwUIVc=;
        b=Pthcr1eE6hbuHZ+HMnLJY0D+/jOeYm6EYYu1Bx9zH/WrqcwlekVFkvTUUGEHMlvpw3
         cxEfnjAdyWu5woApH9FMOYolBZAqjNPtiUHNPIIuixt0fO6YJUqpuQ7tgaAyDnwCO/Zt
         cc76awX5d5UvalfZZS0bp8uY/t1AsHdWXeoEfv1vRPCMNQHPZKflc6XvbR7/hmJtY1F5
         6M+YwRpMgX8cy+qgt3IclWepO1D5GLBslp+zLcCrueXMmyJ6EgsgzwyMqro43JdI2Z8x
         NVxXjrasDxS5UP49MR47j+WOJq9vjGrke6IMywBOjM3n1nSTfTZKdXtUd2DQyeY+3Jyz
         ATrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712071656; x=1712676456;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vayd4avTYFUKs5b508mG/WQSDXRLkORysOW4FNwUIVc=;
        b=P4BLCxRDjEY38/vKApjadNLQgPCF5n5PXXFgMMtaTeQlMQ422le5t2sQgN4RbVxOOo
         NB8Y4Kn7gmM2iNG/Oo2J+XiDxnxm0domZaffEF3Sd9LFxcL2eJl4YCCctNcLxWhJCh/A
         PF0bS1jEcaFfR6C+IkI71ABDqbisQSRtu5SyRCDIhllG25ATN3a79LJbVuGf59ZmzSyI
         9S73xu/05jiWIvr2qw7IzgxVMLUcRxV7X9f6sZALtyPJpp18B/px/yB+pQpTaLiKqdQg
         qUO2+yBG+j/qPhjSWqyOLCK67NRP6LcMNqLIKb4U1RIpSDjK00XKoMogVdaNQfR7p4sm
         Yplw==
X-Forwarded-Encrypted: i=1; AJvYcCX8tImBJr9NzKMpolCIEI59nKqIms/de6m92bWk7AhO1EyeyTzFxRoM2kLAOL9ggp1+2/9oHJN4IoxCWAXDH2Ls154S
X-Gm-Message-State: AOJu0YyzTBW/6MrTo0kczXsWREw3uylod17mUFtN9tAvytmMKm3hZvqW
	6fbKEZY0LNAU6d5/OuL6hrr1kLSbkqgAEjDsSsk/NJtUwRW5au7B
X-Google-Smtp-Source: AGHT+IFO0C9RvD4FNCESeSiQrRc2yMaOpuCC1qnW28P3N5vV+gvXDcCnROhk7ediZbqVdm7yfpIkCA==
X-Received: by 2002:a9d:6c8e:0:b0:6e6:8355:5904 with SMTP id c14-20020a9d6c8e000000b006e683555904mr13085641otr.9.1712071656033;
        Tue, 02 Apr 2024 08:27:36 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dx22-20020a056830487600b006e6fe84cca7sm2334334otb.81.2024.04.02.08.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:27:35 -0700 (PDT)
Message-ID: <ae336a48-1606-47c4-a83e-59dc2560c1e6@gmail.com>
Date: Tue, 2 Apr 2024 10:27:35 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] dpp-common: add TX/RX handlers to dpp_sm
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240327151957.1446149-1-prestwoj@gmail.com>
 <20240327151957.1446149-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240327151957.1446149-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/27/24 10:19, James Prestwood wrote:
> This copies the bulk of the protocol handling from dpp.c into
> dpp-common.c. There are no logical changes but some adaptations
> needed to be made in order to isolate the encapsulating protocol
> from the common protocol.
> 
>   - The DPP header is now reduced to not include the mmpdu header
>     or catagory byte.
>   - A channel switch must now notify the encapsulating protocol
>     since DPP common has no concept of frequency/channels
>   - When a peer is accepted its up to the encapsulating protocol
>     to filter frames only from this peer for the remainder of the
>     protocol. With PKEX the peer/own MACs actually do need to be
>     communicated to dpp-common due to some of the key generation.
>   - When a PKEX key is not set into the SM its up to the
>     encapsulating protocol to provide the key after a
>     PKEX_KEY_REQUESTED event. Once the key is obtained the SM
>     can resume the PKEX protocol.
>

There's a lot going on here, I think you're going to need to come up with a 
different strategy and break this patch up into digestible chunks.

> Other changes were made for readability. Sending/handler function
> names were made consistent. The DPP config header is now built
> and parsed with common functions (as opposed to manually). Extra
> validation here and there was added as it was noticed (checks for
> required attributes, return value checks, etc).

Much of this can likely be done in separate steps.

> ---
>   src/dpp-common.c | 2246 +++++++++++++++++++++++++++++++++++++++++++++-

I'm not taking or reviewing a 2kloc patch :)

>   1 file changed, 2242 insertions(+), 4 deletions(-)
> 

Regards,
-Denis
