Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3821F80A0
	for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019641; cv=none; b=U5o3YDWuhHlz21TueAQBLoMDmKFg7NPMr1e5eAyKS6jMVO1N7O/PmRSGH1O0xI37bRdD+ancLkgsrE90c6AEXYY5+xqncEVDglCaBi7iMecCI/olx2QXEYcS9cw66AZ8rLEbk7GtZNZ5xQay+mmNwgpoipu76eHfm8O+US+7eHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019641; c=relaxed/simple;
	bh=q1aESocUIof2C/PT/VYSr/6GNyK0zTOId+R9aJJfV8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUIJJh6VRZ7buPFPehQMr4NBXAlIRY6kQfrOxRunMlrixwvcG8wr8fRCyBupTTGosmld30MyhWLMKi6J1sPEZvQKdbhwciIc00q+Elr6iPEHMefFTPkXrGGu0eJuCWuFcdgYqgvz3NvuLZ0p5jLUUapdlf1f23VLvQciACX5ZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=egp8JmX3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="egp8JmX3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so2745272a12.1
        for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729019637; x=1729624437; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3sIa4qUjo1z4drdgMIYoWAQwoHhjr/VTu+dY9TT7OmE=;
        b=egp8JmX3rNXzygw8MF7rlWI/sSD+kxF9ccqr8tiZ8s105c00s6uZFJ3RWv8mXmz3lh
         eV1oBHIKu+RDzBndlGzCwBG15xFnXuXMDD9o5g9mIrTm+mQKddbspsRz/GaqejBv6lSf
         pzDui8jr9thebF8tmwZ4cQHcZ3KnQaoNtlWnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019637; x=1729624437;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sIa4qUjo1z4drdgMIYoWAQwoHhjr/VTu+dY9TT7OmE=;
        b=he7y775IfYvoavngXXYexHzWD/WHy++37YZFNfjieAgzvUgoENUezLjC8sRIg3a+5R
         Ff+5oPOPfYr1Ekm9d6dUf3VkKmB4ZebNQ1F3/umC/aQoYgJ8luF6Vqb8Rf2oST/FiTl4
         wXZy0vHiIZb4+gL29oSm5oIyCCJO5kfkqHt/fuKGcutXNbRaTj5nMgl6RPXJFK1wZ49n
         FqZQgDXb3ziOYGVd4r8ib6HYMJJoxtuX9uOzc9B8zdyWcVQI+1GoooUbj1Azht7qTBH7
         g8FacRDYIbrBYJpOG+BaGTTWIO3LLTmP9rRUJIAtBQq96LQZvjY03gkkH/Ea+Q0v5j8y
         nI6Q==
X-Gm-Message-State: AOJu0Yw/2lA94aG/vZ9xWFDgz4wOhCvMCezfwHjfJAxrmSYw6MP9N/hZ
	JLfavC33SDVrxBosWsE5zAuwMZQ4ufvxlKKRuYg1sHZB5NGqfaH9Kcb1NBwWHQ==
X-Google-Smtp-Source: AGHT+IGIbpoA2H5MfOTDW3HnpRRMWw6WuJutLZAttmHM8dMlEu2tKeRP2Um0e0+qfFN0hA84onbYmw==
X-Received: by 2002:a17:907:f155:b0:a99:43e5:ac37 with SMTP id a640c23a62f3a-a9a34cb6364mr111438366b.15.1729019637068;
        Tue, 15 Oct 2024 12:13:57 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2988c560sm101860666b.193.2024.10.15.12.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 12:13:56 -0700 (PDT)
Message-ID: <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
Date: Tue, 15 Oct 2024 21:13:53 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/2024 5:17 PM, Denis Kenzior wrote:
> Hi Martin,
> 
>>
>> I think the regulatory domain issue is fixed. It seems that 99 is 
>> correct (because it is handled in firmware). We see far better signal 
>> and data rates at a site where we had problems. It seems the general 
>> setup is far better now for simple setups. We removed the 
>> configuration from device tree and then it may have used the 
>> configuration from brcmfmac4339-sdio.txt (device tree stuff was 
>> something the SOM vendor added for some reason).
> 
> Sounds like you're getting somewhere.

