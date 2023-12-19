Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820537898
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnUrsq4C"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dba3438499so423395a34.3
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703008177; x=1703612977; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeAU4yxCKG3wOsi6aZvvpaZgOCQGt/3Oi3Ak27U4h+A=;
        b=QnUrsq4CfMme80gNm2C9IquIigTSlEz3uBFDKHNMtStozdP8P2Iy4/8KCSSM1hqUwp
         DHIXk9vGO8YrAmScuA2V0KbTFsdf+TP9QvycJsbB9Kv0OsttNN9B6BkeI7Qg9GJEEgz2
         bPemvjQNiLYdFYzLwOJGEyg2BNYw0QAdXfmd7+uuLte/dxskWWNhvZfdaJTXQziuhpTS
         uGTbsVqNMV3tiiq7gC0vfgSxycwFuo5rrHLmLOgSbZg9QpqLwQLyD8gI7nmEGjV8KK5I
         019Rgx54KEZWMOCTY9HvWhzBBGC0RiiyyKKEUB0MoP9QtVzQZ+fRK1zxzdgUrOB+lTRF
         iOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008177; x=1703612977;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeAU4yxCKG3wOsi6aZvvpaZgOCQGt/3Oi3Ak27U4h+A=;
        b=H1Aj+BiJAgiulIj9fRbTJpkGHX149/kQLDZAlRfkzSab5/I4lZZtkM6P8do686MPBG
         WAp8INWndOEVjw462FbtYNlFiq4vDLMpqRyU6Fat0DElHNrRfw0im3+IZQMsmXCz9CX6
         KMZ4MTisRQLrjqNQWVAVmiY7QAcNst1pZjKoupb+Q+qRK6vjIdvWuhC52savz1/JkcBM
         AGjPCq/NLt9OjUVbjIA3vr9F7I1Lu6Jq+ks13nV6SWJfX6Pr8XgkRoNdLLCzfGlheU3O
         vEjGssULGKBOkuT+Ge5kvMg48QcbxRq4sFk6ksu2oqD0LkoXi/Cj0LGv9bXN1aD9Ttmr
         rzEg==
X-Gm-Message-State: AOJu0Yxj0Vpd/qKGwdAySPKhOARK+c1WOirqCC9K4AI0jn/vG5841SNc
	oAr6Hs1FOr8dP2Ra0PNg/CQ=
X-Google-Smtp-Source: AGHT+IHCbs1dWN9q5eJ3f/qgHhlY6q6hseZRlb6S9xpmJej4aW5ahROUtSSMtDivV9YVAVaPbAKIcg==
X-Received: by 2002:a05:6830:1b73:b0:6db:a7a4:2524 with SMTP id d19-20020a0568301b7300b006dba7a42524mr417438ote.30.1703008177588;
        Tue, 19 Dec 2023 09:49:37 -0800 (PST)
Received: from [10.175.247.41] ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id l17-20020a0568301d7100b006d8786f3510sm5042963oti.57.2023.12.19.09.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:49:37 -0800 (PST)
Message-ID: <2b3f455d-b265-471d-85eb-65202dcaf84d@gmail.com>
Date: Tue, 19 Dec 2023 09:49:35 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] knownnetworks: network: support updating known
 network settings
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231218141250.202157-1-prestwoj@gmail.com>
 <6ac609fa-0540-479e-8ab3-387b0cab24cb@gmail.com>
 <ee339749-46cd-4927-a3fc-ff80924a5f70@gmail.com>
 <f2d94ed6-0902-4dcd-bc7a-b7c58e7e61e3@gmail.com>
 <4ab32218-16a7-4d15-a792-3aed887a91b5@gmail.com>
 <0072dc90-2e28-4f12-9980-b32a693ef8a3@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <0072dc90-2e28-4f12-9980-b32a693ef8a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/19/23 9:46 AM, Denis Kenzior wrote:
> Hi James,
>
>>>
>>> Okay, then this patch in particular is not needed?
>>
>> Its at least partially needed, if a known network already exists 
>> prior to DPP and its overwritten there is no callback. So we may not 
>> need to actually touch network->settings at all as I thought. Just 
>> emit an UPDATED event when the 
>
> Okay, then just do that.
>
>> profile changes. DPP can then call network_autoconnect and the 
>> settings _should_ be re-loaded unless I'm forgetting some instance 
>> where network->settings can persist, but I don't think it can.
>
> network->settings is only created/opened when a connection is attempted.
Yeah, I think what caused most of my confusion was because DPP was using 
network_set_passphrase/psk which will create an empty settings object if 
the load fails (i.e. no profile). This then prevented 
network_autoconnect() from opening the settings (since it thought they 
already existed). So now the DPP change just syncs the profile and 
doesn't touch the network object which lets network_autoconnect() deal 
with loading, as it should.
>
> Regards,
> -Denis
