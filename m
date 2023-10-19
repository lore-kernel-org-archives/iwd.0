Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D519440
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcu+iVg9"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce31c4a653so152606a34.3
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697757132; x=1698361932; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugIDM/pawBEvSJnf2qEJJftCkAoJCYGn8h4JgpjQZfs=;
        b=Tcu+iVg9+ogLyDqgMdAqkrkPuypGvShIq2esdaZhbh7VZd81THfpLukQq2Y8ENRfx3
         /AqoySi+x4fUJ8rw4wce9KZ7Tr4mOpDV1+kVMFBoDBXidCAJx37qg+NSWopWE6FPBLfo
         JjQmmYrMSCDVOVUuMEnCstQX3TmfNRxdsk0ZqyKJlyS17CIHFKLLIuzLaFdBKK8GMK7d
         Xl0T5BBTK5niy6ADqoxlh1ou97gS338UCEULy8obf+rLr2s2NpzEz+xwtanuddq4VL6G
         9rZes3rKVmSfoKkZCiAiTHsDZRRXawDXm+MamGUVhOstbPc7coXP0fuCaBwX1W6EDC1S
         E1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697757132; x=1698361932;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugIDM/pawBEvSJnf2qEJJftCkAoJCYGn8h4JgpjQZfs=;
        b=HBgTnfmTJ+pBWG4axrOAamUN/cT3+oVHSUwEml3PLBl3pMB7oVaELKS9g77QN4EoUL
         2wBwEedmCMB9Z86BVbvQI7zM4F3121ci6L5ypR75aWXJL0nXKU/pyoO2tCufBKyLCDU9
         L8XRHDM4FGc9gZP4TGJdDcDt6Dfa8BSZjt/ik+UqZSezGtlbGdXqYg3pFm/lqaigjfU0
         94ooOLfbxyy981JUftqKdc9fXVO8MiojlNtDMDFf/JztWE1rqaWU/zn+QxflKD08d6Zp
         Pm4vMstSyGER16jy1sG5ULxNgdSDbYc5MJr9loZUNgmU5tFQv/n8d3NNoYLcl29lCTBH
         2PhQ==
X-Gm-Message-State: AOJu0YxZSwW5129SLkqPFysj/E44hRjqXQbiULoc+X0mcnuvB8tyaCCK
	RybWcIfe/f/9jleBN6HLcGgv2ZikxAI=
X-Google-Smtp-Source: AGHT+IEDpwi72o5z+bYVd5xgAskq8S983X6qDzLpuSsZJSgojCns91JYCkbbD3e2z0DK3rbJjF+rnQ==
X-Received: by 2002:a05:6830:4ba:b0:6cd:9b6:5954 with SMTP id l26-20020a05683004ba00b006cd09b65954mr183396otd.38.1697757131940;
        Thu, 19 Oct 2023 16:12:11 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d8-20020a056830004800b006cd09ba046fsm104563otp.61.2023.10.19.16.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 16:12:11 -0700 (PDT)
Message-ID: <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
Date: Thu, 19 Oct 2023 18:12:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
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
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> My comparison to the PSK is that there is no difference in guessing the PSK vs 
> PKEX key. Both equally compromise you.
> 

I'm with you :)

> I'm not sure that quote specifically is mandating the PKEX exchange use a 
> different password every time, just that an exchange will tell you _if_ you 
> guessed the password correctly. But you are right that the DPP spec wants a 
> different PW to be used each time.

I'll need to do a bit more spelunking in the relevant specifications to see if 
we have a bit more leeway, but ...

The draft RFC is pretty explicit, it does not mandate 'every time', but close 
enough:

"Implementations SHALL maintain a counter of unsuccessful exchanges
    for each password in order to defend against repeated active attacks
    to determine the password.  This counter SHALL be set to zero when a
    password is provisioned and incremented each time PKEX finishes
    unsuccessfully for that password.  When the counter reaches a value
    of five (5) the password SHALL be irretrievably removed from the
    implementation."

The DPP spec is a bit more permissive in that it says 'If both sides have a user 
interface'.  But I think the intent is for the shared code to be regenerated on 
each attempt.

> 
> "shall use a fresh code each time and the same code shall not be used with 
> different Peers"
> 
> So we don't have to put it in the config file if you don't want to. 
> Auto-generation just won't work for my purposes since I have no way of sharing 
> that on a headless device, so if that's a must I'd have to do some thinking...

Fair enough, lets explore whether we can provide this via some agent API.

> 
> I'm fine with it as an argument to the StartConfigurator API. An agent could 
> work but we've also got the optional identifier to think about. I'd prefer to 
> use the existing agent API for getting a passphrase rather than a new method.
> 

But the identifier is not supposed to be secret?

Regards,
-Denis
