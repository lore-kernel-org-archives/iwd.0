Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F314659B
	for <iwd@lists.linux.dev>; Thu, 31 Oct 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371681; cv=none; b=Pg9VYz/1iAFBTzhhGp293+mAqZzybioTsaBNy98Ttydlnvtd6NkS7YqfGpF/wITWhB3oqbCsqnGyz5Psoz6NOTGnY6CBi8BJUF3tj5G84YTU2fdgWbfh3dDLjZgZMhI7kRRf0Axd9xlUtbPrf4+OYVmEvvEaTr2H3LDa4ZTljLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371681; c=relaxed/simple;
	bh=daZFF4i7/U8YzFrduO+yeOqJJXDQJGuyoU1kkQTt3FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEtx9/374uUe7QZKjCvpwf5GD26NMYLoO4Si8w1pYMRJ6GXgTSjd7NmmYRDMtiLCvWQ8p4fpPz/2NSrkI//ypKVo84rhmDk6E2zMnwprlQQZXHO87YI5YR3/E6CabqLcex10Op7k71dvncLX+tvjGbnQpmRRJCGt7Na5JEP9dMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pa6TXs9s; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pa6TXs9s"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbe8119e21so4788476d6.1
        for <iwd@lists.linux.dev>; Thu, 31 Oct 2024 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730371678; x=1730976478; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lIfB64a946F586lfKlHiWvIAuQahEmth38Dk52DKTgY=;
        b=Pa6TXs9sG/oLCxlK6nYgxLTdX2ZTunYaWKTyBNqQ3uiN6gruV2ry+bDTT8gOTzobDd
         /E1CMpTal8VLVV3Y0uPhjgcvhiQV0VRcZqY0aEjtBpZZ2UKk0Fwh6NV0yJSnlfZWmbLV
         Kp9T0x9wn6ZvS+JdJwzbsAmhwb7DIVK/Ut2eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371678; x=1730976478;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIfB64a946F586lfKlHiWvIAuQahEmth38Dk52DKTgY=;
        b=ZwBkPkvYMKC+iiwYaVJurCctS9QOsxjuuRcAlllH85/CwvalFDZyrlTE9lp7Z35FvP
         TQyAadmrtyxkSATRjzCH4iZeUdF2GgdkMOFtd2JnIJHYNbQWCQS6t5nbpUPz/udFc5ME
         hB83xwv+P4FUXb8eh86ncR3uqo5xNR8g57q6CWKbjV4Ow6tqv56a1Zvi1MIXUIIDIDEa
         zJWMKc8Xp6xUzAXx7kdxrj/dnKGz0RNJA9xlQ056jsJsVmMf4Y9PS+JnWUOCrPdRdjeu
         KXGRMlxTz3n6DXQRwZD/uz8Tjfe22Ft1+JIFPCFSx4Z/YILbyjv0kOKGo0gXEp17c16o
         rJuQ==
X-Gm-Message-State: AOJu0YxQMJMt6So/Ivf7eRTgUcPB6tgHIkhUTqeGX/VjwG5JiSFDODgq
	JG1AcAyCPc3fTUsLmKXuezfpfR7tCZawNx25EMa24z01lOTV98G0cTlBP/hg6bk3DWLho6LpzuT
	YK+vD
X-Google-Smtp-Source: AGHT+IHbV6Cqojp5Rw6CF8JppzePATw28iurtHuGUuX+acg4gsTKlvyPbTY6Gdfb5fZvtElRQAjqQg==
X-Received: by 2002:a05:6214:490a:b0:6c3:5a86:6a29 with SMTP id 6a1803df08f44-6d1856eddbemr260719366d6.21.1730371678432;
        Thu, 31 Oct 2024 03:47:58 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9f4e4sm6556016d6.10.2024.10.31.03.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:47:57 -0700 (PDT)
Message-ID: <802ee01c-dc70-4138-8ed1-79bf286f8842@broadcom.com>
Date: Thu, 31 Oct 2024 11:47:53 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
 <43c03f86-08e8-4ca7-840d-9230efdd7b8e@tavla.de>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <43c03f86-08e8-4ca7-840d-9230efdd7b8e@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/2024 10:41 AM, Martin Petzold wrote:
> Dear Arend,
> 
> Am 30.10.24 um 20:54 schrieb Martin Petzold:
>> Hi,
>>
>> to disable "power save" with NetworkManager I used:
>>
>> -----
>>
>> [connection]
>> wifi.powersave = 2
>>
>> -----
>>
>> However, using IWD (with iwlwifi or brcmfmac) I don't know how to get 
>> this set:
> 
> I can't find any specific parameter using "modinfo brcmfmac". Does 
> BCM4339 (Laird LWB 5) with brcmfmac (6.1.36) support power save?

sure it does.

> Then it maybe could make sense to switch this off by using "sudo iw 
> wlan0 set power_save off" or IWD configuration parameter 
> "PowerSaveDisable=brcmfmac" in case there is some trouble with 
> connection or roaming. We have a very strict web socket ping/pong (no 
> loss accepted) this worked very well for years, however, it seems our 
> problems are related to this (maybe single package losses, which may 
> happen with power save enabled).

okay. Not sure if there is further question being asked here.

Regards,
Arend
