Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2E1D6B6
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZoMwzI/"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b3e7f56ca4so615276b6e.0
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698941625; x=1699546425; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCc0xXG7qNL28SFR0pwjplXiXPBCFGx9NDWLX4fZtOA=;
        b=OZoMwzI/HIcs1fobcxffZntfjqDq6IUX6/TnfZEGKPd1OpfPfs+HQai3VqKAy9whWv
         yGzmk6z6BMwSY88dFMbTEvPNtSCjls3PEUqNVThG35AtlVNS6cyYgy5ULbnku5FsLlY9
         bPCCq1HIRTP07CxiUScjD8uGJG293ziBY7ljxB1YJ+ceB20AhcU3gpH9t/OzqI4M5THC
         N4AesjYakBntDJ1GWLAgM8kKWDnDSbKn0YEfXqHYM6IdFyMdZ08zch0pfKs/X1gnLVa8
         ScUaeYJzU6X9J2DRlY9H+rXpfYO6+jDstmXhbtGZpfUFbbbABPC5RLCRYhU1719zNrSn
         KuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941625; x=1699546425;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCc0xXG7qNL28SFR0pwjplXiXPBCFGx9NDWLX4fZtOA=;
        b=bUe0ijUvw4Ri7A1OndU1wWSoO02TtdMMNAQAz1VGN1q0Aeet2dx/ltqaghXuqyr4G9
         9i1UsX0hkqkQCDDJVTaWTBVddsc/tBP4DN2N0ByFdeSlzE+dk6+1ziMkmziSlk63DjxN
         DXBy875bnTsJAPKcOcAw4ZYui/zzuR1NrGrS800PloXYxUT4peIG6HnvXVY3GfOsSS9q
         KUFijXfiL1CEOIy4V1qDbwR+hbjHGkx62oxotCAvdeUdw9F2HOZKYCNwaB6uKNw4bHCm
         43PMQlXr9QG/DD2CJoDevppP7HOA5KBaKnnqKDonTN7VFZsddAM4kWmzqzV3J2v/xxzH
         UmjA==
X-Gm-Message-State: AOJu0YxBaQZHTnMfE++8N4LCIsFY+TKbyZKHkQX6nfjXNj/qNhA6kVOQ
	zPdKTbKIO47xvr9pZYg9d5EUeH/OvS4=
X-Google-Smtp-Source: AGHT+IHN+5NHE5YkHZuiVwgOC2AeQBpfs4Nsi41Zt2IvHKM0E41dZCCj1EfrKrV0nK0iBmhADkxQSQ==
X-Received: by 2002:a05:6808:85:b0:3b2:f489:4499 with SMTP id s5-20020a056808008500b003b2f4894499mr19994868oic.14.1698941625133;
        Thu, 02 Nov 2023 09:13:45 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z9-20020ae9e609000000b0076ef3e6e6a4sm62997qkf.42.2023.11.02.09.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:13:44 -0700 (PDT)
Message-ID: <1574cf2a-a492-47c3-8314-0fbca03aec7f@gmail.com>
Date: Thu, 2 Nov 2023 09:13:42 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
 <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
 <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
 <be09ed30-f92c-4f9d-897d-77d9d5f7a919@gmail.com>
 <16ab09cc-0ba9-4c01-9f92-47e05aac2160@gmail.com>
 <424127a9-af47-4a15-91f1-ff97e7ceacc8@gmail.com>
 <99451a2d-7b3d-4927-a733-a86e58c81a4d@gmail.com>
 <e93105bf-c3ad-45bb-8f52-3eac5035bbae@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e93105bf-c3ad-45bb-8f52-3eac5035bbae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 11/2/23 9:10 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> I wonder if we should be limiting both known networks and frequencies 
>> in those networks. We do push new frequencies in order that they are 
>> added so it may be nice to just pick the first 5 or so in the queue. 
>> Then we'd be capping 25 frequencies at most instead of the whole 
>> spectrum in the worst case.
> 
> We should, but we don't track them in LRU order at the moment.

Yeah I see that now, we just add them as we see BSS's, not when we 
connect. I'll put it in the backlog and see if I can come up with something.

> 
> Regards,
> -Denis
> 
