Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7E33F0
	for <iwd@lists.linux.dev>; Fri, 15 Jul 2022 15:30:24 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f2a4c51c45so6604856fac.9
        for <iwd@lists.linux.dev>; Fri, 15 Jul 2022 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aEJoGdiStCdUQCY1hmWR/MdEVLzaM0ZOMkeMMbzRHlQ=;
        b=WGUs8PC8GOTmGcpk5mELABMwXy+UWjAOduuQ5j5fbU0X1L95k8hGGT0NFcq1fK8UIT
         VVi+oxQ+mgoZqY3ilmBQEk3OqCiJQ+p+qV/C6ots3u0GtFcTLVzsdYhNov0kIaSlmkJ8
         SWxmDi9g2N9/WYxILjrToZB4NYB294U+Ym2xQHrbUwu0P+AG3DS+LNoHtIkiUpcuDKBV
         kKft29gzGBQ81wHZLhDBu13d2+elldtKWpXy7R8UQ1N+tLk2BjTecI/V+rOLpfGPfEaR
         vI754AqA9EDGjBqJyyEtbU4dikT/bM6JeYQO9nj3A0hHiFXunwFhp9lFsJD3EY5L8puc
         Po7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEJoGdiStCdUQCY1hmWR/MdEVLzaM0ZOMkeMMbzRHlQ=;
        b=gVWfpfLFOvV9l8aXVkVh2miCtj8i4jjJl8uor3eXEbDjcEiNrsEcxnuBNFISeaDa8M
         5XdVxC4sLSsK32pOJgAydzal7RSD/dkJQxg+uQbgACbpMS6cuCTYIM03cRsYeyegbf32
         1MvMLppA9YxUmoBJ12BRdXIz3TDh03yBD5FpUF+Cxm8hFyu6tnrJDDMeDnfTAvPSr+Dp
         HABXdflDw6XLeZgsexK+tSBqMWk7O7Fic1ZMaZcMcHqsRFbIXSdnAyU8CEaIIuFk2G25
         fl3Sf7ex3PcejhrwfJiOuardOCgymU+xj9WSVYrIMRXUXGjXC9dWTzYo7AUfS6Kr23rv
         IfNg==
X-Gm-Message-State: AJIora/z37GheH3pT8jkI/QAD+Ql/DGCFalUDrs44L/WzkadYdT+5QIp
	Crsez6+ZetxiJM/oWCs0HhI=
X-Google-Smtp-Source: AGRyM1tdURWaZ/M94S/Cx3N6fhdG0bEV+vCFd4afzz5go8zsljm45Puhet2Ucu9F57TBSPYbqzZrKw==
X-Received: by 2002:a05:6870:b50e:b0:10c:7ce0:372c with SMTP id v14-20020a056870b50e00b0010c7ce0372cmr7783794oap.140.1657899023914;
        Fri, 15 Jul 2022 08:30:23 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id v30-20020a056830091e00b00616d7a9bfaesm2077524ott.45.2022.07.15.08.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 08:30:23 -0700 (PDT)
Message-ID: <75994299-03a7-8a01-30ca-2342e5d7c5e0@gmail.com>
Date: Fri, 15 Jul 2022 10:16:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: iwd 1.28 segfault while terminating
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Cc: Emil Dahl Juhl <EMDJ@bang-olufsen.dk>
References: <20220714165240.244e25gcyjtaxhx2@bang-olufsen.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220714165240.244e25gcyjtaxhx2@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alvin,

<snip>

> iwd because of the BindsTo= above. From the logs, you can see that iwd
> hangs around long enough to pick up the recreated station interface and

So we manage to detect and setup the device, scan and start the connect in the 1 
second grace period during shutdown? Impressive.

Can you try the patch I just sent out to the list and see if it fixes the crash? 
  I guess we could also add some logic to disable wiphy detection when we're 
shutting down, but this is a pretty weird set of circumstances :)

Regards,
-Denis
