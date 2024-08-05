Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130FA139CE3
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861884; cv=none; b=DkFGzJWrxyHbU4zIjHkwwMKNF4WYzp9EZKMn9AdK09M5d1fthWlrpcH+RuPcAjJoWoQ37RvbeTpTkJFHbtcsJ6K7h3F+UeiHIp3g1imjw+M3hVcoPZVmwV5Rns0FnhWm5FsUs1apmUrf3zWt3e0IcKmfDlmDCKGdxYtsiJ5/nT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861884; c=relaxed/simple;
	bh=X1FIMAcjJVUJrZ95esWS0X3COrzxNQH5iomJemYGoeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph1ofi/SUHJeVHdN0bbjxuXoXFXpwGyR1oIv0kDGRu1jFOcvGqcfbdM8k5/J+GZg0ycXW+tSxND5uUYe5ulFERI3Ny5t48U93j3YRwu+5+/RjWzQKEfFAezw3LUQXs9Y5bskzYqk/S+Cjk/TYt5bDYMz3mYS5a2slKV4KD0ftFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSPpRcYk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSPpRcYk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-66acac24443so93464377b3.1
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722861882; x=1723466682; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIIbJHhi7fnwyg9y7NfeHJW8B65XTARe+STKb0GgEAA=;
        b=kSPpRcYkRpp8WA3Qkx7dXbsGoxhTEEy7y/bvIpi6YSMbb8CkT89uf4DRzpQXCBTMst
         /Xz+36iNWZHlvYceA2qgRnpKc+MEWMCrWJfbGwZDnVlENpBuLePNXIKP5vGcvhc2746E
         gQm72ZjA2yYOIq3WkchDbbEvcpAY8RpQfywMo+1LDb9ydX1ohRiCYBgKwVRTvbnaxPpH
         rfevs3RjQIWMuZynTz9q38jV91Dbn67z0JsppJxuRYgy132uuZ4VBTR8Jk+JfNKIU3VK
         3m1i2cwmdCLIiPFxSBJMYgo9sunuQZJnjqkc/f8Vp3Laf3CzAFGjinErevouCn8Bp2zZ
         cCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722861882; x=1723466682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIIbJHhi7fnwyg9y7NfeHJW8B65XTARe+STKb0GgEAA=;
        b=YiPl75/RiIwEtBJ6JtEcaOLfsQOIheHMXtJmqJngwrBrDK/eYrlPk9EqzQc0i+5Pzs
         DRtno8ZqtOCDolyOCGvzVG7f00TNxHggHyG2Xmq5MoUAUBALSXS1LIUYvSlWxtq9SWP2
         LE24D+Z2z51XJaUt0MdLXpiKooj6//lfTB8+QIn9VImxwxKQjytn4BsqeFahREeFNPR8
         MczxViM4tzYXap/zjelpAiZMgP0WzTsqEeDY8fxn/9+0MJWhvgcfYmi+u9FrvGTbKz+4
         HPX75Uu/0zDzVoYOiTsJs3jBH3+pRQZwjkPBO6PbywkUJI3BvKZcT8L0jzsHwN4d3qpi
         FAdA==
X-Forwarded-Encrypted: i=1; AJvYcCVcE2V1lDlZCVGtIPVbNsUBwxsMzFVfZqSozRXNpvlBOSSFUMCAX9qSu9jbv2+gLAkWeeiIHPzm4E0hoSiOsIBNykOL
X-Gm-Message-State: AOJu0YzJLq7zjdNrTbCHu12kWBk/Wr7ydjf1MOCP82U/DimVCjN6nUtl
	vywoe15v0r2gcZUQ+pmTyW0Yvrb1KsvrDYgtn3/AdfnM9DiZ2iDFLjrrYA==
X-Google-Smtp-Source: AGHT+IH9M3SSMiYR05ZAnQmcITtij0zMJ9je1r04Rt6yHuPRFHJh0GMhAp+uu9SSr16ySRZBg6L89g==
X-Received: by 2002:a0d:efc1:0:b0:62c:c641:f98c with SMTP id 00721157ae682-6896141b1f3mr112625467b3.22.1722861881918;
        Mon, 05 Aug 2024 05:44:41 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6aaac2sm29003801cf.14.2024.08.05.05.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 05:44:41 -0700 (PDT)
Message-ID: <70e5936f-c789-4f56-a275-e1b559ea27fe@gmail.com>
Date: Mon, 5 Aug 2024 05:44:39 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPv6 Privacy Extension support?
To: Hannes von Haugwitz <hannes@vonhaugwitz.com>
Cc: Grant Erickson <gerickson@nuovations.com>, iwd@lists.linux.dev
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
 <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
 <20240304193253.GA25@magnesium.vonhaugwitz.com>
 <BBC776B8-57F8-460D-A1CC-FD3B5A522311@nuovations.com>
 <047c2dfc-ca69-4117-a3a6-66790b9814db@gmail.com>
 <20240804210103.GA25@magnesium.vonhaugwitz.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240804210103.GA25@magnesium.vonhaugwitz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hannes,

On 8/4/24 2:01 PM, Hannes von Haugwitz wrote:
> On Wed, Mar 06, 2024 at 04:19:41AM -0800, James Prestwood wrote:
>> On 3/4/24 1:40 PM, Grant Erickson wrote:
>>> On Mar 4, 2024, at 11:32 AM, Hannes von Haugwitz <hannes@vonhaugwitz.com> wrote:
>>>> On Mon, Mar 04, 2024 at 04:30:27AM -0800, James Prestwood wrote:
>>>>> I'm not familiar with the privacy extensions specifically, but you can
>>>>> enable MAC address randomization which should hide the MAC for you. You can
>>>>> check the man pages for more details but in main.conf something like:
>>>>>
>>>>> [Settings]
>>>>> AddressRandomization=network
>>>> MAC address randomization hides the physical MAC address but does not
>>>> prevent device tracking (within the same network). With privacy extension
>>>> enabled, the IPv6 address is randomly regenerated every few hours.
>>>>
>>>> For more details see [RFC_4941].
>>>>
>>>> Best regards
>>>>
>>>> Hannes
>>> James:
>>>
>>> I believe it’s handled in connman with these APIs:
>>>
>>>       https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/ipconfig.c#n528
>>>
>>> with the Linux kernel “use_tempaddr” sysctl setting. I assume iwd would have to replicate this infrastructure, or pull it into ELL and share it that way.
>> Hmm, if this is all that's required then shouldn't this already work if
>> Hannes is setting "use_tempaddr" externally to IWD? Of course having this
>> within an IWD profile setting would be nice, but I think there must be more
>> too it than this right?
> Is there any news about this feature request?

I was still not sure exactly what needs to be done. If the sysctl 
setting is all thats needed, this is an easy feature, but you had said 
setting that manually still doesn't enable the privacy extensions? Is 
the issue maybe that IWD removes the wlan0 interface on startup? So 
setting that sysctl setting manually, then starting IWD, is clearing it?

Is use_tempaddr still set as expected after IWD start?

Thanks,

James

>
> Best regards
>
> Hannes
