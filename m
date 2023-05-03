Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DFD524
	for <iwd@lists.linux.dev>; Wed,  3 May 2023 13:50:23 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-61b40562054so18005826d6.2
        for <iwd@lists.linux.dev>; Wed, 03 May 2023 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683121822; x=1685713822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7iDXNIw6kO1+JXWUbWBlAoXKxCqVNAt1tEPrDGfOeA=;
        b=QixlbuaxSLDR1cMROLFh128yIME9y+4mRyY641gkYgn0lLdCp+Mb3mAr/iXd9cPXwr
         p1RRqxTmFJn0wtG1YaTku4mejnUMRWcsIcQ5UXui+ezDdYPdJ4I3gboSUhz0UDGoeGfN
         yLR48otMeAtoTLjiWFxIgz/PlbKYKdDcCnyu90TZbZMPhTer+bZSPjvkAhVev6y0RPYP
         WY6kOnnHnJb1bezsCBKXl5sVmwVNE/7tHfJKWskAvyl3Hs2VPMMGSycp4PtX7l1gfc3Q
         IPc1PwtfCCYCL2h52TqNblInDZ1ZLFUq3f0uZcw+Ov8aegXSquf2zO0rMrHSlLL53Cem
         rYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683121822; x=1685713822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7iDXNIw6kO1+JXWUbWBlAoXKxCqVNAt1tEPrDGfOeA=;
        b=ccAAswoQULBD0Nf1VPA881mdnDG8EOsL4XqNIE+MElC3CDuBkCZrksT5ldGjqaW254
         lzjQj2dIXY2sjSuq5vxfftiQ+6XSvOpqnYyzY4uclxqgfpEaVqE+12mfwBgLBm/iGk34
         B6E/D11JddxfI7sOH88iISHGNMAyaRbJLULfSWqIef9v3SoFOIUPbs7qNhQzA5GB3O0N
         o559Cxmg91Ww7exL0vBPmRTRxWUyppMsy2CtI5CSWfURTjBcyqv2iZczuyYN3a5STzmw
         nQH8EzlWhWEqmYebB8vQxcxUrNRbIplw9XavI51XJ2B9AQNnr2f9gYUPbvPoftU6dQco
         z4JQ==
X-Gm-Message-State: AC+VfDwukC8X2saIhylGe95k9DDrcgMAJJsCO4CmbgSMKQCFM4CW1rVi
	00K8aTsKDgD5ZdGHPyeX5vg=
X-Google-Smtp-Source: ACHHUZ5byMnbJIdiXhJhNmO9nm14Jt1qn97lZhj1rVeskF7NeLw5gkwVfycScYornlNGS1DNU7DGtQ==
X-Received: by 2002:a05:6214:1307:b0:5ef:8c79:fe99 with SMTP id pn7-20020a056214130700b005ef8c79fe99mr11621662qvb.7.1683121822049;
        Wed, 03 May 2023 06:50:22 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z18-20020a0ca952000000b005dd8b9345d3sm10402071qva.107.2023.05.03.06.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 06:50:21 -0700 (PDT)
Message-ID: <2d6dba3b-91f1-4abb-405d-d93fc29e935c@gmail.com>
Date: Wed, 3 May 2023 06:50:18 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
 <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
 <914A101F-70E4-4FA0-80A9-CF3A28BE61D2@holtmann.org>
 <b2be8a34-3624-b269-e253-6b76373807e0@gmail.com>
 <CA+iibzAW33xScrgXCqMebr1t5AmpPG6xntsv+8z4cUjc8ih4uQ@mail.gmail.com>
 <CA+iibzB2XA6xuQtMQRH3vcPiRtsb5bdDHRDQN5HNbvu2eQttJA@mail.gmail.com>
 <CA+iibzCNBhsS3sCkuN4cdvWmLDokaVMoVS6r8Q2mcKKx1+mm-g@mail.gmail.com>
 <4fb2f58e-8a05-93fa-de19-d61d9b4320ed@gmail.com>
 <BD529D19-3091-44FA-8AFE-BE89445D9B13@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BD529D19-3091-44FA-8AFE-BE89445D9B13@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

I really am not sure. Daniel pointed to the change logs which indicate 
libedit 1.169+, but obviously that isn't the version numbering Debian uses.

So maybe its just not possible. At least we have this thread in case 
anyone else encounters this.

Thanks,
James

On 5/3/23 3:07 AM, Marcel Holtmann wrote:
> Hi James,
> 
>>> I have updated libedit to 20221030-3.1 et the compilation off iwd is OK now
>>> may be you have to specify that the level of libedit must be
>>> 20221030-3.1 to build with libedit instead of readline
>>> I am sorry for the convenience the problem was on my side I was not at
>>> the last level of libeditt
>>
>> No problem, I ran into the same thing :) Marcel, is there a way to do a version check on libedit so configure can detect these unsupported versions?
> 
> I can check for version >= 3.1 when looking for libedit. Is that enough?
> 
> Regards
> 
> Marcel
> 
