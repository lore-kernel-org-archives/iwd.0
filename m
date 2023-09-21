Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4820E7
	for <iwd@lists.linux.dev>; Thu, 21 Sep 2023 14:50:07 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d8162698f0dso1329819276.0
        for <iwd@lists.linux.dev>; Thu, 21 Sep 2023 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695307807; x=1695912607; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfv00mJfy+D4FNilbzqZ9MTp817LNFafVFym4Ghg+xY=;
        b=ZzawjliA7OvinlKga6fldt0ulH0UvO7M4Bff2v+SzABGTr7RskOyEw5lEDwOzLHE8o
         lp00bLHm2AZx+pBwgBXHmyTyk39aloDlqv+9LezR2BDXAwrb65vktOGuFON71v3INytf
         LibkEKO+2dbXmjwNmuGeYj966lgCeuVhb69HifOyzOXkCGjjN6EIE8WhpFEPcQJOQPjD
         /zwYMbdyaZRFCkcMC8551v17IaKE/ChqFy5V+hxlQJA/oFvtc6c0811/MZP68l1kd2ly
         kR/272HKBVCdpT6g58e5NimiVbH97+Trpd80rOpsCI/xDUuB1GC8xLqNakfLS4IlLe/O
         uoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695307807; x=1695912607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfv00mJfy+D4FNilbzqZ9MTp817LNFafVFym4Ghg+xY=;
        b=AZQhsBYNeNqKHrUpaPyAtdYoh3AA+BHG2eEpg2L+bDG9SW6D7ctSvmw2XFLrXmfi+z
         Nye/c9OFQ1gClZhV+vJGUBlGwlGqs3spwISSpF3FwM0weswojO2Nbfnz1l7ltkgngWQa
         63iOmPZHoa4erclLtSK8We1L490JaVaBB2p9RIzfvtQCyAFhUuNdzG34WV2UrEVjWG3H
         7O9p2yXSeybkjsRJzGNgrb6FdQde0dsJtNlyMyNYhHxSMhYJW1KNky1tH5iTzQQPTK3g
         dJCuWz+dG2OeNuoHA0oEGgaiKvutnfb/58e9GlPvT0nGLjQqYnlF/pls8j5074ZpamY5
         5HVw==
X-Gm-Message-State: AOJu0YyTU355d2SAr6hBeT1HHw2PeoO4QG52wg+/eDSZ7NZ1AcMkjwab
	m6mX55eqORjOaFBxBOid4Sc6twq9j2o=
X-Google-Smtp-Source: AGHT+IEBmnJg0KAOlvcgI3Zu9FqEtvQlZMGAbUuh5WvZ0i+Wge2plYUCfi+9V39hQwY/NKqKVnBvRw==
X-Received: by 2002:a25:cf01:0:b0:d78:6f1:41b4 with SMTP id f1-20020a25cf01000000b00d7806f141b4mr6045075ybg.30.1695307806705;
        Thu, 21 Sep 2023 07:50:06 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id h13-20020a056902008d00b00d7497467d36sm350828ybs.45.2023.09.21.07.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:50:05 -0700 (PDT)
Message-ID: <0aae89f9-0ca6-4748-9e69-b0413a15e90c@gmail.com>
Date: Thu, 21 Sep 2023 07:50:02 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force use of 5GHz band
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: =?UTF-8?Q?Jonas_Gro=C3=9Fe_Sundrup?= <cherti-iwd@letopolis.de>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 =?UTF-8?Q?Pedro_Andr=C3=A9?= <PEDA@bang-olufsen.dk>
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <cmbwlnlbewbuiu4ricqyl3txilk6ybvvmoqyu3ljmui6imuzjw@rs2ug3nxl37w>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <cmbwlnlbewbuiu4ricqyl3txilk6ybvvmoqyu3ljmui6imuzjw@rs2ug3nxl37w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 9/21/23 7:21 AM, Alvin Šipraga wrote:
> On Thu, Sep 14, 2023 at 11:06:18AM -0700, James Prestwood wrote:
>> Hi Jonas,
>>
>> On 9/14/23 10:44 AM, Jonas Große Sundrup wrote:
>>> Hi,
>>>
>>> is there a way to force iwd to use the 5GHz flavor of a specific wifi?
>>> I am aware of BandModifier5GHz, but even with setting this to 1000 I
>>> still end up on the 2.5GHz band. That band specifically, however, is
>>> unfortunately suspect for some stability issues I'm facing and hence I
>>> would like to force iwd onto the 5GHz band to see if the problems still
>>> occur. That proves to be difficult, of course, if iwd is picking the
>>> 2.5GHz band…
>>>
>>> Even though I do see that iwd probably has the better insight into band
>>> stability from a signal-strength point of view, any chance of
>>> overruling iwd's internal mechanisms here? (Or should I just crank up
>>> BandModifier5GHz by a couple of magnitudes?)
>>
>> All we have now is BandModifier5GHz which is multiplied by the computed
>> rank. The stock rank is based mainly on a data rate computation which is
>> theoretical, but uses capabilities and signal strength to estimate.
>>
>> 1000 is pretty high, so essentially your 2.4GHz BSS's would need to have a
>> rank 1000x larger than the 5Ghz ones. So either 5ghz is incredibly low
>> signal, doesn't support HT/VHT, or maybe the IEs are malformed so the data
>> rate isn't being computed correctly e.g. (defaulting to basic rates).
> 
> We had a request at the company to disable 2.4 GHz entirely as well, but I did
> not want to completely disable it as some customers may not even have 5 GHz
> infrastructure. My colleague Pedro drafted a patch which allows for the internal
> BSS ranking to be normalized according to a required bitrate, so that 5 GHz
> networks do not always out-compete 2.4 GHz networks. We found this worked well
> together with the BandModifier option.

Effectively yes this would work, though its not a guarantee to disable 
2.4 (although the option isn't named as such so its not deceiving anyone).

I personally don't take issue to adding such an option, but FWIW I'm 
currently working on a way to explicitly disable a band entirely. This 
is more complicated due to IWD's scanning logic but its better in that 
it prevents IWD from scanning on those bands as well as connecting.

Thanks,
James

> 
> I have asked him to send the patch to the list, so please take a look. Might be
> something of interest for upstream.
> 
> Kind regards,
> Alvin
