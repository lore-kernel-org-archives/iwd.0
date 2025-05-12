Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338723535A
	for <iwd@lists.linux.dev>; Mon, 12 May 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072490; cv=none; b=UWpV1ooTUlFZkxGFxzMOGAS8yE/2z99++0AzFTGqRv8FHHMYnFazUqz2GyMZBPj7sLSt0I1JAOLyAXnGbMGwgzzHwwbHgfw78EgL73QwHuA0wnkzTYfqsBlnoG/fy1FI+ikY6lXmOjt1EwD9QBIE/yCGx6kqtqjHSvBNf6Bthy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072490; c=relaxed/simple;
	bh=E5HaNjhZ+6XwX9DkoHuHbP9uqRHlcvhMqL2/0BfxPk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GenYljuCdmfh5kbbtHwcsKKGqz3KfNGsUBUN6mdUuJJW/N9fTdO1HjtPsQPweoh1xiOO0woBXA9+u9ab2x7z7r/RDA9makmB8SUJY0xGdqMsxi8w2ORtMJVFAbi+MmH3TaMtFVqrFE2zprZMwkAX19YPhE4P20oxFWU1s6FJxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2yK00R3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2yK00R3"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0ad744811so35805746d6.1
        for <iwd@lists.linux.dev>; Mon, 12 May 2025 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747072488; x=1747677288; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQAnQk1XvRGAxxGfMspsMN1RCMxE50+ixKqieHX9N7I=;
        b=i2yK00R3/ioa0UT2HtO38aoC0NqSnmofd+7sfT5s6Ol9+PCFhg3nQ7peM8V9n+fLUf
         MmyXIzZZ+Oz0DWAGxvish1/jYcMkNClhNVJSD7tsth2HTHMn91K0gLC2LKRQbUYY0MKU
         eR4Ze65951zHcj4+E3HBSmfPQRV4tYFCgVABTn6ZXVMD8O5nK+KZRL8OJTnZtpjAGlSz
         hpZ0V2cVt/+O4MSvrG6/AsDhp0TCXmPoM0iS7K2AxFQ3QuxzAujvpmgyNw+1TEo454V5
         bEIjiHdk3XgZqjx2tCjEi6EaplWhtVBvNxCXXUmCRvG/39Plq4/anPBekInqFqpLwBUn
         Rd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747072488; x=1747677288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQAnQk1XvRGAxxGfMspsMN1RCMxE50+ixKqieHX9N7I=;
        b=a1tG1fMvFHCsh6VViRkfdIC+Ro6Ci9ZCOYi8MLjfZdA4QNRyoVXxVAwCQhrhefTVlS
         CjrCw2jXjuwPp+C0fQUgSPOcrJmDpR04UJrnVAT6gkn+IRPIph1t4NtHyo4+252Obmbo
         SwogBvouPC5lwVuNj+zZJvUvIKb0EnigTABDKqRIV4E6/NEaCvo+dj+iyeuoiborSfft
         cL4kj4ElIvnpIHGAn0YXZxhK8JuME/PsZDFgHyr921oGrbn8csKORM9BiX1XTbwR3Rfa
         ozVdBS8cizxz1m7NHj9BcMMesmsbNp7aXIcoWrR1cVuT0AmiSD0d27J903McnWwN2i0A
         LjCA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ihX6l7eszvaX+lqp+dW7EO1HjSO7KpwP9xT3CudviZRGsQa05R59W15Gu7rvGJReOlE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/nwhSXB898NhqY4dmp4Xw3F/M1owo4K5ZcMOFunNTVh9ougA3
	AjGqyu93Yw8CNL3trvaxUM17+8QGJHUqNMPifYdqmFP9WQHAzQFo
X-Gm-Gg: ASbGncsUCNfgOa2QnJSn/2LTyF09BOZZbjNFQOigZrNQVg16pce+mHsgWBerfPdf4Of
	tk/yT2YaGlUI8/Ax1iDPBfYESNsEfMfchHYcE7gADaI2vy7gos1lbboyUYWypUbnzWv3w5xZAgA
	fOGXzretYZVAbdMIkQfxMFqf8+UMzxIKNRTLHehl6vrhZ4t1ejXCMLUSFpGcxVUV8Q9fe1rACpA
	fRNdB4LVdQifJJKQuuHHuPtspX72cblrqDPXCVN0gr65oPmfXTcYVkxDAjevtoehe8NaLFPJnFt
	XdqEvctFnLXsUCzBTfdrdty11xuk/SGsmKzWjLZQM/ExmJmjDc/BMZM=
