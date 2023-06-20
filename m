Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD71360
	for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 01:57:11 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6b58e439794so528973a34.2
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687226230; x=1689818230;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5Zyec/WflOkLo0C8PfFBqpCSQIu00bsr/z9OJd8YqE=;
        b=G58oKrQC0Z1klXbPXcRVJrioQdef7XzuoGbHCFrQOEepdomCOx7vPjWkrnu6sTfH0g
         x//x4RGzUdznB2nCYXCe2zFnmd3dZZZ6TYkgaz2IVruYnyq3PPysfLX2hA51H5hlbeMk
         9/i9o0jKVDM+lURzjN4z9iKthpH/7k7mTG9aIP13A8P4PzL2FyAeWiOz3D1uDJk0wHvC
         eo5SyM0BKWxezwH6h0ndt8TJaursM3iI3ScnSUjkTmiUMtkSRyh0YEo5ZzOHD8TXJBqf
         EFJwJXYuZCxO/sjussbMufP3DmWAST+D+FGLowhZ9B3ZBVm2o7+ozMEcgPsOZiwMX9H/
         MwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687226230; x=1689818230;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5Zyec/WflOkLo0C8PfFBqpCSQIu00bsr/z9OJd8YqE=;
        b=JYMRPS6hTdnWR+Ik0BSV22acYcu/8Yw61R0n0NiJHhkc8XF+AlJT0m591LFz/+0zzI
         6gQYpLX0WrFoN5Du/JETXh3uYYxOUVz5zEdrw8usrvI4Vs6okGdf7GnPYj6264gdza5Y
         MT5JpGfnACiTW4qSbr6hT9EKM3hxH2+tGfotaFrP9WyeW+blZBAaKryhDqApL+PDX6LS
         kIKMDi6QMSJpcBkvYOx5UMgSx5ASUfIcYdB6J0C2G756sCtczItQfElMYF8ueA6rsg/y
         YHo52b2W2mSVmP2b0YY/yI/5iTsZJn7hNihHOKsu3mwwF4IKGzQcPKdSt4g6X6C3Go+E
         SE0A==
X-Gm-Message-State: AC+VfDy8kaw2GM6rPM68x38fHPmHFhQ1pp1vMDqCjFKnPQXW2mBtiN6u
	FdiPeVv0Kqrke0eUyNU63/8=
X-Google-Smtp-Source: ACHHUZ7yA7lLLXX2zebjikd28Sn7fjH9WknTch+MJkcGnnL+9vDRBhivRowuxwxmjmZCIjvgTMw+LA==
X-Received: by 2002:a05:6830:1d6a:b0:6b2:b0dd:e9a2 with SMTP id l10-20020a0568301d6a00b006b2b0dde9a2mr6005750oti.38.1687226230462;
        Mon, 19 Jun 2023 18:57:10 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k3-20020a056830150300b006b2ca17623fsm443270otp.64.2023.06.19.18.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 18:57:10 -0700 (PDT)
Message-ID: <5d40ccea-c4c0-2f27-78fa-6d84dd65a5f3@gmail.com>
Date: Mon, 19 Jun 2023 20:54:35 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/6] auto-t: add comment about FILS rekeys
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230619225746.462791-1-prestwoj@gmail.com>
 <20230619225746.462791-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230619225746.462791-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/19/23 17:57, James Prestwood wrote:
> FILS rekeys were fixed in hostapd somewhat recently but older
> versions will fail this test. Document that so we don't get
> confused when running tests against older hostapd versions.
> ---
>   autotests/testFILS/fils_256_test.py | 4 ++++
>   autotests/testFILS/fils_384_test.py | 4 ++++
>   2 files changed, 8 insertions(+)
> 

Patch 5 & 6 applied, thanks.

Regards,
-Denis

