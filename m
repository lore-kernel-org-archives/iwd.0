Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F037B97
	for <iwd@lists.linux.dev>; Tue,  6 Jun 2023 16:14:23 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-62b67937a6cso2806346d6.3
        for <iwd@lists.linux.dev>; Tue, 06 Jun 2023 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686068062; x=1688660062;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMyIJE1I9YyfWKJIUwJ2MJwrvi6ay8zQGyp13tqJJ+Q=;
        b=FNfylugN4Q2VSEmF7D1fgEmjD5O/ak0vog6f+O99QwA7MlimJYMkXGJ7QDPa87ujV6
         SZwFhLr/8ovn3ShT9anWzzg2kA0Z6tj45Q+cuFqqhCNzX4e/TcZWP1SVvCFvEPGNOxG0
         Y39VlsQuI7uGzgoexXADB/1PsgQ/7Hb8jMCtG3Ht1yXtMYxOn6IgRyjsJI1j6he93+7B
         nNfL1UIxGdhyeRfo53MiKRq9rUXsYIRcjHBBRMNECW09euodT5sKvSHnq67qZgjAXfcQ
         c6XGw9B78xwZRQKKQoTdmq+I0D3sxMmA6dOTAu8wq0y4TYx+U5GpFcGhxgzi2szBdtV6
         ywQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686068062; x=1688660062;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMyIJE1I9YyfWKJIUwJ2MJwrvi6ay8zQGyp13tqJJ+Q=;
        b=lIzyJhr4eTOUxAURZBJJPzt7CIVCKPl8kX6N9M/F4+eaV5HXTtOSqDsXLRHdczg2vE
         TDdBdZXdH0AAUpng+e/Or0dFXR43tYkfAMIzQi9dA6xflt3wF0mhmjzs9LAAsdzQNR79
         QKwdjoQRupzw686eDUhkNcDQQmEsOQxW0FmDqzHur9xRMBRJEgTMlQ3vks0mrjGT1RCi
         OLEZvsT+YxNnlAr8lpb5SvugT6pRv2CeQ+5JUedl+u1g4aEf7dxEPdYLmV72cPdmZE8J
         oHOiqqLjDJgl3l4KPAZssRdhYgZY6pFehj1D5uoLCerrCYxIMU2od8/TwClNao9FSKQb
         6CkQ==
X-Gm-Message-State: AC+VfDyy0//YL4kMdOVPYke8evMDUnpzmXsQ1fcClK3x2eM8cXlwhu47
	KKulT/j1umlWlZdPPniKKwwR1GYwu/U=
X-Google-Smtp-Source: ACHHUZ4+pdoe23AqVIvwrBCknPCBR+Pyl0GRJM0w8R3dzRXtsEUrPgYMjaA5qsW2wZQdViFMmmPFbA==
X-Received: by 2002:a05:6214:40f:b0:626:24c4:7d91 with SMTP id z15-20020a056214040f00b0062624c47d91mr3207608qvx.26.1686068062141;
        Tue, 06 Jun 2023 09:14:22 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w17-20020a0cf711000000b0062824b0517fsm5422228qvn.67.2023.06.06.09.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:14:21 -0700 (PDT)
Message-ID: <696f641a-59ac-a476-a17f-a9ad43a524fb@gmail.com>
Date: Tue, 6 Jun 2023 09:14:20 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: issue using virtual interface with iwd
Content-Language: en-US
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
 <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
 <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
 <CO1PR08MB7221B49078929FDBB79773B7AE499@CO1PR08MB7221.namprd08.prod.outlook.com>
 <0909f3d3-3ce0-cbe7-48f2-9b37d5ca4bbb@gmail.com>
 <BY3PR08MB72206FB8F6C0F2A34729731BAE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <7c72c879-98c1-2df3-e676-540ee1463cc9@gmail.com>
 <BY3PR08MB7220F8324CED704A01BE5946AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
 <BY3PR08MB72200F3BA8B1FC2C28C9C099AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BY3PR08MB72200F3BA8B1FC2C28C9C099AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

> 
> 
> After looking through the commit history I see the DisableHT support was
> added right after the 2.3 release. I've updated to 2.5 and retried and
> was successful at getting the AP up.
> 
> Thanks for your help James!

Great! To try and get this addressed better could you provide the 
wireless hardware you are using?

> 
> -Michael
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
