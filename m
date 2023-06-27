Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D171308B
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 19:33:04 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1b038d7a5faso2329865fac.1
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687894384; x=1690486384;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scUnOutwh5vco4ozeo0YCNeFvnXhvzAQbIh79X8NunA=;
        b=PVzMl3OcYMfEaprxw9hb/HuC8p/nIv+gyKT6uehGKZw4aL72v5dRtrzCPjE4JgDUWY
         cXaEX4w7/rsjowzoMnaV4Zg2FxJTpXUaGawS1JVtO40slAFJm4KBrF9MkBcF4PdMF7ZY
         wKq9c/YlPgiV3WfwM/b64P/4qNCIWAYa6QW5Hv/8JBD5TZuHjteU0IY3EId1GJrqEs6T
         h+YwnW53ar1iRlQCmFa5Ji8Lop8facXU7+uZM0CMOTJnKcYQcO1hAf+UNkPL8wR9fKFP
         FepjZ6GZaVubUOe/ZLGeBxb4Tx7HhYUH1nqnRUHj1DoxvCT02BrypQyn1usAtlK9IUQ6
         Ci0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687894384; x=1690486384;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scUnOutwh5vco4ozeo0YCNeFvnXhvzAQbIh79X8NunA=;
        b=PE5GdW7ez7IYHOAZy3g9QwAGG+ZNafLeNStRFPAJlizydRU8ndr69gpv/X/h2opbbQ
         sR/YrxYCfagkoapus096j1kJgPjJyriGhpdnJmkV4v4lmJpHzUH0fHaNiXtMic8eCdDL
         lTXf6NXVYQ17VchU/JvNT24/kVlOUtlZQNqZqUCKvznvCcJMiJgmHUHZ2FBb94I14M0W
         SKzyL0LwvTudNI/M+soDqp9KUjm1PVgGQakqTRYecANVFjSSJeSwXPNqNugaTTU3BisV
         /glHFG1ZgQz1mpEjGlVw0MXfSI+9IfQdm1ta4ENGQ3MSzANkNo7Ewr9EBRr8/9Wbpw8y
         PFrQ==
X-Gm-Message-State: AC+VfDwGBCK3iEr25Yx71VFvYIMgWHoUy7bIRhaHGPtYXU4ZilZqvO7X
	UB236XNnfUv5l1iAFYuKRTA=
X-Google-Smtp-Source: ACHHUZ4lqF+IVp9ldNEr3KUWp0QSo11c7n+beiCmGIsfQsOIYyVFwPl9xeD5tukHxvDaCy/WxafvTA==
X-Received: by 2002:a05:6870:e28b:b0:19f:2c0e:f865 with SMTP id v11-20020a056870e28b00b0019f2c0ef865mr22291778oad.7.1687894383629;
        Tue, 27 Jun 2023 12:33:03 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ne16-20020a056871449000b001a6d15fc52fsm5538536oab.4.2023.06.27.12.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 12:33:03 -0700 (PDT)
Message-ID: <b55ba72a-7570-be5e-ff8b-0bb3c4ba747e@gmail.com>
Date: Tue, 27 Jun 2023 14:23:24 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
 <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
 <ae4b9dc2-c88f-dfe9-2146-cbc3cc63f3c8@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ae4b9dc2-c88f-dfe9-2146-cbc3cc63f3c8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>> It looks like we should start using this since most of our autotests are 
>> forced to include the following main.conf:
>>
>> [Scan]
>> DisableMacAddressRandomization=true
>>
>> Having support for the above event would allow us to get rid of this hack.
> IIRC Tim started adding that into tests a long time ago, and had said improves 
> reliability. If I remove it (e.g. in testPSK-roam) things start breaking, but 
> its very random and not repeatable, some pass and some fail between runs.

Yep.  It is very random because the active scans via probe requests fail, but 
the beacons still come in.  So it is very much timing/luck dependent whether a 
scan picks up the network the test is interested in.

We started noticing the failures shortly after adding scan address randomization 
support.  'git blame' pointed the finger, so we added this setting to work 
around the issue.  Seems blindly obvious now, but we didn't recognize the link 
between address randomization and hwsim at that time.

> 
> I would expect all hwsim tests to fail if we are dropping all frames with and 
> unknown TX or RX address so something else must be going on here. But indeed, 
> this *should* work if we handle these events similarly to wmediumd.

See above about beacons.

Regards,
-Denis
