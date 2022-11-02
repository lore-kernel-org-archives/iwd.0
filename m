Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303207461
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:04:58 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13c2cfd1126so21491996fac.10
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tz2SJ0XQFZvk/LCCdK4aNd3fehjY1K7tZTmeTvyiA6g=;
        b=X8LPHqWaGlqrRBwSZo4+TLHQHEY3cdKJ8iy0kpgojJu5uu58tnQgllp3rfrTVUB1M+
         mSNoyos6PypFX2vWvGYYJXSy3W4q3Iubb3g+kHYOXcjJ8738EK3Ev7lfTy8MY5IYxx9u
         TwYi+O+Rfbvp0COJY80mdh98Nqr+PCbToa0xgxcku3XVpeNiX/fQn/Rd5U32ZHuSGWN5
         uamvbMqUKWsetMToGWdBtp1EzMj1YimDNWnvkwQfXQlFNWE8BMBLRnBWTYcHpSE/G/XY
         PpNdqDvZkz+XQZV+MtXc69y8VWsrA7mO0KP+DruHTflf/hkbUFMxB1ZTXi2KwF7s15/T
         SaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz2SJ0XQFZvk/LCCdK4aNd3fehjY1K7tZTmeTvyiA6g=;
        b=Eg/owtKC1dhNoaJ//QBblMr8mnfMGndxrxGwKu06cxTaHLFvIz4T3EQNq7XZzC5go/
         cBTvh2SDEzgW8Jkt2kocZHtMgFti16fg94DB2jLFM5a5UiNdJToBJFAMU1WiIk1TsQa+
         ov53pi2uCUBjsFvLSrkreq5Ycyy4nWqUnE11hIIEOkMOwWrUToZqJYSmNvUBhqhJd7rz
         hixvhYDDFSQ/qZmU1McVBJ7DUMZOBM3TGFm36QwQzvBUFRDiAkZhf/aKdGJLFI3Q1lTn
         PEI5qWCLNsIrHYbPiUTPsoEFx5VyAz6MYIALXqs9GObbuqZMxXfesNbd5g1s/SRoW2Y5
         9jNA==
X-Gm-Message-State: ACrzQf2FX5DUTnJ57O6gG3Qk1yHWbUdj+64+w0Twdw1BZzc/qPP/AnZX
	N5L64GhSE1fqJjRPYzurnS6zacDIFos=
X-Google-Smtp-Source: AMsMyM7ApATpvLiPLUGAzjyLB1hnWP9yV9D+eXdeXknXyour4oZ7EGYIRjO1oPCi9rHilFrih10u6g==
X-Received: by 2002:a05:6870:338c:b0:13a:f214:ff51 with SMTP id w12-20020a056870338c00b0013af214ff51mr15815675oae.123.1667419497289;
        Wed, 02 Nov 2022 13:04:57 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j45-20020a4a88b0000000b0048fb9b6dd70sm4813009ooa.0.2022.11.02.13.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:04:56 -0700 (PDT)
Message-ID: <d99937d8-2c67-1ba2-474f-224949ba9277@gmail.com>
Date: Wed, 2 Nov 2022 15:04:55 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] json: update internal type definition to match JSMN
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221102184600.230988-1-prestwoj@gmail.com>
 <99e42ccbadbba35899cb85d4dad7943983a587d0.camel@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <99e42ccbadbba35899cb85d4dad7943983a587d0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 11/2/22 13:50, James Prestwood wrote:
> On Wed, 2022-11-02 at 11:46 -0700, James Prestwood wrote:
>> Fixes: ceda955ba7 ("shared: Update JSMN to latest version")
>> ---
>>   src/json.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
> 
> Whoops, this should be 1 << 3. I can send v2 or just fix this up when
> applying?
> 

I fixed this up and applied.

Regards,
-Denis
