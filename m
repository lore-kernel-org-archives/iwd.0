Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942B26E2A
	for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 15:51:59 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59f6492b415so71231797b3.0
        for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695743519; x=1696348319; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDfUSH7bgS7+zE3QICvR0+zoxJygj4XQzFgl9D6Emhw=;
        b=m+U0XEFpstNw2QTNieRdKX9wiXv1GG3VzLb1ePelfXXS6G5NddOzhqUGeCjE+gzIbL
         q/6lEQIYBlPLMLfSsdWj/vf6mxxyG8nFIOh1CuvybV9y3UCno0zpjc+18KW+8md4n/Xk
         hHorNbQpJVdMzw9K3n09UvClv6IamzABznMYwsLcoqqP+CnhORDxuUV7qNGv9g1TZO+r
         WqMqg56JgPYtoGAI6dH7ZJJgKhEL3ug9/M9cidYk9bmbD4jNLiJzFeBJ4U1a8x4KaOwb
         /Ze6GI27/4qP+Z9T55TP4T5r5v3+RuplACbQwRkabK+a6t3a2x8+M7n95jLWWesxgm56
         Fbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695743519; x=1696348319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDfUSH7bgS7+zE3QICvR0+zoxJygj4XQzFgl9D6Emhw=;
        b=p15XBsr64VUqQ7XdkKH0I3Bvp6c2YzJj2ZzOVeC2bGgChIo5izP4SIyUFOjWzYi24T
         CBxDkQ+Oh7HF8iuKFFMceLYhPKCilOHRDkT2D6EBj5M/NIVyiDLcB7TErLbwdx4PLZE7
         K4iHtCiF73m8tg14baCJ+LDUPVID4RfhaVmsE1OG/fJUSgbVs4xUfACwmMFQWuHtMrC5
         GQSdNM0sT5KSQliE3uL6+PB/MHoKQLboki2Iv1MYXwpL7vWxmPcC5+OSzcr89191fYmq
         SSOr8UJVvLZR6+0Twb0eLEJ+WgBKFTBvrCOHji94tr8CHi/NKxMe7C5l0ybAgrgyQaX9
         6Jvg==
X-Gm-Message-State: AOJu0Yzc2cOE3MSvlCCl/ze6WJGs4BpRtbSE++qS+2ixNXWPpJUG7ssL
	s7LXqrY5J2WfT1i5WcOCYikDikPuKcc=
X-Google-Smtp-Source: AGHT+IF/ee5knEYNVVru1qQq2w5VH8r8f0XVckxxcZ4uL7GDphPf2w8xja6pscnh6ikqAVGjD8/gIQ==
X-Received: by 2002:a0d:e60a:0:b0:59b:d33e:40e3 with SMTP id p10-20020a0de60a000000b0059bd33e40e3mr2227493ywe.11.1695743518947;
        Tue, 26 Sep 2023 08:51:58 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x9-20020a814a09000000b00589c103d00asm3062605ywa.79.2023.09.26.08.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 08:51:58 -0700 (PDT)
Message-ID: <14d625aa-b2a6-46ed-9410-802b2d587059@gmail.com>
Date: Tue, 26 Sep 2023 08:51:55 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: Denis Kenzior <denkenz@gmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryce,

On 9/26/23 8:16 AM, Bryce Johnson wrote:
> Hi James and all,
> Switched to my gmail account that works with the mailing list better...
> 
>>>
>>>> Yes without PMKSA support the client device/IWD will never "reassociate"
>>>> after being deauthenticated so your right checking for the auth alg == 0
>>>> is not correct.
>>>>
>>>> After being disconnected IWD will do a full initial association, which
>>>> for SAE means auth alg == 4.
>>>
>>> Just looking through the wireshark logs, just to double check you mean the Authentication Algorithm in the Authentication message (0x000b).  I am seeing that as Authentication Algorithm: Simultaneous Authentication of Equals (SAE) (3)  (0x03 00).  So Auth Alg of 3?  Or am I referencing the wrong thing?
>>
>> Yes sorry SAE is 3, I was mixing up what the kernel's enum value for SAE is.
>>
> 
> Still having issues with wifi certification around the PMKSA caching.
> After finally convincing the person at the wifi alliance support
> person where the spec didn't say PMKSA caching disabled needed to be
> in open mode I got this back:
> 
> "Thank you for sharing the PMKSA_caching information from the IEEE
> Spec. It appears that it only describes the correct behavior of the
> DUT with PMKSA caching but does not provide any information about
> PMKSA caching for WPA3 SAE-H2E.
> 
> However, according to Security R3 MRD v1.3 (May 2020), PMKSA Caching
> is mandatory for all devices, which means your device must have the
> PMKSA caching function. You can find more details in section 6.3.1,
> 'SAE Hash-to-Element,' of the Security R3 MRD v1.3.pdf document, which
> can be downloaded from the following link"
> 
> Those lines are here:
> 6.3.1 SAE Hash-to-Element
> • Support for the SAE Hash-to-Element (H2E) technique defined in
> 802.11 REVmd D3.0, including support for Rejected Groups, and back
> compatibility with the SAE Hunting-and-Pecking technique
> ▪ H2E support is required for all mandatory and optional SAE-based
> WPA3 features that are supported by the device
> o Note: PMKSA Caching is mandatory for all devices; FT-SAE is optional
> • Support for BSS Membership Selector indication for H2E-only SAE, as
> defined in 802.11 REVmd D3.0

Apparently WFA does require PMKSA for their own certification then. Not 
sure why exactly they require this. Without PMKSA the device has to do a 
full authentication when reassociationg so its not like its adding 
security in any way, its more of a convenience for faster reassociations 
(as I understand it at least). Its also WPA-Enterprise specific and many 
consumer devices only support WPA-Personal, so its odd they'd require 
this across the board. Maybe ask them this? (unless your device is 
intended to support WPA-Enterprise). Maybe they can disregard that 
requirement if the device is WPA-Personal only?

> • New MAC/PHY/Bands shall only support the SAE H2E method.
> 
> I can provide a copy to the PDF if someone was interested.
> 
> Honestly the wifi alliance has been pretty frustrating to work with
> and takes 1-3 days to get anything back from them.  Depending on the
> followup response, for this product it looks like I might have to
> revert back to wpa_supplicant and deal with some of the issues with
> using that.  I got spoiled with IWD ease of use (and it seemed to work
> better in some situations).
> 
> Products must be getting certificated using IWD right?  Did I just
> come across the wrong support person?

I'm not sure about this. I know companies are definitely using IWD, 
whether or not they are getting it certified for a consumer device is 
another question.

I think, unfortunately (unless they change their requirements), your 
stuck using wpa_supplicant at this time if WFA requires PMKSA. 
Implementing PMKSA is on the IWD TODO but its not something that has 
been a priority.

I will say, now knowing the WFA requires it, I think its even more 
valuable to implement as making IWD "certifiable" is only going to help 
the project. If I can make time for it, or prioritize it, I will.

Thanks,
James

> 
> Bryce
