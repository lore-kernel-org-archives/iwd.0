Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493343C2A
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:52:15 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id bd16so23228838oib.6
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=948UVshxJDUBk505esLE5v722dVeLb6n7nMDjznVvR4=;
        b=bNmd2AFCDIk0elMhuLHLAVWI9djN1iIXsNxbsa3IqQtufq0FPM+CRcyIsMCBjZJU2H
         sg7GhI4HN0TCJj44gcd0i5Xd1mstKQXU+v2NBsJDIdO8IIK9rSCBINLBtic5gpdVose9
         c45b4rn8TYj0ERrtYP9f3r9PKiDPRen9nBA9A4obE14sD9xPdnX4X0Bj29A3gabucqFh
         wVVlRFizVww59HlVQKzIG8umWrs3j/tgX46jQR/Q4v6HFY+ptU1PWnS/OOXZB6eq1aRc
         j30EXwcsfveA/EVXwssKaa45rPdXXkgDaDhy+uRaByxigL74bBPFXIzleepWWt1bSxi6
         7nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=948UVshxJDUBk505esLE5v722dVeLb6n7nMDjznVvR4=;
        b=eMyAiUiNVwvtHcY1Z44Ro9+Kk1EYn+lIvIl7smvScKOU2dn+u487N1zTUf1y+oC0LZ
         bTEcshx19EPgd+UvcRfYGtyWBXRL1n38WO/NYFzvfijIxIayfOjrIO942fEMEO04qisX
         cjdm5/IFNiumADdrErtKyllDr56Mxb0jhAIvurznhfs0XDtjqZb5a/lA5KnTnrixMR3L
         7FKTRDpoBtNdEowUhajn1/2wkX97sAex5vWhEz5Mn3S9OHbe9gnjkI2GKZtPWd3Eve1j
         TRHu1CblayppLbIa5vHi08gJqv8Bcv7aDw0Xxd5qStycsxoRaGNMl9pEiB3iYhvuz1Mf
         EBaA==
X-Gm-Message-State: AJIora8YjoZOpqw7sezzP6Aq1rZFC468oTcSfE3dxZOJRJw1LVlpgCU3
	v0bNvaFTTZeyLcC/zoloSIictuL3aMvlEaq1
X-Google-Smtp-Source: AGRyM1uxD1iLiwvMBBFlB1n/j5tSTFyJMEAe/HksS6XjnPJIk04gf+lbOg4LBv6LzHVihFHTV8DIsw==
X-Received: by 2002:a05:6808:118e:b0:335:1985:cb59 with SMTP id j14-20020a056808118e00b003351985cb59mr547765oil.230.1655941934393;
        Wed, 22 Jun 2022 16:52:14 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s24-20020a056808209800b0032e6b8e8aefsm12937463oiw.17.2022.06.22.16.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 16:52:14 -0700 (PDT)
Message-ID: <c03620f4-c330-ed3e-b7f7-67b8ed99bff5@gmail.com>
Date: Wed, 22 Jun 2022 18:36:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 15/15] autotests: In testNetconfig verify routes from RIOs
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-15-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-15-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/15/22 19:02, Andrew Zaborowski wrote:
> Verify that IWD with NetworkConfigurationEnabled creates the off-link
> routes for Route Information Options in the Router Advertisements.
> Sending this last because these options are not supported by current
> netconfig code and the test should fail without the l_netconfig patch.

So is this true?  Didn't ell commit:
9c5cbf5484b2 ("icmp6: Parse extra options") add off-link route setting directly 
to l_icmp6?  Shouldn't this work with the current (upstream) netconfig 
implementation?

Regards,
-Denis
