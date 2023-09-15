Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273A30CE9
	for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 14:44:51 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59bdad64411so23719937b3.3
        for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694789091; x=1695393891; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bclpvnVgLQPld32b1lue77anMSFWN+L0QZuv4lRDxnQ=;
        b=hfj8kLwO+JmPkPeNcAY9DaMJE/Re2EgnNwY3z1Q/5abRpRUlsCEBZbLX/pGCvAbg89
         rh9p6YbYajjj8mTEf432gG4S899lITARuo0bkwwrV56OKukKcQzafnnsmrVUgwRDSCwU
         MnRWMmoEsJhVX0tEosAGZ0yUra5+hNq9QTaU/Wy0GVX9SJamJEPafVOV4Krp+RUjnDyS
         xtLJwQEJJ4ocyj3/TEPt650Tt7Rlfs3KBY4kiTMS4UnwUF4QGm92v+5KxR1thKSyOBeq
         +NBSoBsrHlWi1gLimbVrng0CezFabapxOPtnP4s8q+/Jz0Fs6FstnYJT+G+zbIqjt0cw
         wdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694789091; x=1695393891;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bclpvnVgLQPld32b1lue77anMSFWN+L0QZuv4lRDxnQ=;
        b=Tw182Vdcao5c15kdHn5gkF6WggFTgzIeuJzV6o4OZGIbxvfB+W2hEEfpvMUmiPndWT
         wiCmsoljhTACQtWaAQXEuDxZAQ02KrhJKWSQoLJAsGK0QKXqLbO5ksCydPcmzzNFu1+W
         XhfoNz6lWs4Tr2uWgDEvYYEdYX8RIa8g4APt/6U0G4kvkeJ2fRVjPRWmGsK2sdtssWMN
         lqVu9oqAEYTiUAANCzsb/ogUQDX0T5OhD/Eh+CKbaHxx8I3ZrQhApLY+HZ3ydz5P+0MZ
         xo9vd3EzxjUz3ZLSZ0eglwCwSQ+AhDS1kbnfI4DfMpv+A8tAtqm4GkY7LNbTA8weKDqW
         GRug==
X-Gm-Message-State: AOJu0YzGlgofJ/hFgjqjAMGyWxd05cVU0DXUR3HQQbXVUC4kXc+HdvHt
	pLzhjnkccKyNM9sVWqkZAlU=
X-Google-Smtp-Source: AGHT+IFzz1DQJn0Z1BEmz+yNFbU6jNVBhUZVV8TzZqyTEGrX648j9SmMb1WivtQGY2/bN9TuYJrRrw==
X-Received: by 2002:a0d:dd4b:0:b0:59b:eb47:d51 with SMTP id g72-20020a0ddd4b000000b0059beb470d51mr2343739ywe.2.1694789090833;
        Fri, 15 Sep 2023 07:44:50 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id o144-20020a0dcc96000000b00576e5af0249sm878900ywd.20.2023.09.15.07.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:44:50 -0700 (PDT)
Message-ID: <2152545f-6de7-425a-8181-c3f76d8b7d63@gmail.com>
Date: Fri, 15 Sep 2023 07:44:48 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>,
 =?UTF-8?Q?Jonas_Gro=C3=9Fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
 <0d355152339b4e937910fb2440d1d3ace453514a.camel@grosse-sundrup.com>
 <449345bf-a1e2-b435-f855-7048ab0770e3@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <449345bf-a1e2-b435-f855-7048ab0770e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/23 7:35 AM, Denis Kenzior wrote:
> 
> Hi Jonas,
> 
>>
>> (Feature Request: also accept "5GHz" as spelling, given that's the
>> correct unit spelling? 😅)
> 
> Yeah we really should.  Too bad we somehow screwed up the capitalization 
> in this case and settings keys are case-sensitive.

The API is camel case, so I could see the argument the 'h' should be 
lower case. But I don't care either way, supporting both is easy enough 
to add.

> 
> Regards,
> -Denis
