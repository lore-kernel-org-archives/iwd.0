Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64E13AEB
	for <iwd@lists.linux.dev>; Sat, 16 Sep 2023 15:18:04 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1d6baffcac2so217573fac.2
        for <iwd@lists.linux.dev>; Sat, 16 Sep 2023 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694877483; x=1695482283; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVDzPuYDLILfzVlk8+zsNDxllZMCL9fhVPSeAHV3REo=;
        b=NBxC1imCog84JTGBg7kVu4zgdypjWSx1iU4RQTsa0fD+4934nqnf28WGjyRdPW9px/
         +yJ78RqPV7C8zek/KiA4TkoffOqpOCRr4DfO0HoX/yvTrzDT/o/3J3ht0FPz7z2WGqn7
         wXwUYmWjxnXLMudzuRa2Ff42ZFhLuu05quU+Pwz+NkDrmoGxX3g+Rxabc3Oq24nzWG6J
         iH81lw6HF9F1HEep0FuSqmYyaTDbhOUQWh8wwHJLHhC4RpPkl4ntqmuE9MnbALZHQ8vO
         hd5rrENWKOwx2iR44pcNIiWR769cd949ZOOwbhX2zPociqcocCOQphgzrg3kZb5wdCdg
         RgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694877483; x=1695482283;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVDzPuYDLILfzVlk8+zsNDxllZMCL9fhVPSeAHV3REo=;
        b=YDismJYVcJE1Yiv8UAIGFd94bXs+rRBxAU+gNO4CRcTPO7YJ15LkIDBMP06xpNnwzc
         VQVk1TyiEhfKubTittAmsUiSLwf84fmKJw8WSbQi3FIe+KGB+jlvTy3ixnGS3vrGt5Lc
         FmyGXWF/xZA+NfSyCIcp+RgtLTTedFt/ZBiKGg8oV2wRmJp8EADNtVEAG9CK7rkKwXPy
         qQcyVfVNiBVeddCbmLcSthMJJxI0dZlAo6bop/zGbNHZivTzxBOxX1ZDuQLYnPePlzMy
         UIWBCazKyoH+ZyKsa7AtCWeIoVrOJD1zXH+RgaJQ3uXd4K0lQXDC0HC3MVeGF1ce5fUO
         7Qiw==
X-Gm-Message-State: AOJu0YxrcgTYyPIktMvw7z4PeRGQ03tPFxFtzHDCiIXr1BEkrHUturAZ
	Jp8o7rI5H6Ug0OIOjump9Zk=
X-Google-Smtp-Source: AGHT+IH11z/4yYsEq2Kp+X+1mw3m+kwjWLSsvMvjATxvJxAaiUjbqucumfxwJ4OVWVfKCFOX1IfUFg==
X-Received: by 2002:a05:6870:ac08:b0:187:92fb:6ecb with SMTP id kw8-20020a056870ac0800b0018792fb6ecbmr5744498oab.20.1694877483353;
        Sat, 16 Sep 2023 08:18:03 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r7-20020a056830120700b006b94aba1f0bsm2665701otp.43.2023.09.16.08.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 08:18:02 -0700 (PDT)
Message-ID: <a61e3a1d-9e97-89c1-d543-6b6ba9860146@gmail.com>
Date: Sat, 16 Sep 2023 10:18:01 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
 <43d47533-a4a3-e3d5-8f17-30467475660a@gmail.com>
 <8629e294-0550-436d-91b3-e0cf1c84f8e7@gmail.com>
 <42efcf9a-6aca-c728-ba9d-fe95a6066900@gmail.com>
 <e144f8a4-82b2-4882-bf25-5fac6165b9af@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <e144f8a4-82b2-4882-bf25-5fac6165b9af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> How would you prefer I do this? We've got quite a few modules using scan APIs so 
> I question if we want to filter the frequencies before calling scan_*

We should be doing that already, no?  Any code that specifies scan frequencies 
in some way should be aware of wiphy band capability and regdom.

> 
> If we filter in scan.c and call back as if the scan returned no results we 
> shouldn't need to touch anything except scan.c. The downside is its a bit of 

I really rather not generate dummy/bogus callbacks.  That just pollutes debug 
logs and makes the code hard to follow.  Station would be most affected here 
since it breaks up the 2.4Ghz band scan quite a bit.

If 2.4 is turned off, it should just skip those requests entirely.

> wasted work doing this since we have to create requests and work items for 
> nothing, but the alternative of adding this specific logic to each module using 
> scan calls seems worse IMO, what do you think?
> 

One thing to keep in mind is that some devices operate only on 2.4G.  For 
example WSC/WPS might only perform push button operations on 2.4 GHz band and 
not 5G.  Might be similar with DPP?  So for compatibility reasons maybe this 
should be a station-only feature?

Regards,
-Denis

