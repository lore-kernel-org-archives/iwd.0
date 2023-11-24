Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356B2EB15
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVmz+iBp"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-581fb6f53fcso1126869eaf.2
        for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700843142; x=1701447942; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9L4iF/BPbbYEyRMdG7DbiXCzn6KTlzGEiNpSh6JQ+SU=;
        b=eVmz+iBpSSdJoiNQex7UafmdVLocsifQXBUnjZv/xaaKrSULyQTqa5mdz1vT24PTCh
         YUqel39sKhzyW9/PYO14oHnpU7AD3LQMgfY5VbP8uagYR7+mB5xZ4khT38yvSN9/wtkE
         GHeY5f5MLSnv6BwphNuKisZnzqmz3XWGgPPT/iv+rQ2yqzdsAQYFqJhhEX995cwwNzHX
         oDcGcb+TejmohPKM7G7MJF9c8PUbBhqMDj6KNDvl/CB4l5R1ByMUHTXmhBVz3tcowfSO
         zxCAEcoFPWlcwPUuRt942GVe3ljaUlPMXzJMV4n0TUPRZYGvz+QHO4t+ere5xAn55OgQ
         jwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843142; x=1701447942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9L4iF/BPbbYEyRMdG7DbiXCzn6KTlzGEiNpSh6JQ+SU=;
        b=btpjY/n15nMFdWtm0YqETSdTcKeJshZoKjh1mmD+xCnUzxdWzJTs7PGkvbEsh7Cidv
         6LmL8g4hCdcNgTmMWPwPBaeyTphqvfh2PHI3Ts+2zuW6b3tH+n17TnX/xA0UaoC6YNhN
         ySoPCbnsMuDjeiFuLm6qn1FxPFporTk63HYX+o6ELHVVd73FV3jrYfenjaPit0FVt9Rz
         WXeh4PB80KkFsn4uG7QCZ8IiA96YBwA8otr+ic7w0Fwg1HEgDeozjznfkvlmO//WTIak
         WAM2mrUm48hzxmX71YTJSgmPwakMsgpzymuO8ZRElq537FUN2OX91wRhRwkHnCD+EPi/
         /XDw==
X-Gm-Message-State: AOJu0YyKL9ZBmmAoFGc0GgfxaGkSWgh/av1bSNcCplatitZVBBrbS025
	/8aRaqipJu8wa5TmeDwey1s=
X-Google-Smtp-Source: AGHT+IGD96CkjHZ4Q9Eb5dfSKDYpivXjpoAqADo9QCcAf2k4jZtjXs86ZMZvbNa5hlHPOtHmLPjnAQ==
X-Received: by 2002:a05:6820:228c:b0:581:e303:807c with SMTP id ck12-20020a056820228c00b00581e303807cmr3933170oob.5.1700843141819;
        Fri, 24 Nov 2023 08:25:41 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f19-20020a4a5813000000b00581e5b78ce5sm598113oob.38.2023.11.24.08.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 08:25:41 -0800 (PST)
Message-ID: <f25e7bcb-3990-4d72-b51d-b197f8c40a64@gmail.com>
Date: Fri, 24 Nov 2023 10:25:40 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] netdev: disambiguate between disconnection types
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20231114171455.1108856-1-denkenz@gmail.com>
 <20231114171455.1108856-11-denkenz@gmail.com>
 <z6bw5z4aptq4fq73ercwhrp76wpz6ihtlzrst2kmfqjoru42y6@v5e5za2r23lb>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <z6bw5z4aptq4fq73ercwhrp76wpz6ihtlzrst2kmfqjoru42y6@v5e5za2r23lb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alvin,

>> Distinguish between 1 and 2/3 by having the disconnect procedure take
>> different paths.  For now there are no functional changes since all
>> paths end up in netdev_connect_failed(), but this will change in the
>> future.
> 
> Sorry for not following up on the issue I raised the other week. I am
> catching up with the mailing list now and see this patch. Am I right to
> assume this is some preperatory work for solving the issue I identified?

Yep.  I got side-tracked by some oFono work, so don't have a fix for your 
particular problem yet.

Regards,
-Denis
