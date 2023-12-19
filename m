Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F739AC2
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd4UJJAE"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35f7589ea1fso17469235ab.1
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703007969; x=1703612769; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wun9617v6OW1+TQGVbgI4rjyFkOpVdZPLsEasAB8FB4=;
        b=Zd4UJJAEIhd7NwICWpfAck94YSFmEPPTTkn6r90Hen1c9KlPnNaOvwPKJvoBnbVgDA
         uJERktOr8kP0ehvWyoaDVLf6oT6+noFD48DTA4kuuozHx8LpAuw5Kgt3v7lGA3iQg8oA
         Ifg3pTeACQkRD8AMZHzg00VVgW8P9furIUdTMkgg3QeD/fX/EqfoYUw5s5aKOTFn+bZk
         rPTF8oB6l62b7gOiK8LhVLV3RrO4BGmw6q+SmInQJpSvlBMi9Waz+KvxBM3o0fRmOzv6
         yfRInfSwaw51fvS2Pt3YNT97Q/8kE0Y+PyPHqGqCYz8T2QvWFRYSZzuWWiL5YD6kKLPW
         79aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007969; x=1703612769;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wun9617v6OW1+TQGVbgI4rjyFkOpVdZPLsEasAB8FB4=;
        b=QZRe3xEjkk9R8Pw0Bh+kqJDO7LlBsY1/5UeX9bLTk7dIcSWQ7kjCY4EtG08Ld1J4m9
         Xdm3IaV9jjesX45q70FFOYYvVsKkYtyvCTj2dx9KIPbk9dfRj/3Toga7cgfn10/ieYNP
         khA69Qj26IQ8UR5qyOAKZ2EzYjtc03P2+dr9t/bcvVn3IxARPypmc/m5/M8IrCKUEUMn
         joCRpUCeMw3ubVTCCyJ5IZIvg9pIJETA4igI0H4Der6qsPCanxI1/ZyzvYq98giMige/
         l3fZ9vVmHHmC+X1fvtDNXe5KQ/Br8eOGGizwB1B0HTGBjtP2nmDq70FCqksU9TBlQYfR
         dcvQ==
X-Gm-Message-State: AOJu0Yx7ieZls1eXXpxeExpSASn74xO99LTbk4EUSo+SYs1Pgzw9qpuz
	aueuKjiFtYmGvqvDnAdqQVvemuN2Hsc=
X-Google-Smtp-Source: AGHT+IHwQ3Altg5ijf9VlkGm5a5jY0G3XWNDZ3cjy3PKWgGb5mRBP9mKaUXvIUFY3YuTgcTKF6tu2Q==
X-Received: by 2002:a05:6e02:18c7:b0:35d:a349:ccef with SMTP id s7-20020a056e0218c700b0035da349ccefmr23660279ilu.22.1703007969483;
        Tue, 19 Dec 2023 09:46:09 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id dn14-20020a056638090e00b004665e8a0608sm1557228jab.137.2023.12.19.09.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:46:09 -0800 (PST)
Message-ID: <0072dc90-2e28-4f12-9980-b32a693ef8a3@gmail.com>
Date: Tue, 19 Dec 2023 11:46:07 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] knownnetworks: network: support updating known
 network settings
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231218141250.202157-1-prestwoj@gmail.com>
 <6ac609fa-0540-479e-8ab3-387b0cab24cb@gmail.com>
 <ee339749-46cd-4927-a3fc-ff80924a5f70@gmail.com>
 <f2d94ed6-0902-4dcd-bc7a-b7c58e7e61e3@gmail.com>
 <4ab32218-16a7-4d15-a792-3aed887a91b5@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4ab32218-16a7-4d15-a792-3aed887a91b5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>>
>> Okay, then this patch in particular is not needed?
> 
> Its at least partially needed, if a known network already exists prior to DPP 
> and its overwritten there is no callback. So we may not need to actually touch 
> network->settings at all as I thought. Just emit an UPDATED event when the 

Okay, then just do that.

> profile changes. DPP can then call network_autoconnect and the settings _should_ 
> be re-loaded unless I'm forgetting some instance where network->settings can 
> persist, but I don't think it can.

network->settings is only created/opened when a connection is attempted.

Regards,
-Denis
