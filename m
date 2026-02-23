Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106931984E
	for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866676; cv=none; b=kgcANzZ+39PM9pzD2ZK89GQlVjsMVAbPoMDxcOUyBH/moRjtgOMs6jziP/2iqzVvaQqP+4xxp6QHVSBVrDpqvPGHPFMfxQD+HhCqOyyRQHBG2VYkUONtMUyA6hzMBj2oa2xM5u8BjQGGa7oU9hLw4VpipVaIUkOV7cwGJGCMcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866676; c=relaxed/simple;
	bh=YUund9TQVKbN6wA/Q1DO/K9fhLY1bLkC8ViRxC6CcuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXZrmTHAUVBEUEy1n7RCSPlxPy/TrTr85WLCTX9lERZ/0/xeKH4JRIQYXjSQi4gW1jVoarRJUaYpIblzZsT5Pex1yKe3HbC/8CELl+tP+MIsPCqqAHsqPCv3JvtBp5YUB91NAGen3dstHgphALrHslhmwgU/iQi0F1NXu+fCi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE2ZZqdN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE2ZZqdN"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824a3ba5222so2425217b3a.2
        for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771866675; x=1772471475; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6g+L1cHBv/qiIoo18sapl/OoSgp1mMxWJfDxS8gfhg=;
        b=SE2ZZqdNuLIOTIFoficuy1YotWuKIG6fFRdg7uWnWu/c0K/oOJcZQg5N+HkhxfzQgt
         /k4Xb43wYJd1ObTLgH92DvHZN0t2N3F4atReGFuSsuTuLulB4jvS95gGDlvvcRHsww34
         +0UdNTvJ+0ul+44zxMG5Ot55RKnxCDDu6HL++oygWB4xGWca/iGIlIM4FVdO7Mbt8ZoM
         DujqYs/UBT7n4OK8nom0M1g31VGGAiclD9dlqMaU1gale6lGOJgUfjnSwzj5O46bvnRh
         0DhZ/ldDCc4UE+BBbjNjlNbiZ2HKQPFA5qSlGL+PNT+9FiQcLfXomhNOfiQB4GQbz2IL
         FezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771866675; x=1772471475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6g+L1cHBv/qiIoo18sapl/OoSgp1mMxWJfDxS8gfhg=;
        b=Jfu5iK7r+tYxcXx1IURsI5eNLAUttCI+Z/qZw0l2tI5ofX7lNFLWdtVYUxqf86MjBX
         /TuuBTf/RwEwTMVhIRqg9C4u46bRYTkqzjZaxXhN98TbLgqT929KJ/z9hIs9dBwW5wu6
         mu3skQujgZ+xHGRQ2JywtFHbhYrPFB6ega+967b3s/rTywYskNueflCFZIZd+gEA1uTI
         +CKClFzwsH9gabDgSaD0IcHQnipT/B7BHdm9sMU8QeHTv2JmqHznP4d0QnwPYNg3i/JE
         ekELlWyEvbLy3KLNyjQRlaD3rj8wuUVMX1UawnUdk4cG2iJzmGbiOhbBi9yakTPCqUqC
         AsJQ==
X-Gm-Message-State: AOJu0YwguR2Cm8iw4wQkWZBSqDKU9sehvBylgDOYInWbbf9fO0p3b0KN
	x3k6Q1AwIA7yGThLeUS6a9V9xtngXok5QPv0H+eESii69c/vLdOc7q7FdYABWQ==
X-Gm-Gg: AZuq6aLCBr4rcc2BwWYHqZGr5Yo9dnFQW0+kcvpS2woML/km8kW4Op0pNkejjxfGzjp
	1xuGUJTWJfNazHwqx1Via2lsEkQVacv/cDHkwxAego2ez92ys0IkG7O6YB39DUJm1ZShAniGQZd
	xxpdxdTl+QqzgpUQa7XvjSKk5oRLZKdJkjlj2mBkfUdboTCkUE3uSTKi4c/GtWssoto5PD0dJ2a
	KSc+UfQS3XlF+7SbGdFNJAMlMOUEdRFT9DggLoSbfMeqq7s3MxkvdMQ/Y2JxbpzVIADqgdlUjfx
	0LDun/A98pc4ArCdjOLnzvjT6tFy+BukfHs6bIzUO6wMCeOVWOqpdOuPnq7AyvHq/I4MXxBH1zu
	3SMCd4TPRECnYe6v9q+I+onH8BBEH9pVnxExVsS7VO2trzn6tQE8hzb7TExxNWK/Fvkw5fbvdgU
	UtvWEJoyZNmXYiUegsszOjXUhu6P0DJ3nQlY4BJ3Wbe0bUVgg0nnutacwN
