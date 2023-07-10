Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9A134DD
	for <iwd@lists.linux.dev>; Mon, 10 Jul 2023 16:58:05 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1b449890ef5so3542696fac.1
        for <iwd@lists.linux.dev>; Mon, 10 Jul 2023 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689008284; x=1691600284;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hz+XXRKLaQJMcOYdCTEXlVBNWKQG1HHf5qPo6OxFwmo=;
        b=VXVRe9DW8YVvkmCp/WChoPNLW80oMdork8kAi5VasJmUuDXxM8ryE7B29FdlR2ZjyN
         cC0GB0thGLgiDXGUK2sEhPL1L+XW0nBwueadbM6xjH3Niqq3pczOqB+GcAZ8YPtimEfO
         QKLOVR98WvK93CxN3cAPMCSwgYWvZIyICeio3fpkV4TfrO3OgPtXsQ5W0Dh7tTIZvLva
         0w9RpSz0h54Q8fmB+3cYjIGUZAJ7+zBu8ZSIhL/LKEy5pSKCbVHNFSfENqcQA+PBfP+W
         lPOOiLHLFIZ8m4VtwKueuJAw7Rs+dHPWwG3PX3r6+C8NoGsggumaUM5oS3mPEmnfY75L
         ETGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008284; x=1691600284;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz+XXRKLaQJMcOYdCTEXlVBNWKQG1HHf5qPo6OxFwmo=;
        b=WY+Y+DP6/ETH2PbF6n1K/PNQBESa1NtQnOT/ued2kgChmaUjDTAISeo2e08L0ZBx7W
         4BaH0WSC06bwoTh3ljgzdWBkObH3kcMo4H+7pkYQeYxFwTYf5WbYf2f1o3tzBovnJZms
         J3c5wFsDI4sszGqWoRMsSJUp7dS+1zWic8Dm/B74e6I/hHCfsYk7mU4I2SWGP5sOaers
         jvlaA4J6FSP3AVCVCyA2FXZx6W/JcWIfx2mpR7JqmE9ra/1guzmTbv5Mq5JnryOD/bbP
         mqBdCYNK6+k7lnNfiP51gsAPJD/z4qz+HxWm+a4+KM+GjXgc5ZBaPmvtKBAeJ0if3xMX
         v/yg==
X-Gm-Message-State: ABy/qLYq4GE+5t9TPsWbLXCbtKF3dy4gbK4TXGLeI2KTIa4V0vbk/IF8
	oA32o6uBQVVkCvjKXyVIA3k=
X-Google-Smtp-Source: APBJJlGPhO5x6kao0WFQ530cSNIHJpkXkmvxvvZlp0vwj4ydzORluC2NgKgatJZGVbjdT4EUyIn1OA==
X-Received: by 2002:a05:6870:6494:b0:1b0:25b4:4b7f with SMTP id cz20-20020a056870649400b001b025b44b7fmr15494702oab.27.1689008284313;
        Mon, 10 Jul 2023 09:58:04 -0700 (PDT)
Received: from [192.168.254.40] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id dw16-20020a17090b095000b00260cce91d20sm177349pjb.33.2023.07.10.09.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 09:58:03 -0700 (PDT)
Message-ID: <f60b8582-a1c0-f8d0-abce-7f5813c3eb11@gmail.com>
Date: Mon, 10 Jul 2023 09:58:03 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 2/5] dbus: remove iwd.h dependency
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230630191812.2884637-1-prestwoj@gmail.com>
 <20230630191812.2884637-3-prestwoj@gmail.com>
 <c54f0b24-b359-e51b-b30b-2175348348d6@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c54f0b24-b359-e51b-b30b-2175348348d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 7/5/23 8:17 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 6/30/23 14:18, James Prestwood wrote:
>> Require a compile time flag to set the service
>> ---
>>   Makefile.am |  1 +
>>   src/dbus.c  | 33 ++++++++++++++++-----------------
>>   2 files changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 401d2ac5..2fb03aa9 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -268,6 +268,7 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h 
>> src/iwd.h src/missing.h \
>>   src_iwd_LDADD = $(ell_ldadd) -ldl
>>   src_iwd_DEPENDENCIES = $(ell_dependencies)
>> +src_iwd_CFLAGS = -DDBUS_SERVICE=\"net.connman.iwd\"
> 
> I'm not really a fan of doing it this way.
> 
>> @@ -38,99 +37,99 @@ static dbus_agent_shutdown_func_t agent_shutdown;
>>   struct l_dbus_message *dbus_error_busy(struct l_dbus_message *msg)
>>   {
>> -    return l_dbus_message_new_error(msg, IWD_SERVICE ".InProgress",
>> +    return l_dbus_message_new_error(msg, DBUS_SERVICE ".InProgress",
>>                       "Operation already in progress");
> 
> I wonder if we can add this to ell instead.  We have almost the same 
> code in oFono for example. And something very similar inside connman 
> src/error.c.
> 
> Perhaps we can simply pull the name from l_dbus_name_acquire?  Our apps 
> are unlikely to ever register more than a single service name on the 
> bus?  Other ideas?

Since ofono and maybe others have the same code I can add these in ELL 
and use the service name thats registered.

> 
> Regards,
> -Denis
