Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AB10964
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvTpXgVJ"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-586a5d76413so2595719eaf.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676804; x=1699281604; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21Ut4qvlRuTx6c/r6Colas55FA8bNjydcTxrbVyMZwo=;
        b=IvTpXgVJyKAnYpAp3YdYueFf6GdGR7MxQDiqXnnWUbj6U9sL6GRwYPJMNcc1NygWs1
         PUS5uzFPDoqyZaTpgvWtW+DXWDAXMQI6Vzrk4v5jOJvmI3VGk+kmalbRS4U7QKTP8rzK
         QK0uDhgfZZChsi2iMPc/ESQBqpsI7qWIYlagYwQTHS/3Z6BBDBI9dFctHhTTc3mua/1m
         w9JuKzAWcx4iuE4KsNCXUve74qpMOxSw5cfeNO1BEXOa4HiP2vxUWR8TQbeNdyQxudk0
         JOct9Pwdp8U0zlrR+Hr4Bskjxu6NLKYTCOL9LFa+3Tb18as0+SKNFxvEMQKrfKRrHDI9
         oBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676804; x=1699281604;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21Ut4qvlRuTx6c/r6Colas55FA8bNjydcTxrbVyMZwo=;
        b=hmpA4r9VkhkxAavDj38WPJ6Qyyz8RfPoE03XVqHpQqwYeAzbNa9Ic0IjT2SK3Xcwvv
         4CDiBi2ywMZ6q3K728SqF5FSYa/7/pCJiFMGaNjKxfbkdAir2N8eKwH7AbIdS0Mec3J6
         SVUvAuDIks0Z9u8OUNTUhT2u2zk9PXdk66C2F/AU7NMJxHv0aloYI34jNVvV+1I7nOs7
         PtxwspaBpuoJsOxafV/GOo1OOw3nTsRkBvVuQUGetuk7PmAFuQZK+13QzWrP2j0wQnH1
         cQA2dXunihrQ9ix6VhYyWyCx2il3wozqtAEmDvNcwRd/C1MQYjdvVPTo8ehJuXWcK/Oo
         gRCw==
X-Gm-Message-State: AOJu0Yyeoy+dC3HVTyQ8peHHCGw6UxUyE9iMuBA26mhNCJN+zRhKo295
	VrUDAPIyqJT2ucgJQJk2fiXI0c0Yz70=
X-Google-Smtp-Source: AGHT+IHa5J+0OYLIGmub2EvfMuPKa7KhQPBMtHUsOjqsUH5drWyuiaa2QpJmSyglGzhLr+MBmRtxuw==
X-Received: by 2002:a05:6871:5a87:b0:1e9:dd69:2fc1 with SMTP id oo7-20020a0568715a8700b001e9dd692fc1mr14622261oac.7.1698676804155;
        Mon, 30 Oct 2023 07:40:04 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id du19-20020a0568716e1300b001d4c5e4c2c5sm1614904oac.25.2023.10.30.07.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:40:03 -0700 (PDT)
Message-ID: <b2d50ec6-5cc6-406b-b52e-a3e94b64ae37@gmail.com>
Date: Mon, 30 Oct 2023 09:40:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-13-prestwoj@gmail.com>
 <35ca1bec-2ccb-4e23-8b98-f6dffa4675ac@gmail.com>
 <1a87a53c-e95a-40c4-a410-0929a29456cc@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1a87a53c-e95a-40c4-a410-0929a29456cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>>
>> Where is the agent documentation?
> 
> I wanted to get your preference, I can add a separate agent API specifically for 
> shared code (RequestSharedCode), or we can piggy back off (since its the same 
> signature):

My first reaction is to use a separate agent, similarly to how we handled 
SignalLevelAgent.

> 
> RequestUserPassword(object network, string user)

APIs should be self-documenting as much as possible, so I think re-using the 
method falls short of that goal in this case.

Regards,
-Denis
