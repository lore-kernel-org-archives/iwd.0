Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13AB663
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118004; cv=none; b=htwS/9OXc6F6HAUwSw6TKL6Wb8HVlNzsztAZcvBqRW3LhidB0svBAoiiAjtbJPlJK3jQl6HdSr0btF9+gq0k7n7mhNyyU9koVhkOm9k4BAGm7xyZu7GdnBVUWmd4EogQl6VNeUues8ttYpExjszQFS7COYaQPCfId/FIp9cewmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118004; c=relaxed/simple;
	bh=FVQruRY7Vw6o9VwYCgf1cpG2qkpRCa7AjbBO4cKReHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB9dtmxrH9ikCU9a6QqIhZ8oSvy2kA0tU/Y/8kDtVqOTa8gnjJwqciTnZzgEeYEb0hyj52X75FUzpLwpuX3ZnfIp7g+ec1SBAEpkg/eQ2WmRHFr3OQ7m2zsjK/ihkONQKjDlTfssKe+3xM8bpi8lUWhuyQOFGtqUDIXOojgsoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWPvWhiT; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWPvWhiT"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23d3d092a1bso1595934fac.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715118002; x=1715722802; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROAxg688gPNg/nn45IHEBZbWBECncIXwHwl9kgnx8Uo=;
        b=EWPvWhiT5fXPUluYkasW//NMWvRBHMPEJWUmOHBLGxr5OINX3Op/PyfLtx19nrpjoc
         laj+JewGE5MxIm6LPrz7MgzKr2/EV1GuPI1clkx/tpz/VggZ+zyBTd9AXPGWqg/fgXQt
         e6UOkSZ/zz/3a/Un/ARjejFHWF+p6Mwr/5KzTP4MFZRooo9/tgWWuJfrTHmPgmhRIVRJ
         hQjvDcaSYJJVp4BPxKscxqik4Lp5UF/Imcw5GYYWkpz8P+Rk5lkgeu5ru370hwRkKO1M
         WlrT+R0a5SRD+hCWyqlaJ2zFZVs5XDIfxmy1y8mORUPHQC5Xo9FmOeXQ18UMoY446Hy1
         xuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118002; x=1715722802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROAxg688gPNg/nn45IHEBZbWBECncIXwHwl9kgnx8Uo=;
        b=RqboGgg8bc80xv65wlJf0dVMq+qCF9oGOV6pTqMFr8o9kgdgq1+r/ivB6Ub1BnIVl+
         IOv2L7LTc+ImsBMWD0UNSQU2pGhYkRg0qsjlSpYKpMXHmZqGiyhKlzJ/QA7+ETYYnXzs
         yg4ex5iul/LYBiy1+suz/PCfb2crUshUOnrSM6L8MJIA6x0AksaKIfpq5rXuP2tIkSIR
         DBg9R2jDNomIgsmqOKN+VIPW1ZKpgf18WFLaRHU3oLRVDCOm5Sri8fgMzwAPspa9dHUa
         b3DTI8esS9fvd7BSeK5Lvvolzf/P4pZusTOuLVjGol6RO21af05o7p0BE3SW1ERjlkQ+
         Y05Q==
X-Gm-Message-State: AOJu0YyHZZnJHokcSmOF2vbKpL/N+sF0C/HlbL6pf7EUpc/c9kkZ2w3f
	iTwh1S5Emxz5Bn9KLkcLCfKW/yn5ozAjmc6Q7o9e97Ja/W+FjmZU
X-Google-Smtp-Source: AGHT+IGI++ztfi2sYTtOUhPkryo8shsYWS+HNkqSFUosYqrHJohI/lUmo6phDCe5PKDtv36afo9iUA==
X-Received: by 2002:a05:6870:5152:b0:23c:34cb:294a with SMTP id 586e51a60fabf-24098c7b536mr904892fac.51.1715118002184;
        Tue, 07 May 2024 14:40:02 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id wn16-20020a056871a91000b0023b82735487sm2755943oab.52.2024.05.07.14.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 14:40:01 -0700 (PDT)
Message-ID: <d1e641d8-5a7b-45f3-9505-164a92997b7b@gmail.com>
Date: Tue, 7 May 2024 16:40:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: James Hilliard <james.hilliard1@gmail.com>,
 James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com>
 <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
 <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com>
 <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
 <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com>
 <CADvTj4qvEniwLnox8dZeqsDRbrBZfiqbKoCPxgRRNVu8sDBWBA@mail.gmail.com>
 <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com>
 <CADvTj4rOr3p80nTg3ACqQMzse6HFWfijFQYwKj+eonyCLz_V2Q@mail.gmail.com>
 <8b2156c0-7b98-4bc8-ab1a-5009389e5e83@gmail.com>
 <CADvTj4pYPBbvEDBoTnEZacE-Ah7S7wgCBYkJoonUMfac1o64ag@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADvTj4pYPBbvEDBoTnEZacE-Ah7S7wgCBYkJoonUMfac1o64ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>>
>> Should only be using the Start(ssid, psk) method. Its really that simple
>> so I don't see how it could really get anything wrong as far as being
>> notified. But again, I'm not too familiar with NM.
> 
> Looking into this that doesn't appear to be entirely accurate, that method
> seems to be working fine but is not the only API NM uses to interface with
> IWD.
> 
> It looks like NM is also using this for interface configuration:
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/agent-api.txt

That is only relevant for Station interfaces (i.e. client mode) if you're 
running iwd with EnableNetworkConfiguration=true.  The Access Point mode is not 
setup to report network configuration details via this infrastructure.

Regards,
-Denis
