Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3637C8F
	for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aejArGOf"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3af5fd13004so4506373b6e.0
        for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697639559; x=1698244359; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uT2SVZah6tuvSqGz5BQcbdspf13Fn7vLyyp5YDwTtx8=;
        b=aejArGOfrXKbwT44435HgEcV/JvF+co7NNO0VCy85biwzA0xSj0JJyo4V1Iy5UCmKM
         M8aVLDv5C46T4opGpbx0452jC8A9fs2MsXYKtzGO6bYP67PkzhVXkmpUoFi3geZB8nMM
         kD1ZNgnkG13JqJIAqkg0aUN7EXPkEAKRO9LdLHusyNaTe8ssSCs+cEXz6RbBrSqIQ19Q
         hmulO21LUF6jJ+q+ZSOXtxtF/FzRTGg9tJlUYmY7BjVQ3hXvlp5WBYgslD0pBom7Kfsf
         Y1e6nOOiRdj3xZ9d+RsjwYIq/ZA9f6I0UO0piOdCkxH/9von2mieaeGq9+b0/ms8VUhD
         iHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639559; x=1698244359;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT2SVZah6tuvSqGz5BQcbdspf13Fn7vLyyp5YDwTtx8=;
        b=Y8yaDQLz50c5NiEiLB8qJlJxePYS+puwb2rpAOj5j2AamIznz7U/HagjIrLfYZeGJI
         ntN9Ly2DycYzwJDD3sbgGY3GLYY3HDNfOBy9F+DQgGFP45KIbna3jhwqQasBwvdE8ac6
         VS2Bwca3JbWhIdRupEA/cDyNQ1aqtquy704/g6Rcvr93ES3eFM2kFc832+hii0sKdjWO
         Y+VY1x1BcbXfxEfTj8nmCPaBgent9o9IEqC+ONLy6Wvf04WwoN4a+zaxItS14L7RYqq9
         7Q3NSC+mVH/TQWzWRHAOeknas7cRIJK/OLg3h7AnBxf7qRFXA+ulCfFmFVJiSMXuj+v7
         QD6Q==
X-Gm-Message-State: AOJu0YyyGdNODrEoxEASROuS6KNNq01ghoqxrxvbpC50SjHSniVy/5tO
	AK0YQGd+V/bjyFXEW+BKKVo=
X-Google-Smtp-Source: AGHT+IEp7rq1jBfKBdTnQ02DqRNDlo7DeGu+GquZwLNz230vIqnaOBCf+lE00d2DfTXgdhZYLkGMDw==
X-Received: by 2002:a05:6808:1b2b:b0:3ab:83fe:e18f with SMTP id bx43-20020a0568081b2b00b003ab83fee18fmr6774741oib.35.1697639559158;
        Wed, 18 Oct 2023 07:32:39 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bf33-20020a056808192100b003b2f369a932sm46023oib.49.2023.10.18.07.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:32:38 -0700 (PDT)
Message-ID: <76261973-a04e-488c-8fc0-a0f623c15af0@gmail.com>
Date: Wed, 18 Oct 2023 09:32:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add AllowRoaming station property
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, =?UTF-8?Q?Pedro_Andr=C3=A9?=
 <PEDA@bang-olufsen.dk>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20231018122534.33455-1-peda@bang-olufsen.dk>
 <8bef6b0a-8284-4889-bd23-b33e26b450f2@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <8bef6b0a-8284-4889-bd23-b33e26b450f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> LGTM, I actually needed something along these lines for dynamically disabling 
> roaming e.g. during a software upgrade or some time when networking is critical. 
> Just hadn't gotten to it yet.

I'm curious about the use cases.  What were your thoughts on how this should 
look like?

I imagine for things like firmware update you still have a set time limit in 
which this upgrade should happen?

Right now I like Pedro's earlier proposal with the minimum throughput guidance. 
I think we can go further and calculate the roaming RSSI threshold based on the 
minimum throughput.  This would allow iwd to ignore roaming until that minimum 
throughput can no longer be delivered.

If we need a bigger hammer, then we may want to consider using an implementation 
similar to how Modem.Lockdown was implemented in oFono.

Regards,
-Denis
