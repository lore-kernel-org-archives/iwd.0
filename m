Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DDF405FB
	for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658689; cv=none; b=OPA28iUTV88Lgjab5UkJ86k54wZ+OxJ4OzC9R/aHhV56QUuqMd7pXNiQUWxhCWk26SI+U+7ZHeFFfZJLIHq5aE3H14gFIghdkvV5SkVjMa7t+oijIz+0O1Y0F7wtT1lUDY9KumS5649fC4JPjlcbEnvA6uZDhuIY0PVWTHNesD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658689; c=relaxed/simple;
	bh=KMolJLx/p1laRqUVXITkLQXilnyvZG2pS3gKxLv6OyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sLDjgHiLtkZyo44enDrQNFt/u5mBYUai8XXyy8JSjsQha0trWMjNEwwjm+EvBk0/Z2HYlidg8pJAD74KSPvG+feXl9CV2lXV3lORSrQJwdFPSREfh+RTamYqTDO1oQ8+xOqmI2KzOIQdDQ053IOQpKFXNZJrkAxMB//ySUFDoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XujgRj34; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XujgRj34"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7ac83a98e5eso180669985a.0
        for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658686; x=1729263486; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX3v/C2mFMVMzIVyhJQ6391Z2O6eREON4ulFxUOxDwk=;
        b=XujgRj34qrRK/tVvnUa/bXJgTSmnPKKEtEx05Rz5ZTzlnFTOxsoD4ETuAuSm3mvb8F
         YTzSFHfsBIplguGoeJL1Aukp33iL4gl0R0mXHCr+2FGwGyDitu7ZGgivhpO3aFuXENah
         dhDXRqZt0mvyjeCCwdVrMbgQBsd4lhJfUzrfKQ/HdHmXmfENfpWhbQdjYnVoEdpsIbNW
         hPj+gDVKWb3rP4zy/8ycFAMWgPwyLp9o1mEW+3nl9tTstms/BAqIez/6c1lvP3bwzAL5
         vXEPiJ6vUvUIuZRsfTxLJN2ox7ZBhAklDaBg4eEUOTKXWIJTW5WycOabzg8dWCDv0RhG
         RDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658686; x=1729263486;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX3v/C2mFMVMzIVyhJQ6391Z2O6eREON4ulFxUOxDwk=;
        b=eNH+xLqI7aPzCfvOT/o2NRYGE92K9ziZoSbeqaZW+zkmZ21swjegM7BO2B5zFmU3WI
         8efKyhbujnWD455K1xN1cmtAW+36BaKZrvGoFN5vMCFHlRFNMnB2ZY1bYrNvBehUguUL
         0yFi+glXjhBHbFV5qD6cutgZvo77h9MC/4JwYqABwdfcMZGPC6egdKRy1r+OWNoN+lUd
         LOIh9PH/9+TSCCYZyST4mkDmi1ma0nfJFbtLxAQ9Tt5ze3pi84AxTxAZgkhVrLlxoLPB
         1PQNZib3DFBoXc8CAJMrk1Ew1SYEbCy5MYF/MtG6vlhVrVilNqeI9tGzAPRi8ojAYaOd
         g15Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9OA20FShVl/wWUKCNjX46gltmfTwrHZY8PeKmshNTPWUWCFwoiAOCxvV3GfUQZkAvjn4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxfYyG8KLxPO7+BKqLUt3VDTT7E3lKXHNx11OLenJAS0i6FCzpP
	TaQVjgrmd6Ur72R0ZmSD3YicDUI18da6OzZMWt62GnFXV8+QA9aXL2+Icw==
X-Google-Smtp-Source: AGHT+IEFxNxFQYqcjiNnsfLjUgtT2G/LAAW3YJg4+s/UU1IqEO47m0yojERhBqC9moejWVnl+sx7dQ==
X-Received: by 2002:a05:620a:46aa:b0:7a9:a389:c12e with SMTP id af79cd13be357-7b1124c81dbmr1190222085a.16.1728658686453;
        Fri, 11 Oct 2024 07:58:06 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148f032asm138993885a.60.2024.10.11.07.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:58:06 -0700 (PDT)
Message-ID: <1565c790-83d9-4972-b0dc-e9f575bc8d93@gmail.com>
Date: Fri, 11 Oct 2024 07:58:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098
 chipset
From: James Prestwood <prestwoj@gmail.com>
To: Dierk.Modrow@sew-eurodrive.de, iwd@lists.linux.dev
References: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
 <c477b2d9-dcc7-4ea7-a6b1-47f6f84e4736@gmail.com>
Content-Language: en-US
In-Reply-To: <c477b2d9-dcc7-4ea7-a6b1-47f6f84e4736@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

H Dierk,

<snip>
>> I also added a sorted log file containing iwd traces, iwmon text logs 
>> and kernel msgs (of the NXP driver): 
>> resorted_logs_of_iwd_ft_connection_trial#3.txt
>>
>>
>> We would like to use iwd instead of wpa_supplicant so any help would 
>> be appreciated!
> At this point in time looking at the above logs it appears IWD isn't 
> compatible with this out of tree driver due to the requirement to use 
> CMD_AUTHENTICATE. I've thought about adding this back in for "weird" 
> drivers that have problems with how IWD works. For the near term we 
> could try and detect this case, via the CMD_REGISTER failure, and 
> disable FT entirely for drivers like this. You'd be stuck with only 
> reassociation but at least the device could roam. I can get you a 
> patch to try soon.

I just sent a few patches to the mailing list. Would you be able to try 
these out and verify the device roams? Note, its going to choose 
reassociation now (if they work as intended), not FT. But any roaming is 
better than nothing at least. Longer term we can think about using 
CMD_AUTHENTICATE for drivers like this.

Thanks,

James

