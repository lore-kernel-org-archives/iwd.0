Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2628E29
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibtVkaWJ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7dd65052aso73181567b3.0
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699379618; x=1699984418; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dj+7va5BZYiVmjKh1EZyFBHIr4O4QV77+zrZ6oj68fQ=;
        b=ibtVkaWJLBcl1Y2DDhcXfvKiX2j/+BDtL2fu5O21PUT8pVj7tCP3TQDWIYK03wvU7M
         gSxaWktDu/5dbpcks1Xga4qV4rWUgFqB4ETHsegF2v3fLH7gtZUApNtPj55qoPVwMXBO
         EZb62IS0+VVIe59bUC4l3iYPUqddX6XgrwG9q7oscOIzb+Pik/UtXfttW1ETRTyBiNCs
         uoemWcqHf9r0Bypszask3oheO1uqW3JL2c5TrBP/7HLb0CRLgHFqyOAza8lbQ2j9Z91v
         hMcXxLpCYjg/JQBlk03QGoEu0gX66X7UvMUmtBlcfbmTaiCsW/GQS7TH7ZMno/Yo0lLh
         HCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379618; x=1699984418;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dj+7va5BZYiVmjKh1EZyFBHIr4O4QV77+zrZ6oj68fQ=;
        b=WKNaqeLpGbOw0FD1njIErugVuUDqI5tKmnoSj7Sf2/doEc3N1d5ijAAucbjAx/doVq
         3/j32zQd95tytT2CKz171i5IOIaB5bhbr8lrE3nQ/+gLKUNhUdwlLNofBPt3XdwZXX+H
         j1IELjgXeuL9GKXCfDOvGfFI1jMZdPTJ4Cfsf5fbIDS1lmuyTz6BJUe0Gfh3xUoDlAke
         Owwq5p27/psO82EzQdqxf2aJwF09MGIlkxACYdZ/aRCcMtVfARo2Uuf134kP6FXezfRo
         rzn3QsZvxqLs0npnaD0ZdcmxAhQSEQLnZtvVu79Kiv7ra+xj8Kgaf72iD83kYMrr5Z9I
         N7Tw==
X-Gm-Message-State: AOJu0Yzw9a1AY2nLMQbjKSKuJ31FR2MBmbiREvkWE0GQaG1VGGxo3Y7w
	2LsBwzOqyX/OQslOXdqntaWc7jhO2W4=
X-Google-Smtp-Source: AGHT+IFFIyo726cHoIXPSmTkvPqbmY3JIqhKC2lTgh1t0BGMvK6W6hkC0pI0sRLIQN2KNbGPuAQjGQ==
X-Received: by 2002:a81:7896:0:b0:5b3:46f2:fbd3 with SMTP id t144-20020a817896000000b005b346f2fbd3mr13448626ywc.7.1699379617981;
        Tue, 07 Nov 2023 09:53:37 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id d7-20020a0ddb07000000b005a7bf9749c8sm5840031ywe.4.2023.11.07.09.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:53:37 -0800 (PST)
Message-ID: <6d5103a7-5bec-4526-9ba6-b7ca398c5d4a@gmail.com>
Date: Tue, 7 Nov 2023 09:53:35 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: error with commit aff2d4d66f07ed0a1816122d26369ccfce348f90 pmksa:
 Add skeleton
Content-Language: en-US
To: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzAu1YwZV7e96cjP+xtn6A24ZCN1AiGW9-k35BWi=6wU_w@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CA+iibzAu1YwZV7e96cjP+xtn6A24ZCN1AiGW9-k35BWi=6wU_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 9:46 AM, daniel antoine wrote:
> 
> 
> Hi
> 
> I try to compile with the last commits and the compilation failed on error

TLDR;

Denis, looks like minheap.c/h wasn't added to ELL when you added the 
pmksa skeleton.
