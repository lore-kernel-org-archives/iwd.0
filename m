Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEEF2AD25
	for <iwd@lists.linux.dev>; Thu,  9 Jan 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434061; cv=none; b=RHm6I+5zjzPz+lSGqphv9d6A+xG4r7u5gQg19K8p3v7LO1grlEWsDaVzTIzsWa9LATLbY/P9H9DnErUMhVDGcoE62brLvSaZzlDNA3WgCevFnfTEL9aeqCJtfwKgFvEMmee6aVRkjPxiYkw85NpalEz2JGwcwUkC2Fxk07bX7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434061; c=relaxed/simple;
	bh=PQOS0SGZn5qsNENMVrGWxeLL6Niic8mPlixhzm1D3fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=jEEAWdcxlnVDdYpCoUkOZmMC+GmN4vG6UmY4xbWqCwe5ZAgAMnGv46A4CpWSRfOuSdfO1iAlHLD+8uKo0JjVjrlNESu/YPJYw+iblfgnzZ/GiPFJPwGKVoKuK3XVUfCHMS4xqCJ/w8hUApt1jUkVXqBOghql6jFUWu+WC7it28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSmaaB80; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSmaaB80"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d89a727a19so18070646d6.0
        for <iwd@lists.linux.dev>; Thu, 09 Jan 2025 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736434058; x=1737038858; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wgk7coEx9BkHmoTB9fLFi5RrWRH2pt8V2/w52HTu1ic=;
        b=KSmaaB80gJt2oyMubUA5dJ2TI+M0YsdjuxLg6hVVLebyx+zZaYK5W4vec7sMIwbFVR
         FDq4DOExT/sCEgsFFsceyoHle907drTBefvNIo8GH2hjJxNaOZL/QYdkdThHp0ujg3rf
         BzTiMEkSx/kg4HwbyNCs4qfEy+EPDkvBGHwsmImCD1m5y3irEriaTpP7FJSSvkGCy8lB
         tDqA0/oaU7u/z2Gt0z73+CyhY87BMenfNn9FffgXy7TC62VBg+xpJG+zWM5XYgcuL+FK
         N6EoWPnGn6kFAKkLy0chmIPAEzsnLW94hbEoWjNSt2bQFctd9t5IbTbiaL+ABosnmt3r
         jFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434058; x=1737038858;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgk7coEx9BkHmoTB9fLFi5RrWRH2pt8V2/w52HTu1ic=;
        b=cauuoRpjViQ04IaHKq7oSWISlypF2HU4Mp0zXeaj6W/edZvXioMvgvAz3TOHrqT/nR
         VKeraE67jCFf5u3jga+fr6kdEswVtb56dpgybi5N2dCPqVGGrukyu3qKPMxnwp6WEGl/
         tW5umpiF5sLkDw+G6ZhINFZlnWg8iBKq4e/IafgY92q6b7E2WAk/0C/pKoFoSgGJLIkt
         nSZO819BomImUVbrcg1ZzKJpAyVX2+PhoONhBbSs4eQBheiI1uPxixRUYazYzGdCm/T2
         2Jqd6aVW1FOeBLHMDwacSS1Xp1T1oM3JdBWsu9kK3+Jd+mzsZxkulQm5wF3aoGbPEcmY
         B1gg==
X-Forwarded-Encrypted: i=1; AJvYcCXXjoaz6uX8OFfa+ZJ+1zVfSF5ikNYTAKOcScsv/Lr0CWiLtpcyv547qZ5BABz++OWxBnM=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZSz43c5PjTN0cGD0ExON/cGwRC7IoskyeqVMoNwQB/8J4ni8s
	m6IRrE21FCJ2IgU+sRbEwpPCKmt8OFKFPIRgxoiFd99oIlay+NMe
X-Gm-Gg: ASbGnctY9OSoHwZDSk9WpqeGl1sfqAXQOfV5tVt6+y1UVNADNV1nMXgUtpDRi4pWkxr
	N1lxbRy3CfqE5l+ULR+patjfkbrobOMeYFmj3pO9UYXtXD4iquFtvNRyXsa+kyXtXk8bED9HCVP
	4ryrZ9CYQ3o26aT7+jTaMZce5hEHwxTlQ75MR2iW9pbDTDU5BOR3+AXfNYp1C3P3rjTDvw/egLd
	13svwnQxDVk6o67oPil1jUY/+luEtUODyp2b0+kLv6Lp/JBkU2QpIdbqHLu
