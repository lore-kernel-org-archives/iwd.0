Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DB26E17
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 16:13:30 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77433e7a876so413254785a.3
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695831209; x=1696436009; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PE6kUwwZ6Y6uFIMLbW+ENqNHc1HABg223AqfcZjcXKc=;
        b=COTUMCl2tjxObcTe7OM3W81U/k1OXvSpD7MU2innoIWAbSEkyid3hJLYiviqgdmU6u
         DTjRh2uRQ5O9DMa+xpLgw8aKodMmilPK9qgAFKe05XDiCuyXZq6TTd52heFVZzvQR0zA
         fdLmlMpp+WBb2LcOk56seXq0LFkaPirS/qw0OKSJLn7A1rGKWeVMkA7dZcPjRNWImBMy
         Q/s5EOxTzOAhEb94IWdvX3vGP12EAXNIiPDI2LHFxWDZ5toFJyn2eOww0/5Czj0GMjH+
         pfs0ODPBqzxgbXLB2+Ib4mHvtv6woqaK68sOyagZvPnlssjMKRJ5/6xtYMNPu8kL7cVg
         TtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695831209; x=1696436009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE6kUwwZ6Y6uFIMLbW+ENqNHc1HABg223AqfcZjcXKc=;
        b=acNWIQwsxJAMYnN+CsDD/F9NP0yFcGn4YHrumXCj9KuKdXosVkEL+Au3oJePwXpkdf
         0N18ZKhanfmZWX7pcwTrgB20VOAzPg0bRxATmq/11giGlv70Sn3Syl1pesYnLoEPNVFG
         c2R3U5MWs9zgphZpvCB4h6YmdRV5hx2fss8oDtDtb6ibqg0oixyNzv7CLumNtpkQ/x8v
         G//fjgRy8tcqrygfgh7Ovt/o7lBcI98kR4efTXpnlmwbWypD1uhMT8se8X2FZM7BovVJ
         Mf8jz2+v3ZuO5ZQT/aLPp7FpXPnXVwaz89xctX/GV2l8wGWSTpcHCA/IX0hXpA0WdcTT
         okfw==
X-Gm-Message-State: AOJu0YxtI8qc/H/BxMI6IVhwZnLJArKp+a2vjH2hkIhYXWgIW8dzsDME
	jfiI1unJB9Igbd8M2pS1sIg=
X-Google-Smtp-Source: AGHT+IHajwGg3+WQYjbyll9uF8j1feRL96LCb1W8MdRBjfq+EaLaAtEuU9EWMJO5I+ioJbocGjuczw==
X-Received: by 2002:a05:620a:a8c:b0:76f:1614:577e with SMTP id v12-20020a05620a0a8c00b0076f1614577emr2158818qkg.25.1695831209469;
        Wed, 27 Sep 2023 09:13:29 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a164700b0076d08d5f93asm5576149qko.60.2023.09.27.09.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:13:29 -0700 (PDT)
Message-ID: <98464440-5567-40e7-aa26-504d9c474b53@gmail.com>
Date: Wed, 27 Sep 2023 09:13:26 -0700
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
To: Bryce Johnson <bryce@redpinelabs.com>, Denis Kenzior <denkenz@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSJhjpBk_FcQn_rfK6xB0viR1rRXSiiwr1tSFxi0EYnY_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

>>>
>>
>> I'm not quite sure what benefit there is in supporting PMKSA for WPA3-Personal.
>> Maybe lessening the CPU load on the AP?  The number of messages exchanged will
>> be identical if I recall correctly.
> 
> I am just learning this now, so might be wrong.  But looks like it
> would it then skip the 4 initial SAE initial handshake messages?

I believe yes, it can skip SAE entirely using Open Authentication:

12.6.10.3
"If a STA in an infrastructure BSS has determined it has a valid PMKSA 
with an AP to which it is about to (re)associate, it performs Open 
System authentication to the AP"

So in that regard its faster, your saving 2 messages essentially (since 
open auth still requires a request/reply).

But this all gets beat by FT anyways since you can skip the 4-way 
handshake. I think this was all considered when we decided whether or 
not to implement PMKSA, it just didn't seem worth it since FT exists and 
is superior.

> 
>>
>>> Honestly the wifi alliance has been pretty frustrating to work with
>>> and takes 1-3 days to get anything back from them.  Depending on the
>>> followup response, for this product it looks like I might have to
>>> revert back to wpa_supplicant and deal with some of the issues with
>>> using that.  I got spoiled with IWD ease of use (and it seemed to work
>>> better in some situations).
>>>
>>> Products must be getting certificated using IWD right?  Did I just
>>> come across the wrong support person?
>>
>> You're the first I've heard about.  If anyone else is going through the
>> certification process, I'd certainly love to hear about it.
>>
> 
> Me as well, I'd rather not switch back to wpa_supplicant so any
> workarounds would be great!
> 
>> Regards,
>> -Denis
> 
> Bryce
