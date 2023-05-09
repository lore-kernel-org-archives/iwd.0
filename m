Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDA17ACF
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 14:17:29 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so5402931a12.0
        for <iwd@lists.linux.dev>; Tue, 09 May 2023 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683641849; x=1686233849;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1MuPPPKq/lpEWA1N8oYUO5g1fSZLAvHsBi3ngLAzI8=;
        b=FnYdWr7TH2ugoOqjyz0ha8C2IJh/gF5iAszwtpXzSHyJ+SnHhdm2Qgr17lBoqq1bpV
         O/FJ1S+vW/A2+QJ/Oqx/CwJPuYPNWdxp/ZDMwWQubfTpbJTuYQUYtiFNqydBAub1JD3N
         EcJ2JNJJYS+5mJY/po2f0xyd0p04cdxxWygcv0q0GZNk4+KH+boj/WW6rsisrzbNimng
         6TCwoXzuG69UvmTX1h19IQbDHVLwUtkxGaiBymffgR2u1rG6OZCCUINq6uuOTyZIKcBr
         5aHWLP86olZg5vCMAldEUIjcFLwr+E9t2yjxs974RnTHzMBh8eS4yNmmh7yvw/MokEKs
         iVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683641849; x=1686233849;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1MuPPPKq/lpEWA1N8oYUO5g1fSZLAvHsBi3ngLAzI8=;
        b=O10F02PxkhpmS8YlrmOSYwsvT7wpkknIfAAOYInvHirPjUxo5UY0QdeQq8K07GuYqU
         D6ozaKl6sO3RSA2BZl0IqX9kXqOi0/ZdWlHEaER42+9ygWYH5Pefn/EKULA+H97UVGgq
         KErnvAoQk5W3t6rvcxkx+VEaRvKoTWnMuQiCqFpuUSz0v9EXtyRRbPgot0IsM7rEIx9x
         Q6x3DncI1fA1tRfBbjyLkIYLXDMe5AbpeY9N7j4Ni7MkLRYYuZHwVWdn7bkXBXqtkTrv
         MPMKzUnm7rdn9Sy0K5KfxV15/SjoRxYxD10HshJuH/5+hNIqD4ucJhGEx25qvMK/0lGX
         sj5A==
X-Gm-Message-State: AC+VfDze9UAIuyK5JMt/J+PjvzCwZ7X1FbcOrMmPj06SOVByOGA7unsk
	gg7QOJmHedHHP73kycJlYxSe2IqcwjJmDA==
X-Google-Smtp-Source: ACHHUZ7W1ecme1tdLXCGYGGGtE5AxCWgv5Le99+BJQ8XA3ZDsNOfc5mDFbEDEtdX+QW04KT1Omu9hw==
X-Received: by 2002:a17:903:294c:b0:1ab:1b8:8a5f with SMTP id li12-20020a170903294c00b001ab01b88a5fmr14262325plb.33.1683641848533;
        Tue, 09 May 2023 07:17:28 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c20500b001ab03ac82aesm1621230pll.122.2023.05.09.07.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 07:17:28 -0700 (PDT)
Message-ID: <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
Date: Tue, 9 May 2023 07:17:27 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: powersave support
Content-Language: en-US
To: Mike Silva <mike.silva@mikesilva.com>, iwd@lists.linux.dev
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mike,

On 5/8/23 7:50 PM, Mike Silva wrote:
> Does IWD support disabling/enabling WiFi powersave/power management?

No, currently it doesn't.

> 
> Perhaps, I’m failing in finding it in the documentation. It’s possible to do this as needed with ifconfig, iwconfig, or NetworkManager, or to permanently configure them to enable or disable it at boot..
> 
> If IWD doesn’t support this, it would be nice enhancement if IWD could when managing the adapter/connection, as some drivers do a poor job of handling powersave being on.

Yes, I've recently seen instances of drivers handling this poorly. Are 
you envisioning something like these other tools, where power save is 
just toggled on/off?

I think this could be done, and actually we do this manually every boot 
using iwconfig in the software stack I work with. The tricky part is PS 
is done per-interface and IWD doesn't have any concept of per-interface 
configurations.

Denis might have preferences on this? but my initial thoughts would be 
something like:

[General.wlan0]
PowerSave={on,off}

Thanks,
James

> 
> Thanks!
