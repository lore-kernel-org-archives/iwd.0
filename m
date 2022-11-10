Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643D382
	for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 18:31:09 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id q186so2680464oia.9
        for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwIZdD+LKB6t4VL09YNcuJcPBOUzxcQfgO/4Q1d5euE=;
        b=kSqX4/9pJl4sm+U5myNzNw7nmctHC3WLVwEyQCktmaUtNC9o4ahz7EjtC4kQz8lV5u
         IGQFUplMa3eILsL41VCw3gh8VcnnX2q3fqMdZ/0l2kBavbZvxeJtBloVmTR15cLvvrzT
         q0UpCKBSxMgWIx4PhOb2O84nDFz3zG7JzZmiejxHyxiXCeinV+FJfEBi0OuGZCwQX7l4
         yvj578GmoeK2LrVD9M7FUl5i2q+bj5qW7CTtPyokF/bg7801PHz0wCTQ1uen3nnr/qF0
         88Z5bVxJ7hB75C2032bSlVIBLSTIP0l362XI9VPBx2k+VbRNZmPd5m+zCFfeu96QraUF
         14fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwIZdD+LKB6t4VL09YNcuJcPBOUzxcQfgO/4Q1d5euE=;
        b=aDeJnWaXOX4+f/3FqS4VWc4eIrTHs6XRHTErt/fflB16F9mSMuwwr8g5vwOgXmlO7Q
         vn+2AE4XcUMbBOw4PrOVgWpylmtW57CQQVWhT1d7znmPV9j53Hgv5S1+JRL9pP/0Sh+7
         3dZewvAJxVBJXzL5IaoNZHJGaPTThEP95sGwNpjK6MbGJ8eOozbbpyaGTXuc1b3iME1m
         xZNlR/HWwIsUed7KMovbcW7R84EQYMnkyYSfYeK6d86y8H0D3JdkAFfzQduQcuFjNDtF
         yEhsCXkk9eBNWNTVC3Ugx6bmGSjE5oyX4BBOxjQtOVmpX6JkIfg+0M6V/PKnr2OmMiGy
         AfVA==
X-Gm-Message-State: ACrzQf33eKro6HhxrEeW694KvJ1WDR26xMIFDk39OEa5VRXoNyXfpfXZ
	2dB13fKXW68Akz7dPwjp9cg=
X-Google-Smtp-Source: AMsMyM75bnM8vd7yFpE8yzaUysY4Y0/rzRFWofog/4C+SysVQKdCKI15838sRltX9uLsQFgPdUVFeQ==
X-Received: by 2002:aca:b957:0:b0:354:91e8:6983 with SMTP id j84-20020acab957000000b0035491e86983mr1776742oif.144.1668105068124;
        Thu, 10 Nov 2022 10:31:08 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s14-20020a4ac80e000000b0049eb2793516sm36989ooq.44.2022.11.10.10.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:31:07 -0800 (PST)
Message-ID: <b5873dac-88c7-875d-9388-35d2c8359b68@gmail.com>
Date: Thu, 10 Nov 2022 12:31:06 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] eap-tls: Add session caching
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: iwd@lists.linux.dev
References: <20221109170438.535300-1-andrew.zaborowski@intel.com>
 <20221109170438.535300-2-andrew.zaborowski@intel.com>
 <e7035cb1-17d0-22e5-3bfa-4e6515e2b4c9@gmail.com>
 <CAOq732Lhjow_iZyNHs9bn+j9q_yHsZDP7qX37pgWrzsUs+y=AA@mail.gmail.com>
 <7931ee49-c4fe-51b2-81c0-afc473c19fda@gmail.com>
 <CAOq732+gHv3qJfP7=fve0LN1VgH87S7qEyu2Q=NwfYFZggN-ZA@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOq732+gHv3qJfP7=fve0LN1VgH87S7qEyu2Q=NwfYFZggN-ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

<snip>

>> So if we index by
>>          a) SSID -> there's a good chance that we can reuse the session across routers,
>> even if that fails in some cases
>>          b) SSID + BSS -> We never try the session ID unless we have been connected to
>> the same BSS before.  In which case there's no advantage over PMK caching?
> 
> The flipside of this is:
>     a) SSID -> since we only store one session so everytime we switch
> BSSes we overwrite the cached session in the co-located AA case and
> rarely see the benefit of the cache.
>     b) BSSID -> we store one session for each BSS and after some number
> of reconnects every next one is going to be fast.
> 

So for case b, I would argue PMK caching would be even better since we skip 
8021x completely.  As I mentioned earlier, I would think that RADIUS server is 
the 'general' case and we should optimize for that.  Maybe I'm wrong here, but 
I've never seen a colocated option in any commercial APs.  It is always a RADIUS 
server.

> That said the RFC-recommended session lifetime being only 24h makes
> this less practical.  Since we can't know how long each server's
> session lifetime is I wonder if IWD should set it to a higher value in
> case we're lucky.

I'd just default to what the RFC recommends, but maybe we can add something to 
the profile to make this configurable.

<snip>

>> I would think we need to explicitly drop anything related to the SSID of the
>> network we just removed via KnownNetworks.Forget()
> 
> Ok.  I don't believe we do this for known frequencies though.
> 

I think we do?  See known_networks_remove()

<snip>

>>
>> Yes, but how does eap remove the relevant entries from the cache?
> 
> If we want to do this I'll probably move the cache singleton to
> knownnetworks.c and drop the relevant group and not notify eap.
> eap-tls-common.c would use something like
> known_networks_get_tls_session_cache().

That might be the way to go then.

Regards,
-Denis
