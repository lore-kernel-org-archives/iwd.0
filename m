Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68624D314
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwd8FFW/"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1e10507a4d6so5630422fac.1
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732234; x=1698337034; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mwEVxIJzD04Oa1ukleSHb/O23pQbTp+VQwg1B6PmE0=;
        b=gwd8FFW/l8NYSjvyJYbrgfMBmmDSQnN/j68I5E0xU7iZZ0z+9V27v1BcB4cmyghNhZ
         LLPtcfWYAkZ3qXwx+BsCx2mCY5lkdtON6D+wXtSApURRICFlMzKuvMCExtFUaEaKFUSa
         FIoPnLRUh9r0s+736EZovaDAC5jkhi9iK4HH84+t6s59acr5NDaSS3e8cElJ1uG3nTEB
         a7X0kOt/mYRyZpS8XteJK/RxjH88LkMCYg5dKMPyx7TIdAYY8Fm5vSMmrTdkb47bkFzq
         XnlwAhMAd8lAsl6mLkxxmkEMLz5GGkBvVr9Kp5rSJe9zm6EmFhX03c87qCUksQap8rwQ
         0TWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732234; x=1698337034;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mwEVxIJzD04Oa1ukleSHb/O23pQbTp+VQwg1B6PmE0=;
        b=E6M84o/cmsv+Toqn9aCjiJego3Aj3BXJ3oLVyjqlGqXbKYc2JX2QKAnpfS0CUfJBQW
         eR4DuKPbxAkWs+UxP/jZ3MkO3nWZXsP/ys70C0oLr/gdMIrxFE2g25yza2n4vOesrX/q
         yM+Dkj/ZsDCsLUWB09NkATIE/DAiH5tqYfDCol5hmF7O1r5itgJscvC79bEvnGHm/1fT
         G6BKsBhZlQNvTuCXJj2KPJ8CpoaNBf+sl3eiLuDrhpDZP9rCgMqDL7H/2jc4+82S7FhF
         o7JSBWLiTZK7d6RFV9jMpKfQSdXUz8dnyXU+7/cFpOHO+Bmm4xrUYxGWWjgFlIjMZBfy
         ks+w==
X-Gm-Message-State: AOJu0YyYVGQxEFMP4KxIvYQ/TQLSdeGvLgR2cgm5vzBgkFKdoIjUBQDT
	75ZdutH+WxSKZ8zvhWc6P0wxB0qfNE0=
X-Google-Smtp-Source: AGHT+IHhhUSDyJRwy/DAH3jHMuhWWYAZ3+Rkpmv/oUrK/57+aPz9V5Jw0VOccc5ywVTbpNeqYiOVEg==
X-Received: by 2002:a05:6870:f225:b0:1e9:9bec:c01d with SMTP id t37-20020a056870f22500b001e99becc01dmr3288230oao.6.1697732234415;
        Thu, 19 Oct 2023 09:17:14 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w3-20020a056870a2c300b001dcfaba6d22sm1223408oak.46.2023.10.19.09.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:17:13 -0700 (PDT)
Message-ID: <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
Date: Thu, 19 Oct 2023 11:17:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>>
>> WPS auto-generates a PIN, can we do the same here?
> 
> You mean auto-generate then have the user (configurator) share that out-of-band? 
> Sure, but its probably just as easy for the user to type in 1234 or something as 
> opposed to calling the API then reading back the generated code to their 
> enrollee. Or maybe I'm not understanding what your talking about.
> 

I assume the shared code should be of a certain size and complexity, no?  Just 
like your web browser can auto-generate a strong password, same would apply 
here?  Also, PINs for WPS had special rules.  Don't know if this is a concern here.

Regards,
-Denis
