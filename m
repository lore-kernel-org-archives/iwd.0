Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7A5258
	for <iwd@lists.linux.dev>; Mon, 21 Aug 2023 12:50:41 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58c4f61ca12so36184507b3.3
        for <iwd@lists.linux.dev>; Mon, 21 Aug 2023 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692622240; x=1693227040;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NswtTYqyKNJDlxMQSQsgjdeIcRS/yhdfDwe4A6DDkko=;
        b=Vzv95a+09awmMPquwVoPwwvG/a5JtGio9ZG+0iljlE4jUgJYKdFPQ25DS9w2vpQpor
         TmJG9h68stdoqR1Y9C+JntfQrZZwZVd9rjetKZ6X9YqU6w0BF8w7S0cksupFHkKdsm0p
         nbcSDPP8Cr/5/ViN71jEwu4OUQDbF/3Ayp1smP27Pg+BmbyRoTM455lOj+vNTsisOmpV
         s+ZfjURTljxWq/p/yGYwKK8svg6fpf8I3+QrphJ6u6/0npaWPyrm4uGW4hFpu/1PE5Hw
         oNg34pZlPdvxRfA/3I17v6rkOT979ZPZHpryG25or7efbt/MyN4p/eYs5d9ZzWXbCpwz
         091Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692622240; x=1693227040;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NswtTYqyKNJDlxMQSQsgjdeIcRS/yhdfDwe4A6DDkko=;
        b=ixP7Saa+4M6xfFgI8NN/azrh7i+t33hEBdd3JPbSZHC9+g7gTVg04RTtQMIopgPLE/
         fj4+OeVFxUHkcmN6H8wPd68l2ArX1iE81vPngwdWb+K0VCN971qotfmW6HH0VpsTvFVD
         bhmnNfgN4BR41acccZ0gARd+nEFtxqqksRBrHfUviEqwXDYUIl/INxVu2UyxUmaW0qSL
         +g1NuSDB+/1HZovEXEcN70e29/6ql4F1Fac8X+5SusxwsikdD2W1VcwUDFiw1uQZZMSY
         LnFGME/vqP+Gsj9SgiHxpaqyhq8X2qj9tW7yiPeY62R20jXgu77tayXYfJPJ1JdPLljy
         lCOg==
X-Gm-Message-State: AOJu0Yzi4jXARrhd/YzfdECNDSu3JBzTc5XseJFV0qecycycSi5x/8uA
	QM71kAjSUnsJEQDrbTdWEk75g0CJBl4=
X-Google-Smtp-Source: AGHT+IEly8rOTrH/WiRY4dYTcepJwLjdvKveD6xxvra6Yp7opFhIKS43tElXQP30xM95E4oWDhz63Q==
X-Received: by 2002:a81:6c12:0:b0:577:4387:197c with SMTP id h18-20020a816c12000000b005774387197cmr8079306ywc.16.1692622239995;
        Mon, 21 Aug 2023 05:50:39 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j68-20020a0df947000000b00586a74620f9sm2205808ywf.41.2023.08.21.05.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:50:39 -0700 (PDT)
Message-ID: <56209aa3-d9dc-4199-b1ff-d81866cdc977@gmail.com>
Date: Mon, 21 Aug 2023 05:50:37 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segmentation fault
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <CYXPR08MB92949D45E846096B18128C3EAE1EA@CYXPR08MB9294.namprd08.prod.outlook.com>
 <fa11a71a-42ff-4c54-9f0d-e8635e0782b5@gmail.com>
In-Reply-To: <fa11a71a-42ff-4c54-9f0d-e8635e0782b5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/23 5:13 AM, James Prestwood wrote:
> Hi Michael,
> 
> If this is a debug-enabled dump could you just post the stack trace? 
> That way it won't require people log in to MS to see it. If not, how big 
> is the file? We may want to figure out another way to share it.

In addition, I tried logging in and was unauthorized.

> 
> Thanks,
> James
> 
> On 8/21/23 5:09 AM, Michael John wrote:
>> Hello,
>>
>> I hit a segmentation fault with iwd version 2.7, and captured a 
>> coredump. I've attached it at my onedrive below, please let me know if 
>> you need more information.
>>
>> https://midmark-my.sharepoint.com/:u:/r/personal/mjohn_midmark_com/Documents/core.iwd.0.a68e5068b8214b27904b0fc85601ac35.241.1692277585000000?csf=1&web=1&e=4NPwg3
>>
>> Thanks,
>> -Michael John
>> CONFIDENTIALITY NOTICE: This message, including any attachments, 
>> contains confidential information intended for a specific individual 
>> and purpose. If you are not the intended recipient, you should delete 
>> this message and any disclosure, copying, or distribution of this 
>> message, or the taking of any action based on it, by you is strictly 
>> prohibited.
>>
