Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AC37D06
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFlNA+bF"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b435966249so197319639f.0
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703003525; x=1703608325; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDpiit8FX79dOjMwAZG9leCcqIuy/YnTjvEBGTvet2w=;
        b=fFlNA+bFboAu+WgMQ9HAT4BKHHbkKF9iEc5F3vKHVY2odO7o/WGmoT0RnHn9YEs0DR
         Nbiy2rsojld2RBaooqmKOGLuCnmcem7gBu/zeJnT9Tm6QqmO0btH8MzyU0Ya1c/Pq0r6
         54JNorZ4oLAZUo7kN0wXvFvJXyJDcLavVfDzlY8MPTBhMV2Ayr3mckcPO+Xsm5L1bfuJ
         SANFrLbDtWM2dC5sNzyONZ5wZWpBd9yIC8AoxMlbGAmRq8Yqqlx7i2qDQVE251rTUK/x
         h08IWT6NIPTuYOI+bsAHjcWGkVCuXzWhPwLuHH5aTPZ8rTvLf7Bm1BDecYzrAha/SvVo
         mKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003525; x=1703608325;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDpiit8FX79dOjMwAZG9leCcqIuy/YnTjvEBGTvet2w=;
        b=TCxt/Stf2KioaaHA283ilBME7+ccWDSS5fAVyCxNadm3dY/kZYg45E6cmegPmDem7b
         JSzcxy493M/1xA2VKc+ABU7wYVwy42nLWDjO5vJVlLZofCE+ydOSeOMQLxAqg+5ognvK
         5vmm83pPRKmVcLtO7Y2zfy69EPHy4/VnklhMeWhskzcf9NyHkZj9vsAQGVYMJYl4CUPk
         y4SZPaMdHbnrTRPHPdSsC6zOb8ZJpQazzaxo5y3SrQayZc9MXMVaKPXuPHM/8bdIwYtZ
         F262AhkcIzehvJsRQ94UXenvktfk3boKXtKWYkU50nyqN3nRZ4bIrXelXVlH5C0PEJPo
         sH6Q==
X-Gm-Message-State: AOJu0YzN0g/MUfOkQPsds++xdPwyBDLBkw1Mc3+gMG2hSVsiIe/zIktZ
	oAsxNRZFRbzxwu0m5wiUpio=
X-Google-Smtp-Source: AGHT+IHZMj8u+sliGqa21HDoyi6lLQ50ZC7WxQEa7Pyoh8SYG85pLj1SqZ4dGL2M3hIsuZvcVItdrw==
X-Received: by 2002:a05:6602:274d:b0:7b7:e9f:b93f with SMTP id b13-20020a056602274d00b007b70e9fb93fmr19854692ioe.0.1703003524710;
        Tue, 19 Dec 2023 08:32:04 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id ck19-20020a0566383f1300b00451b5feb80fsm1466827jab.8.2023.12.19.08.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 08:32:02 -0800 (PST)
Message-ID: <f2d94ed6-0902-4dcd-bc7a-b7c58e7e61e3@gmail.com>
Date: Tue, 19 Dec 2023 10:31:59 -0600
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
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231218141250.202157-1-prestwoj@gmail.com>
 <6ac609fa-0540-479e-8ab3-387b0cab24cb@gmail.com>
 <ee339749-46cd-4927-a3fc-ff80924a5f70@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ee339749-46cd-4927-a3fc-ff80924a5f70@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>
>> Ehh, I'm not so sure about this. handshake_state_set_8021x_config() does a 
>> shallow copy of the l_settings object.  I think eap state machine will make 
>> copies of the info it needs, but...
> Ok, yes this wouldn't work as-is then, but we could clone it instead.
>>
>>>     to the profile if there is an ongoing connection. This is a much
>>>     simpler approach (unless I'm missing something). Only questionable
>>
>> Also, netconfig_load_settings is called very early in 
>> __station_connect_network, so even if you overwrite the settings object here, 
>> it is probably too late to take any effect.
> 
> For this case I'm not sure there is any difference. Keeping the existing 
> settings or replacing won't change netconfig once __station_connect_network() is 
> called. We would need some changes in station to load the settings again after 
> the connection. I'm not sure trying to solve this specific case of settings 

I guess I'm then confused on what you're trying to accomplish with this patch. 
I thought you were trying to take care of the inherent race between:
	1. Connect
	2. Write provisioning file

The result of that race is that any changes to the provisioning file are not 
taken into consideration when connect proceeds.  In particular, any networking 
related settings are ignored.  Note that today we have a bunch of logic with 
several paths for syncing to disk that take care that the settings are not 
actually lost (well, best effort anyway) when the connection is successfully 
established:
	- Special logic to update Autoconnect inside knownnetwork.c
	- Special logic for updating just the PSK bits in network_sync_settings()

I assumed that by solving the above race, you'd be solving the problem you're 
having with DPP?

> changing _during_ a connection is really in the scope of this patch set. I'm 

Okay, then this patch in particular is not needed?

> also not really convinced trying to fix this race condition is all that 
> important. Its not really a "race" per-se, but more of just how IWD works. The 
> profile is loaded upon connecting and those settings are used. If you swap 
> out/modify the profile in the middle of that I don't think anyone would/should 
> expect those changes to be taken for that ongoing connection. That's my opinion 
> on it anyways.

That's fine as well.  In that case you just need to have DPP wait until 
knownnetworks adds/updates its state.

> 
> What we do need is the ability to update settings on disk if IWD is sitting idle 
> or connected. Currently if network/network->settings already exists its not 
> possible to update unless IWD disconnects.

I'm not following.

> 
> You mentioned copying over all settings except the security group, but this 
> wouldn't handle the case of DPP (or anything) updating the profile with new 
> credentials. I think we need the l_settings object to be 100% synced with whats 
> on disk (but as you said, network->psk/network->passphrase shouldn't be 
> altered). This then means the entire settings is copied, so its much more 
> efficient to just replace it. Does this make sense?

If the settings are opened, it is too late to alter anything related to security 
since that is used by eapol, ft, netdev, etc.  You might have a chance to apply 
/ re-apply the settings used by netconfig.

Regards,
-Denis
