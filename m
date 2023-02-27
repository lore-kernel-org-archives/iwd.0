Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6232F3A
	for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 16:33:49 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id y184so5629105oiy.8
        for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpCu60fhXol0r8Hr88FAwj0FMcwBKTtOn2gfNc8LBI4=;
        b=iDLqpQ7IfyEd9YzRAb9qpzp0wz6E5Y/dDF1e5T6nmFsLp7zE0WckUkJbiklB2HEIWF
         yKQkcxVr4vUg6z/w+xquYlWIjesvUonlOfa5go0ytr0L/WGE/zU4k4XWu7971S+D7zKs
         Yq/uhQqo+ulBVx3KyuTgb9SVCAcrWYFfVqs7r504J4dY9iHXz1+Z4jI17Mdmd/t12jOB
         OqLq5NrGBSFp96RjYmnvWEhVi8axmKYFN7olbbOIo7MC5WU58y80CRKkSxbPUrJyS+zW
         SqGKTe/8M4wRK2G0XCVvnp/CKNjs+17wgumKLoNYWXVMQPZlsjf7GThTVZ8VFsWZe08R
         aOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpCu60fhXol0r8Hr88FAwj0FMcwBKTtOn2gfNc8LBI4=;
        b=MxpfbMwf+ulKVFK2U7F8oa8khiCiokv+Za8PJBL9eaDTKFGDYbs9dAwaa9/OvItLbU
         EFRthmroiJ2+dh3F6qS3O3EZL9iI2rcIhLzL37UGlyZ0VWxdyf9ztezk7HmjupfoYmfI
         ZyCvG89hYeDJ4sD/otBbMhU0sTjswlP5FPR9dofgg2tefpfjySLyyMe49TW4RbfuawOm
         WDMDrO7vdgua/NQiR3Ask1afcePaPL13Zp6GQg3aaYCBdYY7cuwmMmIYAGfT98O9qSgp
         eOdDVbQMbYG7AUm0K/2201HUGOwJtgsEdoL4+nqJ1tHbUFRc2kF7tzJKtYPt64mwYYdb
         f+wA==
X-Gm-Message-State: AO0yUKUih6ZcYdH9aV8CFWphiWSKcyUZ7kMIP1YSEBBUthzwaWne6Mb/
	mDSlOb6x+k4Sh4RVY7+Nr++WDPOBZT4=
X-Google-Smtp-Source: AK7set/aXtwagkQs3aqzcNPgYSCQnQ91s9BraqNaOUY7XMU2nog/y2l2njbNXxRa4f8P6VnmFziPQw==
X-Received: by 2002:a05:6808:4396:b0:36d:ea30:7bdf with SMTP id dz22-20020a056808439600b0036dea307bdfmr8376759oib.49.1677515628841;
        Mon, 27 Feb 2023 08:33:48 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v132-20020acade8a000000b003646062e83bsm3279312oig.29.2023.02.27.08.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:33:48 -0800 (PST)
Message-ID: <790e0f2e-6fc2-820c-22ce-8ccf253d6864@gmail.com>
Date: Mon, 27 Feb 2023 10:33:46 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: iwctl using readline, and readline is GPL3
Content-Language: en-US
To: =?UTF-8?Q?Joakim_Lotseng=c3=a5rd?= <joakim.l@orbital-systems.com>,
 iwd@lists.linux.dev
References: <CAELJisw+czjWSgHKNi7w7mkBX80pK=KnC4Nu0GNi9j-fq2n6dg@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAELJisw+czjWSgHKNi7w7mkBX80pK=KnC4Nu0GNi9j-fq2n6dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joakim,

On 2/17/23 05:40, Joakim Lotsengård wrote:
> Hi,
> 
> Is there any way to replace or remove readline from the client iwctl.
> iwctl is using readline which is licensed (since v6) under GPL3. GPL3
> will transfer to iwctl. GPL3 is a problem in embedded devices due to
> the GPL3 stating that the software must be reinstallable. That makes
> it impossible to have a trusted (signed) filesystem. And a "port" is
> needed to be able to re-flashing the device.
> 
> Maybe a build option to just remove readline support? It will be
> perfectly fine to just have a cmdline support, and no interactive
> prompt. Other solutions out there are to use libedit. Or even
> noreadline.

We have had a plans to implement our own version of readline inside ell, but 
this has been a plan for years now :)  Feel free to propose something.

> 
> Yes, we can remove iwctl entirely, but it is a very nice tool for debugging.
> 
> Anyone done any modifications to iwd (iwctl) like this already?
> 

Not that I heard of.  In general we haven't had any time / resources to 
dedicated to iwctl in quite some time.

Regards,
-Denis
