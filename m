Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69D30FB0
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMTzreGE"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b2d9ac9926so1849440b6e.2
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697730356; x=1698335156; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBGsKG5pGismUnOm21Uw5lshR50A0Vsc3RSnCBFbqNo=;
        b=EMTzreGEcyCETF6AoDVocbWX9ttNVULCqt+RVwbBBGGrT0Cv8yMm9TIhAIkcaxpL9D
         QQlZh51wJaYP6GArNZ/w4oq4cQxfJh4y1sDCHbvgGh4WMHMB0iVNOyqTanQ+HBOPtG2Z
         AYsnm0aVP/q0D4BpKiGQHrtJYbfj7QQjDT21W1e0/uV5xN9MvKFpKUR4aBaEYoU+ztIF
         tvPV7ZuPdc7SW7ObNIcFiNCn5+tqm2Q3/5yppwCMIHShU3yy9c3YKfhurgGsGpq9+dxJ
         /E2d1MisNk2k4KFVy9jwj8n0YnUu+la5/vrI4ic0bTZo8JCYoE4hizJ0x89axsEklr91
         n5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730356; x=1698335156;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBGsKG5pGismUnOm21Uw5lshR50A0Vsc3RSnCBFbqNo=;
        b=G9SJdFpz770vzGih0IPrI9SYMY4Dvy+NIp8xknmWeELBvpkBeN8nIA2eosdYFFngmc
         lpUFyv/KoLTKugUIJ0t3H7v06W6nkOAIZWTjLItrTXBRNXlMOlHjkI+2iYTXPF2Y6kO1
         phA3pocLTAkYC5NVRPAFK+oAOe03QEkA5U9iPPNiu+tClXPTgKgSPXzs9CpqXKXzHE/f
         y/3CnsncTfHnd6jSyNS2X18siRv1zCGsccIMe2fxJLz7NoSPAbwTVV9ciVbZpdfXV302
         cvM8Fw7a4Opg7hlaNskjf5Ph/UkTaZS7E4zpHMcyAzkHg9vHO0YUHRFGbSskVseATJfn
         6arg==
X-Gm-Message-State: AOJu0YxziJcQI5DN8jOwpOTrWatQeqy34p7uTn1dSF/wjIr+Rk/rJ8EW
	BY5/JIdWuZ4HGeC5DVEO/TdwmUfcxF0=
X-Google-Smtp-Source: AGHT+IHqnSbvD+AGg8wZJFh5d18M3MfnNYuCJpdEcGbVHo00JTWU9h7lkv8qSo5SNVWwhqf/cZR28A==
X-Received: by 2002:a05:6808:1b14:b0:3ab:84f0:b491 with SMTP id bx20-20020a0568081b1400b003ab84f0b491mr2671673oib.19.1697730355855;
        Thu, 19 Oct 2023 08:45:55 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id q8-20020ac84508000000b0041cb8732d57sm816845qtn.38.2023.10.19.08.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:45:55 -0700 (PDT)
Message-ID: <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
Date: Thu, 19 Oct 2023 08:45:53 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 8:36 AM, Denis Kenzior wrote:
> Hi James,
> 
>>> I would think [DeviceProvisioning] SharedCode and Identifier?
>>>
>>> But I do have to ask, this is used for PSK networks where profiles 
>>> are rarely touched by the user.  Do you really expect someone to muck 
>>> around in them?  I wonder if autogenerating such codes / identifiers 
>>> or an Agent API is more appropriate?
>>
>> Autogeneration really won't work since both peers have to match.
>>
> 
> WPS auto-generates a PIN, can we do the same here?

You mean auto-generate then have the user (configurator) share that 
out-of-band? Sure, but its probably just as easy for the user to type in 
1234 or something as opposed to calling the API then reading back the 
generated code to their enrollee. Or maybe I'm not understanding what 
your talking about.

> 
>> For my needs the code/key is baked into the device image (i.e. a 
>> config file) so putting it into the .psk file would work great mainly 
>> because IWD could encrypt it (by adding "DeviceProvisioning" to the 
>> list of groups for profile encryption).
>>
> 
> Sure, and that's fine since we don't want to bug the user every time 
> this happens.  But we have to provide some way for this to be provided 
> outside of the user hacking the provisioning file.
> 
>> But for a human user the shared code does make sense to come from an 
>> agent, or the StartConfigurator() API itself. The use case here that 
>> comes to mind is sharing wifi credentials when your PSK is a very 
>> secure random string and you don't want to have someone type that in.
> 
> Exactly.
> 
>>
>> Could we support both like how we do with PSKs already? If not in the 
>> config file ask the agent?
> 
> Yes, that would be ideal.

Ok lets do it both ways.

> 
> Regards,
> -Denis
