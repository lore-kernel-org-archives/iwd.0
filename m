Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA77D07C
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633715; cv=none; b=SzKpF2w06SJ+VzrO8noGEbuW0Iure9PDVFKvJEYbub4bPxhp/SHCufri5luRP8hXSJ1Rwc1xiBbQwABIUsM5wjOxlXUGXmpwVIjUr2drAaFp13q5Y5TnwE9VBiTqCx7kZga6q/hxDDr8awEMQ/VBKZpXMx7yNfWUSqKYe22dePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633715; c=relaxed/simple;
	bh=uppXBgj24Z1LtLhCAUig2wI2OdULt7CxnBFSub4DH/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vCc+f45jarnHzcwjukJjdzJU1ftrsPdqzX8fR+RNE6UEIOPAeNhI7HtS8UaV+DNFGRf89q00f8r8iiIH7Wu6GYRBFlnIvsUv6n50IzvMFxBzIGLJJDPNN6o8+KPOxinXT/wUYB88MeUZ1AQANiHXpoXaTvTJ7ou0m9E0h5yRpzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj3PG2xL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj3PG2xL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso1129411b3a.0
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711633713; x=1712238513; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zr3OjfzNPEbhH329lRa69f3R02pXGDi7VbL5IhHd+iY=;
        b=Aj3PG2xL2JkSJB91wSlH7kK5cpspaSS2IfsX8H4yrWs4nHJSil2Gh2eFsIDMud+zau
         OGxqJDhj21JbBEY5q4OZ5reEsfp5WKscIQy3EkwLEgys7r0RTdktxrtSHQ7kKyeTuoIy
         ybOVU4U7fM6Zq3A4PpvhNf8V+4XRcmt+isrfNJrCzQegeJuhnS2kWP/lT1d1Pzs+WHbB
         QuNWwCVHMef/6gv7EiE4bUJGSMwnx19YKE+8gaWEF+Ed2mr7WJrs7dh37ajXh0m/fhbZ
         1jPy0sBigL+luNdnJkOwF1AuZ9g6uvk7WlE0V4tPFuG4Cx+SA7UD+8+QqrEFUj8kv/Yc
         +KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633713; x=1712238513;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr3OjfzNPEbhH329lRa69f3R02pXGDi7VbL5IhHd+iY=;
        b=fmzXMe3SDcjwyzSLqv2+0ZETcNnpwz8f4eWntZtBcLUefgO/mGOLn8tOBfau9frgJ2
         NUTdnwDYTI6mTUL245AA8LufxWKKr6rLlF2YnXfEOU8wN3c9IjE0dqdrnuXA5GHv/ERs
         D5BKkuTh086bke8k+QLrpsE46nXeA6fRtP8V+mq3fqFkdZLu5dzpFJHxz2quhB1HAXBR
         Ex4yiEcLemPUynNvRyeDJVJnR5Nxlb8ksClVJzQ0yFf+nOm1rrw61943asBo/ePc7YFe
         F62nqRs//PJr8KXC79rEHp2874xuCtK8GO0s2q0s5UxTgRUIobAL/p1RD9m4KxH+reXy
         IOAw==
X-Forwarded-Encrypted: i=1; AJvYcCVgGkWhM1MFk5F9sPykshle35ynp4/4h+r+jw6bbh3EiNxpt0x7kdP0SGXbf42YT+LHXSoW9P/7ilYz5txdJLBzTa9F
X-Gm-Message-State: AOJu0YxAVk9O9PXHmKGoZzRtrQeMN2+BFwbjeQTo+94hnA6TMH/xNo11
	+OP1O1RAb1hiUP1KQudGOAJ70Ql/2HX9YKRUvH8l5smWcXBOjXS61V8dV3rp
X-Google-Smtp-Source: AGHT+IGbxaG8pfH3SyPlGcLEiEUVgZoFjVvuGFhJiphQqrDe5Y0Sc9ZdGNC44N39HQdMaSfuqjLolA==
X-Received: by 2002:a05:6a20:9f93:b0:1a3:dc09:85d0 with SMTP id mm19-20020a056a209f9300b001a3dc0985d0mr3499354pzb.26.1711633713089;
        Thu, 28 Mar 2024 06:48:33 -0700 (PDT)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a000a8c00b006e5a915a9e7sm1413581pfl.10.2024.03.28.06.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 06:48:32 -0700 (PDT)
Message-ID: <5c42759f-abe9-42c9-922f-4568d4f04de1@gmail.com>
Date: Thu, 28 Mar 2024 06:48:32 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <07f49420-74e8-4954-bd87-9ae3290e86d3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sven,

On 3/27/24 12:21 PM, Sven-Hendrik Haase wrote:
> On Wed, Mar 27, 2024, at 19:54, James Prestwood wrote:
>> Hi,
>>
>> On 3/27/24 11:36 AM, Sven-Hendrik Haase wrote:
>>> Hello,
>>>
>>> I've spent a good chunk of my evening looking into why iwd doesn't select the network I want it to select. I have a network "Home" with two APs. iwd seems to strongly prefer the AP that is further away and that has worse strength as measured by iwd.
>>>
>>>   From some testing, I believe it has to do with the AP rather than the wifi adapter. I tested a wifi adapter using mt7921e and one using iwlwifi and the result is the same in both cases. The APs are both pretty modern: The one iwd doesn't like is a FRITZ!Box 7590 AX while the one it likes is a FRITZ!Repeater 6000. From the log it seems that iwd is unable to perform a proper data rate estimation and then falls back to some default. At any rate, the rank would indicate that the estimated data rate plays an important role. If I use the developer mode to force roaming to the AP I want (named "better" in the log) then I'm able to use it perfectly well with a good data rate.
>>>
>>> As such I think this is a bug _somewhere_ but I'm not exactly sure where. I searched the configuration options but it seems it's not possible to turn off the data rate estimations for the ranking. I'd be perfectly happy to just go by signal strength. However, I suppose it would be better to actually fix the core problem in iwd.
>> IWD bases the ranking of BSS's heavily off the estimated data rate. If
>> that fails then as you see the rank is very low as it defaults back to
>> 802.11b rates. There are several IEs the AP sends which IWD parses, any
>> one of them could be either not included at all, or not be formatted
>> correctly, or an actual bug in the parsing code. Could you get an iwmon
>> capture of IWD scanning your APs so I could take a look and see exactly
>> why its failing? Then we can go from there.
>>
>> Thanks,
>>
>> James
>>
> Hi James,
>
> You should have received a pcap file of an iwd restart in a separate email. I hope there's some usable data in there for you.
>
> Cheers,
> Sven

The issue is that the AP in question is not setting a bit correctly in 
the HE capabilities element. As part of the HE PHY capabilities there is 
a "Supported Channel Width Set" (Table 9-322b):

— B2 indicates support for a 160 MHz channel width.
— B3 indicates support for a 160/80+80 MHz channel
width.

And it then goes to say:

B3 is set to 1 if supported. If B3 is 1, then B2 is set to 1.

In your case B3=1 and B2=0. This is checked by IWD and fails. So this is 
something the AP should fix. But at the same time this check actually 
bypasses the VHT/HT/basic rates calculations which is why your only 
getting 2mbps as the estimation. I just sent patches to the list fixing 
this, so this should certainly help in your case, although the HE 
capabilities will still fail to parse which means IWD will estimate 
based on VHT instead.

Thanks,

James

