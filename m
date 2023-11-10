Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE518E09
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqXPuHmo"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7789aed0e46so131543385a.0
        for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699619317; x=1700224117; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8iRW+vrKznH2Z1GNVG/BT3cpou66CNPl/gxIC2sEIs=;
        b=HqXPuHmoBVaScjMfc+w3z8BsEdu4HU5S9dE2y0zbOUNSLpS9jq8mWrEPP+PPSV6R0f
         ZSjArYZpe0aNa7MQn41DHyNCgg7WcNzCathCV+IX0gmBVgKlYZ5J1cPDKtYVSfA91kTU
         9xQyO7cKQxJkhQTzlDLXC3eKiPORoS3ypYk4+pT8xTr9z3oeA+D57oVF2SkxCpZRYF/g
         8S+eqrpYTngqld02xkIXZILVpG2TrXzrscG/5uBguGiHDQB9ZREllBnzj+P/Nl0mB3hj
         TmtCoZ53QlA3nQGfSpYT1WdV11tQXetARvSSV3b4s2g/yh8CXFiQVF/ToLh4/6mnWNLU
         lQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699619317; x=1700224117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8iRW+vrKznH2Z1GNVG/BT3cpou66CNPl/gxIC2sEIs=;
        b=uomv27sobxao5HPWkVyNCSu2maW5ornaPdY89c2RaklJO7vHTwUZwkQ/bLhRJrgZ+q
         vhv4FMdJC3OzV1VjO/WV8wCpXW0Y1ZTQyLxKkdbOG01lHMUR5qhjiuM0/397awRNe3Ck
         PO2OJCvDezFtgLWwwvNIQZ9ilxXO8m5PdaXhKBtDufoAqhTU/pIgJ4UrRt+TBZDSkG5s
         xs+Mg9gXYOz/pnBBSUGRA0PE/kIz4yS7cZ38wKsbbNp4Bru/SPsp8ZpQ/08vZ2QIN2b9
         HVD6hnO10Ttq22LZpSxmY9PlGkYf8Z97jiDwmhHLsQ8ZSlG7/n5QAab3idVb87n/rpQ1
         H3nA==
X-Gm-Message-State: AOJu0YzAoF9G5R5CooiOEcBCHtYy7m4ilEoMIZRKCZsjGFeel4+y2ba0
	5Pb9I8zRhjc+pQHQm9DLsBJkppVkEGU=
X-Google-Smtp-Source: AGHT+IGP0g1yG/njNji6NTC9kBqQWikEPty5YBwdQwTlPsW7QGUXJ/YQNxDA7GU+XqXzPWC4GVpwIg==
X-Received: by 2002:a05:6214:1c48:b0:66d:140a:18f3 with SMTP id if8-20020a0562141c4800b0066d140a18f3mr8717089qvb.45.1699619316921;
        Fri, 10 Nov 2023 04:28:36 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ceac8000000b0066d32666a27sm2848958qvp.66.2023.11.10.04.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 04:28:36 -0800 (PST)
Message-ID: <f4eae46b-977a-435b-8798-0e59343c1e2d@gmail.com>
Date: Fri, 10 Nov 2023 04:28:32 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] client: add helper to call method via builder
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231109184926.52629-1-prestwoj@gmail.com>
 <20231109184926.52629-2-prestwoj@gmail.com>
 <8963c077-984f-474d-afec-5e02ef8182e3@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8963c077-984f-474d-afec-5e02ef8182e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/9/23 6:22 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 11/9/23 12:49, James Prestwood wrote:
>> There was no way to call a method with anything except basic
>> arguments. Add a helper to use a builder to create more complex
>> args.
>> ---
>>   client/dbus-proxy.c | 36 +++++++++++++++++++++++++++++++++++-
>>   client/dbus-proxy.h |  9 +++++++++
>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
>> index 42b8427f..de252427 100644
>> --- a/client/dbus-proxy.c
>> +++ b/client/dbus-proxy.c
>> @@ -2,7 +2,7 @@
>>    *
>>    *  Wireless daemon for Linux
>>    *
>> - *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
>> + *  Copyright (C) 2017-2023  Intel Corporation. All rights reserved.
> 
> Is this correct?

I'm generally terrible about updating the dates on the copyright and 
really never do it. Decided I'd try and do better this time :)

But I'm not actually sure how this works. Should there be multiple 
copyright notices if different companies touch existing files? or should 
we just leave the copyrights as-is if the file already exists.

> 
>>    *
>>    *  This library is free software; you can redistribute it and/or
>>    *  modify it under the terms of the GNU Lesser General Public
>> @@ -629,6 +629,40 @@ bool proxy_interface_method_call(const struct 
>> proxy_interface *proxy,
>>       return true;
>>   }
>> +struct l_dbus_message_builder *proxy_interface_new_builder(
>> +                const struct proxy_interface *proxy,
>> +                const char *name)
>> +{
>> +    struct l_dbus_message *call = l_dbus_message_new_method_call(dbus,
>> +                        IWD_SERVICE, proxy->path,
>> +                        proxy->type->interface, name);
>> +
>> +    return l_dbus_message_builder_new(call);
> 
> Do you really need this 2 line function for a single call site?

With knowledge that l_dbus_message_set_arguments can handle dictionaries 
I don't need this patch at all :)

> 
>> +}
>> +
>> +bool proxy_interface_method_call_from_builder(
>> +                    const struct proxy_interface *proxy,
>> +                    struct l_dbus_message_builder *builder,
>> +                    l_dbus_message_func_t callback)
>> +{
>> +    struct proxy_callback_data *callback_data;
>> +    struct l_dbus_message *call;
>> +
>> +    if (!proxy || !builder)
>> +        return false;
>> +
>> +    call = l_dbus_message_builder_finalize(builder);
>> +
>> +    callback_data = l_new(struct proxy_callback_data, 1);
>> +    callback_data->callback = callback;
>> +    callback_data->user_data = (void *) proxy;
>> +
>> +    l_dbus_send_with_reply(dbus, call, proxy_callback, callback_data,
>> +                                    l_free);
>> +
>> +    return true;
>> +}
>> +
>>   void *proxy_interface_get_data(const struct proxy_interface *proxy)
>>   {
>>       return proxy->data;
> 
> Regards,
> -Denis
> 
