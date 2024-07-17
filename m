Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF31CD26
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251132; cv=none; b=MXQhwgcHntgGjnU4q7LxqKCschS7AzemxhCS8EWHJq7/itvlGREZJf8g6LtWg/0w+mWeUOPwpkciIjieH1NFFc2c7DzWgwVf07sNecX2khQ5RHfuE8y6C+0q+vNPlAprmkglW6Y0PHcLBm9utRMerfMRcKOrrwKZMB+aboejHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251132; c=relaxed/simple;
	bh=KWtSn6EcnuE/E52JWa0/GHFdN4ZXpUhXuFXppyO8WcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krxmu+NpxbrPzocZwjNOsfANf28zeMWqAwmAp3XRDMDvuHllT7CLOnf+THVHy1nmKDwpbG66LZIhAvYNP0+VfxczD99PqzecABZ1bN946bvaccc76uveSk7flgfoifOMMoy/ML7CV3SV/r6YSvrc/nHZS6o58POFtrZ1BZwuw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOroKzJN; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOroKzJN"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b5f46191b5so840096d6.3
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251126; x=1721855926; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQW4oGawQjM824KnDLrqtd/zRSKBH2LITVGqcL/Y+Ak=;
        b=OOroKzJN8vPsudKuMHQtxCwv1Oiz6EQ2iFFYGINdf81Jr8up0cKX2IyurmmX/1u2VJ
         ldcLDQHTbuDSW03nxVEGWuGYTZeSYDJ1yR155IysQmqy9O1EcRUcTRpPVplapCpC7YW+
         zZFFRfbQvlQCH73fcmaal/zlBaV/c03jHrz4gkm7cmmWSxgVyTtdIkgA/ehM98+TVcSM
         nK/RogI3GCAB7ueEFcS8iZ8jsPjHeCqUKB6MxSmc5pi6CzX/HMtJ/N7sC3f3NbmBwRC4
         qGuf0YXIN5V0ZPk0b6zz4NZF6Gz8gk0YEzoZUy7OujXeeidn6wEooMqkJ4FtLNm6ViwN
         2X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251126; x=1721855926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQW4oGawQjM824KnDLrqtd/zRSKBH2LITVGqcL/Y+Ak=;
        b=fO3RBplmNRxTdUUPRn2523IxTKkeLLUZnKYuGv0wUIPn87hwqm4fePujI1bNsAfBkr
         jax0rfBa0j3mwpNgjGdG7uiEjBlapUR/XsHe0gOw9lFQt/iCaditFFsN65Qo7X9I1/uS
         d7sBNvQ+/m2k6qIkK9CWCFW5Wd29WntmAsJ2aqjvMVCUuJPpQomT7mD0Lmf+ZlK7OaVv
         dEcEGtWZGScJqcacrVKNjsfrzJOXRVHWDUhqSYDBqs2+MI0YepjUNhte62i4s63ak0q3
         bcid5CUDMSPjHQlPYgzMoEGt+Rj4s9s/MtiCOW6IZlbVTJtxa6ta47+vJFhawtd5+8hs
         r6ng==
X-Gm-Message-State: AOJu0YxAGh8xZDVM4pCZ3VgM3KRobXOKq9vWxjGIsV3aTHqR3ba/oUXb
	xbHA5OVRp0oag8qIxSyUvIpIgiQhM9ZVdRvdSRUjIz+gEHjIY/Rr5i2rkQ==
X-Google-Smtp-Source: AGHT+IFcj7ZUdxoGDRsumpnBpYRyQWV7aEYBsIP8GR9NfxoEtI3MGdb5qvb9MNL85KrYsjvYmysYtw==
X-Received: by 2002:a05:6214:2b0f:b0:6b4:fbec:952f with SMTP id 6a1803df08f44-6b78cacf392mr39676406d6.25.1721251126146;
        Wed, 17 Jul 2024 14:18:46 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c4cd2efsm2365666d6.23.2024.07.17.14.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:18:45 -0700 (PDT)
Message-ID: <0bcb2fdf-69c2-4bc3-84ce-52b72d60836b@gmail.com>
Date: Wed, 17 Jul 2024 14:18:42 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: handle disconnect event during the 4-way
 handshake
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 =?UTF-8?Q?Pedro_Andr=C3=A9?= <PEDA@bang-olufsen.dk>
References: <20240717140009.2648885-1-prestwoj@gmail.com>
 <a3c34f70-9620-4a27-ac76-ab55b2bc636c@gmail.com>
 <egk54l4s2ylywom72plctncrjbvwvd4h3ddcrnlnbqecl5f2l4@pd7ojuwyivf2>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <egk54l4s2ylywom72plctncrjbvwvd4h3ddcrnlnbqecl5f2l4@pd7ojuwyivf2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 7/17/24 12:35 PM, Alvin Šipraga wrote:
> Hi James,
>
> On Wed, Jul 17, 2024 at 08:02:17AM GMT, James Prestwood wrote:
>> + CC Alvin
>>
>> You had originally reported [1] a similar issue but it was unclear exactly
>> what was happening at the time. I believe this is the same problem. This may
>> not be the final version of a fix, but I wanted to CC you in case you still
>> were seeing this and wanted to test it.
>>
>> [1] https://lore.kernel.org/iwd/20230403141927.235014-1-alvin@pqrs.dk/
> It's been a while since I dealt with this problem, and in the mean time
> we have been using the original patch I sent to the list as seen in your
> link. Unfortunately I don't recall how I reproduced this issue, but
> maybe my colleague Pedro (+cc) remembers.
>
> Regardless, a static code analysis suggests that your patch yields the
> same result, so I think this is good - one less patch for us to apply :)
>
> Do you have some easily communicable steps to reproduce this issue on
> your end?

I was able to write an autotest for it that took that code path. Its 
basically just as you thought from your previous thread. If a deauth 
frame comes in during the 4-way handshake or key settings during a 
reassociate roam it triggers that "Unexpected disconnect" path in 
station, causing IWD to hang up and not clean up its state.

I just wanted to check in with you that its being fixed. Denis and I 
have been discussing it and my ML patch still isn't quite how he wants 
it, but we think we know how it should be handled.

Thanks,
James

>
> Thanks for following up on this!
>
> Kind regards,
> Alvin
