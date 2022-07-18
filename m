Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0312320E
	for <iwd@lists.linux.dev>; Mon, 18 Jul 2022 16:03:19 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-10c0052da61so24866432fac.12
        for <iwd@lists.linux.dev>; Mon, 18 Jul 2022 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w085JLBpQ99GiE/XhaYNJfQBr+pEB2OcgTk7lKRlgKg=;
        b=GuoYzSA84uoDuH7WXv1gYnn+iIIKMWkA3DnuPPikZ/Zw1yWOSHkHBLzAJIu+hvNtov
         wJgn/skkQa18nmJhknifGyBRS4TVt1JpuUVgE8hToQx+P+Pos2ewH06VCOM51Mxdphxp
         20zAmjI8wpgQUlZNyhn/qPSrO8LHxKZioSCVQ+jovypqIFWSvYMfgcyzeVLNca4Azrp7
         /Uwekl2g5MgDjQAKT9/bIFOtqtNkpIfyMbFyJ4LaB73ZaNfhVTCjbCkNI3gzgqM3OFfe
         Sd4JZUb5ICZqgNQbhMZ44fG4hTrjQVYppMA69IAPnvY+yBWBt7zgWS3jZQi4YSHjGiMr
         AGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w085JLBpQ99GiE/XhaYNJfQBr+pEB2OcgTk7lKRlgKg=;
        b=cEDzpzBVrY+l1/0nTgV2Wgm5N96pNmN/Y7PT/qsPlO0kl9n0Wz0y5Blog94xtit43U
         yB5e6OYoob+f3K1W9oVghOrvSyeJgx1X/eHW+MIbkhCqXKTkpQjb5Vtp2PWJyBjA6c/M
         XzP18vDn6hAv19bEfAAl6XMBASEirX6AA3ekGw8/38cANq/ovpLOb+3oAgQ+RRrpdgLl
         RJZSFjIylzs6qeqpFHzkV8e32Bs2M9hrrfcFLNNvMeyRIGNiIE74/cuFMqWMMjCapTzg
         V454Dr3ZuCEgsRzZKqHkGqp86EemDDeKmSgVoXTyI77f5B/h20EHQcwZvMTb6Xs5ObKS
         Q39Q==
X-Gm-Message-State: AJIora+++ntb5pMJTvo+ebCLdiKX35rGip7SdPUnIeiQsCaF2HcIvZSY
	7Q5kylamG0GbfDiD/ZwW7Xo=
X-Google-Smtp-Source: AGRyM1vdrS81veLxpN4/wrKw7IK16w4Ceh/Dpbq8hnMD/X//UwKcz9sd7MqwZ4iMRFs+0TyR63Eo5A==
X-Received: by 2002:a05:6808:f8a:b0:33a:3b5d:d5f5 with SMTP id o10-20020a0568080f8a00b0033a3b5dd5f5mr11179812oiw.287.1658160198894;
        Mon, 18 Jul 2022 09:03:18 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id t24-20020a4ae418000000b004359b581401sm1268232oov.25.2022.07.18.09.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:03:18 -0700 (PDT)
Message-ID: <9bd2acd5-b987-9c7d-73c6-f133e8f98d0c@gmail.com>
Date: Mon, 18 Jul 2022 10:58:58 -0500
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
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Emil Dahl Juhl <EMDJ@bang-olufsen.dk>
References: <20220714165240.244e25gcyjtaxhx2@bang-olufsen.dk>
 <75994299-03a7-8a01-30ca-2342e5d7c5e0@gmail.com>
 <20220718091017.yk2yu5fwrf5qbyoc@bang-olufsen.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220718091017.yk2yu5fwrf5qbyoc@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alvin,

> Thanks a lot for the patch. Sorry for the slow reply. But I tried it now > and it seems to do the job: after hundreds of cycles it didn't segfault> at 
all. Previously it was reproducible after 2-3 cycles. And I had a> look over the 
patch and it seems correct.
Excellent, thanks for testing!

> 
> Do you intend to commit it to the upstream git tree?

Yes, pushed out upstream now.

Regards,
-Denis
