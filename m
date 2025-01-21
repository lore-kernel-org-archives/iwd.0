Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C51F192A
	for <iwd@lists.linux.dev>; Tue, 21 Jan 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470187; cv=none; b=K+A3uQyTlcjwUb/sI0v8saxMUmlP3BwssNiLSt3ge+ozui+xR09hSnsLRq05nKwfNAA++D3oWiz+/otTKFY5jkfZSZqs7k7K/5pkSAEGM090SvDQu9Ynde6qLiA5CAEmsYkMW3LnXk6jnxKMzlKKfRoLbE3pAVQGcH7pnq30pXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470187; c=relaxed/simple;
	bh=YBk+HbK+VEYS1PvMRsQdI8PVYsGgIN4uQbbd6zRo7hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAqJOKvzdNHF+T89BW/vn5kSxirVJofUENDZJ7hYAvdDqD0ivo/XrRQSXIzYYkVd/JKWTBNEJ5fEBFBKNjnoI2vEToGQThfKRrl5/Wj6Cu3s8CaF2qqWI3wwhUkCxXGKboDYKG/B3Ua7yBVmNSVA4ZML9q/+ahzRyaaMxRqJgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm3PduwQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm3PduwQ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so9793680a91.1
        for <iwd@lists.linux.dev>; Tue, 21 Jan 2025 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737470185; x=1738074985; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pznW3m9tbzmKD3nS0VKrCy1lF5HKpjtK8++I5guIbWg=;
        b=fm3PduwQ8ifGNgt+m7layXDQYQpXV7OXwzvc/gWqrTBwhM8DYzNjqb3x6vr8WvvKDY
         zgZmqUcvhIXajqiQ2IvyyO30xMKIauw7CxhZBKW2D/dNOzkFx1knoZBBTSj32UwuQWIv
         KKgY66RmVzSRCSDEDoApg+ykbwe7RHha0fB0DOKsI9H/KzFYczytmACzJcD+UkFK2V+4
         Eb+ds+/F6zLQuuGNsP8CZQZxuBoiZTefv2QsOrN5yVMNSnqicX0OtNQB2epywYm6Yul2
         pPd+moMUMzQOyL+C6fNbmUVYm2l3pgSgNNoHhJ28xPsMFdlIDG4mM9zKH6m8ZBU/CGdG
         xsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470185; x=1738074985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pznW3m9tbzmKD3nS0VKrCy1lF5HKpjtK8++I5guIbWg=;
        b=mqnJfPOPlBOnkiL+Ctp+eV0ZXh3xJySVucjP84hIxyBJC5ZfFwVPcEQUvKUCv1s7eJ
         RgdLYCfDs03qeB2zXF8Jm3PluTRLsF7OwvO8Zmwsqfo6zSzUpuu0BCyn8RhF2qQxh3tG
         ghbhjZjQyxlcQQp/bo+OF521PXRgSCA97yf1H9FGa7UW+HhwjT2xxRqkGb7j5Ux3UYA1
         0VkYA+u4j0RIthhA4RhLyeycLX6mrJu66TlHAXWm9HaERvXVj7a6Fp2+JnekpCUyCzH2
         /LGm61p7CPzYEUrRoSfLtCeg3KNvbhQ+LBp/VHHjEXQbCEApg+p64iC7P7hoM1vVU/qE
         +dnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKty6CJvVNwCB8+8dslxOzBCv42JpCsSZZXnNY4LR2w5bbE9GQtGn10ITsGaAFCq06+aM=@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ4vcRJ7yXNJVIqPJTK2geoM+WadeGj5XVdYw+wmT3YMvaR/Jo
	Iwz9ecEQ7NW8WwrpvuPfOsXagtFns1JUmiUHynIKJzJh9mpUYDAl0JyZ2A==
X-Gm-Gg: ASbGncv15MRcRklAhThAJy0AMLqNEm/vtwrOr0aAoVX4ks8O18+tcUmTFjyHc7fmhXj
	PMY7izdjVUmESUWV4zphYkXKz7jHau5wkJpiy9hAzRCTm3TiD7qnQkn8XrvsfJyiwTHIiKuCm7L
	kbwjhU/MjJKHuL8ODVMkm5vlWURGysO7ueGlejXFM2YoY0BCZgT1QLcs76pR8fMD7al+UGNRAqK
	/OBCsseDC2N6IiKZL83K9AfDxdLI/ohhAZ00g0r/0ox1/u+vN243xsyV40G3JZpvCxNZ5fvj/cc
	jZcJ8GmxswK6j0M+3Pb58k+oahq9tDm1HGj9ULeIy2vPs33r
X-Google-Smtp-Source: AGHT+IGEdYo1+6OHFYRwOwXE+R6uc9pf4V2/UQS29d41LoJz6pR+7eE5eMyhX+GaqRuodl53hMa6/g==
X-Received: by 2002:a17:90b:4a41:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2f782d4ed35mr27520173a91.24.1737470184599;
        Tue, 21 Jan 2025 06:36:24 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f776154378sm9837210a91.13.2025.01.21.06.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 06:36:24 -0800 (PST)
