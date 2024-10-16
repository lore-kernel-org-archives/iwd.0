Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA91F80DC
	for <iwd@lists.linux.dev>; Wed, 16 Oct 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067570; cv=none; b=M3TRhdY+SUmtTuAEZlmEyd1WVDUrnHCy7oSuKV+WYWUX7IC3tPkN+aklULXP5pU8TVtbrf+z6D/P/kij6YrN1pABzqCO+oucAEtd6A9Sly52IIkww0N07pL/HqWLEpqCtH29NXu7y9qOj9VbPgsrLeeHFAFis0al4YX+JvpqmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067570; c=relaxed/simple;
	bh=BfhCCS9MZtLXY9WAxXfuQNjpujKRZuZFGXBKwIGjYbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W95RBKsx7ts66Oxh8DeYDiP3nHovU4VR/mxG0y/cy2A1ns64RQXnkDx3uvV4oNDjXdatFG/KlWpIGsukhcKSn3y2jv/D84rn1rFPeyfolI8PMSgzzug/Nh/HuJ1baWWoIQ+mJ9axIzSUh0FimTVofNVbC/4OZI1sabloxNNu4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h2RSGdbO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h2RSGdbO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4603f47b2c8so64173161cf.1
        for <iwd@lists.linux.dev>; Wed, 16 Oct 2024 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729067567; x=1729672367; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mgefh34p5lvQPb0D9yYOYV8BzNaMFft4MkjmGqtU3Po=;
        b=h2RSGdbOFlPfONzyYbcAxfzq5+2gzirvxbl1bLpZR9A9dYakkh20qnl6liwCnEruqQ
         qdANhDSiwATUB3IM4CHVUaOp10pYQSSJzY6PaxKBe7345Y4Woc0q/4DXG5LkTGdg/zrt
         Ze3fhRpKDOF2utWZSgu7rEHfcKDrkJ/36fyfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067567; x=1729672367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgefh34p5lvQPb0D9yYOYV8BzNaMFft4MkjmGqtU3Po=;
        b=HH4yrliXoFbSDsa9IE6U6j/1P35prTTk01FV0irPXJeOivEO/5KB19KyDQ1vzGqQyy
         cn0hJ37+nRYR64CaiuBt2rSl1wTOelg6qf0CLcwEo6iSiAjEVyrgQOTZ+rgxOjzRq/mU
         nF0gNulMYDvBnaPApCVCGyuz9RGyzEkF81nCAheTiFqkj9aXaKScyKyD2ZVNEb+5KQFI
         qO+Im8cIBhtw3sNI6fS6552jqS2CdtwhoDwkZrinL2vewqTovLWHasR7cAa98zg6xv2B
         TBh30JCRb6FmFvLTF0dHEvSgo9sGOV9qr9YvlC683eHtwTq3a1U3YyR9R4Cydi4YZUVT
         ckpQ==
X-Gm-Message-State: AOJu0YxxGWjg8QKD9teaugG4ffF4SdT9eFfEky6t934cxUkzS6cmYqLJ
	N53W5kpQiz9uWMrLCC2/Nxbtiv4qPi2CRN1khaIFdEDfqGMkp1gfaePjvqCYvg==
X-Google-Smtp-Source: AGHT+IEXIiVGW8VoIJtf+rO1s547bDDcLfpN79J3/4xHWhAzQZBNUoUN0rD6Z6i9nxZOXw8s8SsdGQ==
X-Received: by 2002:a05:622a:1a87:b0:456:7fb5:1bdb with SMTP id d75a77b69052e-46089f6544fmr54489641cf.0.1729067567310;
        Wed, 16 Oct 2024 01:32:47 -0700 (PDT)
Received: from [192.168.178.55] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e1564sm14538611cf.29.2024.10.16.01.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:32:45 -0700 (PDT)
Message-ID: <6b9d7715-4e2c-444e-91fe-2820fd33c41c@broadcom.com>
Date: Wed, 16 Oct 2024 10:32:39 +0200
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
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/16/2024 4:04 AM, Denis Kenzior wrote:
> Hi Arend,
> 
>>>
>>> One may question why -67 AP was preferred over -29 one?  We'd need 
>>> logs to answer that question.  It could be the -29 one was simply not 
>>> seen in the scan results at the time of the initial scan / connection.
>>
>> The roaming algorithm is not that intuitive. Roaming and rate 
>> selection are not based on signal strength alone. They may look at PER 
>> (packet error ratio) to decide. -29 dBm might actually be too strong. 
>> I always try to get between -40 and -60 dBm.
> 
> I was mostly thinking of the initial BSS selection which iwd can 
> influence at initial CMD_CONNECT.  iwd sorts APs according to highest 
> expected throughput, but that generally means that if 2 APs are 
> identical, the one with better RSSI wins.  Still, without logs there's 
> no way of knowing why the lower rssi one was picked.

Right. The firmware is probably release version so it will only have 
error prints and that kinda details are not showing. If brcmfmac is 
compiled with CONFIG_BRCMDBG you can enable firmware console logging 
(FWCON) with the 'debug' module parameter [1].

> I'm curious: what are the downsides to using RSSI above -40 dBm?

ear damage ;-) Not entirely joking though. Too strong signal can affect 
reception as well. However, I am not sure at what level those issues 
would show. So my -40 dBm is not backed by technical data. Maybe my 
co-workers doing phy stuff have a better explanation.

>>
>> The nl80211 API actually offer the possibility to affect the BSS 
>> selection. The NL80211_CMD_CONNECT command can have the attribute 
>> NL80211_ATTR_BSS_SELECT for that [2]. When not provided the firmware 
>> will obviously use its default behavior whatever that is. Not sure if 
>> IWD or wpa_supplicant support this, but I am fairly sure brcmfmac 
>> supports it. However I do not know if it also applies to roaming.
> 
> iwd does not.  Doesn't look like wpa_s does either.

Should have done that when I added the nl80211 api change ;-)

Regards,
Arend

[1] 
https://elixir.bootlin.com/linux/v6.11.3/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
