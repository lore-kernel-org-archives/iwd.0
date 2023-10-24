Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39217266C9
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiZTdDtf"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7789a4c01ddso296539285a.1
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 05:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698149116; x=1698753916; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JM64tcyKSQMefiZLW0aCbYrPXVE1pU881GTkHlvmXbs=;
        b=LiZTdDtf2qcE2/JvpxwwnYwY040tip+Mvvc9D4y7/9Lo7hgKJiLzc09WWBv7S2rtkA
         h90M5U6cBpruYNnD/ibfG+MRYpY9RsPx2WkyZidyK8y8KpbxvRpwXb3gz+JHrCpBsEkt
         zUuA0r1mpApEYB+x1NjSoRVRj8kfOXqydBp4u012QSoyJId7ngpwipjiaM3InHgzcwfl
         bh+ghlp2oUyFnI/Bab0QHQSV1LecNymne7592KASOTkCW09j1Ia3XB5uYytpJ0hjuSQF
         Us4VfSQNuYMn5vxZGSjLyZ0x8wC4NosXLDf/nLd6t4xJKdVlc6q+r66LzU116DPTEKbb
         PpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149116; x=1698753916;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JM64tcyKSQMefiZLW0aCbYrPXVE1pU881GTkHlvmXbs=;
        b=k8eGVnxTHvNL18UJGZ014P443kiIFbpO95UIq8Ao3YUuSqIFIk0nIU4HqIVGnE6YZ0
         kVVlGPWLYL9bPn+Itg327DEgch78OApX0hG4d9AIUiC0aMh2cHDO6iCov4eo6FfV0Tri
         dzWDeOUvxPgZepGvQN2d1vQ5dBnPRxJPgCwCImnSvnozl7q6v8xzTckUz4r1uzEvIb0N
         NC+5tW2KrmIqkUh4FdPl3zjorSP/nXvvlc3Eceib4BLRZSfvu7xLzITcfByD9Y+P4Wri
         5nOCT71VcJcAWcxpi7Y/yWc1YlAIFMqCwZ4DCK7K4C8QJDAnY/wK+Un1UKJ1bahjDQOj
         7ZcQ==
X-Gm-Message-State: AOJu0YwF1hIaVSR17/WazEAz2a11Co/7uCzbD4AgmqT2R+EtTRGnlz4z
	PyDm4XgG5FRXL3FukD3fjWc=
X-Google-Smtp-Source: AGHT+IEIuVjE+PMA8ftfnexd0SpsKGgc+tiapsfPQNM+BiA/qlLyIsF+hLmxNqUPsOIRR8tVMw+gGQ==
X-Received: by 2002:a05:620a:2891:b0:778:a7a:bf03 with SMTP id j17-20020a05620a289100b007780a7abf03mr12756750qkp.42.1698149115918;
        Tue, 24 Oct 2023 05:05:15 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a074500b0077434d0f06esm1762938qki.52.2023.10.24.05.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 05:05:15 -0700 (PDT)
Message-ID: <f5d4ec5f-a7c2-4dc5-853d-d65ae1b72c93@gmail.com>
Date: Tue, 24 Oct 2023 05:05:13 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
 <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
 <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
 <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
 <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
 <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
 <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 4:12 PM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> My comparison to the PSK is that there is no difference in guessing 
>> the PSK vs PKEX key. Both equally compromise you.
>>
> 
> I'm with you :)
> 
>> I'm not sure that quote specifically is mandating the PKEX exchange 
>> use a different password every time, just that an exchange will tell 
>> you _if_ you guessed the password correctly. But you are right that 
>> the DPP spec wants a different PW to be used each time.
> 
> I'll need to do a bit more spelunking in the relevant specifications to 
> see if we have a bit more leeway, but ...
> 
> The draft RFC is pretty explicit, it does not mandate 'every time', but 
> close enough:
> 
> "Implementations SHALL maintain a counter of unsuccessful exchanges
>     for each password in order to defend against repeated active attacks
>     to determine the password.  This counter SHALL be set to zero when a
>     password is provisioned and incremented each time PKEX finishes
>     unsuccessfully for that password.  When the counter reaches a value
>     of five (5) the password SHALL be irretrievably removed from the
>     implementation."
> 
> The DPP spec is a bit more permissive in that it says 'If both sides 
> have a user interface'.  But I think the intent is for the shared code 
> to be regenerated on each attempt.
> 
>>
>> "shall use a fresh code each time and the same code shall not be used 
>> with different Peers"
>>
>> So we don't have to put it in the config file if you don't want to. 
>> Auto-generation just won't work for my purposes since I have no way of 
>> sharing that on a headless device, so if that's a must I'd have to do 
>> some thinking...
> 
> Fair enough, lets explore whether we can provide this via some agent API.

Reading more about the identifier being used to distinguish a "plurality 
of devices" this is what I'm thinking as far as the agent interaction:

It would make sense (on the configurator side) to query an agent _after_ 
the enrollee sends the PKEX exchange request. That way the configurator 
can look up the identifier/code, somewhat the same as RequestUserPassword.

I don't see much benefit of using an agent in StartEnrollee(), and would 
rather pass via the DBus arguments for simplicity. Adding an agent for 
this doesn't really gain us anything, it just adds complexity. The 
caller of the API can still change the code/id for each call it makes to 
StartEnrollee() as it sees fit.

So something like:

StartConfigurator()
     ... waits for PKEX exchange request ...
     -> RX PKEX exchange request
         if (id)
             Agent.RequestUserPassword(id)
         else
             Agent.RequestPassphrase()

(And if we want "SharedCode" Agent APIs, that's fine, these just fit the 
need)

The one caveat here is the timing since the PKEX exchange response must 
come within 200ms, which isn't possible for a human user. A human 
configurator would need to establish the code/id completely ahead of time.

We could either:
   - Handle this from within iwctl and expect other higher level 
consumers of the API to do the same (when interacting with a human). 
I.e. ask the user ahead of time, create an agent, the call 
StartConfigurator().
   - Allow an a{sv} argument to StartConfigurator() which can be used to 
pre-load the dpp_sm with the code/id, or if empty query the agent.
   - Or if we wanted to go off-spec and e.g. wait 30 seconds for a 
response. But I'd rather not.

Thanks,
James

> 
>>
>> I'm fine with it as an argument to the StartConfigurator API. An agent 
>> could work but we've also got the optional identifier to think about. 
>> I'd prefer to use the existing agent API for getting a passphrase 
>> rather than a new method.
>>
> 
> But the identifier is not supposed to be secret?
> 
> Regards,
> -Denis
