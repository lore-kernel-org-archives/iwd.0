Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B21B6D1E
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856898; cv=none; b=a/oraY3SAU1iYg7zH2WvFx2vThcRu63ol4vWCeL13j5DZXlTrANqUxrz5dro/fU7OdkLFlW3Rv8eZGGQmP6cd0oO4DgNTJ1wLDvp2rspnJfNTZH9YhcImR3tda2ct2PYq5G8QqVA4eES6NcBS3GLQO2pogIaEeXhc8WmIBzI/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856898; c=relaxed/simple;
	bh=fSBjgnN5lNLTvLnRct9kD4GTAwRw/cB6r0d7AXLbHNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X+BeLybeIbCz//SxAOptqP0lG+xVovgSNpC7OVt1ybHSt9i2F+g0fwLId1ASzLS84xXk4lxz6nfLjQ/9O3ipF+STX7XYGmhyA9sSuQHsHtuKrJISKhtd4DbWkla39d3GbBczGB+Vuy0tEfoWBJxvBlfF4aBkocZSaK3r867ENJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WynlxFMI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WynlxFMI"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b15416303aso129110785a.1
        for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729856895; x=1730461695; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6kvXPkV8zeoaOMd+/7fAoh8b4b1mMNOYc3tB37Z+Wg=;
        b=WynlxFMIhGXUR/arMF4gbKI+K02lEM9fWb6S5JSKwPkuf0mDCF8P162tT8nBfM3r5Q
         ht+c4UYKu1hdlptLZWKNo0X6i7WiyzgqZcF6IJrKRj1oNiI+EkFEux1/YD3AUIiQWFkt
         oadrshuwezwo8mPH8cO1LCeHk5v0oT1bysZare6ktaDRXlZzwj0bplZ1gu8q1TFnzqrc
         nQL4NNx6AmXMcrHm3R9Qe4CqxGWVrHlXfn3tdKDEWJXbfhuUrRMszruH/8sK0F+vMeNc
         SKTqEmstHkH+bzbrLDV6gVcssuztQYQzI6E0W4ORAAxHyyWydaGoDwpJbVoPCBhAKEfd
         sn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729856895; x=1730461695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6kvXPkV8zeoaOMd+/7fAoh8b4b1mMNOYc3tB37Z+Wg=;
        b=d4INJ0OyUowPIN7fYVbANfk5YDNi9pQlEGRL6FFjcvVZjVNI3Hr4OtRWhpRnCEgrO6
         gBnSNpu25wPXzxxkE4Fkt2LGbWg+4grjWpQ732hypC5lQe3+EaibVk1tY5H6hOxdIkIl
         Bw4BR8A/AFDU50+xaKsKV1zXaw73Z+VFCdfR75QqaF4hLHIy/as9rLwbN0NXmI0n58Lt
         HYkilLtNJdh9T5ExuTCW67mFoa5fkOUWc+L8XbzGv3eycWwkNj2ZgzA4cjJLRdRoPJQ2
         nLDk8ywZ1CadJhHLsbgP0t+eb2acv/Tli7fZSjDNIjslju4ovr9pBfG78TVqvcKTLJ6/
         QFvw==
X-Forwarded-Encrypted: i=1; AJvYcCUyeTsGmJNBOEdcdE6+cYAKGjzT4gz8vwRAyxtvaxJd2QejrKzeK5BEpnBhE3NUi+128II=@lists.linux.dev
X-Gm-Message-State: AOJu0YzlMYmBB2Br08p8TfxJ5FduXHIatxl+77NdQIhUkiGYYS7b6KJh
	SlFk1zLM7oyiJ494Djt6U5xWwcR8toOMYXqYJkokqfKE6rfQyGM232FkUQ==
X-Google-Smtp-Source: AGHT+IG8+EiRIiEz0UXN48IklA3qqUf7uRNXW6dwuXLu28Jp8YhOen4yLdS2J66GyuNAUQuf9mT9vQ==
X-Received: by 2002:a05:620a:2729:b0:7b1:5089:4867 with SMTP id af79cd13be357-7b17e5bd442mr1263625585a.62.1729856894719;
        Fri, 25 Oct 2024 04:48:14 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d292c88sm47879385a.30.2024.10.25.04.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:48:14 -0700 (PDT)
Message-ID: <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
Date: Fri, 25 Oct 2024 04:48:12 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 10/25/24 4:10 AM, Martin Petzold wrote:
> Hi all,
>
> Am 25.10.24 um 12:12 schrieb Martin Petzold:
>> Hi all,
>>
>> I open a new thread for this one: During the last weeks I have seen 
>> connection losses for 30+ minutes, sometimes even hours or just now 
>> even forever (IWD HEAD with v2 OWE / BSS selection patches). Driver 
>> is brcmfmac (NXP 6.1.36 kernel) and chip is BCM4339 (Laird LWB5).
>>
>> It happens in a) single router environment (WPA2-PSK; Touchstone 
>> TG3442DE), and b) router + repeater environment (WPA2 CCMP; Fritz!Box 
>> + Fritz!Repeater), and maybe also in the WPA3 OWE Transition network 
>> (yesterday lost a connection again).
>
> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
> roaming). However, now they don't disappear all after a shorter while. 
> It seems to be later.
>
> I also lost one device in a Router+Repeater WPA2 (CCMP) network. It is 
> confirmed here on router side, that the device is disconnected. Since 
> more than a day.

We can't do anything without logs. If you suspect its the blacklist you 
can lower the blacklist time down in main.conf:

[Blacklist]
MaximumTimeout=5

But logs would be best, we would be able to see if that is whats 
happening or if its something else.

Thanks,

James

>
>>
>> We have 100% reproducable builds, test environments (testing sites), 
>> and web socket-based telemetry. Thus my feeling is, there is still 
>> something wrong with the BSS selection (maybe blacklisting)! Of 
>> course this can also be something about the driver (brcmfmac) or 
>> firmware (roaming?). Or can this be about IPv6 disabled (my 
>> configuration below)?
>>
>> This is really really serious, I (still) lose connections to devices!
>>
>> I will investigate further and provide logs later today, if possible.
>>
>> SETUP:
>>
>> SoM: Variscite DART-IMX8M-PLUS
>> SoC: NXP i.MX8M Plus
>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>> Antenna: Laird FlexPIFA
>> RootFS: Debian bookworm
>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>> Network Daemon: systemd-networkd 252.30
>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 + 
>> OWE and BSS selection patches) + ELL 0.69 
>> (7bed251f8020ef896043f008276f41cd13fdd43f)
>>
>> KERNEL:
>>
>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
>> https://github.com/varigit/linux-imx)
>> BRANCH=lf-6.1.y_var03
>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>
>> FIRMWARE:
>>
>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>
>> From: 
>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/
>>
>> IWD
>>
>> -----
>>
>> [General]
>> EnableNetworkConfiguration=true
>>
>> [Network]
>> NameResolvingService=systemd
>> EnableIPv6=false
>>
>> [DriverQuirks]
>> OweDisable=brcmfmac
>>
>> -----
>>
>> Best regards,
>>
>> Martin
>>
>>
