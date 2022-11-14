Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977879F3
	for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 17:57:50 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso13298901fac.11
        for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eL4F9zjLE93O5bmwSn8hcXlfWVmJgcna6OfGB8ftrrI=;
        b=mep5rrFn5y5uaOW0RohQPzdTK0BXhX86nsB0Sz58e8ictpo89jfIWBnmkWlkEehVps
         3kSQkNKuHwLrvSJwLX4zp70zTGwKDG076f8oA0ezUZxAAz15XoBm0RN0GpcR+skm3YTo
         2NH/Qz97n7cNsaOfL5RWrdnEUzqnDwWEQPg9y2y3Gjw76uK/0Ibkba020NEra/fjgt3f
         yyKoJsARXlkU0sDvoYIoiKeI36Y9TNxcBTP6fC3toS6zsqX3zS9ouIGP+mTvJ3aVU+s8
         hM/icwnqWJvc2Oia/vmQzilm2EOrYRikfyj3o84NgRRMy+4gvy4NWlT5PF2ROY4xNrAY
         5Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eL4F9zjLE93O5bmwSn8hcXlfWVmJgcna6OfGB8ftrrI=;
        b=hXefiHFHB8BG+LWQoBA5qnRTx/Wjcdv2Gl/R0yVBfzsNKXMeD8aHYN1KhLgcKAMVln
         NZESdRkvPYzBVe1fMFKLSbIofkJ7GZfg2I84XM1T6eTBOm8lm+mLaEq9OdO6l9OshFGp
         sNkIMYjA7Y3wtbFcsheXqwGa1uADsvV0EQpYj6Il8Lqj24l+/LiWtMYkVC6cmiEx/ZvX
         gExl7BkFkIoJNrlQGY63tukIO5u4vuSEyF/aJe1ebyLTw4HJSqjRlUceDgLXu7y6vyRx
         aCsCYPbsbN999mIURDo7J9GNYe1PEE8vCRXMc51WxcYf2b3rft60Gyxsewa2vPfFH+YS
         f9ng==
X-Gm-Message-State: ANoB5plemhy4zzh8m5YfN4ej9NTn99Qmw5D/T6D5D1ELd4ZCUhlQhG2k
	IOk31UaYrSKj18OmY4VUPuhOag7fFGg=
X-Google-Smtp-Source: AA0mqf47PvnErQvOuRc23KOM+DrMu0z/OzDF7c55sPqCsv0OCPLLYmaU7leq+9jMnxjEy+jErnFKuw==
X-Received: by 2002:a05:6871:4683:b0:141:f416:a3bc with SMTP id ni3-20020a056871468300b00141f416a3bcmr912933oab.237.1668448669625;
        Mon, 14 Nov 2022 09:57:49 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j21-20020a544815000000b0035aa617156bsm3857601oij.17.2022.11.14.09.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:57:48 -0800 (PST)
Message-ID: <93bde019-af0e-2aa3-be32-787febf85a3c@gmail.com>
Date: Mon, 14 Nov 2022 11:57:45 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Scanning hangs up with Marvell wifi card
To: =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
References: <1e372397-d06d-df32-dda3-d89a580a9ee7@v0yd.nl>
 <dae74530-3fa3-0507-1d53-928d8cbce757@gmail.com>
 <c8e794e9-c211-4b7d-5061-604842db7e3a@v0yd.nl>
Content-Language: en-US
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
In-Reply-To: <c8e794e9-c211-4b7d-5061-604842db7e3a@v0yd.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas,

Note: Jonas sent this message off-list by mistake.  With permission I'm quoting 
the original in my reply:

> thanks for the quick reply, checking with iwmon was a good idea indeed, seems 
> like the subsequent scan request fails with EBUSY:
> 
> Response: Trigger Scan (0x21) len 4
> Status: Device or resource busy (16)
> 
> I assume iwd would have to handle that and try again a bit later, or at least 
> cancel the ongoing scan?
> 

We only handle EBUSY in the context of another ongoing scan.  This can happen if 
for example NM/iw/whatever triggers a scan request in a race with iwd.  So iwd 
waits for a scan finished notification and re-tries.

The behavior you discovered (which I find quite bizarre, since there seems to be 
no way to find out when to retry) will require separate special handling.

Regards,
-Denis
