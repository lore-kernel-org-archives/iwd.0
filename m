Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416815C85
	for <iwd@lists.linux.dev>; Mon,  5 Dec 2022 19:38:44 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id n205so14261209oib.1
        for <iwd@lists.linux.dev>; Mon, 05 Dec 2022 11:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLGyAp9VEJqQfmKCFs4rNiuVerz+qi8GmzM3Lc/KMSA=;
        b=bF4WUDMnjtzJgTyr6GyNr764ty3BzTIeTAA4/EuaBRdYqFaPyL/sSY/CxY2ZKvOS/e
         P08nUOVCJAEeF2LFdvP1gf7VYaNgXs+JkCYOLoJ6DYzYCCRF76LKzM4vdwYOp6bdb5SD
         bLMgmuv0ivdoDpCG8poIuSKjur2a/G+byN6XJ44TDGRBrWkDEauBxs5W/xxhFy3khK9T
         x6478YSBs/RPfzjqDiYxh4XvjW/4iSrDQQf3utSVoV+nfT7gPOdKa9GZ6Tvyo9s7+qFW
         /wBxIfZDDEJEOUJSTDYSO1XbQr6Wr6rd+Q+JLA4l+caxao8psPzvuhATnoPURUoUauRs
         GJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLGyAp9VEJqQfmKCFs4rNiuVerz+qi8GmzM3Lc/KMSA=;
        b=ICM/Wq+pUdpCbCvnY9BGVJikcxm590iP1mojeXxMRxOgecWQ6P/g+oS+H+E5U6gw3E
         reM6YceUfrP+PKKClpUGmmKjnCS0DLrSXfUekUrsSDh7iGGcABfQChLNEvoVaO9c/wJX
         6iaTH1Q2MXpRbSqf5zUS+tkDNFrzD5lPazPTHlxeE1jP9MmI55VNvpaln251mzVetn4x
         N+eynafj8JAJhnn5mrpkVw6t/Dj8voYXnvI0710keW1XbeqzLwyAJihFLD/4174AqhNX
         75HhThvaSjP+Kx/26or0N/xrv5H/uxcOJUq5g0+Dr1aTYjFMAUCEZnznMWqsh8/YsgSX
         XuSQ==
X-Gm-Message-State: ANoB5pmU/eHP6z4dDyN+C4QIw0pY4LkEouJ2QW1It6aGaxz96GljDX3f
	QedMqG11iqkThaMkdKENBKM=
X-Google-Smtp-Source: AA0mqf4GsJfpd/7xM8pIvJhVffsZYx0dz/+STLWCACR3z805NlvxED23FVjOWiEJkuVPcpzXYPa4bg==
X-Received: by 2002:aca:ba83:0:b0:35a:1d11:dd37 with SMTP id k125-20020acaba83000000b0035a1d11dd37mr31803616oif.208.1670269123841;
        Mon, 05 Dec 2022 11:38:43 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b19-20020a9d6b93000000b0066c34486aa7sm7992877otq.73.2022.12.05.11.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 11:38:43 -0800 (PST)
Message-ID: <9ac1b980-eea4-bcc2-a7cb-c6727731ee6e@gmail.com>
Date: Mon, 5 Dec 2022 13:38:42 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WPA3 SAE passphrase limitation
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>
Cc: iwd@lists.linux.dev
References: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
 <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com>
 <CACvgo53tii9sLJFcmsPymJ-8HBZjvwpuBR4DNKYLNVdoGFY3_Q@mail.gmail.com>
 <37ab408f-c9e6-7e9b-0088-d7e5fed08241@gmail.com>
 <6c0e45693e254dd8dda4d07a51896bab855a6324.camel@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6c0e45693e254dd8dda4d07a51896bab855a6324.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>> About the only thing we can do is 'assume' WPA3 when:
>> 1. The user entered a non-conforming passphrase, and
>> 2. The current connection candidate is a WPA3-only AP,
>> 3. Connection succeeded
> 
> There is also the case of network profiles which we know even less
> about compared to agent requests. We could allow <8 character
> passphrases and just force WPA3 for these profiles too... but its still
> a rather weird side effect having a short passphrase force WPA3.
> 

This isn't only about < 8 chars.  It is also about allowing UTF8 passphrases, 
which is kinda desirable.

I would think the same restrictions would apply to saved profiles:
1. non-compliant passphrase
2. PSK setting must not be set
3. transition disable indication set.

If the above 3 are met, then we would allow this and the network would be 
treated as WPA3-only.

Regards,
-Denis
