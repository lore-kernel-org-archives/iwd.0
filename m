Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D713DB80
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahB9hy0r"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b844357f7cso39690b6e.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 09:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882895; x=1702487695; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5h8/5wPNlsasQQq1X0AQx+zJRhbOTYk9pkHBbawpEYc=;
        b=ahB9hy0r4Y037loMf/w3i0UbdsX5AVTAqkdRPi++W+SiYEqwfW5Ozke1adpwvHHrt1
         E4B2G5546VDVsbZZhHK3vckH/MhvgqVp+RcVkO7UaRd0cgYFf+9kjDQX9mp9YXq4tM6O
         g9UJbYtTsNo5IgDjTPrLLtClA84M3qCbfCvJgE0CODfEa9sO29VnQ8Duz7MGHLfkSvHi
         chtHEu4iJJciP9PmbBAuo+8xpc6ZnrPXz57TS6IiRgyQ/QAakij+jksFrumc27F7jo+p
         necbkpkIbGPzpSG3ji9ifvXFl6AvtkI0gbwHNhRW8R95iIX99rm/IjZA6Cq5coB9z9Id
         4syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882895; x=1702487695;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5h8/5wPNlsasQQq1X0AQx+zJRhbOTYk9pkHBbawpEYc=;
        b=UmSzFNiLp7VRCwLi/Q1RYbe1Ifso9vw2swZS4gnz7ntRBKIeODUnT9ANJL1x79T/aw
         TpcTtAYItrjMSMtxWdo6YRtLkJvXaPABYy0EDuBIzSZ8VV4lcdeXfevwtcPJ4xjqtjt0
         6WViO1oqRwyet1gVHCGtarxGSemaQRaZvd82QU2CHwFQnOz9u7iqHclojOcZ9bSeoxRI
         ZbLHKcIg3HcSTymZ/gPtGVX9l9S52OR7TL+4hC6wJcqXM3JeifcNS9YoDEYGQahOdX/G
         tnOpE6Ko2d8iqAL7phUN4qoWaSgbHxkMxDYH7WJDfla3RulrQHHQ31lA2j0DyyFObViu
         UH8g==
X-Gm-Message-State: AOJu0YwWYAM2cPnYBdI4/1StfrVCxrzgRS/q0vs9VhFC89qajlkV1zlL
	xWSPsY0sUWFjHccHTgUYuYZFotv6/CM=
X-Google-Smtp-Source: AGHT+IFRFHNsufAyK5Cs4Px/Y0f1PbAlhHdmxn6UK73GEx9eI6CzkxiSDBLmW0LSKwU4yOgPy2HiGg==
X-Received: by 2002:a05:6808:3a9a:b0:3b8:b063:6bb6 with SMTP id fb26-20020a0568083a9a00b003b8b0636bb6mr1300898oib.101.1701882894914;
        Wed, 06 Dec 2023 09:14:54 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e16-20020aca1310000000b003b85cc30fe8sm59197oii.36.2023.12.06.09.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:14:54 -0800 (PST)
Message-ID: <76d133cd-e0b1-4a8f-8ade-891af9331dda@gmail.com>
Date: Wed, 6 Dec 2023 11:14:53 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] ft: add FTE/RSNE building to ft_prepare_handshake
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-5-prestwoj@gmail.com>
 <620a779d-e694-4057-846d-23e6eea35252@gmail.com>
 <14c4906e-099e-4e9d-90c0-fca8d5eb38dd@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <14c4906e-099e-4e9d-90c0-fca8d5eb38dd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>> +    handshake_state_set_fte(hs, fte);
>>
>> However, this is less clear to me.  Looking at how FILS and FT uses this API, 
>> it seems that set_fte is meant for the authenticator FTE element?  So I think 
>> rekeying after FT would be broken by this change.
> 
> Good question. Rekeys do appear to work as-is but you are right, FILS/FT uses 
> set_fte() for the authenticators element, but eapol seems to use hs->fte for 

I'm pretty sure the intent was for the FTE element to be from the authenticator.

> building message 2/4, as well as checks that the handshakes FTE matches what the 

I'll have to look at how ptk_2_of_4 uses it.  Memory is fuzzy now.  Need to open 
the spec.

> authenticator sends in 3/4. maybe this is actually a bug in eapol? I think the 
> reason everything "works" is because the FTE should be the same between both peers.

Yes, but also we have logic in: netdev_connect_event() that sets the FTE from 
the response IEs.  So that's probably how things end up working in the end.

> 
> We may want to refactor and do:
> 
> handshake_state_set_authenticator_fte()
> 
> handshake_state_set_supplicant_fte()

Yeah, that seems reasonable.

Regards,
-Denis
