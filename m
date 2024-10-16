Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D114BA45
	for <iwd@lists.linux.dev>; Wed, 16 Oct 2024 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044295; cv=none; b=L37d83HyfY2egfeuokX7DsB2BFEAhTXFHBSebssxynwNKXZfr3onlcTKslSXOp/UDrKkYZlLRUNo/20oJDYLcgp4G242b2yzjbacFR0yh/ZvbLCOrTrmIRU3wUn+p3vV6RykiDh5qMHXlbnc8W7Ely3FN1xwn20qKP+hTNRDPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044295; c=relaxed/simple;
	bh=5S9OnbOv5+9m/qJomlpIgLC2V061d43RKcD4PBmyJuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDY0XnXMqj9EScWht9cOXBvGuKV6hG+n5eyuIYC1SNmGkLPLLk7mzDN5THXCn9AYikfcuXwRnaPp6Br4XkN/kJ168pWsyyCTP6aU+fTeuToDau7zIRJZHSH7Z6UQI1QpAQ5cFyBtwLXi7Sz1iMVgjga4WSwCx1kctIV9pvzji4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+L9RtoO; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+L9RtoO"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-716a950a886so219566a34.0
        for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 19:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729044293; x=1729649093; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yrxiwIOIoStDkiXnb7ZGf3UEroF7sy07UVkjBRQwTQ=;
        b=D+L9RtoOCvW8Sb2hGu1vWGJ9hz1lCvAp13fw7pLNBZKEOkVhZI9UyhKMKqWbifXVh3
         5QqN1katCv6iSyPxVvfw2FnvPf/I5mM3TJ0cPBF4IbUl2bzAePzQwBEJeDQzl7+rKWuw
         UqzOfkj54adRkMT0yCwt2mg/5uIi4K1EQtDvt4AtrYivfyrQV9ptHB+dPh6KyX7xkt3B
         icpcSbI/s9brv7TsSeIo26NY88hrAdPClb8bBVLb6JYNuGkcVAzaagxXCTpGv1ekpVr0
         gq93Vbkt+VCanoISVlVyAQaeOgq5jSu3nuiW8ZEx+KK6CZO1VS/aMBn9XGBwWf5atwQC
         wW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729044293; x=1729649093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yrxiwIOIoStDkiXnb7ZGf3UEroF7sy07UVkjBRQwTQ=;
        b=TuWE3ohqKe6zHhkVnnt+JxQehadmnWZD0FqS13EtRW/b/WnwcDJs8GjV+SeXbHYJr6
         aAY4IDUZjSY9VPZEi8Ui8o02j/6FxLhyrTOlsyBXfgcYBA1/QVFR5IA4O9f3KjrccH9O
         2ZnkDeNtrbY4RgYB4YrpQ3P5iWpbRb84izVa+0Ffsp+31fOdgix6bc5DUFsbejZioLVM
         V7HR3IGhCJcg5BnT4q5xO5mnHBuDMja4htDpAJ0aZbkUL+kJTnRiOFOz6+kW3v2bUhmv
         ITdFu0pEfjBeKKR+c/XkahI6SfZf9uypx7xffhmeFiSYW6BopxgJ4wlLqyxf+wbKWo01
         c2ew==
X-Gm-Message-State: AOJu0YyMCuT+2MFxHUMuaCfxcSfU+aEBFOy/8qbzb9CDxbHNfGQRHF2g
	XZrvzA2TMrf7ksXWGi48raDIKxoDQuj6hVVMKlxhzzrL6D33pHcS
X-Google-Smtp-Source: AGHT+IEDprQc10VxKlopG+ezL81BdR/6svbtIjsVXbIg3BSPeWxhv34tXwORJ4ny1pUFwzxG4iRpeA==
X-Received: by 2002:a05:6870:d14c:b0:254:b337:eeb5 with SMTP id 586e51a60fabf-2886d7f027dmr7981823fac.18.1729044293052;
        Tue, 15 Oct 2024 19:04:53 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-288dac0d62esm672510fac.21.2024.10.15.19.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 19:04:52 -0700 (PDT)
Message-ID: <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
Date: Tue, 15 Oct 2024 21:04:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Martin Petzold <martin.petzold@tavla.de>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arend,

>>
>> One may question why -67 AP was preferred over -29 one?  We'd need logs to 
>> answer that question.  It could be the -29 one was simply not seen in the scan 
>> results at the time of the initial scan / connection.
> 
> The roaming algorithm is not that intuitive. Roaming and rate selection are not 
> based on signal strength alone. They may look at PER (packet error ratio) to 
> decide. -29 dBm might actually be too strong. I always try to get between -40 
> and -60 dBm.

I was mostly thinking of the initial BSS selection which iwd can influence at 
initial CMD_CONNECT.  iwd sorts APs according to highest expected throughput, 
but that generally means that if 2 APs are identical, the one with better RSSI 
wins.  Still, without logs there's no way of knowing why the lower rssi one was 
picked.

I'm curious: what are the downsides to using RSSI above -40 dBm?

> 
> The nl80211 API actually offer the possibility to affect the BSS selection. The 
> NL80211_CMD_CONNECT command can have the attribute NL80211_ATTR_BSS_SELECT for 
> that [2]. When not provided the firmware will obviously use its default behavior 
> whatever that is. Not sure if IWD or wpa_supplicant support this, but I am 
> fairly sure brcmfmac supports it. However I do not know if it also applies to 
> roaming.

iwd does not.  Doesn't look like wpa_s does either.

Regards,
-Denis
