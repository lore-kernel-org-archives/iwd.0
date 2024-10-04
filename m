Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BB1C69C
	for <iwd@lists.linux.dev>; Fri,  4 Oct 2024 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728010741; cv=none; b=rkEoCCwGQaxrCONNfBzeLo1XWfgUjiR7ttRP+2eWgdrA3IFklHhGrEDMf8J7YvBFCIgWARriY9mlGSXjhRcIqolr0QaXY02VvSzyBsIMbmqX5KX1Kx9Yf73EEm6MY9npMhFIlPmYk62Y//vcXKykEToDP7xT8EMYDBS4pHGB7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728010741; c=relaxed/simple;
	bh=mdtQdypsXp798ELnWqMRMGow/4T0iDr6KKlJtQg1d6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PT8Cn3583lnWELLJ5vCtjR15i/dvj4TUXftRwhlvkOA+J6aTK1B1XSUj0zbvHvG15n39JWKnkoo57SCrfxOb4wbnkUpFXNbeAaXZ2LeiOyN/dHST1x1tF92EoWXfbjvg2USQk2Ey3jZOw1k+iDzGMlKtLIUHtPNF3+OYPxA/mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHIctOtd; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHIctOtd"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e5568f1baaso838502eaf.2
        for <iwd@lists.linux.dev>; Thu, 03 Oct 2024 19:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728010739; x=1728615539; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hytV5arURx0vcG8QlGLAJWnhWhtvanwCyvbIDtjWNzU=;
        b=mHIctOtdj4YlJEjN3egAF0zLDWum8COvSAn3rDZu+Iqi6XVBKQWVxedY8ns5Evpbk4
         R/o7yitVtJwtlvOQdSop9JkMvQqJ2BDt16JUSBfMXm9Ow0BFfrikUKYyxGJWe5Ggx27a
         O5aKPIZVjSKBhBObK/u73AExzWXzsZC191ynSQgjZ6QlIetZWo+gfY7px3Tad5vh7xDm
         CGiAcM+Q0EeXn7bAAFWQH17bmqXUWh/MCmESPAY1yKWs9TPfkipzcgQ7nXqWFtj9p1D6
         RqacZV3UXhWnNapc4oLBOWrnqDJ+CAjVSAvedUHkq/12mpkkA+IMeID5Vb4g73hRP9Yl
         EkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728010739; x=1728615539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hytV5arURx0vcG8QlGLAJWnhWhtvanwCyvbIDtjWNzU=;
        b=UeD+u2z4oBXoSlOqV1T8qHwPKglcNWcKeSjE2xzMkwt/hRUZEJqv1boqhNVsSL25a1
         ninOYe012RfN/op0tvwkhiVR2VEQZ4YHg7XUSm1Qx9Rt3bPtlyGyLO2JVrXqQAln4WG4
         KTSl0Px6xStNQDilhHP9l4LoWbyQn4cxkO7CAf6SLzfrB1zRBldtLHZeex5UzDSggsXS
         LlcPBU0pS92Uc6E/SVc6LJ3i/ftpvB/FQW7jSoCNcoOdZFDCWRyXnnK8LTC3nmglLfMB
         /0noCkCYo86GUyNcn3qGmWUgL/oZBcVLD3zxpbfoE4xIrVFhbNTtguNYu0E851ffiOVg
         0kFA==
X-Forwarded-Encrypted: i=1; AJvYcCUnyq84TXRpHTKq9pZbr5J7HiYVxxI3MszaYSKLvRLfnqMqTlYuvcrBytmy1BGlN3JjuAE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx61G9cdkwnKwh2Dx+cTnwnKr6PirQO06fafR3US27UTalz4Z/s
	aHtNOjatbd4OqzVsvJmfoSrbT2eyS127myVCTKzxyjapr/jsenfI
X-Google-Smtp-Source: AGHT+IH3lAhCEeZkcaDpeDZHy7Bvmjb+BH8RVob3WwD1WX4Ka5aXbAA7ratbywzeL5CLfDefkiHrcg==
X-Received: by 2002:a05:6870:7014:b0:277:ef62:e6a7 with SMTP id 586e51a60fabf-287c214cd65mr1113589fac.37.1728010738830;
        Thu, 03 Oct 2024 19:58:58 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-287abc1bfe1sm901669fac.48.2024.10.03.19.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 19:58:58 -0700 (PDT)
Message-ID: <8da83f6a-a437-4306-875f-b7276da342d6@gmail.com>
Date: Thu, 3 Oct 2024 21:58:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interop problem with Quantum Fiber WiFi7 pods (duplicate RSNXE
 IE)
To: James Prestwood <prestwoj@gmail.com>,
 Vivek Das Mohapatra <vivek@collabora.com>, iwd@lists.linux.dev
References: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
 <f234b143-63f6-4184-b97a-bfaa082d8cf6@gmail.com>
 <f8703c80-14fd-42b8-bf8a-d06919b0db6e@collabora.com>
 <c400002b-ce76-4cfa-b5f0-c51be00eb9cb@collabora.com>
 <a6e3a5c8-2f6a-4af4-9433-2e3a3c74c1e8@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a6e3a5c8-2f6a-4af4-9433-2e3a3c74c1e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

> So not only is it duplicating the IE, but its also violating the IE ordering 
> which is actually a spec violation (Table 9-35—Association Response frame body). 
> So I suspect even if you allow RSNXE duplicates you may still run into a failure 
> with the ordering. Is there some route to reporting this to the vendor?

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=8f9ed66bdd4c26e619f0878cc8ef987ce27e4305

We gave up on enforcing the order a long time ago.

Vivek, if you want to submit a patch allowing duplicate IEs as long as they are 
bit-identical (length, and contents), I think that would be okay.  From what I 
can see our logic should be only picking up the first occurrence.

Regards,
-Denis
