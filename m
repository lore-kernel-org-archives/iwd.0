Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DA2701C4
	for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524214; cv=none; b=GxIHB14IwwJuRhwhxC0jWGi9CgtHxl63JfRLfVbrz+O7wHy/VFzk+fF2YYLgdaNWxDQZZuYPoRhESVsmGrYNfb0WcFjsLdmtKZDU4jymOIosuN5lwHYOcqQ+Y/Sj3skY6jqLJx8fCJwVdHEVlCX9lAIGXD6SM4jfBdDCBAwLwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524214; c=relaxed/simple;
	bh=2CjptxBVQIfI/sSAOeuHiFf6d5xWnQ5Jb7fV8UXeK88=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ik6tK8L4B+OBn7cJUnr6nUYer+11Sv+oHy/gu8B/irzGkey9STmVwHGhOocfL7Kr+yMNx6HxM7dB9ljXBXdfpP5SCNEDR4j/UuWz1MGHF2J+I0FFFygxOZMESI+PNiKQQzyYORxecF1pQc5Barm0LJ9PidSlB8UTDCxNK3rEM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0sa948c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0sa948c"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aad1dc8856so8193085ad.1
        for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771524212; x=1772129012; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Xeph/qR9IIN8n5l83IqdC0DrYUXS8oiQMv560NM3vA=;
        b=c0sa948c463Psug5jkxq8priXjtMVKr17pHU3FfoCPwF6QOgCwwWPafwTsQybhgAiJ
         HL5dT+KuCo3XVzg1MjsrJ6mw2aqGgXtO5Y5tKuwl+gcKt5qfT4LB1J3hp8RR+MD4MYBt
         30yggi2QdFd0zQvDyFYfFfVHfny6LG0S76CLBSkWn5tvTIi1zimA8kj5N1gPpouh03LH
         GoHajEn8mcH6j3BWAPacHr6JSCOhciyRYJjal1I7hTL9OVOiVqVbvrYOJ1Gda2/5I9M1
         Y1EwLl1c1y8PpKIXzi/sGjkQlkbxOSKxkFhFitzscy8ZK/X4QDWueLNTbFRybNHH4FSq
         xUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771524212; x=1772129012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xeph/qR9IIN8n5l83IqdC0DrYUXS8oiQMv560NM3vA=;
        b=E4GubKOj/SILJRVFfmdf2eb5gvEtnTdvIiXzbJhDTfY0+6UgLXGDjVXQfaia3IFUGC
         n2Eu0ssZum+vHYoTqIy5obyKMtOdxBd5Iv3UThPMKx1p0zK9zCBsH0/BKuZXPHJ1sRyy
         SoQVlaBXq5arX83i0DWb0XjV0nybYv0x0OOlVwzRw3QygG7FhY3RFvlzv44oxBbPtDAS
         jF6MwJz5M+zSYrxUqqOKvDOMjJGQ+ltM9i+EUlRVfYNmW+BFS4VJKFNVVNZ5fvy9xfSr
         csZ6usjJtNeTj474B907nISSBkFlBaI/1w8kgnmW4A5NXNPwAQ7zgO0xRtm5IKxyl7v/
         6BZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCwcFIxQPciGcMqwGIfpdfmFjxCq9l8IUJqPrYipGa6G45tAL16/L61Z2N2rqZiwOy7Jo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzxWAY+Z18wOqkxSeChM53GaSwg7mUq+ZH5AKe47jQhx4t91BS7
	P8kv3NTTQoHV3FufcocQK6AVepmfBOhKRVKaqadZbyDGP5kRDS7JpMsRfFyVRw==
X-Gm-Gg: AZuq6aLhIxg0psZZFxlczXRFsYRU6kaT/paAw/ccCOAZnyUEjZsm5x63J0aqZ4bX9xh
	IRiyU+/ckbkqhq5CKtiaPG/MRQpTbojkWUl7PbL8XSfSTZv5dHLOI0owiO7bUcuG83XMq9sUnYp
	RNLAog8LnMCdQgcqMhQwywKg88SYeQXq5vGaU7TQ5D80ELpj/lh+IbwE5l2sDS2UpnROSaMtpbu
	uYat2FqIeGi5T1hToOzlOAfRKbB7hXrScQJp7mSoNbj1qOphsrp8YS2/9g1ThAhR58EZM/Pj7OC
	IN6Li8zN+7yfRSurXpzdT0ADoOEOfwTaoRtzAPWWY9oGwkMuQeYQX730ev5/qyctNKkuZxkZE48
	nz5T8an5mnXZuwVKAYb5RUmEVsJ4QUI718chvwqMsDLCujQ/5rJvC3wtqftL4gY3+PgwK3rZ0UU
	lYOJXQa1U2rdSopdfIwGo2uLThr6bDeYali1u/AOht/2R2dUx4M3CdH+/q
X-Received: by 2002:a17:902:f682:b0:2aa:dcc0:370 with SMTP id d9443c01a7336-2ad17431aa6mr178833955ad.3.1771524212182;
        Thu, 19 Feb 2026 10:03:32 -0800 (PST)
Received: from [10.100.120.15] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaebfd6sm160813745ad.85.2026.02.19.10.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:03:30 -0800 (PST)
Message-ID: <d0aa9904-1af1-4505-bbc6-3c75b784e3a9@gmail.com>
Date: Thu, 19 Feb 2026 10:03:27 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: does not connect with intel 3168 past kernel 6.16
To: Rosen Penev <rosenp@gmail.com>, iwd@lists.linux.dev
References: <CAKxU2N9ED1tuKM6ygCb1Ln9VrrMEHGOoc_NhNTn3md87-wH8Mw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAKxU2N9ED1tuKM6ygCb1Ln9VrrMEHGOoc_NhNTn3md87-wH8Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rosen,

On 2/11/26 3:15 PM, Rosen Penev wrote:
> Output from 6.17 dmesg:
>
> iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
> iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
> iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
> iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
> iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
> 3168-29.ucode op_mode iwlmvm
> iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0
>
> There's also iwd dmesg spam:
>
> invalid HE capabilities for xx:xx:xx:xx:xx:x1
> invalid HE capabilities for xx:xx:xx:xx:xx:x0
> event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x1, signal: -76, load: 52/255
> event: state, old: autoconnect_quick, new: connecting (auto)
> event: authentication-timeout,
> event: connect-failed, status: 1
> event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x0, signal: -78, load: 96/255
> event: authentication-timeout,
> event: connect-failed, status: 1
> event: state, old: connecting (auto), new: disconnected
> event: state, old: disconnected, new: autoconnect_full
> invalid HE capabilities for xx:xx:xx:xx:xx:x1\

Is there any kernel output during this time?

>
> 6.16 output:
>
> iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
> iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
> iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
> iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
> iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
> 3168-29.ucode op_mode iwlmvm
> iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0
> iwlwifi 0000:08:00.0: Registered PHC clock: iwlwifi-PTP, with index: 1
>
> Note the extra PHC clock message.
>
> This is still an issue with kernel 6.18. I work around this by using a
> USB WiFi adapter, which is not ideal.

So the USB adapter does work with 6.18? Do you have any other adapters 
to try? Does wpa_supplicant + iwlwifi adapter work on 6.18?

Trying to determine where the issue is. To me, if a USB adapter works 
that tells me its not necessarily an IWD issue, but something with 
iwlwifi and that kernel version. I'd be most interested if 
wpa_supplicant + iwlwifi works, if so we can try getting some iwmon 
logging of the two setups to see what differs.

Thanks,

James