X-Google-Smtp-Source: AGHT+IE8WqX9RraeCkTLh9+NsgKQAaYaUCzUekrrlV1mwj7GuuNNs40aF0lQEOF8o6T8iPgvy3Mmnw==
X-Received: by 2002:a05:6214:5783:b0:6d8:8a0b:db25 with SMTP id 6a1803df08f44-6dfa3b19357mr55639136d6.21.1736434058267;
        Thu, 09 Jan 2025 06:47:38 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd32b2be9esm179682566d6.34.2025.01.09.06.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 06:47:37 -0800 (PST)
Message-ID: <afa3df0a-ba58-4d5c-aaa6-2cd3015fad91@gmail.com>
Date: Thu, 9 Jan 2025 06:47:36 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support for multiple EAP methods in one config?
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350114FC7C034E2E52F199BAE132@LV8PR08MB9350.namprd08.prod.outlook.com>
 <fcd2ddec-e21c-4a4c-9d28-c9c8bce8e6d5@gmail.com>
 <LV8PR08MB93501EF78BD49426D4C39D18AE132@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <LV8PR08MB93501EF78BD49426D4C39D18AE132@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/9/25 6:40 AM, Michael John wrote:
> Hi James,
>
>> Hi Michael,
>> On 1/9/25 5:37 AM, Michael John wrote:
>>> Hello,
>>>
>>> I'm looking to see if IWD supports the ability to support multiple EAP method, like what can be done in wpa_supplicant.
>> At the moment no, there is no way to configure this.
>>> network={
>>>       ssid="example"
>>>       key_mgmt=WPA-EAP
>>>       eap=TTLS PEAP
>>>       identity="username"
>>>       password="password"
>>>       # Try basically every common inner method
>>>       phase2="autheap=MSCHAPV2 autheap=MD5 autheap=GTC autheap=OTP autheap=TLS auth=MSCHAPV2 auth=MSCHAP auth=PAP auth=CHAP auth=GTC"
>>> }
>>>
>>> My use case is that I'm given a username and password for a network but don't know the outer or inner protocols (or even if its personal or enterprise but I can determine that from the broadcast beacon).
>> So does the network actually support multiple inner methods? or is this
>> just more of a "debugging" feature to determine which (single) method it
>> supports. I'd be interested in the motivation for a feature like this.
>> Is it:
>>
>>    - There are _real_ networks that exist which support multiple EAP
>> methods, or...
>>
>>    - Your network administrators are not providing their clients with
>> enough information.
>>
> I don't have enough information. The product I'm working on would go into medical offices and could be connected by a range of users and the username and password is all the information that is provided. So the user connecting the product will likely not know anything further about the network configuration.
>
> I can determine PSK and Enterprise via the beacon, yes. For Enterprise with wpa_supplicant it allows multiple outer and inner methods to be supported. My understanding is the client sends the EAP-Request to the AP and then the AP proposes the EAP method to use and the client can decide to accept or reject the method, and when defining the multi 'eap' methods in wpa_supplicant you're defining which methods to accept. Allowing the configuration to work with multiple methods and not requiring the user from needing to know this information.

Ok, kinda makes sense, but at the same time even wpa_supplicant's 
support is going to be fragile at best. Yes there are similarities 
between EAP methods, but also there are differences which a single 
profile can't possibly account for. Your example above allowing 
TTLS/PEAP might work (both are tunneled) but e.g. TLS and PEAP aren't 
going to take the same configuration values. Let alone stuff like PWD 
which is completely user/password based... I'll have to think if there 
is a way to support this in a sane way. Maybe Denis has some input as well.

Thanks,

James

>
>> I do know its possible to configure/allow multiple EAP methods with
>> hostapd at least, so it is _possible_ that networks like this exist. I'm
>> more just curious if its done ever in practice, and if so I guess that's
>> something IWD might want to support.
>>
>> Also, you should be able to determine at least if its PSK or enterprise
>> based on the AKM in the beacon. And IWD will also print this in the
>> debug logs when it scans.
>>
>> Thanks,
>>
>> James
>>
>>
>>> Thanks,
>>>
>>> Michael John
>>> Midmark Corporation
>>>
> Thanks,
> Michael
>
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
