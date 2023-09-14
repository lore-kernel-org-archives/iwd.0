Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445B18E1B
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 18:16:14 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3aa1446066aso746905b6e.1
        for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715373; x=1695320173; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/JYeIHk1ZmKUS9q8WLa/9/mK+L0EjAJBGpE0hougw4=;
        b=sy7GdK2TJ5Ejsj7QWylS2KVqKNXc27ka9k8OuDoYcMNdX1OtRz4l6J5L8s++mRJSJY
         nnMAjpzAuaYa53TzJNGo0QbRvbmrpK6IkL2YDdNRRjtnwFx4icicHP1KTkwHyqgps58a
         92MiFDX9X2g6p6qKRiOIrLAGrkll1c7KeLf0GBW3NSQdYjbE880yTUGw+GeBbSLsLMVU
         Br2jcLikX+29xBvFy0rjzXieZnVA6yVuKfe5ECRzDL664UglSBoNCby9DHjUeUtCBtEZ
         XF0GayeLOv+5Cx9EMjqlpFnCVBwfxcqbEOWTHFjzySJQvn6FRIi9bVtx0V+vESYUvNR7
         DE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715373; x=1695320173;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/JYeIHk1ZmKUS9q8WLa/9/mK+L0EjAJBGpE0hougw4=;
        b=No9yCos0NLwr1h+9vRDxn7WiCWYOXJI3EbGKqgoP5vnTUGrrBibIH51aiFIFNwIJvM
         yXW4elSWEh3ObIkOB0Mx3bAJNbtRmNpfhmof7zrWN8iL1M++jBD3QJGbhWPPNxw9t/bZ
         2rNdeM3Knie6VPT9nh0FAq//na5akt0RRFcdATAYrpGYUwYh55kIDg+IHN8JCmgrsvew
         aSgsCgLg/WFpF2funKsWS/GdyWg5rDn8TuD+pf55IPnEXa7VI5FlUbdXD5Pe6iQecTpi
         dcDwBJAT8sPYzvRdnnpW/LqSw3XVEemTrNi4UgehgjwkLaOK99iYZ+E6k+K/43dexTMk
         8HnA==
X-Gm-Message-State: AOJu0Yxzc7QVqeuJOPW+uQ9L10Ups+lkDC+NAnlYB5Vkkr6TdVx+ML46
	K7cc845wgk/nBhONPn6q887Cf4+a1kI=
X-Google-Smtp-Source: AGHT+IE2H6AMjqP99YpYk3BNyVViiq9uO5scd/Mv17JkPAu6x8J0U5eWQfk6rShA8zFNGG9Mw5mIsQ==
X-Received: by 2002:aca:901:0:b0:3a9:ba39:6d6a with SMTP id 1-20020aca0901000000b003a9ba396d6amr6206834oij.21.1694715373504;
        Thu, 14 Sep 2023 11:16:13 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id u35-20020a25ab26000000b00d71c764379fsm448528ybi.55.2023.09.14.11.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:16:13 -0700 (PDT)
Message-ID: <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
Date: Thu, 14 Sep 2023 11:16:11 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: =?UTF-8?Q?Jonas_Gro=C3=9Fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/14/23 11:13 AM, Jonas Große Sundrup wrote:
> Not right now, but if you give me a command that'd spit out what you
> want to see, I'll get them.
> 
> Just iwd -d and then trigger a scan in iwctl?

Yep that would do it.

> 
> On Thu, 2023-09-14 at 11:06 -0700, James Prestwood wrote:
>> Hi Jonas,
>>
>> On 9/14/23 10:44 AM, Jonas Große Sundrup wrote:
>>> Hi,
>>>
>>> is there a way to force iwd to use the 5GHz flavor of a specific
>>> wifi?
>>> I am aware of BandModifier5GHz, but even with setting this to 1000
>>> I
>>> still end up on the 2.5GHz band. That band specifically, however,
>>> is
>>> unfortunately suspect for some stability issues I'm facing and
>>> hence I
>>> would like to force iwd onto the 5GHz band to see if the problems
>>> still
>>> occur. That proves to be difficult, of course, if iwd is picking
>>> the
>>> 2.5GHz band…
>>>
>>> Even though I do see that iwd probably has the better insight into
>>> band
>>> stability from a signal-strength point of view, any chance of
>>> overruling iwd's internal mechanisms here? (Or should I just crank
>>> up
>>> BandModifier5GHz by a couple of magnitudes?)
>>
>> All we have now is BandModifier5GHz which is multiplied by the
>> computed
>> rank. The stock rank is based mainly on a data rate computation which
>> is
>> theoretical, but uses capabilities and signal strength to estimate.
>>
>> 1000 is pretty high, so essentially your 2.4GHz BSS's would need to
>> have
>> a rank 1000x larger than the 5Ghz ones. So either 5ghz is incredibly
>> low
>> signal, doesn't support HT/VHT, or maybe the IEs are malformed so the
>> data rate isn't being computed correctly e.g. (defaulting to basic
>> rates).
>>
>> Do you have debug logs of the scan results?
>>
>>>
>>>
>>> Thanks,
>>> Jonas
>>>
> 
