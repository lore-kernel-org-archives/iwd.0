Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D61D53F
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555432; cv=none; b=UAtRw/2NYpk0Y1uWivYeJWVaMoCzKil88SPKamAeC8D+VIkok0hfIRlpM0DPRP6uEDF5X1gWgVro8Ey0H1a1wNrVe7hv6kWHcjA22dOpQrBd1Rx9oF/E7PGCbchjvi0urAVCUryxVnUgRvfCMpQb797KLpvT3z9mbeGwd/h7VyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555432; c=relaxed/simple;
	bh=+zf5PjQFFUPkcP6YZLDVNeA08w+rk4mrdT4GZmOuMXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l7wxSXFilmOJuPj0DmkSpuUpuhAjfGT2CZpk8+nxDfkAZet8PcGMXzQc+y6JX+SBJ4baMZ+ZYwPwm9kgVfL3eVPm67q5tQ6hbJN5acrEAOpa7P7lU6mT0zQPdb2ovXQMTQSrek5+5z9gXYnc4P5knLyYMLFaYeWEaWymDdlbOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO/jJNFe; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO/jJNFe"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f5cdca7a3so39855896d6.1
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 04:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709555430; x=1710160230; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwLDC4qRvwe02xsNAIv3b6tN9UBQcA3oGbE6g8EFlL8=;
        b=SO/jJNFe6wlN82YZMTE1eG3/kRLfmdf027S/vCwWTqunUNYr1Rw8HX7e/4hJVvT6A8
         hIuuLyXVcEBcbaoL5vJY2/Usj7qtCqMSTJRo6sTT8Q3HVCcG99aw/eyUWZbCHQZc5LhG
         dYpzaQZyFOG/zxeimls8DxzT9Zs5WAXkqRKz1Ebe0xh5TWBV638IFexmM2HCdG1Buaum
         UVcKvpQujuTymKygIpf1ZKiaxAC0oiPi41FCvx72piRMydb1ZLi0LTwE45pj9+RLMemF
         eb42WWAJxo7WshFfydrJW5fOwubhtQfGX1Ge9u+I6MOBH1uKBZwk8X+IZL6ETsmvLQrY
         oFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555430; x=1710160230;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwLDC4qRvwe02xsNAIv3b6tN9UBQcA3oGbE6g8EFlL8=;
        b=HQwl2prvsR4NSLHhImOd53m5K4kvZEgXx4nKhnXWRi0FAiNRpCIMo+f6iMKBJIAQEK
         XG3zsuKE2Xc4wPdKbv/SwFALKx9buNJFgSev8hE7FOfmIyFZ2PcnK8YP/L9Y1zMcip6/
         FtO6hIXxPs51vtxNez3J/Ou6yYKWopCWBa+ElysEvt05QkfAF8bNtdQoxUqcRb6sODlZ
         a7557nWHWPNrHnM68UTu01DaHsrkt+TV2EHnf1cuow5YeU8qp8mdk98RSMTo5aDGUOkg
         qyma63ww6mtbIbH4HlEbb6eYhBrucraZOFn5472Q8EMAeFTkkJgNyjJSqjzrLIFyX+b0
         smuA==
X-Forwarded-Encrypted: i=1; AJvYcCVVpREGuYumR06YLyPhG3Ag6TOx9p0b2gALeMpqm1DbNSQC/hCZ86wxlWWrINqVXMIVpwl+UVDH9ET+QKR+M2bRNeDF
X-Gm-Message-State: AOJu0Yxshb1I7qFPoj8ACdYkbSLixf7LLSMbfU+dcnv7r08wJq7FExu3
	I6uY4c4MI/0WRFUMZJBwG/FEdf+6lAaYyqz7br/nVNWBglkkmZ7B
X-Google-Smtp-Source: AGHT+IFQAXSwC7CWph66o2qslrBcegt+LnGMY50R391Gd4699spNLelUzhVLGhHKgU9hx/Njr1YmSQ==
X-Received: by 2002:a0c:e7c4:0:b0:690:7345:6799 with SMTP id c4-20020a0ce7c4000000b0069073456799mr4332078qvo.17.1709555430222;
        Mon, 04 Mar 2024 04:30:30 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id kf9-20020a056214524900b0068fbdafa771sm5063885qvb.5.2024.03.04.04.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:30:29 -0800 (PST)
Message-ID: <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
Date: Mon, 4 Mar 2024 04:30:27 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPv6 Privacy Extension support?
Content-Language: en-US
To: Hannes von Haugwitz <hannes@vonhaugwitz.com>, iwd@lists.linux.dev
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240301144608.GA25@magnesium.vonhaugwitz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hannes,

On 3/1/24 6:46 AM, Hannes von Haugwitz wrote:
> Hello,
>
> I'm running Debian sid and iwd 2.15.
>
> When I enable network configuration and IPv6 in iwd config, the IPv6
> address contains the embedded interface identifier (i.e. the MAC
> address), even though IPv6 Privacy Extension is enabled for the device
> (net.ipv6.conf.wlan0.use_tempaddr = 2).
>
> Do I miss something or is there no support for IPv6 Privacy Extension
> in iwd?

I'm not familiar with the privacy extensions specifically, but you can 
enable MAC address randomization which should hide the MAC for you. You 
can check the man pages for more details but in main.conf something like:

[Settings]
AddressRandomization=network
>
> Best regards
>
> Hannes
>
