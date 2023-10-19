Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDE335DB
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz+oQOyB"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-581fb6f53fcso108053eaf.2
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697754143; x=1698358943; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgJcCa6XspRZUV5ykNFpCiSGGDnDVsK8LJzFxTZsIWA=;
        b=Tz+oQOyBEfJ3b6dAIgvw5dgqj4xqAZkyV+saSrIGy8y7wd/T3TuC5AQmKqsTQlGmXc
         16cVjnBjZG42BVCNZ3UwlB4F7EMOlh7XzFQdsQX3shRpWcVhZXDz9jqhjOULtXqeoL4d
         m08YrZvp7+ayChFI2YI2dFEMZnZHwMnE9xCXYEu1YgwsZM9U6NF50+SOSWdySLErg2mv
         7xWAf7q8KbojQOigquE9P99bqJlVCsU51z42Boi9QQdmCQXob/Hud9oOOveP6dxHk6Yf
         qBHBkzSe2RhPQz9f/wB+4DokBwI2yb+VlcVdZDSvkvYpU/gZAQrcwDA7NsArCHuJufqL
         tLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697754143; x=1698358943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgJcCa6XspRZUV5ykNFpCiSGGDnDVsK8LJzFxTZsIWA=;
        b=VJJKl5xaSBN+xjbASY1h82/8epNdEQCeVyX2MVl4n7WoYCdB+ubZUBC+gBc1ddxyHr
         ENTpiOWL1iXgwuE49UM9k/FnyJDkWLUS1f0tS90j/vfcvtU4XxymdH95Ou2L6OGAZXI+
         V71fyBpI8lnBoC17Jo8SYMyw1lQQlllhdfqdfV/ZhkpvjXmnep5Okrhefd1GvJ4cR7I4
         CHDjHw6BAcZUm94gyP3DEyv4d1CRssfHsQ2zH3/UNM3yt5Xc7S6X8cLUtKNl/qiDH1TE
         pUswTmLDwuGBPkEX/QNcyu8vZ8/u7TaDHl498VetoAUOknL69baqaq2Jj8cJybtzf1Gl
         IvtA==
X-Gm-Message-State: AOJu0Yzq2LpiNuyJl2O/Z15EQAvzuJsPWLT8tEVgDJFcDibiBvFoH5Tb
	qzNmwKj/Ti0TWy7uzJqZzW6yNI8BIWs=
X-Google-Smtp-Source: AGHT+IEJllpf5jaZGR7e9M8if9dEF97OTg0GQwHbtP8wRMlqQCdyRTEqrj2k5roO/tJl9M9UOLqcDA==
X-Received: by 2002:a05:6358:999d:b0:130:e0a9:a7b4 with SMTP id j29-20020a056358999d00b00130e0a9a7b4mr29283rwb.13.1697754142685;
        Thu, 19 Oct 2023 15:22:22 -0700 (PDT)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79f82000000b00692cac7a065sm264418pfr.151.2023.10.19.15.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 15:22:22 -0700 (PDT)
Message-ID: <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
Date: Thu, 19 Oct 2023 15:22:21 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 2:47 PM, Denis Kenzior wrote:
> Hi James,
> 
>>>>
>>>> For a headless device auto-generation just won't work since the 
>>>> password is baked into the image. I considered generating a single 
>>>> bootstrapping key and 
>>>
>>> Doesn't this run counter to what PKEX is about?
>>
>> I don't think it runs counter, it just may not be _exactly_ what the 
>> spec intended it to be used for. Using the same code isn't any 
>> different than using the same PSK.
> 
> I don't know if I'd agree...
> 
> https://datatracker.ietf.org/doc/html/draft-harkins-pkex-05:
> "The only information exposed by an active attack is whether a
>        single guess of the password is correct or not."

My comparison to the PSK is that there is no difference in guessing the 
PSK vs PKEX key. Both equally compromise you.

I'm not sure that quote specifically is mandating the PKEX exchange use 
a different password every time, just that an exchange will tell you 
_if_ you guessed the password correctly. But you are right that the DPP 
spec wants a different PW to be used each time.

"shall use a fresh code each time and the same code shall not be used 
with different Peers"

So we don't have to put it in the config file if you don't want to. 
Auto-generation just won't work for my purposes since I have no way of 
sharing that on a headless device, so if that's a must I'd have to do 
some thinking...

> 
>>
>> No matter what if your PSK or PKEX code gets compromised your stuck 
>> re-configuring all your devices. I don't see an issue using a secure 
>> but static PKEX code. Either way, this isn't really IWD's problem :)
> 
> Well, we have to design the API with the 'right' way of using it in 
> mind.  I don't think what you propose fits that.

I'm fine with it as an argument to the StartConfigurator API. An agent 
could work but we've also got the optional identifier to think about. 
I'd prefer to use the existing agent API for getting a passphrase rather 
than a new method.

> 
> Regards,
> -Denis
