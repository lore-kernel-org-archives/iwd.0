Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520B26E07
	for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 17:13:31 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59c26aa19b7so113886997b3.2
        for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695748410; x=1696353210; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LejhHvlQqoGNE/gpDuNdut4zyvYwAecPBDklLA0eRcM=;
        b=eWkhTgNDxVOolloLou4L2rhE6orsZGtjxewRQhfzDjcCvBvb6RsJvlyKOApVPQ6Hoy
         kBPdqhqVHbP7RdhMUDXnbpveSc+zilIFZLgdF9kgB+rxbER/sAwxpK/Tvp5TQ6HO6o8m
         YtwfRa/dv3ZwV/cSv5JuxGZ6NQLIAl0DWRQopeXHpLHUGvm3n0qUindFG4TOdW1i9pPo
         nwxnm+b6f/s7CdbeU6XuB1UTK729ES+CyCGEsyYliv41rzc01HJpGoWOiiLR/xKGyR4P
         LGEPUMyfgFW90/BhsHoY1kSpsdHuH+HBxaDkWoVfcMLGsvv6MUxe6azfXWA4FZ93VcU/
         3m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748410; x=1696353210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LejhHvlQqoGNE/gpDuNdut4zyvYwAecPBDklLA0eRcM=;
        b=dc7+vp4kDEHIRxMXWC785Yt1l0XhDabHQKj27+mb9cbG4O6/I6i6B5TScWGdJegfCV
         1np9SzuaqqBByliODCUEbdWSXo7+U+8QrchB9tFDf2km8ge8ORdTfKWuCJquWU/7e5sr
         GH8/R0CrK8cAmXSMI2dpFAOQxg1hlgYfUBdi0v7YwfqAiFYafrGcjcQaa2wob9nTlK7D
         +8hgor2LH7OhrgePsxUIzy6xZJKI1DnOI0IVjhE3+WurARpgpQZQhjfAjIhe4hHJeB5a
         zbMaIW+tKfMX2+yUj/21CXDOrkR3W449G169/IrxiCxzHeeLcf5kW828SS2WPO0UWp97
         ICrw==
X-Gm-Message-State: AOJu0YxToWIrQ4N5HGfyOHH6DYAViBwqUDEamBmTDimO9HZqi702WxWS
	/y/+D5PBeTCRxjiPzIp1oFs=
X-Google-Smtp-Source: AGHT+IGZ+HAFdQy2RP/gU10i/G8zcF8k9lWIcLw9WlKQwvxQH+y+RugpQvnuq+pu9pPCNAxTli0oqw==
X-Received: by 2002:a0d:d44b:0:b0:591:4f2b:7eea with SMTP id w72-20020a0dd44b000000b005914f2b7eeamr10066906ywd.18.1695748410405;
        Tue, 26 Sep 2023 10:13:30 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g203-20020a0dddd4000000b00592548b2c47sm3099335ywe.80.2023.09.26.10.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 10:13:30 -0700 (PDT)
Message-ID: <84b05acf-778b-4284-a032-4b1a8ba71398@gmail.com>
Date: Tue, 26 Sep 2023 10:13:26 -0700
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
 <14d625aa-b2a6-46ed-9410-802b2d587059@gmail.com>
 <CADXxVSJpPv-AtS6ztyg49UYcpqU=MLxDD+s-tuEJg=Fgay3HKw@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSJpPv-AtS6ztyg49UYcpqU=MLxDD+s-tuEJg=Fgay3HKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryce,

