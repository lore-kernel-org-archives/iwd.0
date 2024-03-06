Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACC5CDCE
	for <iwd@lists.linux.dev>; Wed,  6 Mar 2024 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727585; cv=none; b=u4WUqH8QxsmBowEipIcU8S9dbvWLW94TjwFLVy+X6TRvMeEVA+51M+6cXsz2eV4kl2Q772GHgDzTEeQ95FnTjnDQUg3BtRsr+rF52Vg2RObTsEPWFzUxreNdCehEhAWBjskkp5kb1tgDCjK0Vk8j60Q8CKn6Qz0j9JxjjQtQn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727585; c=relaxed/simple;
	bh=E/HqaTUqPkBwUfp3NDDSMcBwyV5MlblnI10ypxh9Ib4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYaay06EWbGH8HzKAOYFGyj/0yl901sxSPmJxeW3VofvW9o6ZILZjjgxdD9p7WEqqLFMV4g/BPGSmOY3q/eWmGjjLpfglbsr9cYU1jzDYyjNX8aOCmrS21gpGeJhTrEwcQAoheTu3V76qYkwPD8N6nmQo8O5TUG/HQu5oywPZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGs+1HT4; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGs+1HT4"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c1e992f060so2066733b6e.0
        for <iwd@lists.linux.dev>; Wed, 06 Mar 2024 04:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709727583; x=1710332383; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jh8aUDKc5QtEIKwMbhSPYl4pJqwYWaNJ/2ZokPCF33M=;
        b=ZGs+1HT45uI0xklI8A3wInGdYuLSroMtJuAZhRI1Mwj7qPLNHl2Ml+AX1ZclrYWh1d
         0GNer2C6F2SjYYUZ5Y7SMtNXvO+xv1e1nnvwPJ+S+8MGqA+NmcXkQfNePwAYBGfRgsPa
         ZcSXlh2SJQhYKCxZmj2KfMnnqLPuqo24Ewnh3G9RwgJJT+PpLj8RhT0ILWfkj8Yq16vI
         2ux02WGkgUYputOs3TGBLK2lSUb6sXC0xOY+AbLmqZsMtI/WKRty9VI7v90oHz3YORTq
         sWVYGCuWPiaUYi5oUrGdO/i8iTh8z0kd8oqdBQNcrYaL5jBvsC9fZl6SBI3BpaSAUskv
         v1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709727583; x=1710332383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh8aUDKc5QtEIKwMbhSPYl4pJqwYWaNJ/2ZokPCF33M=;
        b=lUOqZ001+W0tQMJjmmOL/ERYbWk/F+yMkaDmImq+ZJF+YjNBR/k3pVqr2c0SECIlEW
         1FePcEyu/l54gUla+Dod+u9nNmlne7lczp3hSSFl9oXgcvi61H5KjktbnTuoS+T8BOeC
         UIPceO4bH2Xm/zV0euC2Gf/SCkI1jeH99zW10uz5AMEhEDIQam2TZM3F9864vR8e89Z+
         QzRjE+1ZjtzRY2w4++qmWaIlqi+Os0AZ2rB+lgubSh/m7SbSGHf4A3AfIvO3NNFSpkaA
         aj9sSpYYxaDE6HIF+XUDWK93VEWwLXj9GC/K/FBgGywfe6nLKWnr0VqQrKrv6uC6j4nX
         CalA==
X-Forwarded-Encrypted: i=1; AJvYcCX75XE2omZIBBKKSNH5oLVocTYfT6PZjJaonRGJ6VWl/LQpdtJh785wDudpvlYAVjCHVG1KKQpTLpbhDxeVtFutOlYb
X-Gm-Message-State: AOJu0Ywu/xBVCt006S+k9ZWESHTql04pHVMkUt4m2ypDDE6ZPZU45Z4b
	KcKgdaRKWTiBhvj+/b1aR+Qb4IWliSHGn6/nt3b230UalQ8OqcU8hz+ORzZk
X-Google-Smtp-Source: AGHT+IERBUzGGEWGK6iichDXBPQPm0Fc76aAc1zCleUazEf2V4PNvVtQjie5cq8CgepG8/GfXxLVhg==
X-Received: by 2002:a05:6808:21a8:b0:3c1:e05f:d2b3 with SMTP id be40-20020a05680821a800b003c1e05fd2b3mr5754319oib.0.1709727583491;
        Wed, 06 Mar 2024 04:19:43 -0800 (PST)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id a24-20020a631a18000000b005dc491ccdcesm10613108pga.14.2024.03.06.04.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 04:19:43 -0800 (PST)
Message-ID: <047c2dfc-ca69-4117-a3a6-66790b9814db@gmail.com>
Date: Wed, 6 Mar 2024 04:19:41 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPv6 Privacy Extension support?
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>
Cc: Hannes von Haugwitz <hannes@vonhaugwitz.com>, iwd@lists.linux.dev
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
 <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
 <20240304193253.GA25@magnesium.vonhaugwitz.com>
 <BBC776B8-57F8-460D-A1CC-FD3B5A522311@nuovations.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BBC776B8-57F8-460D-A1CC-FD3B5A522311@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/4/24 1:40 PM, Grant Erickson wrote:
> On Mar 4, 2024, at 11:32 AM, Hannes von Haugwitz <hannes@vonhaugwitz.com> wrote:
>> On Mon, Mar 04, 2024 at 04:30:27AM -0800, James Prestwood wrote:
>>> I'm not familiar with the privacy extensions specifically, but you can
>>> enable MAC address randomization which should hide the MAC for you. You can
>>> check the man pages for more details but in main.conf something like:
>>>
>>> [Settings]
>>> AddressRandomization=network
>> MAC address randomization hides the physical MAC address but does not
>> prevent device tracking (within the same network). With privacy extension
>> enabled, the IPv6 address is randomly regenerated every few hours.
>>
>> For more details see [RFC_4941].
>>
>> Best regards
>>
>> Hannes
> James:
>
> I believe it’s handled in connman with these APIs:
>
>      https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/ipconfig.c#n528
>
> with the Linux kernel “use_tempaddr” sysctl setting. I assume iwd would have to replicate this infrastructure, or pull it into ELL and share it that way.

Hmm, if this is all that's required then shouldn't this already work if 
Hannes is setting "use_tempaddr" externally to IWD? Of course having 
this within an IWD profile setting would be nice, but I think there must 
be more too it than this right?

Thanks,

James

> Best,
>
> Grant
>
