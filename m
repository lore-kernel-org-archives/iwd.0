Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B41684A6
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721647416; cv=none; b=s146UiVkJ1k8qUdFrIvJQx8JJO/ud8bpYmXbbBT4zRw1Lvfs9B3ExZ0rOkgwV6emNUAt6EQQWgSdXvcBYTdEr7IqjELH3fNWSR/c1BP4Q1La55c54NCmK2EGpqN4YWMr7N5Dt6rBMIYQ2Y5NAkz4GMQr9C4r9VrLXFaMMxj2VPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721647416; c=relaxed/simple;
	bh=zQsOPLCzCBNta1bx6mHmZDwYNcLsLsJshJc0cYW30Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ghcsRa8XgivZS10T1mUg725WgnraLYcL1vYAsse1FSAvNlJDc0a6WI5xxHxmRZdhGbWpJKYDw2+rGHmOI3iK6AKxjD4eJk8dYqHuH2DkkFCnQY4nyOr7L0xcdZyFCNxLjcewwHfOCuXNaSh6RRhpA6zLQ165YkDUCIQVNV81/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9KGTu7+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9KGTu7+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc60c3ead4so26363315ad.0
        for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721647415; x=1722252215; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQ6WSvruY7CA/cHIjSdYgieqYv50qpL9qtzGOrfGLns=;
        b=V9KGTu7+/qiySZtTJdfa5CjwkoeEtLOpwqjhwIP2xk96whvhY9Xmvrnz9bY+bB1dL6
         Ia4sKbhTvVD17bs6+5DO/PHPkbrkYGx+GOtBerDRcEyNpJgEzerMlrAdTibE7ZjCcAiv
         loCOUoHIMACtSdCymA30vbZMqD+FbDNnnRFHiqNvkOGZfPdM77iBbh+yaGJsRMxDx9c/
         PjLYrZqNlbZiqFOhRmtPSOi4h78dGvzOFEpBX7HxLIGKYlj/VRpY8CyOByBvUaB0Ng3K
         pZSuGxjlB8l2mnX83RNie/9M6Q/GH5RBDNjoYhSNbOSdvkRnrg+9hh0fgUuyISDdkLtp
         0jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721647415; x=1722252215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ6WSvruY7CA/cHIjSdYgieqYv50qpL9qtzGOrfGLns=;
        b=YN3y6tMuUg6Fk3PIBpvn4BrWwDDqpXldsU074499+3G+7zzhEJcbBrL3oH5y0AStz1
         WFbeSy3nh75DBRo34Pp73IQVEaAWLn94MZNss+MW1Ad6BKDWh65fSurxyiyuZGpy1n8t
         NaUzw8i0Y96XjxSzv6/xmLa2PpiZqQAZaeL8HxovQFc6hY6QBlLeHsPGh2Hjhapn0QEM
         tuft2r9XF8mjn8jPJzRdXc+3r+/hSUBAklDPUwN9eBnCGtJvXWlVyUWqvZ83pV7nFz2S
         67G0qhnwFnpajwuTcPKgWcwGc0FIcKY3VuwOpVEmwafuLOCd2+OucbHSMVYJA7880Jl5
         rFtg==
X-Forwarded-Encrypted: i=1; AJvYcCVWf/f0oG3KUWva19XdJuPqHe8aHU4PPXY5y/ePec1dO4RVZp3V2ZRUAYUxh1ey0N4KibFsODLAZk3O5tkHHDvAjdq5
X-Gm-Message-State: AOJu0YzKeUyNUagsToZSvi+59E/znvb93Oi5coL5QBLQaIFyN5TnrDd/
	arqEsJVBjeB+/E6hAXF59p5pH48HqDPh5LM4m8FbySLswM4CfwYr
X-Google-Smtp-Source: AGHT+IEYLVFni6dsFvLRZ1J/vslo+gZ20YBpAM9+mvWxQ1hIAGfyfqk8AnYooO6BxtGiFVEdo4d0DA==
X-Received: by 2002:a17:902:db10:b0:1fc:369b:c1dd with SMTP id d9443c01a7336-1fd74533825mr46928675ad.6.1721647414759;
        Mon, 22 Jul 2024 04:23:34 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f314e22sm52135175ad.136.2024.07.22.04.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 04:23:34 -0700 (PDT)
Message-ID: <14f02ac9-612e-4d12-bf59-d51ec96dc2f6@gmail.com>
Date: Mon, 22 Jul 2024 04:23:33 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dpp: relax requirement on IWD being in a disconnected
 state
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240719181926.3888420-1-prestwoj@gmail.com>
 <abdda292-7c90-4705-9c81-9e11ffaedd10@gmail.com>
 <74956b29-14c9-47ae-ac7e-4294f52d2147@gmail.com>
 <8a021f22-346a-43c1-9b2a-49bcdc1deed5@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8a021f22-346a-43c1-9b2a-49bcdc1deed5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/19/24 2:00 PM, Denis Kenzior wrote:
> Hi James,
>
>>>
>>> Have you looked into how WSC does this?
>> I hadn't, but looks like it waits for a disconnected state before 
>> starting? We could do this too in DPP I guess. Just check if station 
>> is in any pending connecting states (connecting/connecting_auto), set 
>> a flag, and start DPP when station signals its disconnected.
>
> My view on this is that the user has explicitly indicated that they 
> want to connect to a new network, so any ongoing autoconnect in 
> station should be canceled.
>
> Also, I think it would be good to be consistent between DPP and WSC.  
> In the end they implement the same use case.  Whatever we do for one 
> should be the same for the other.

Ok we can do this instead. I see that WSC will actually disconnect 
explicitly when its begins, and manages stations autoconnect state. This 
was my only concern with DPP as I didn't want starting an enrollee to 
cancel autoconnect in general in case of failure.

Thanks,

James

>
> Regards,
> -Denis
