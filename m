Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448401A23BE
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824076; cv=none; b=snm67BWTniE18bVstbQAEArSQWNz4tmozAX0sm7moupoCsy0kc8L09lYdUm+dTeCu1xm/bAPpi7Sf+VQQxz1+Mi/nOdmv1/P3teNTikXbHh8AklFduYwD8duW54DsIHF1cJLRRwxpQmhr1Ks12IbgIyUGYmopyYOh4jtYaEnb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824076; c=relaxed/simple;
	bh=lm4AVFh3hVpn6eU5tLLSzmRdjEdRcJoFQWeoMeVYLu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EswNk9cOndTZbfJaCPe8gRiKo6G6wlsjBvL00AjYJVREsOXVDpf+0kMqdLJ8FiwJKhHfA2TorIwunGF5LCO/sllwkYfPZzTdEjqoZAK0pYbadXY6bYTr2I3da6ztceVMdo1vds0TW0FEbtZhZqzYpJbEPD86bDJl6uE6McPyrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHkMHva6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHkMHva6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0e135e953so728769585a.2
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824073; x=1745428873; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lm4AVFh3hVpn6eU5tLLSzmRdjEdRcJoFQWeoMeVYLu4=;
        b=jHkMHva64GaOcpOHqf4ZoaL+dMYt+GUnzPm9dcmO9ot1jbtxLjmp0CO3oKEm9zf03k
         Rf+ifxQo/zneK5h5psyd7wfnHrKhIBeDmAPy4xfPD7+1q7AT9FKn6YlBmAZcaEUfjmKE
         Kq6fBIPBC2wZhuWHPaQlVjD/Q0ToAU/67E1XRojoj/dAZkDa40aCkOoRKL56VgnCmH6N
         rZcVhjHhTuFvregrNi863DQpsgEb/mLmG4jmO9Yca4+3DYpa1Z3X9mqHRlemlIOsIVLL
         G91I9D+cQgJXCeOyewVkg2kGFnMPrtrt4ST7qNs/vkZeVcHqHNRK2XqFloze/RvyLObi
         iLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824073; x=1745428873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lm4AVFh3hVpn6eU5tLLSzmRdjEdRcJoFQWeoMeVYLu4=;
        b=ETRSPnWHKOYM+bRYqjaoO4Pm0jdRTQBDL2/IaXE5YI9KhaYAIoraRBaRJMdbEySNJc
         tH2d28s8MsCK6l3VFxtYgNChaZh6i2WPY8Obc2LP1kBzKTCCh5okcE1I7OJ3cNyhuuUc
         mE95JBW17rpkp0x7kGu72Ee0sYLvC5lkIIu9EieXem/VR8U9MUhA/SFq1/jcgr2wF1Xo
         4KUy612TNfsipwNNGwSvMMQiDcOtOXQe7B1mfjUCsnr2pW2LSI7FCWYkfcga5H9Oyuuf
         XZAyb7OtKsvDhOP/l/5BMUJf1A5dcHYD1WWeFSNP+kwcKPNbTrICFMKbAk0FbnHFapgK
         vtHg==
X-Forwarded-Encrypted: i=1; AJvYcCVhk7J+whuXB4T28KF/OuIDiUHJjA6vHWjS7CEJE8zz453hn2eqG5u1M4HSR9JjUcF5MV4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyDR8rYZv+JVUw6dpirmbKbvo6AI0539z6/DAkYnrzOmYWwfnci
	CQTUiCO+1lg2h+5cV1wU6IPXDblCN807cSHrP4NT45Vv85Qdparn
X-Gm-Gg: ASbGnct3mEphg66bUjvrSxU/zLPhdsUpbogOP4I2jxSnXn/z8cC/GmZAme+C1s+EUdL
	RjHuEAwA28RYBV4hZNojeUPJEJgW0PDp+ESqRKDpfMk/DV/HXWMhkOJBl3BzbCDNcSUNuGf0pcZ
	4pbdfR/8FaJ5IoTfWXgEnpEf2MWSNipuE6esNukfcKD7MafUueJhlteh6OCOwmF5auoR484uEJC
	h89irmINGLfukDB0m9dnJS+tGp7BKsqCyoSQLGTVKQN40g2Tt6WPHfWWoKUQxVW+q3yGW9kTNKZ
	n0oMCgBStAMtdp5iIeRtJlksnEZJTabpj/G+Dsam56WF
X-Google-Smtp-Source: AGHT+IFBomBDpBUzDubHXFmcmS6VYP5aAWTfNvNw829HrTaNUxOU3ux8nrU7rcxsSGkuK8s4O6YT4g==
X-Received: by 2002:a05:620a:8002:b0:7c5:57b2:2cb9 with SMTP id af79cd13be357-7c919001f44mr368783285a.26.1744824072913;
        Wed, 16 Apr 2025 10:21:12 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0c557sm1083413185a.91.2025.04.16.10.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 10:21:12 -0700 (PDT)
Message-ID: <667e6c01-9782-4bf9-a2ed-971783c896f7@gmail.com>
Date: Wed, 16 Apr 2025 10:21:10 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] scan: fix out of bound array access for survey
 results
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20250416123414.114231-1-prestwoj@gmail.com>
 <20250416123414.114231-2-prestwoj@gmail.com>
 <b527f1e2-a619-45e9-b551-50482ba26588@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <b527f1e2-a619-45e9-b551-50482ba26588@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 10:20 AM, Denis Kenzior wrote:
> Hi James,
>
> On 4/16/25 7:34 AM, James Prestwood wrote:
>> The survey arrays were exactly the number of valid channels for a
>> given band (e.g. 14 for 2.4GHz) but since channels start at 1 this
>> means that the last channel for a band would overflow the array.
>> ---
>>   src/scan.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>
> Can I get some Fixes: tags for these?
Sure, I'll see what I can gather up.
>
> Regards,
> -Denis
