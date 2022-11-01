Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCE7B
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:53:47 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so2226385ooi.5
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTUOXZqkcpvTe2r5DlPQ8XLqPYW46xJ2bifprmfj3wA=;
        b=F4Wf7n/qNVSuaVCQyz14dGXWkkyAhqm7dC6dVWOF2sXkI+xkIqDmXzioMFdgLk2tFC
         D+H2U3pUTQsEGZeAUqf9J+85xt4e4DYvB5fuBQy5IvjbcMkzjN+NrMlisgh5L4oEA3GI
         7jIgttZgDpa75clXbjAWGhQgIvFHZeh4jZfStBnG+8GPQ5HO8m/AIDKqIBf9eXB/tVaf
         /qRk/3nBpcU+HwkeGrvyzuK/Ix6+2/lHlZkztTy+mZd9UHyCuOQa1cay8eM7sdZkvzJV
         sxUW/bs5eaVk4jqctuAcRxBITTf0Pum02pXFW+otXhTCCv0r8kv2npgGVgHaTKdJIVl5
         mMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTUOXZqkcpvTe2r5DlPQ8XLqPYW46xJ2bifprmfj3wA=;
        b=k3ZI0Py1Gg6eK/uwtRNVWlp17MFsOuM/DKT8rd3Ihbv1nnnr+DIVEN5afP5fMaNi3/
         ftLJE9THeBtcNxNtHhXo1HuSzQiXozDaetO7pdukp9SMBEx/koRTnH5dwMo1OWcA6BV8
         9V6AaBPuPbSws7SIiHH/7ku7jTX3Su+9F1mbvzyN1zXrmG0yEkVGB7nAzj4hCJo9Sqja
         wRyNLR/iX8zXedvZPv6N6Tsi2rq3fr19BF/7sM9rMlLgFvnf9IfvVld9Yjd0Jeb+J1cb
         F1664TfPDwhzxNPfobQWsyWXXkJBEDDuSQEUYe3P7bh8WCPFEhmlsOlwvm2gpYxwjHeK
         IXQg==
X-Gm-Message-State: ACrzQf0uLSAoiZrFrbWxwhb8ojzpjyduDHkDhuDPL1/OSeGAZHMaevmR
	yvADCz0chmVpo+gSWsip2j4=
X-Google-Smtp-Source: AMsMyM4wLPpAQRGfjtBt73mjImWlT3049Ea8rpNrlE0aca37LypwYwSI16qYMJd/lJsRDX9wNvPtEg==
X-Received: by 2002:a4a:a30b:0:b0:49b:de15:f29b with SMTP id q11-20020a4aa30b000000b0049bde15f29bmr3903931ool.52.1667336026384;
        Tue, 01 Nov 2022 13:53:46 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cy14-20020a056830698e00b0066c7414029bsm228968otb.66.2022.11.01.13.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:53:45 -0700 (PDT)
Message-ID: <42236ea5-8e5a-936d-8426-9ef406f9ee3e@gmail.com>
Date: Tue, 1 Nov 2022 15:53:42 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/17] netdev: add more info to key setting debug messages
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221101201747.143379-1-prestwoj@gmail.com>
 <20221101201747.143379-13-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221101201747.143379-13-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/1/22 15:17, James Prestwood wrote:
> Specify that the ifindex is being printed and print the key ID
> as well.
> ---
>   src/netdev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Patch 13 and 14 applied, thanks.

Regards,
-Denis

