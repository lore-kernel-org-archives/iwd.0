Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDA64AA8
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099382; cv=none; b=asl5QmQoJQTfpw1YiySk6hXDPiOxSKj0tV2wwMN+Hx3I6BGwg2u6+dFT7bS9T3LwxBQud+Ixz23JLCnKG7c3O1EtRVCVDT9tdmqnnLtJtJOyMqAI7udI1m7BNU7ZwZdI+HeOSP4921E0l4YkVvoiNX8C3Crvnfl54d1Bs9QJziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099382; c=relaxed/simple;
	bh=3uaEU0uPFwNvbfmaBsuUrYOEYONxYMHjcnRmgnQw8mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o++POuNZAshLBICEwfXrWxc4/pLjq0WhAXj4VzoKlFmiZRnXLkviO6CXCEAC8BFcUYipBcTVxbbt/yWgIYSO4ybua/unDB7oelxfmTk+uGqhveH84XszwGqz+bt8jM8J6MmelL3Kx/boLGwZ4HpoDFzqgqCvNpaGfS+kEmkvkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv9xTpC9; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv9xTpC9"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dddfdc3244so3874217a34.1
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 04:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706099379; x=1706704179; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWukRaVL2h90kPk/BAdYIltOGC9+YcP4aqS1z6qqdKU=;
        b=Fv9xTpC9a4i9Jw9R8fOAzEZeilnhxWImUOZINIbeCJHSzKzCc+7cD+B0XdNrTzP6QC
         4oxZsovXDUeQ0/k3bxS1DrUGHBsLdoJcBvMFDRRVFnCcudZfSKaDvXswJ6ZaJoBaMjia
         vFA0M4agWw0Rc127frIA9ocwG+dRowWaH5HlLTOkej+VtISQ3K+bsir0i8fzgAUQhjIk
         Mvp9to+7mxnUcN81boAUGtcDijiJ049BSfUmELTmGwpt8uh7Z8+nD5Oy/zbuvF6ebax9
         f5MLVGsRVRDcx1D26/28/IM8WJmsyFDRptl1c2uWdYtXLTJ7ZytxfaSpZjy7A2rpIHtV
         rk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099379; x=1706704179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWukRaVL2h90kPk/BAdYIltOGC9+YcP4aqS1z6qqdKU=;
        b=lTFKJcSRLVo7wGNYHqRr696sEj592UrMcTBHB1VCxjsBKc39ckJzlfUSeegsIBBWbd
         LpAoc//ESDYynSeYoBROXlUE0JVhYS6+2d8IXjh7LtHx5NBYU1kNP1kUKFoEUwc0Aotr
         fEq+NO75LcIu8A/Qx9txCKJm31maSwNyYGaMkBe95kIuKj3YZwJoDo+SMMoQhQ1BbeWx
         WIjpvmZMw/lxZc5NZwe0on44XiZBfRB6PHPCA6Jy8BfRhtM2Vve+TixfyKKmbWJ28Hwc
         GzANGxJgwy4Mm53q8m1ZmgxJaeKuNTs/aw0JDbBLR+AsOR6Jhf3SYFE0PZUlGdFrIp8b
         eGrQ==
X-Gm-Message-State: AOJu0YzoFiwdnnW42MGQJ74Sa0DzAh59E+wruu2ggRZTAGGl9hOJ1xgZ
	j1yIEO0STGbb55Od6ZTisyXcb2Q6ERe8TelF137pyqtAihiU7Xd6hUgrFaDbFWs=
X-Google-Smtp-Source: AGHT+IFE5cW1tD2YgwVAdxzFsDDh6zUaSdepwLRzCosUOBXrKqmtU2kb03GmqM9O5CdFGh4WQ5j2vQ==
X-Received: by 2002:a05:6358:94a0:b0:176:4b1a:8364 with SMTP id i32-20020a05635894a000b001764b1a8364mr4675918rwb.21.1706099379558;
        Wed, 24 Jan 2024 04:29:39 -0800 (PST)
Received: from [192.168.254.83] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id v7-20020a62a507000000b006dbd17f833asm7785540pfm.0.2024.01.24.04.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:29:39 -0800 (PST)
Message-ID: <fc3962d4-dc38-443b-b8d0-df3e57bc591d@gmail.com>
Date: Wed, 24 Jan 2024 04:29:37 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iwd: unable to start AP with NXP 88W9098 chipset
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>, iwd@lists.linux.dev
Cc: gregory.clement@bootlin.com
References: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
 <c11d1310-a0ca-46a2-b08e-d1e35351826a@gmail.com>
 <8c484950-c99d-47c0-b048-5a447cffd719@bootlin.com>
 <edd63888-bf1f-440f-98d1-3fc33fc2b609@bootlin.com>
 <2f3e11c6-bcf8-43fc-82a1-afe836d37a2d@gmail.com>
 <46d06d59-3695-4062-aebe-7e124fa67446@bootlin.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <46d06d59-3695-4062-aebe-7e124fa67446@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joao,

On 1/24/24 2:18 AM, Joao Marcos Costa wrote:
> Hi James,
>
> On 1/19/24 18:44, James Prestwood wrote:
>
> [...]
>
>>
>> Prior to me adding HT (high throughput) IWD's AP mode was just using 
>> basic rates, so very slow. I added HT support, but apparently not all 
>> drivers were happy about it. So DisableHT removes the extra stuff 
>> that allows it to work with this specific driver, but at the cost of 
>> performance.
>>
>> I'm not really in a position to devote a lot of time to AP mode at 
>> the moment. I know we've gotten a lot of inquiries about it recently 
>> but to be completely honest if your intent is to run a full fledged 
>> access point hostapd is really the tool to use. I'd love to get IWD 
>> up to the same level of quality and support as hostapd but its a 
>> massive undertaking. Not only that but out of tree driver support is 
>> something very hard to get right. Hostapd has been around long enough 
>> and is the de-factor software for APs that hardware vendors have 
>> added their quirks here and there, IWD doesn't have that luxury.
>>
>> Thanks,
>>
>> James
>
> Thanks for this insight. I'll keep DisableHT for my tests, then.
>
> However, there's still something I don't quite understand. I'm trying 
> to set up this AP:
>
> [General]
> DisableHT=true
> Channel=36
>
> [Security]
> Passphrase=***********
>
> [IPv4]
> Address=10.0.5.1
> Gateway=10.0.5.1
> Netmask=255.255.255.0
> IPRange=10.0.5.100,10.0.5.110
>
>
> but I keep getting this error:
>
> # iwctl ap muap0 start-profile smarc5GHz
> Argument type is wrong
>
> AFAIK, 5GHz band supports up to Channel=37. Is this supported by iwd?

Could be a regulatory domain issue. Try setting:

[General]

Country=<alpha2>

For whatever country your in:

https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

>
>
> Thanks!
>
>
