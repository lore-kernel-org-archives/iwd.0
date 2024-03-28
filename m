Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE9225D0
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644338; cv=none; b=Cvq5y/68s2Bd2LtDkEnYHYulV74I6MMXfSZtBlHdL7N6IWiYeq7PbfmiygDv7W9tVzzZqW/0WYoSaDGsVrtQaNucQ1MaRYBiQexwN9KAltqQ25a3opSL9iyNOCPJ8a7knkfrHCj0chYeGw3/wGvzFBRjzMcp6fpphY3boa/Lsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644338; c=relaxed/simple;
	bh=DVCiVo27kR7BH3EufWnLYmHhJop1Xdy311dujxEfhfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=stDcB3MoBHyDWSpYCUDJ+M4Jc18r/VQ0bdZRtzzZl4YKYyaHFigbJ3BD0GksAj1/SNXpwDEWVhtPSgYsH8FCQ8sJm989qe11nh9PLzY3+R8e2/+aair+9XvYaAj57is30W9ASEmi0JSTIQofIZmi9zuJjfvoxEmHjrQYCLsrtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUIoJc1O; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUIoJc1O"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a01a3012aso71286585a.2
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711644335; x=1712249135; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QX6SVi84w0TxqUVmJ7szOHS+9hFj+xgRGCsBfwxMfCY=;
        b=JUIoJc1OERD9mm+tZXh9/IFkY5UVWeHPCCVtEFOEkj8UdTWL0RXg1KVvsAxkpbxwxz
         hmREcqukdwF4D1Z5f+ZeUjvWaOpLgt0oH0bg7W1tXSoiLgFPs4eZBaomHS6wQNKfbp4x
         8vPFfpAEM4XIJqhEmR5eRtgIVcGBYfLm7QuPOUhsM1ipQqwXOa3SJRgPBcBtJ/VeHWpM
         N4C8rh/+dBpAYnM+IGJwewBsFGvMzJjZ0BfQHV9MLpNicz73HQq/kKAKzKjQTGhPhhHW
         QjURCj/zX/+VDTVdxbk6B+vwMUeOCy4d13Qw67+hm7eJ1IM1gntQGvFDysw0hAOLSo7q
         iNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711644335; x=1712249135;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QX6SVi84w0TxqUVmJ7szOHS+9hFj+xgRGCsBfwxMfCY=;
        b=WJKjRbL3swyxCuMnNSWg0YwiPttxCDy9ZZ5cA1bHmMnEE5mxoFEiRzcFu80W/Wuoae
         kw6SsX0yzHvDg2SSsLjYU7gYRkUKRaRQ5MD2z2bvHg4KBMYG6LZVtNULIiCfy//7mdeP
         +YE0HoihraY/ccjBZxA3ARsOwNNwsWWPFSwzY46VYe70LH+UD8ST1BdFa4tgkAM5/m7z
         p5e7hg6gMbsiE7Aje3jbRKu+WINOEDH26j7tNdq5pT1dwCEVIusMP+4R0/b6UymPIzth
         /5hE/JBcrp92ktieG1epZHvs6kp3n99q6gBbQis2YPnFqRg1gaqvton/VgV+84KRh4Ko
         JKRg==
X-Forwarded-Encrypted: i=1; AJvYcCUZwP+o0NHH/Q52Bd2PE2aQRT5I/+Mj29aM/DVSXzqzQIim25j3+UCUTZunrSP69JVkefYJ4uWTR/+wQ9kkMd32zQqY
X-Gm-Message-State: AOJu0Yz3rYQRggqIPbc+cb7KWnXPxjREzJxT1gvWZ+ZnaBIcmYCck+UD
	N2oxtw0Md8je2XyaccHcR2tiukyJVTHGIkNrLIL8dHATD+1znwpzp5ZztJ16
X-Google-Smtp-Source: AGHT+IE3PqBl08rwgmo6Y8I/Jt7otdbkwyAbd7cj1CcE97PUeAmlFxDHaDdM4uh7GdfWZkgcd56QYg==
X-Received: by 2002:a05:620a:4514:b0:789:f1b6:56fa with SMTP id t20-20020a05620a451400b00789f1b656famr4341744qkp.66.1711644335584;
        Thu, 28 Mar 2024 09:45:35 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ea16-20020a05620a489000b0078bc503bc4bsm116736qkb.115.2024.03.28.09.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 09:45:35 -0700 (PDT)