X-Google-Smtp-Source: AGHT+IFA5eWbrJEpAMIqIWTZTVEsoojdZh5Z2jW4crNT3WIniTpGC2sWkZrP4BefHLk+zIjfanLnGQ==
X-Received: by 2002:a05:6214:234e:b0:6e8:ff46:b33e with SMTP id 6a1803df08f44-6f6e481eed9mr276862336d6.37.1747072487525;
        Mon, 12 May 2025 10:54:47 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a0c0dbsm55148576d6.56.2025.05.12.10.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 10:54:47 -0700 (PDT)
Message-ID: <d6050f21-98ad-4b1d-a3ca-1d0be7ff7f15@gmail.com>
Date: Mon, 12 May 2025 10:54:45 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linksys router incorrectly showing as WEP?
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CADXxVSKPz7o3TT18hCqzz=3MMWrE69NbaBDLSHFBfoRDq5VT7w@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSKPz7o3TT18hCqzz=3MMWrE69NbaBDLSHFBfoRDq5VT7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 5/12/25 10:28 AM, Bryce Johnson wrote:
> Hi All,
> We have some embedded linux devices with TI cc3301 chipset.  At one of
> our labs, the router (linksys MR6350) according to IWD will show up as
> wep security then go back to psk.
>
> Odd thing is this router doesn't even support WEP - the only security
> option it has listed in wpa2-personal or open.
>
> We have like 20 devices in the lab and it appears to be happening to
> some or all of them. I'm needing to remote desktop over to a computer
> that has a serial connection... so slightly difficult to get logs.
>
> I want to just blame the router and have them replace it, but I
> figured I'd check if there is any other issue here as well.  I have
> full IWD debug logs saved, but here is a snippet.
>
> 2025-05-12 16:15:53.428737870  Wireless daemon version 3.4
> <SNIP>
> 2025-05-12 16:15:55.791609235  src/station.c:station_print_scan_bss()
> Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2427,
> rank: 492, strength: -4600, data_rate: 72.2
> 2025-05-12 16:15:55.791622150  src/station.c:station_add_seen_bss()
> Added new Network "Revelotest4" security wep
> <SNIP>
> 2025-05-12 16:22:15.714231348  src/station.c:station_print_scan_bss()
> Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2427,
> rank: 492, strength: -4700, data_rate: 72.2
> 2025-05-12 16:22:15.714244273  src/station.c:station_add_seen_bss()
> Added new Network "Revelotest4" security psk
> <SNIP>
> 2025-05-12 16:22:15.717638513  src/station.c:process_network() No
> remaining BSSs for SSID: Revelotest4 -- Removing network
>
> Then killing IWD and restarting
>
> 2025-05-12 16:23:24.015924492  src/station.c:station_print_scan_bss()
> Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2427,
> rank: 492, strength: -4500, data_rate: 72.2
> 2025-05-12 16:23:24.015937250  src/station.c:station_add_seen_bss()
> Added new Network "Revelotest4" security psk
>
>
> On another 2 device: (2025-05-08 date is incorrect it was before it
> got good time).  They in total had been up 30 minutes or so.
>
> device 2:
> 2025-05-08 17:00:09.699817830  src/station.c:station_add_seen_bss()
> Added new Network "Revelotest4" security wep
> 2025-05-12 16:33:47.901451708  src/station.c:station_add_seen_bss()
> Added new Network "Revelotest4" security psk
>
> device 3:
> 2025-05-08 17:00:06.777723005  src/station.c:station_add_seen_bss()
> Added new Network "Revelotest4" security wep
> 2025-05-12 16:33:49.145627332  src/station.c:station_add_seen_bss()
> Added new Network "Revelotest4" security psk
>
> That 2 devices do it at the same time - makes it seem like the router
> is doing some funky stuff.

Could you grab an iwmon pcap of this? Here you can see how the security 
level is determined, and its quite basic:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/common.c#n89

With an iwmon pcap we could see the exact bytes of the RSNE and see why 
IWD is categorizing it this way.

Thanks,
James

>
> Thank
> Bryce
>