Message-ID: <18b33ae2-d6a2-4950-92cd-d38d41d4bc10@gmail.com>
Date: Tue, 21 Jan 2025 06:36:23 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to triage an "Invalid Key" error message?
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com>
 <60c1b2cf-95be-4a4b-9195-f141adf45a6c@gmail.com>
 <CAG17S_NS18ubECyF0sz0AmtFq3wufjTVjQV2QpWLxCqV8ei1UA@mail.gmail.com>
 <578421A3-35DA-431A-9319-96D847AA4CB2@gmail.com>
 <ba94e034-df99-41c8-8da6-3ddaa3fb1f66@gmail.com>
 <87E0B927-2A75-4737-9D45-B3E8809B2E43@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87E0B927-2A75-4737-9D45-B3E8809B2E43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On 1/21/25 6:24 AM, Christian Hewitt wrote:
>> On 21 Jan 2025, at 5:50 pm, James Prestwood <prestwoj@gmail.com> wrote:
>>
>> Hi Christian,
>>
>> On 1/20/25 7:36 AM, Christian Hewitt wrote:
>>>> On 18 Jan 2025, at 8:38 pm, KeithG <ys3al35l@gmail.com> wrote:
>>>>
>>>> Christian,
>>>>
>>>> Is this, perhaps, on devices with the brcmfmac chip? I have seen this
>>>> recently with on my Pis with wpa2 and wpa3 APs.
>>> The majority of reports are from RPi 4/5 users which have brcmfmac
>>> chips, but 85% of our distro installed base runs an RPi board so
>>> that mostly reflects our demographics. I’ve also seen reports on
>>> Amlogic and Rockchip SoC devices (also using brcmfmac); but to
>>> offset theories on it being brcmfmac specific, we’ve also had
>>> reports from users with Intel iwlwifi hardware and someone using
>>> an RTL8723BS chip. So it’s more likely to be an interaction with
>>> common code not driver code.
>>>
>>> At one point we suspected an issue with WPA3, but that was triaged
>>> with RPi developers and we now disable SAE offload which allows
>>> boards to connect to mixed WPA2/WPA3 networks, see:
>>>
>>> https://forum.libreelec.tv/thread/29155-rpi5-network-disappeared
>>> https://github.com/LibreELEC/LibreELEC.tv/pull/9477/files
>>>
>>> In the following forum and GitHub issue threads. There’s lots of
>>> assumptions, guesswork, and false conclusions, but among the noise
>>> there are some snippets of iwd debug log:
>>>
>>> https://github.com/LibreELEC/LibreELEC.tv/issues/7166
>> This one actually has some iwmon logs. Looks like the kernel is sending a failure within ~100ms of the connection which is odd. IWD waits for a successful connect event before starting the 4-way handshake so its not even getting to that point:
>>
>> < Request: Connect (0x2e) len 172 [ack]                                5.644853
>> ...
>>> Event: Connect (0x2e) len 36                                         5.735838
>>      Wiphy: 0 (0x00000000)
>>      Interface Index: 3 (0x00000003)
>>      MAC Address 00:00:00:00:00:00
>>      Status Code: 16 (0x0010)
>>
>> There is also a core dump attached, but the back trace isn't of much use.
>>
>>> https://github.com/LibreELEC/LibreELEC.tv/issues/8731
>> This issue _appears_ as if wpa_supplicant is also running along side IWD. That is generally why you see this log:
>>
>> Mar 16 21:10:35 pineh64-b iwd[1046]: Unexpected connection related event -- is another supplicant running?
> 100% guaranteed wpa is not installed at the same time. LibreELEC has embedded style packaging with a read-only filesystem and no package manager. The iwd/wpa selection is baked into the image at distro image creation time and can’t be changed afterwards.
Ok, this must be some unforeseen interaction/bug between IWD and 
brcmfmac. Debug logs will help here for sure.
>
>>> https://github.com/LibreELEC/LibreELEC.tv/issues/8760
>> This seems the same as #7166.
>>> https://github.com/LibreELEC/LibreELEC.tv/issues/8762
>> Not a whole lot in here, but apparently resolved.
>>> I’ll need to rig a distro image for greater debug (as per James’
>>> instructions) to see if we can obtain more log output.
>>>
>>> Christian
>>>
>> So overall the "invalid-key" issue seems to be due to brcmfmac signalling a failure very early on. In a perfect world it would be great if we could capture debug/iwmon logs of both IWD trying to connect and wpa_supplicant, so we can compare the iwmon logs and see what each supplicant is sending to the kernel. The messages _looked_ ok from IWD but if wpa_supplicant works fine there is obviously a difference somewhere. As Keith knows, brcmfmac is kinda a pain to support as its the odd-ball as far as drivers go. IWD doesn't get much contributions from wifi vendors so any odd quirks only get solved by trial and error.
> It’s been seen on other chips too, but if it’s timing related it could simply be that brcmfmac trips the issue more frequently and that plus distro demographics skews the volume of reports.
>
> I’ll prepare some end-user debug instructions around debug/iwmon and then attempt to recruit some affected users in a GitHub thread. Let’s see where things take us. Thx :)

Thanks, lets see what comes of that.

- James

>
> Christian
>