The firmware pretty much has its own regulatory rules or they are 
provided separately through the CLM blob. The fact that you can use any 
channels without the CLM blob indicates the firmware indeed has 
regulatory rules in place. If the SOM vendor did not provide one my 
guess is that the in-firmware rules are sufficient for this wifi module. 
In firmware the rules in use are determined by {country_code,revision} 
but the kernel only uses country_code. Hence brcmfmac supports 
configuration of a mapping between those. This may be done through the 
device tree (see brcm,ccode-map and brcm,ccode-map-trivial in [1]).

>>
>> However, I have now already seen at one of our testing sites, that it 
>> connected to the router instead of the repeater (which is far closer 
>> and has far far better signal: -67 vs. -29 dBm). It also did not 
>> switch to the repeater after
> 
> You may have to revise your expectations here.  Most implementations do 
> not trigger roaming unless signal quality reaches a certain threshold.  
> This includes many of the firmware roaming implementations I've seen.
> 
> For iwd this threshold is -70 dbm on 2.4G and -76 dbm on 5/6G by 
> default. Parking at the AP with good signal (-67 is good) is just fine 
> and I see nothing inherently wrong here.  And remember, the firmware is 
> responsible for roaming in the case of brcmfmac.
> 
> One may question why -67 AP was preferred over -29 one?  We'd need logs 
> to answer that question.  It could be the -29 one was simply not seen in 
> the scan results at the time of the initial scan / connection.

The roaming algorithm is not that intuitive. Roaming and rate selection 
are not based on signal strength alone. They may look at PER (packet 
error ratio) to decide. -29 dBm might actually be too strong. I always 
try to get between -40 and -60 dBm.

The nl80211 API actually offer the possibility to affect the BSS 
selection. The NL80211_CMD_CONNECT command can have the attribute 
NL80211_ATTR_BSS_SELECT for that [2]. When not provided the firmware 
will obviously use its default behavior whatever that is. Not sure if 
IWD or wpa_supplicant support this, but I am fairly sure brcmfmac 
supports it. However I do not know if it also applies to roaming.

>> several hours (both FritzBox - so consumer grade and we don't know the 
>> exact configuration). After a reboot, it connected to the repeater and 
>> until now it 
> 
> So that's... good?
> 
>> remains there. I will switch to more complex roaming environment, 
>> however, this is more sensitive because it is at a clients site. This 
>> first impression gave me not much confidence...
>>
>> What do you think about the idea to disable roaming in the firmware / 
>> driver? (if I understand Arend right, this is setting "roam_off" in 
>> brcmfmac4339-sdio.txt)
> 
> You can certainly give it a try.  It is not something we have tested 
> explicitly, but it should (mostly?) work.  However, note that trying to 
> make a FullMAC card roam from userspace in such a manner is inherently 
> limited.  iwd cannot utilize advanced roaming features such as FT with 
> such a setup (I can get into the technical details if you care).  Having 
> said that, roaming behavior is a frequent complaint for many fullmac 
> implementations.

AFAIK it is a module parameter.

>>
>> Will IWD smoothly take over the roaming? How can I check who is 
>> handling the roaming?
> 
> iwd looks at the NL80211_ATTR_ROAM_SUPPORT flag.  If such a flag is 
> reported by the wifi driver, iwd will let the firmware handle roaming.  
> Otherwise it will try to handle roaming itself with the (rather limited 
> in the case of fullmac) tools that it has access to.  Taking a peek at 
> the brcmfmac driver, looks like it is doing the right thing in setting/ 
> not setting this flag based on the "roam_off" parameter.

*phew* ;-)

Regards,
Arend

[1] 
https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
[2] 
https://elixir.bootlin.com/linux/v6.11.3/source/include/uapi/linux/nl80211.h#L2443
