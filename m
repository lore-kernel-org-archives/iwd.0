Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BB2108
	for <iwd@lists.linux.dev>; Mon, 24 Apr 2023 13:24:19 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-63b7588005fso3790856b3a.0
        for <iwd@lists.linux.dev>; Mon, 24 Apr 2023 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682342659; x=1684934659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnkPyaZ9HgbqefdfgIBMtHBnpG2FWvHabhUNQQddqmo=;
        b=Qc+N2VvGxFscvw2VowngX6Dx9Y5HsGkDStEC3qq/1e6f246yoXfQENysuuOS3lbLMX
         HJ74ITIGkJnwa1Gb1GLkQ5fFH36GYChLNTSn3vQDdGOXEQBLXWVSExruxKNaHZ7H/MAH
         1rlPMpmHMp/Aa1CsrqdersPstaOoiXfPGGCXesOID683xVC6+l7+ONShPHMQy4JtkWBW
         qZnWCkDYLaRxUMkpu+0gslTARTsclnbcQTBPDDLzRTo+N8Tr5zFQ2dTmlDOc6A/UbVwX
         1jKfhg3qVATi+uCYQ8GqIBDfvMNuERn1Yj+qDDJvDLaapgm17kbtQaZ5yrKvu+JhV1Wn
         8yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682342659; x=1684934659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnkPyaZ9HgbqefdfgIBMtHBnpG2FWvHabhUNQQddqmo=;
        b=C7dtvn80GAIapPWjKoO3vtfN0W+rAdtYAQJZCB4iSgCnTQidZ1XaUy9OtmWAsR9gEL
         0/5kmFAvKxQbnIrPEBP78Bqb5cSypEoiiasIq3OQfAla+dNqtFU+J/Y4NweTMGIvWSHt
         Td9b6y3AtfM3BkBKqzLlfMQsSZ1Q3hmzJi5e5mu+RuShlHjqP7/ThW5YTDWlU1HIUmvT
         fGxCNyqRYFAvBjpAtXBNSmRVfwQdcHKd0ojaScCPihh0JhJHJFUC3pPET1y7QDa2ZFrR
         4wsnCOS9dcDaNXC8WcXjvbHkzXe0Npow5WyR8Ox5Yzfw/7VvSmEanS3l8QgzI78dvE8F
         fJCA==
X-Gm-Message-State: AAQBX9ciNMWcgHzZF4PqDKXRH+rgajbaeuychR3wqFuO2wFxPG6fBCxK
	mWTC0h7MKZe5PXHUNu59uRj6OgtoH1+g4Q==
X-Google-Smtp-Source: AKy350Z0plylkIKJF0A61hZ2kAKeNPfm2QSji4A4NYMx4bnU+uV10yVZ3w88yzjMidw6C2O/Gep4oQ==
X-Received: by 2002:a05:6a00:21d4:b0:63b:5609:3bb5 with SMTP id t20-20020a056a0021d400b0063b56093bb5mr18196468pfj.18.1682342659342;
        Mon, 24 Apr 2023 06:24:19 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b005aa60d8545esm7473684pfh.61.2023.04.24.06.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 06:24:19 -0700 (PDT)
Message-ID: <03f26ded-afd0-9e01-739f-5798ebcd90dc@gmail.com>
Date: Mon, 24 Apr 2023 06:24:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] station: delay roam until fully connected
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230417185457.1000642-1-prestwoj@gmail.com>
 <a87b28e8-b4c3-a7ae-e01f-9e48731f7d78@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a87b28e8-b4c3-a7ae-e01f-9e48731f7d78@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 4/23/23 4:39 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 4/17/23 13:54, James Prestwood wrote:
>> If DHCP/netconfig takes a long time to finish IWD could end up trying
>> to roam to another BSS. This could happen if the signal strength is
>> below the set threshold while connecting. Once authenticated to the
>> AP IWD would get a CQM event and start a roam timer. If DHCP did not
>> finish before that timer IWD would start a roam. IWD would not handle
>> this well since a roam doesn't trigger DHCP to start and likely the
>> network infrustructure would be very confused.
> 
> Typo here, 'infrustructure'.
> 
>>
>> To fix this continue to delay the roam attempt until IWD reaches the
>> connected state.
> 
> I'm not convinced this is the right approach.  If the signal is bad 
> enough that DHCP is failing, then delaying the roam is probably the 
> worst choice we can make, no?

It may not be that the connection quality caused DHCP to take a while, 
could be the backend just was slow and not responding quickly.

> 
> I would think the better way to fix this would be to track netconfig 
> state, and if it never reached a fully configured state prior to 
> roaming, reset & reconfigure upon a successful "roam".  Note that since 
> we haven't signaled "connected" just yet, we're really still just in the 
> "connecting" phase.

The question is if the AP infrastructure could handle this. For example 
the worst case being if DHCP started and we roamed right in the 
middle... That's why I thinking the safest option was to complete DHCP, 
then roam. I never actually saw this behavior happening, just noticed 
that IWD would get very confused if it did happen.

Thanks,
James

> 
>> ---
>>   src/station.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
> 
> Regards,
> -Denis
