Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B7155A32
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207703; cv=none; b=tzUJCk9tn1/MIYBLAqQB894L4H+2yJ9U1jiw8jH08+fzMpKBSTE7QGsyLOG+yly9lPMM1ylVz5CAa+80iQtMcTdQAk4+v1zGDZtrEjGcPOKRKpuJCC5A73i5Ep0sscqS75iJTGrZbU9lC2tRi1LtE326nV1K/1oXyuBx9qLGFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207703; c=relaxed/simple;
	bh=YnKmowB5LAmCBkB1qtoVtkQ6mLteiLW/cXYlubf+OlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l+p/2ria0yX8xa7F13kG1KV5GHvzZe4ITXOhqf97aVU4wNy0hkO9LKVW9KpePLblzh2W8FIDLbQ3REdvEoUKl6ORtJj0/RQ+sZBRl3iBkSVBkILDMIY5IBeoshrsgt07AumHTOJjJ1xcUL5AL4KogSRw9AqWUpg/c58uCYwW4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoGgSljv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoGgSljv"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d620408f8so293586085a.3
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713207701; x=1713812501; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qKV7aqaz6EQ/1wZRNZGCqYIRXstgMAbQHSxlQ/GICI=;
        b=VoGgSljvQWpudEv6yrZ4bxy2B5mqqgfPRtNy6ZBJg14mSTSTGOqXWVFkXEPm5mMiH2
         QvOlNwmN/bG7QFzMhsSMl0Nhhk7Ibd6YGKzh5B0mYDpaSt2WTwWqq7e7BbLTff6qy6vw
         r/WLz9B3r52T4HMyAtsx5Fo02nXX2XDggS6PghYNN0DXgIHfGGGoppMoKFbuscvTw6/L
         lHX/8SAuDiYWFqE5tkfv2ykSCUbLQvJUurWAodX8uxWcmnQAWcoEGu0wk51W5VrxPHSJ
         IDnLCDkZSxU2OG6Ag3ZG552uW7PjwlGprNVN9nRweTnNrWRLP8jFmz2Hpee1fxkL0Om2
         gBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207701; x=1713812501;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qKV7aqaz6EQ/1wZRNZGCqYIRXstgMAbQHSxlQ/GICI=;
        b=q8+f4VnknOYrcUpQ2wcdC81UoBPRe7XN0IFWiaCvlJjt+p5+cXKe/wl2Lge2g2GN3u
         gMzUjPAJ+Z9WiDJNXyGDVftO2Cauf1pNHK3oeaU81WFZFJRnRfFvVY3u6Y7CdbdbIIJh
         ysIcy7UTzT9tlc9/i4O8Nw0utcRpMReHjJ0FOUk4NYIhf27X52oIWAECZeTdCfytgqeJ
         7lX8vV70XS6KwNFslacpydvgo8X6D5WaPYkyf4LoEmC3sQhi6CcF8hpw1DPhrZFqT6jp
         ktn2ZhkeYe303CDKv1l1diKr7VdceylnkEBhs9m8Ux23NRbzvHLbW1j6ax9d2Vbxd7on
         dIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXjcSC6ivefDKaeMrIfSs2nJBUwJa7rbSgvLJ95+ZHDPS3pJTPAOMSCqgwD3tbGYEcply6VnErRB0+7F6KUKSVMQU4
X-Gm-Message-State: AOJu0YwNIKBo0m/565J2u4fjf65tKmm45ZNfhHnkpyIcNw8s4tJBqR9b
	hfDhpfBULLUGorxW+Yo9CV5Ppoba/KCLfDixik9zVVsQBJiZ4r3n
X-Google-Smtp-Source: AGHT+IHNBP6UuBwahlG9W9/ZIofhGOfe/PMRnAv538SDCsxn60f6sBpSoDsVims7WuZpQzgpy4pZDQ==
X-Received: by 2002:a05:620a:3bcd:b0:78e:ccd6:be8a with SMTP id yf13-20020a05620a3bcd00b0078eccd6be8amr10481376qkn.57.1713207701465;
        Mon, 15 Apr 2024 12:01:41 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a084d00b0078a04882ac2sm6624179qku.53.2024.04.15.12.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:01:40 -0700 (PDT)
Message-ID: <8e9b5eaf-6ac2-433d-9c49-5f1fc3912924@gmail.com>
Date: Mon, 15 Apr 2024 12:01:39 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] band: return -ENOTSUP when RSSI is too low for rate
 estimation
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240415151130.40389-1-prestwoj@gmail.com>
 <873738bd-0761-4b0a-bbcb-cf76ea8f66e9@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <873738bd-0761-4b0a-bbcb-cf76ea8f66e9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 4/15/24 11:47 AM, Denis Kenzior wrote:
> Hi James,
>
> On 4/15/24 10:11, James Prestwood wrote:
>> This was overlooked in a prior patch and causes the rate estimation
>> to return -ENETUNREACH if the RSSI is too low to support the
>> various capabilities. This return was unhandled and was treated as
>> if the IE was invalid which then printed a warning.
>>
>> The low RSSI case should just be ignored, similar to if the IE was
>> not provided at all. In this case return -ENOTSUP so the caller
>> moves on to the next capability set.
>
> Err, why?  Just handle the error code.

Seemed better to do this than checking for 2 return codes. And IMO "Not 
Supported" actually describes the situation better than "Network is 
unreachable".

But I don't have a strong preference either way, if you prefer checking 
both we can do that too.

>
>>
>> Note: this does result in most of the estimation functions only
>>        returning 0 or -ENOTSUP as they do little to no validation
>>        on the frame, but rather just test bits. Additional
>>        validation could be added in the future which would be
>>        handled by this patch.
>> ---
>>   src/band.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> Hmm, this set is failing CI for some reason?
Ah, good catch CI :) its because test-band was expecting -EBADMSG when 
all MCS' were unsupported. Really this is a valid IE so we shouldn't 
expect -EBADMSG there but we do. I'll have to change this, or check for 
-ENETUNREACH if we go back to that.
>
> Regards,
> -Denis
