Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EF1BDE0
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 16:53:47 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77574c2cffdso75246685a.0
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695833626; x=1696438426; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PR8QM3GAf1dE0KT2mn4X2FIcA2Y+7H5pJ0uq/qDFhoA=;
        b=ijMc7Ac7lM0QL3bSu7aQiUCDbFnG1o9HuiyLCmQNBrAMDd7LOUXIrXliJbxGoFyybg
         zz56oTxlE9vK5ZdraSvVCNTh0b63Ryawt8cv6M6gYZoikJUHDHC3U6TREKrwGW8kYNlG
         LSGrZFHETwa1PxZwJmWwCpZHXmScxl5KBPKrcCF0K/BfpV5FgSfFJHcr7EWOjzvUo+0w
         rLjv1miXWH4MtW/0HnOYUXa/iRBJh5ZahetBItECBsku6FfXaOciu623HkJzf0F7tkDU
         7t9CGUKKzIL705Du9ZLeqP6jJatrxiBFFyuJRTCXGj/fqtFmk5yQ55imtlIXGC2mrKbU
         Wx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833626; x=1696438426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR8QM3GAf1dE0KT2mn4X2FIcA2Y+7H5pJ0uq/qDFhoA=;
        b=ieXek1y1z3QOTrwreIPNxc8n2Dpz3JwK2fMx1eGtRFSJSoTJ2e7cHwCVsJR1GJ1oTs
         hSLou5SCxo2ROP7m8DafM037yxk13nw7cEEP48D3/8KNChiMxjPCEdd75ewOoA3RF9bx
         NbPE+ywey5x+/5OMtejv7k2fO/clczKXti7PHNaCh72Kom7pnRFDr0bDxyZIR9Shhp9R
         tPB5YTFMS1rCtX/M8Jn67Ft2M7GNn4pqiguQoKi/h0CvHNZH09skkl4V23Ml+Sdl+c5I
         sGvLfv9+IPyBmv7QqP+KbWuk7NqOetz/8M5TfBJigW/eU0bYZoU39CP3YDEmbx4vyOSJ
         xh5Q==
X-Gm-Message-State: AOJu0YwlGiVQbit6TMg/LRH5XtwoOXUCWFa6GTwAyFDibBoZpJCW6GrK
	T7ZsAqnWRYI/7PwXQnyw2Ph3ZHD02TY=
X-Google-Smtp-Source: AGHT+IGqSjKBt4dCnWtQgSe2ssUIr5yGEcoTkI70p+KE/syZH9u3LL3821v2HY4qLfAjJdzAFYBB2Q==
X-Received: by 2002:a05:620a:e93:b0:76c:d2be:b7d with SMTP id w19-20020a05620a0e9300b0076cd2be0b7dmr1983672qkm.14.1695833626059;
        Wed, 27 Sep 2023 09:53:46 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id f12-20020a05620a12ec00b0076eee688a95sm5606903qkl.0.2023.09.27.09.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:53:45 -0700 (PDT)
Message-ID: <87dba12f-bf3c-40dc-8bc7-00b34074fdcb@gmail.com>
Date: Wed, 27 Sep 2023 09:53:43 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, Bryce Johnson <bryce@redpinelabs.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
 <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
 <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com>
 <PAXPR01MB9217F29A004603E62CF9FA2AF4EDA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <1f4a9aaa-6e7f-4f07-9ee3-87599b47eb3e@gmail.com>
 <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
 <631dd09c-94e1-44bd-88a0-32ecd12f8221@gmail.com>
 <CADXxVSJhjpBk_FcQn_rfK6xB0viR1rRXSiiwr1tSFxi0EYnY_g@mail.gmail.com>
 <98464440-5567-40e7-aa26-504d9c474b53@gmail.com>
 <ccaa868f-d803-24e8-733e-91c6d6d3b282@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ccaa868f-d803-24e8-733e-91c6d6d3b282@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/27/23 9:47 AM, Denis Kenzior wrote:
> Hi James,
> 
>> I believe yes, it can skip SAE entirely using Open Authentication:
>>
>> 12.6.10.3
>> "If a STA in an infrastructure BSS has determined it has a valid PMKSA 
>> with an AP to which it is about to (re)associate, it performs Open 
>> System authentication to the AP"
>>
>> So in that regard its faster, your saving 2 messages essentially 
>> (since open auth still requires a request/reply).
> 
> My memory is fuzzy here now.  Aren't we skipping Authenticate frames and 
> go straight to Reassociate?  Or is the kernel still sending an 
> Authenticate frame as a result of netdev_reassociate?

Whether or not the kernel sends an auth is a separate question, as we've 
seen it erroneously do before :) But it appears the spec still expects 
an auth frame request/reply:

"Upon receipt of a (Re)Association Request frame with one or more PMKIDs 
following Open System authentication or (only in the case of a DMG AP) 
if IEEE 802.11 authentication was not performed, an AP checks whether 
its Authenticator has cached a PMKSA for the PMKIDs and whether the AKM 
in the cached PMKSA matches the AKM in the (Re)Association Request"

> 
>>
>> But this all gets beat by FT anyways since you can skip the 4-way 
>> handshake. I think this was all considered when we decided whether or 
>> not to implement PMKSA, it just didn't seem worth it since FT exists 
>> and is superior.
>>
> 
> Agreed, but WPA3-Personal is less likely to support FT.  Also this is 
> potentially beneficial for non-roaming scenarios.  I.e. just reconnect 
> after sleep, etc.
> 
> Regards,
> -Denis