On 9/26/23 9:54 AM, Bryce Johnson wrote:
> On Tue, Sep 26, 2023 at 9:52 AM James Prestwood <prestwoj@gmail.com> wrote:
>>
>> Hi Bryce,
>>
>> On 9/26/23 8:16 AM, Bryce Johnson wrote:
>>> Hi James and all,
>>> Switched to my gmail account that works with the mailing list better...
>>>
>>>>>
>>>>>> Yes without PMKSA support the client device/IWD will never "reassociate"
>>>>>> after being deauthenticated so your right checking for the auth alg == 0
>>>>>> is not correct.
>>>>>>
>>>>>> After being disconnected IWD will do a full initial association, which
>>>>>> for SAE means auth alg == 4.
>>>>>
>>>>> Just looking through the wireshark logs, just to double check you mean the Authentication Algorithm in the Authentication message (0x000b).  I am seeing that as Authentication Algorithm: Simultaneous Authentication of Equals (SAE) (3)  (0x03 00).  So Auth Alg of 3?  Or am I referencing the wrong thing?
>>>>
>>>> Yes sorry SAE is 3, I was mixing up what the kernel's enum value for SAE is.
>>>>
>>>
>>> Still having issues with wifi certification around the PMKSA caching.
>>> After finally convincing the person at the wifi alliance support
>>> person where the spec didn't say PMKSA caching disabled needed to be
>>> in open mode I got this back:
>>>
>>> "Thank you for sharing the PMKSA_caching information from the IEEE
>>> Spec. It appears that it only describes the correct behavior of the
>>> DUT with PMKSA caching but does not provide any information about
>>> PMKSA caching for WPA3 SAE-H2E.
>>>
>>> However, according to Security R3 MRD v1.3 (May 2020), PMKSA Caching
>>> is mandatory for all devices, which means your device must have the
>>> PMKSA caching function. You can find more details in section 6.3.1,
>>> 'SAE Hash-to-Element,' of the Security R3 MRD v1.3.pdf document, which
>>> can be downloaded from the following link"
>>>
>>> Those lines are here:
>>> 6.3.1 SAE Hash-to-Element
>>> • Support for the SAE Hash-to-Element (H2E) technique defined in
>>> 802.11 REVmd D3.0, including support for Rejected Groups, and back
>>> compatibility with the SAE Hunting-and-Pecking technique
>>> ▪ H2E support is required for all mandatory and optional SAE-based
>>> WPA3 features that are supported by the device
>>> o Note: PMKSA Caching is mandatory for all devices; FT-SAE is optional
>>> • Support for BSS Membership Selector indication for H2E-only SAE, as
>>> defined in 802.11 REVmd D3.0
>>
>> Apparently WFA does require PMKSA for their own certification then. Not
>> sure why exactly they require this. Without PMKSA the device has to do a
>> full authentication when reassociationg so its not like its adding
>> security in any way, its more of a convenience for faster reassociations
>> (as I understand it at least). Its also WPA-Enterprise specific and many
>> consumer devices only support WPA-Personal, so its odd they'd require
>> this across the board. Maybe ask them this? (unless your device is
>> intended to support WPA-Enterprise). Maybe they can disregard that
>> requirement if the device is WPA-Personal only?
> 
> Yeah from what I can tell it is just to save time reassoicating.
> 
> We are just doing WPA-Personal (not just enterprise) but it looks like
> it for WPA3-Personal as well and not just WPA3-Enterprise

Its been a while since I looked at this and your right, both personal 
and enterprise can cache the PMK. Sorry for the confusion.

> 
> Here were the previous lines to that:
> 
> 6 Requirements
>   6.1 Prerequisites
>    6.1.1 Prerequisite certifications for WPA3-Personal or
> WPA3-Enterprise Certification are listed below:
>     • Certification of supported physical layers: Wi-Fi CERTIFIED a, b,
> g, n, ac or 6 (includes WPA2 Personal certification)
>       o Or any other PHY program once such becomes available.
>      • Protected Management Frames
>      • WPA2-Enterprise certification, for devices obtaining
> WPA3-Enterprise certification
>    6.1.2 Prerequisite certifications for Wi-Fi Enhanced Open are listed below:
>     • Certification of supported physical layers: Wi-Fi CERTIFIED a, b,
> g, n, ac or 6
>      o Or any other PHY program once such becomes available.
>     • Protected Management Frames
>   6.2 Out-of-the-Box Requirements
>     An AP and STA that implements Operating Channel Validation shall
> enable it out of box.
>     An AP and STA that implements Beacon Protection shall enable it out of box.
>     A STA that implements client privacy shall enable it out of box.
>   6.3 Mandatory Features
>    In addition to the original WPA3-Personal mandatory requirements,
> the following requirements are mandatory for the:
>     6.3.1 SAE Hash-to-Element
>      etc..
> 
>>
>>> • New MAC/PHY/Bands shall only support the SAE H2E method.
>>>
>>> I can provide a copy to the PDF if someone was interested.
>>>
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
>> I'm not sure about this. I know companies are definitely using IWD,
>> whether or not they are getting it certified for a consumer device is
>> another question.
> 
> Yeah I see a lot of companies don't go through the effort to get it
> certified, but it is a requirement for our projects.  We had
> previously done a similar product with wpa_supplicant.
> 
>>
>> I think, unfortunately (unless they change their requirements), your
>> stuck using wpa_supplicant at this time if WFA requires PMKSA.
>> Implementing PMKSA is on the IWD TODO but its not something that has
>> been a priority.
>>
>> I will say, now knowing the WFA requires it, I think its even more
>> valuable to implement as making IWD "certifiable" is only going to help
>> the project. If I can make time for it, or prioritize it, I will.
> 
> Understandable.  It would be nice if the WFA would be proactive and
> let the developers know instead of updating the spec and waiting for
> tests to fail...
> 
>>
>> Thanks,
>> James
>>
>>>
>>> Bryce
