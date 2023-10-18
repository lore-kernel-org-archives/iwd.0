Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525C16427
	for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+1rFDHK"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-66d0760cd20so58084696d6.0
        for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697641003; x=1698245803; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ch4rvf43qx4f3hKaNy30zkNDLl1v+KZ4wwfvBUYathQ=;
        b=C+1rFDHK4glQD5hZ77YM7ZTHTBMMtF1uRV09gYd3rPQgsNbrRemCwYc7kReYozGApF
         ymt0m+Sas7R7dVGIj8tdOyZTleSM8X6OJu9HHzOKJbChCOHq9AIO4YtKOIOzJguc8rC1
         QqYvUqltsB8YBxtwjjTcBWjkkrO4gfJ5bwjh6Bx6dpRhawD4Usf5T3Cu29DHJk6XJvuE
         KBRwZXZRhywrSCTtqhSRscCLqeGsz8cfj0TNsaJmzJEzB+tD75Ao8GM5KHfVPbdCKT5r
         n64KiQeZ2hjra6coA8eHAjZIc84/K72+b0Xl9yZRbTariYwAdd98MpCluCmT1V8T6qW4
         LIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641003; x=1698245803;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch4rvf43qx4f3hKaNy30zkNDLl1v+KZ4wwfvBUYathQ=;
        b=EP2txlVU001Ma0XSqWJZdx66VqejnTxyKn39jZ5qXdEwqTqPbaR0yHgkhPhzDA/jVF
         HOk0+QxZLjKjV/eN32tUcyp+6c79fq3VQbWAGFR3edMlRr1D42ZGJjTPqkY8O6FbxsVT
         7/pqBKVObjQTnIESOB7u5LeLSGjKo3PuSKB6yOxWj/CKj2zh02MHbF+O3a/LFpTSFnpU
         BccPAvSYKghgHzsz3f8/P7RbUqodC3jlEU+aqo+8OaG4ZG/WJa/QZMOTNvjtQrlCrBCq
         Z8+Ln8mzpbxUeFWTOFYgBi5MkfFDXNOqoWtFTW25fTwQRWMTiEwdT87wwqRGscZzKnkF
         XKQA==
X-Gm-Message-State: AOJu0Yyu8LBdhGQmNKUZeWsJXDP4a7jdsH9YVQsbS/z/2nqyXDpm1j36
	C0fZO6PFyhUxg5bNzDSELWs=
X-Google-Smtp-Source: AGHT+IHnWcnTLf4X6Vj5C+KVxiaNLli5JxjXjn0+P9qFBiH5c2wv5dQ5DHBHSYaEwg5UA8ukpfRbeg==
X-Received: by 2002:a0c:b2cb:0:b0:66c:f988:20da with SMTP id d11-20020a0cb2cb000000b0066cf98820damr6216537qvf.28.1697641003409;
        Wed, 18 Oct 2023 07:56:43 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id u4-20020a0cf1c4000000b0066d1f118b7esm15980qvl.1.2023.10.18.07.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:56:41 -0700 (PDT)
Message-ID: <222ec16a-6ee4-43a0-bb9d-17d258a0ba4f@gmail.com>
Date: Wed, 18 Oct 2023 07:56:35 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add AllowRoaming station property
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, =?UTF-8?Q?Pedro_Andr=C3=A9?=
 <PEDA@bang-olufsen.dk>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20231018122534.33455-1-peda@bang-olufsen.dk>
 <8bef6b0a-8284-4889-bd23-b33e26b450f2@gmail.com>
 <76261973-a04e-488c-8fc0-a0f623c15af0@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <76261973-a04e-488c-8fc0-a0f623c15af0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/18/23 7:32 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> LGTM, I actually needed something along these lines for dynamically 
>> disabling roaming e.g. during a software upgrade or some time when 
>> networking is critical. Just hadn't gotten to it yet.
> 
> I'm curious about the use cases.  What were your thoughts on how this 
> should look like?
> 
> I imagine for things like firmware update you still have a set time 
> limit in which this upgrade should happen?

I wanted to remove the possibility that a roam could cause a network 
timeout during an update. In a perfect world network queries should be 
fault tolerant and retry, but in practice this isn't always the case. 
And to be honest this is probably less of an issue than network 
congestion/latency on the backend causing a problem.

I think any issues that could happen would be entirely related to the 
infrastructure but nevertheless if avoiding a roam temporarily makes for 
better reliability I'd vote to do it.

For example one problem we see infrequently, but it does happen, is 
complete loss of IP networking post roam. Disabling roams during an 
update would at least get the update finished before this potentially 
happens.

> 
> Right now I like Pedro's earlier proposal with the minimum throughput 
> guidance. I think we can go further and calculate the roaming RSSI 
> threshold based on the minimum throughput.  This would allow iwd to 
> ignore roaming until that minimum throughput can no longer be delivered. >
> If we need a bigger hammer, then we may want to consider using an 
> implementation similar to how Modem.Lockdown was implemented in oFono.

I'll check that out.

> 
> Regards,
> -Denis