X-Received: by 2002:a05:6a00:84b:b0:81f:4f05:4fe6 with SMTP id d2e1a72fcca58-826da8e26c1mr7307004b3a.1.1771866674861;
        Mon, 23 Feb 2026 09:11:14 -0800 (PST)
Received: from [10.100.120.15] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd640d16sm8524099b3a.13.2026.02.23.09.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:11:13 -0800 (PST)
Message-ID: <8de64523-bffa-4455-9928-dfe924ac2220@gmail.com>
Date: Mon, 23 Feb 2026 09:11:11 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: does not connect with intel 3168 past kernel 6.16
To: Rosen Penev <rosenp@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAKxU2N9ED1tuKM6ygCb1Ln9VrrMEHGOoc_NhNTn3md87-wH8Mw@mail.gmail.com>
 <d0aa9904-1af1-4505-bbc6-3c75b784e3a9@gmail.com>
 <CAKxU2N_sUr_rmbV5i=MP6c1J7pgZM=f7b1yAUSjg+fDgXNPqTQ@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAKxU2N_sUr_rmbV5i=MP6c1J7pgZM=f7b1yAUSjg+fDgXNPqTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rosen,

On 2/19/26 4:26 PM, Rosen Penev wrote:
> On Thu, Feb 19, 2026 at 10:03 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Rosen,
>>
>> On 2/11/26 3:15 PM, Rosen Penev wrote:
>>> Output from 6.17 dmesg:
>>>
>>> iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
>>> iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
>>> iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
>>> iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
>>> iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
>>> 3168-29.ucode op_mode iwlmvm
>>> iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0
>>>
>>> There's also iwd dmesg spam:
>>>
>>> invalid HE capabilities for xx:xx:xx:xx:xx:x1
>>> invalid HE capabilities for xx:xx:xx:xx:xx:x0
>>> event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x1, signal: -76, load: 52/255
>>> event: state, old: autoconnect_quick, new: connecting (auto)
>>> event: authentication-timeout,
>>> event: connect-failed, status: 1
>>> event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x0, signal: -78, load: 96/255
>>> event: authentication-timeout,
>>> event: connect-failed, status: 1
>>> event: state, old: connecting (auto), new: disconnected
>>> event: state, old: disconnected, new: autoconnect_full
>>> invalid HE capabilities for xx:xx:xx:xx:xx:x1\
>> Is there any kernel output during this time?
> It's basically this continuously. I use impala to manage iwd but even
> if remove it and use iwctl manally, same thing.
>>> 6.16 output:
>>>
>>> iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
>>> iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
>>> iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
>>> iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
>>> iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
>>> 3168-29.ucode op_mode iwlmvm
>>> iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0
>>> iwlwifi 0000:08:00.0: Registered PHC clock: iwlwifi-PTP, with index: 1
>>>
>>> Note the extra PHC clock message.
>>>
>>> This is still an issue with kernel 6.18. I work around this by using a
>>> USB WiFi adapter, which is not ideal.
>> So the USB adapter does work with 6.18? Do you have any other adapters
>> to try? Does wpa_supplicant + iwlwifi adapter work on 6.18?
> Not sure, I can try later.
>> Trying to determine where the issue is. To me, if a USB adapter works
>> that tells me its not necessarily an IWD issue, but something with
>> iwlwifi and that kernel version. I'd be most interested if
>> wpa_supplicant + iwlwifi works, if so we can try getting some iwmon
>> logging of the two setups to see what differs.
> It's definitely a kernel issue introduced between 6.16 and 6.17. Still
> present on 6.18.
>
> Interestingly enough, If I boot to Windows and then reboot to Linux,
> it works. But booting directly to Linux fails. That just tells me
> firmware loading is broken in some way. Or something is not being
> initialized.
This all smells like a driver regression to me. Or at the very least 
something in iwlwifi/mac80211 changed, and IWD is passing or not passing 
some attribute that is now expected/unexpected. If you can successfully 
get wpa_supplicant to work with this setup I'd be very curious to see 
the iwmon logs with wpa_supplicant vs IWD.
>> Thanks,
>>
>> James
>>
