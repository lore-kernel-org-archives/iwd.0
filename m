Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE41111AF
	for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 14:30:18 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5738cb00eebso1285685eaf.2
        for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694788217; x=1695393017; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARMML+xGEqa8kQRddLI3Y3+2TPZwAohBWhEjhRcX7sc=;
        b=FMkC2yyV4mNeOinjTat7d4Q2/KqJIAOhPANTZgqlzfN1OjBwfasMUrrvfnbuc+39TI
         BZeRQurqvhQJ0It5GR/K48h9vVnGupcc9Sw6iwe/GqT/XpfF4zAPg0CXaJ7VW8lk168P
         SJ6GqGzzM7MB9WLGMwtWCpRgVO4TL93+PF8y7k9p1aeBQEMD92CeRAB10tT+tUjnBvNH
         o0V/mNx/nb3DbvvuIR/kuH+8clC/II0R0Yzh7kePlHrGUSim2jNGfWL8s+0giSRkVhic
         4RKqsGs7YU1GUEsFvR0MzW/KbSdVO29JnjVSeldZA7BSF4juZoJiShLCuPuRB6+UWKo6
         z0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788217; x=1695393017;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARMML+xGEqa8kQRddLI3Y3+2TPZwAohBWhEjhRcX7sc=;
        b=M3Oy2dDaxCNYSCeIkvbgyTF6Nyvzb1YqcbMaxfs+UqCLAM3XQlcyGVzUHFN6Ln0ejQ
         3L1sprcVeJtGm1Bef7/Hj4ZdJKXY+q/fmiKfUWNDcKfOFkl75F6iEjCVr/BI0hSLPTp3
         NZ+ZDbmL5oSjIq7/LmNG9t+ilVbb5OBb8V8bhnUUVtxAQet+flcCAfClTxjEyfCIIKQS
         UuXtV6FbYKyPOzcpeGwIE0L7OLaSUU6NWxi4KdhEifmN4rxxSr934abJVkLwhDtf08OE
         UJUNNvTLo8nceS5o5BiYGwW2W6Exp8kG9uXF8V8F/3MWX/0Zm7fmkGKtcRZXX55wHhws
         ysPA==
X-Gm-Message-State: AOJu0YyXh3bcIw+BvXfSLkgyZIAN7JggazzK9Y5qV9p4F1GRkt3qo4/c
	EN/aSYT1fjHMFmPCoHz5uCU=
X-Google-Smtp-Source: AGHT+IFxgjLETiemxoFUnNv11zzqx0avVbtclNMfO5UaOehsqf+zh+5JHgkePyIXMCUX0DBHCtg5/g==
X-Received: by 2002:a4a:8781:0:b0:56d:2229:5f94 with SMTP id b1-20020a4a8781000000b0056d22295f94mr2136255ooi.6.1694788217518;
        Fri, 15 Sep 2023 07:30:17 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o2-20020a4a2c02000000b0056c81dedb3bsm1798675ooo.8.2023.09.15.07.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:30:16 -0700 (PDT)
Message-ID: <43d47533-a4a3-e3d5-8f17-30467475660a@gmail.com>
Date: Fri, 15 Sep 2023 09:30:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 =?UTF-8?Q?Jonas_Gro=c3=9fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 9/14/23 13:33, James Prestwood wrote:
> 
> On 9/14/23 11:22 AM, Jonas Große Sundrup wrote:
>> On Thu, 2023-09-14 at 11:16 -0700, James Prestwood wrote:
>>> Yep that would do it.
>>
>> automatically quick scan upon start: https://p.nnev.de/12646
>>
>> explicit scan triggered via "station wifi scan":
>> https://p.nnev.de/12647
>>
>> anything insightful in there?
> 
> A value of 1000 should definitely work... Are you sure the syntax is right 
> inside main.conf:

Careful about using high factors like this.  Right now the rank is computed 
using a double, but truncated to a uint32_t and clamped to USHRT_MAX / uint16_t. 
  This works fine, but the FT roaming calculation is a bit more careless.  Could 
lead to very funny results.

We may be better off introducing 2.4GHz factor and suggesting using a 0.0 
multiplier to turn bands off.  Or add an explicit setting.

Regards,
-Denis

