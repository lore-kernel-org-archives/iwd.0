Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536C20308
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO15S01R"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb69f38855so152664b6e.1
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004830; x=1703609630; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIWJ6viMvVLHLi1wqnb2dhKMGSe67LqqpwYs/dLX3C0=;
        b=nO15S01Rpeq6V7QOYnfPiuGkRE8OMiuCcoOqfFkVI/bUL4+JyodzrT8rRFOqMPh9MN
         jooVAiRIYJ+TZFrK+rw3KowESCQ/PK05qRjXG2QClgC3liad5jiE44MV5jKvGmDrp2mj
         3oh9UAx2mc3+FzPn9cF9l3mxonrsx7Iv3tWX2wnwsW+NmgOuAMGIaQxDplaF2CSMXGdw
         JsCb+OFZlUzelmh7Of9X9ufyVkL40uEqFGxcyGDzszYucarKAsa/fzLlxxaLPtdDF7Zi
         b0zs8SVaC3ZxrXF7hFaMKEr5C9elT6mGwgXkEieD1VBgioS075uxGIzQLwZH+BJmRUzC
         iJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004830; x=1703609630;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIWJ6viMvVLHLi1wqnb2dhKMGSe67LqqpwYs/dLX3C0=;
        b=cFBtqxcEg2cglDq1VsbVbnv+jOIYq2oArIm9Gq+S9JQat1Nduf0sM2/KDi5yRschoT
         Az8iia2NeV5ppHsrO2kfQogEgo6/675K5CTESBhLh+dcZsurjJMsQmwnZYS4jMMKyNEI
         SFBVyChsd599Xd5tUsy5l/MJyr7/+qN54OME2FtYb1ZxKzz+PLGB7LiXWEFQAPLQgOVb
         M9rk08WB4rCyEhi5v8dRVDYGTpZXKDJVK9QE9ohKtq5Gno9Fb+Q8OR/MzXLj7oCtkpwL
         IvFuN5xWENn5QrOhDKQgbPke+R6hJ8239ZX8H7qWqVGFxfi5w1KW1Q4TAfQY3xx2Mzaz
         cdyg==
X-Gm-Message-State: AOJu0YxRA6U95LIS8DQZCATc9/tM8SzvEqV5oKWk56WE7uHJ3uCW/DUH
	u2zSS+P5BtUF/IZuppq1qYo=
X-Google-Smtp-Source: AGHT+IGWu4bNwKjq4iPwm9UK2GfnhOCkT0BMGUqxNAChsyjWn23gGoSwiLVqL3sSF+DtqhYBC+scbA==
X-Received: by 2002:a05:6808:22a4:b0:3b9:ee89:5418 with SMTP id bo36-20020a05680822a400b003b9ee895418mr15779477oib.29.1703004829708;
        Tue, 19 Dec 2023 08:53:49 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id m15-20020ad44b6f000000b0067f5c779bddsm743709qvx.35.2023.12.19.08.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 08:53:49 -0800 (PST)
Message-ID: <4ab32218-16a7-4d15-a792-3aed887a91b5@gmail.com>
Date: Tue, 19 Dec 2023 08:53:47 -0800
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f2d94ed6-0902-4dcd-bc7a-b7c58e7e61e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/19/23 8:31 AM, Denis Kenzior wrote:
> Hi James,
>
>>>
>>> Ehh, I'm not so sure about this. handshake_state_set_8021x_config() 
>>> does a shallow copy of the l_settings object.  I think eap state 
>>> machine will make copies of the info it needs, but...
>> Ok, yes this wouldn't work as-is then, but we could clone it instead.
>>>
>>>>     to the profile if there is an ongoing connection. This is a much
>>>>     simpler approach (unless I'm missing something). Only questionable
>>>
>>> Also, netconfig_load_settings is called very early in 
>>> __station_connect_network, so even if you overwrite the settings 
>>> object here, it is probably too late to take any effect.
>>
>> For this case I'm not sure there is any difference. Keeping the 
>> existing settings or replacing won't change netconfig once 
>> __station_connect_network() is called. We would need some changes in 
>> station to load the settings again after the connection. I'm not sure 
>> trying to solve this specific case of settings 
>
> I guess I'm then confused on what you're trying to accomplish with 
> this patch. I thought you were trying to take care of the inherent 
> race between:
>     1. Connect
>     2. Write provisioning file

Things sort of evolved. I originally thought I could handle this race by 
just updating the settings but this is not really the case without 
additional changes to reapply the any netconfig changes after the 
connection. Yes this would also solve the DPP problem but I think its 
makes more sense to just sort out everything prior to issuing a 
connection rather than rely on the update to come in and quickly insert 
the missing config values. I'd hate to rely on this, its quite subtle.

>
> The result of that race is that any changes to the provisioning file 
> are not taken into consideration when connect proceeds.  In 
> particular, any networking related settings are ignored.  Note that 
> today we have a bunch of logic with several paths for syncing to disk 
> that take care that the settings are not actually lost (well, best 
> effort anyway) when the connection is successfully established:
>     - Special logic to update Autoconnect inside knownnetwork.c
>     - Special logic for updating just the PSK bits in 
> network_sync_settings()
>
> I assumed that by solving the above race, you'd be solving the problem 
> you're having with DPP?
It would yes, but not without re-applying the netconfig changes again.
>
>> changing _during_ a connection is really in the scope of this patch 
>> set. I'm 
>
> Okay, then this patch in particular is not needed?

Its at least partially needed, if a known network already exists prior 
to DPP and its overwritten there is no callback. So we may not need to 
actually touch network->settings at all as I thought. Just emit an 
UPDATED event when the profile changes. DPP can then call 
network_autoconnect and the settings _should_ be re-loaded unless I'm 
forgetting some instance where network->settings can persist, but I 
don't think it can.

>
>> also not really convinced trying to fix this race condition is all 
>> that important. Its not really a "race" per-se, but more of just how 
>> IWD works. The profile is loaded upon connecting and those settings 
>> are used. If you swap out/modify the profile in the middle of that I 
>> don't think anyone would/should expect those changes to be taken for 
>> that ongoing connection. That's my opinion on it anyways.
>
> That's fine as well.  In that case you just need to have DPP wait 
> until knownnetworks adds/updates its state.
>
>>
>> What we do need is the ability to update settings on disk if IWD is 
>> sitting idle or connected. Currently if network/network->settings 
>> already exists its not possible to update unless IWD disconnects.
>
> I'm not following.
>>
>> You mentioned copying over all settings except the security group, 
>> but this wouldn't handle the case of DPP (or anything) updating the 
>> profile with new credentials. I think we need the l_settings object 
>> to be 100% synced with whats on disk (but as you said, 
>> network->psk/network->passphrase shouldn't be altered). This then 
>> means the entire settings is copied, so its much more efficient to 
>> just replace it. Does this make sense?
>
> If the settings are opened, it is too late to alter anything related 
> to security since that is used by eapol, ft, netdev, etc. You might 
> have a chance to apply / re-apply the settings used by netconfig.

Yes, with additional changes. Not anything network/knownnetworks can do 
about it though is all I'm saying.


Thanks,

James

>
> Regards,
> -Denis
