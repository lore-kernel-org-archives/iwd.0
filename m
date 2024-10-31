Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD383CD9
	for <iwd@lists.linux.dev>; Thu, 31 Oct 2024 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372768; cv=none; b=EqDEVrT2AJczarlJ5+DoM7cAlHXRtYjvs3OD1178BZvDNDbIT5V1NboZnRLg+DRdeHfl7QlXAr+fYW4rPhBFf+wtzB8AmrSHZAjamoqxgou6iqtbt2kxqq9dar+wNzvaU39UYgYfZXAO64qOma/Y2bo78LJOlSbU/mFH9O2PFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372768; c=relaxed/simple;
	bh=CSqfSvFupdTE0YIocCg+wTGvAXFiYYxtPzaENlwO7Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YN3wveg/iscUtUlgef6a8HwR7OKtcXK80OA3ZjsT7i0LNt59+RxggdUZd0ckKTkiOVjwutBliHsXpX2zhMIShvc2D96YIANdUyqsRFwjM7aZ8z2wXEPO7BzMJUMpq3YymIp0+/1pForwVb7wb/l4yHAgjECO/mmjveLUpdjK3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=qdZCwVD4; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="qdZCwVD4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XfLlD1DXrz9w46;
	Thu, 31 Oct 2024 12:06:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730372760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bs7Wmmi+sDY+ayeclfIy+eTwpKcS4cNbsFCk9VMXcoA=;
	b=qdZCwVD4b0bWkbaQl0KWHv5vWUZznzFvocFAi2bO0cOxxQY3AhMEvIDip9BREXOAQ9gYR/
	y3JKDQT+h/5W7WVl/4PYpgWUEapQ21sTtcOF9cZgh0yVcuTfGVmNB+NTv7/cWP1g0MHMkR
	XyJAdk77mO/ytmrpxw+H7m/NcNSa1bLSygWElHmPIrNtNxpDhkB2PxyKgx9n/30Wxpil/w
	9CW87LqKxmaf8Bgd9H+Z/bh6O3KVUDxIk2SNXKqmm4f0jnpofJFx3eLUQ9CM4qgwmVileI
	3ZAyaA2oWRyYQurch9uozzv5JqK6xzTF9rZTIvHqkFtRdUvDaefy6oMh7HW6Zg==
Message-ID: <8ad989f6-bf3a-40b8-ba10-c1539ca857ec@tavla.de>
Date: Thu, 31 Oct 2024 12:05:58 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
 <43c03f86-08e8-4ca7-840d-9230efdd7b8e@tavla.de>
 <802ee01c-dc70-4138-8ed1-79bf286f8842@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <802ee01c-dc70-4138-8ed1-79bf286f8842@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XfLlD1DXrz9w46

Dear Arend,

Am 31.10.24 um 11:47 schrieb Arend van Spriel:
>
>
> On 10/31/2024 10:41 AM, Martin Petzold wrote:
>> Dear Arend,
>>
>> Am 30.10.24 um 20:54 schrieb Martin Petzold:
>>> Hi,
>>>
>>> to disable "power save" with NetworkManager I used:
>>>
>>> -----
>>>
>>> [connection]
>>> wifi.powersave = 2
>>>
>>> -----
>>>
>>> However, using IWD (with iwlwifi or brcmfmac) I don't know how to 
>>> get this set:
>>
>> I can't find any specific parameter using "modinfo brcmfmac". Does 
>> BCM4339 (Laird LWB 5) with brcmfmac (6.1.36) support power save?
>
> sure it does.
>
>> Then it maybe could make sense to switch this off by using "sudo iw 
>> wlan0 set power_save off" or IWD configuration parameter 
>> "PowerSaveDisable=brcmfmac" in case there is some trouble with 
>> connection or roaming. We have a very strict web socket ping/pong (no 
>> loss accepted) this worked very well for years, however, it seems our 
>> problems are related to this (maybe single package losses, which may 
>> happen with power save enabled).
>
> okay. Not sure if there is further question being asked here. 

How to set it?

Is there also a kernel module parameter? Or is it encouraged to use 
"sudo iw wlan0 set power_save off"?

I also found this [1] but don't understand where this would be set and 
if this is maybe some other parameter (idle_interval)?

[1] 
https://community.infineon.com/t5/AIROC-Wi-Fi-MCUs/CYW43353-power-save-management/td-p/405836#.

