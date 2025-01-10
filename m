Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064420551F
	for <iwd@lists.linux.dev>; Fri, 10 Jan 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525414; cv=none; b=F9eqF8ZGiY9lQFJ5EsnjqZ7P3nJ2zm5tahJDMpKVW9m+5jkpj6TJ4bGcSX75BAvleeYp1DHCBAwS6GmIWEIWAgbbUoVHS86I++MXU1FB/ysSdYTBC66+dKK4wlGtzL4PdUBlSaUWkJdwhGRahuSxsBJezNiU8v2N6+14DTfyXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525414; c=relaxed/simple;
	bh=e2KrLJokaYRMypM9o/BySHgEBtEgxvU+84WsrhQQsm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J6c12xILxSGA5NSAegU3hE4VRmDC3kl7rpbxgxtFGEDbYlJkyz3sxe9D7rAHIR158E50od1g6TTW4bIsbjSpnWhbHMt/jmq3u60ghoKesgsO0LRJx/++Wf0YDMch9SD1c6SGnyLkeqsOQXW5Xa6j2a1vacc2UamP0naECpJpmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0xCIEgT; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0xCIEgT"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eba347aa6fso1281478b6e.3
        for <iwd@lists.linux.dev>; Fri, 10 Jan 2025 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736525412; x=1737130212; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rM7vreWa3kHCBvicKFa/bDBLezkdL/FPI4B2BW0ie4Q=;
        b=E0xCIEgTSV6lvT5N4ypcgZdPs03zNnSIp2/wHmtkUm2jf3DqrTD9FKRGPIrfOj/fIl
         iae9k8K/2TL+KVK3Rt9Ir/UGx0mzJSonnXPLQISgRnAei/RX1mjKp1J8qyrJe2UKm7ft
         65f3p0JO+cSTyy+rLt3DRhcnIesm7C3S8wamiiFaWuZBcvMbWtzFqOH5eBLV8SsW7J2N
         jNde2uM+8UuCWtXEakIGICUojYRd1k0ko1mH1ghE2FRuudHy6FlxzmtOD6CCnacqiLUw
         yYCPWGrAnBAaFmCpV55k0THaxlLMoOoRbrdV6wQ3R7CNeQGiiKrf3+DawC68vqe2J+ce
         i1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525412; x=1737130212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rM7vreWa3kHCBvicKFa/bDBLezkdL/FPI4B2BW0ie4Q=;
        b=AP95W5p7byj/qQ5mZdA6giGQf7fahI3S/vkjtOWz8ZXtokszcygCbwGsa8y9tGKK85
         aRlWZDxEUDZbZnb1oHvwd0K0FAuLlZgtB74k6BJTLx91cQOS/L2WKm6rMfxXkaN8+JyY
         xDxjWe/AtbirlLRXTjWwANhSYCzNVChZ8vyMNwcFe1L8qn3bjtZy145IzATAfMEM2d83
         yYXBMHHu9aloIYG/t2I/J1bsKy8F/B/pOVQJx2mRAtFH4oGueU0P9Q8ZyciOGcl7Jfk8
         NJGi/mkQIx4V7sfllihxIrzuKAf2N6Z4DpJaZtl6zMwV+4koLpHymuL5G1hSDYmkxN2P
         d5bA==
X-Forwarded-Encrypted: i=1; AJvYcCVQIb0FxseN6C1nuMDkSBru0ZEEShTL0q1amOvSqhy1db1IXUsS3UngUUlqQ7faXX6q2Vg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiAkjnQmrEAJjdGjaOT0q9bm31yBkVOE+K+X4FM9Rwabm5rE33
	tEnXq4H9uxQSA71tlewiW9wJeESpc+F0OVANnYSnEvn6Xrk4kwNl
X-Gm-Gg: ASbGncseuxGPQzhmISjG8sdBNkRgSx8+adG6r1IUQuST0WPCFp4qKultJhll0aBBTuL
	/5yRp7Jt9D9drRhcXFibFy8OcXR8th8IWhFWXpS57kgKeRr49Mnx3fz14XR8HHDXcBLTG4wlrQ1
	E56fiBPOflQMwsjJ08QGx2tNwI9EyUehOq6aEoDgJKkSDhmBjPLtlz7oULKak3gEloHr6BqjAQN
	VcRyyoiww3qEFwyvFS+f3yed74nbDHx3vkKu3pie/vUkwa77NqUXCOWcvIdSwr3ObKOPZK2z/sV
	4ffsL1rE272w3V94M6nyrQ==
X-Google-Smtp-Source: AGHT+IE9hZ+R49ip9LTv6DgefuFqlTIC1K3C0gkzHh2idhfVy/m9PNJLUEVw/JoFQYKbvPZYhV9Qrg==
X-Received: by 2002:a05:6808:1b0b:b0:3eb:5d3a:5b20 with SMTP id 5614622812f47-3ef2ebedb60mr7810161b6e.4.1736525412169;
        Fri, 10 Jan 2025 08:10:12 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f037612625sm784363b6e.7.2025.01.10.08.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:10:11 -0800 (PST)
Message-ID: <6221c3a6-09c8-4df3-aec6-6a9172ad90b0@gmail.com>
Date: Fri, 10 Jan 2025 10:10:10 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support for multiple EAP methods in one config?
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350114FC7C034E2E52F199BAE132@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <LV8PR08MB9350114FC7C034E2E52F199BAE132@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 1/9/25 7:37 AM, Michael John wrote:
> Hello,
> 

Please get rid of the confidentiality footer.  It doesn't make any sense when 
you're corresponding on a public mailing list.

> I'm looking to see if IWD supports the ability to support multiple EAP method, like what can be done in wpa_supplicant.
> 
> network={
>      ssid="example"
>      key_mgmt=WPA-EAP
>      eap=TTLS PEAP
>      identity="username"
>      password="password"
>      # Try basically every common inner method
>      phase2="autheap=MSCHAPV2 autheap=MD5 autheap=GTC autheap=OTP autheap=TLS auth=MSCHAPV2 auth=MSCHAP auth=PAP auth=CHAP auth=GTC"
> }
> 

No, and it probably doesn't even work with wpa_supplicant.  Not in a way you 
expect anyway.  See https://w1.fi/cgit/hostap/tree/src/eap_peer/eap_ttls.c#n112.

The fundamental problem is that some methods, like EAP-TTLS, expect the client 
to start the inner authentication, and there's no good retry mechanism in case 
the tried inner method fails.  With PEAP this is less of a problem, but then 
PEAP is pretty much only deployed with MSCHAPv2 as the inner method.

> My use case is that I'm given a username and password for a network but don't know the outer or inner protocols (or even if its personal or enterprise but I can determine that from the broadcast beacon).

If you have a username, then that precludes PSK networks as those don't have 
such a concept?

However, username/password is really not enough.  PEAP/TTLS based authentication 
really requires a CA certificate to be set.  Otherwise anyone can spoof your 
Enterprise network with $50 router.  If public CAs are used, then a 
ServerDomainMatch setting is also advised.

iwd doesn't support a 'Trust on First Use' style scenario where the signature / 
certificate reported by the peer AP would be presented to the user for 
verification on the initial connection.  We didn't think supporting such a use 
case was good a good security practice.

For enterprise networks I strongly advise figuring out some sort of provisioning 
mechanism.  There's even some code in iwd to convert iOS provisioning format to 
iwd settings files.  See tools/ios_convert.py

Regards,
-Denis