Message-ID: <e26370df-6a03-4b23-b71f-049b530841d7@gmail.com>
Date: Thu, 28 Mar 2024 09:45:33 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd picking worse network despite better one available
Content-Language: en-US
To: Sven-Hendrik Haase <mailinglists@svenstaro.org>, iwd@lists.linux.dev
References: <699c79ff-0082-4602-9bb8-475722563c46@app.fastmail.com>
 <16f79ea4-32a2-47f5-b6a9-cfd911454a6a@gmail.com>
 <07f49420-74e8-4954-bd87-9ae3290e86d3@app.fastmail.com>
 <5c42759f-abe9-42c9-922f-4568d4f04de1@gmail.com>
 <aa2a5e2a-77f0-4b79-80d0-6dbf877c5b6e@app.fastmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <aa2a5e2a-77f0-4b79-80d0-6dbf877c5b6e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sven,

On 3/28/24 9:21 AM, Sven-Hendrik Haase wrote:
> On Thu, Mar 28, 2024, at 14:48, James Prestwood wrote:
>> Hi Sven,
>>
>> On 3/27/24 12:21 PM, Sven-Hendrik Haase wrote:
>>> On Wed, Mar 27, 2024, at 19:54, James Prestwood wrote:
>>>> Hi,
>>>>
>>>> On 3/27/24 11:36 AM, Sven-Hendrik Haase wrote:
>>>>> Hello,
>>>>>
>>>>> I've spent a good chunk of my evening looking into why iwd doesn't select the network I want it to select. I have a network "Home" with two APs. iwd seems to strongly prefer the AP that is further away and that has worse strength as measured by iwd.
>>>>>
>>>>>    From some testing, I believe it has to do with the AP rather than the wifi adapter. I tested a wifi adapter using mt7921e and one using iwlwifi and the result is the same in both cases. The APs are both pretty modern: The one iwd doesn't like is a FRITZ!Box 7590 AX while the one it likes is a FRITZ!Repeater 6000. From the log it seems that iwd is unable to perform a proper data rate estimation and then falls back to some default. At any rate, the rank would indicate that the estimated data rate plays an important role. If I use the developer mode to force roaming to the AP I want (named "better" in the log) then I'm able to use it perfectly well with a good data rate.
>>>>>
>>>>> As such I think this is a bug _somewhere_ but I'm not exactly sure where. I searched the configuration options but it seems it's not possible to turn off the data rate estimations for the ranking. I'd be perfectly happy to just go by signal strength. However, I suppose it would be better to actually fix the core problem in iwd.
>>>> IWD bases the ranking of BSS's heavily off the estimated data rate. If
>>>> that fails then as you see the rank is very low as it defaults back to
>>>> 802.11b rates. There are several IEs the AP sends which IWD parses, any
>>>> one of them could be either not included at all, or not be formatted
>>>> correctly, or an actual bug in the parsing code. Could you get an iwmon
>>>> capture of IWD scanning your APs so I could take a look and see exactly
>>>> why its failing? Then we can go from there.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>>
>>> Hi James,
>>>
>>> You should have received a pcap file of an iwd restart in a separate email. I hope there's some usable data in there for you.
>>>
>>> Cheers,
>>> Sven
>> The issue is that the AP in question is not setting a bit correctly in
>> the HE capabilities element. As part of the HE PHY capabilities there is
>> a "Supported Channel Width Set" (Table 9-322b):
>>
>> — B2 indicates support for a 160 MHz channel width.
>> — B3 indicates support for a 160/80+80 MHz channel
>> width.
>>
>> And it then goes to say:
>>
>> B3 is set to 1 if supported. If B3 is 1, then B2 is set to 1.
>>
>> In your case B3=1 and B2=0. This is checked by IWD and fails. So this is
>> something the AP should fix. But at the same time this check actually
>> bypasses the VHT/HT/basic rates calculations which is why your only
>> getting 2mbps as the estimation. I just sent patches to the list fixing
>> this, so this should certainly help in your case, although the HE
>> capabilities will still fail to parse which means IWD will estimate
>> based on VHT instead.
>>
>> Thanks,
>>
>> James
>>
> Hey James,
>
> I just tested the patches and can confirm that they perform perfectly for me and I'm now getting the right AP selected along with incredible speeds so I'm happy. Looking forward to the next release of iwd!
>
> I also reported the problem in detail to AVM. Let's see whether they will actually get an engineer onboard to fix the fundamental problem.
Glad to hear it. The unfortunate thing is these bits come directly from 
the driver/hardware so the AP is probably just passing those as-is, 
which is what IWD does as well. They'll have to push on the hardware 
vendor to fix the bits. But in any case, glad the behavior is at least 
improved now.
>
> Cheers,
> Sven
