Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C334CCF
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQOTACiu"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-581ed744114so1772472eaf.0
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698158404; x=1698763204; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RVfnC0MCsDIFfQP9HhvY1WxiIH7/vUHwUrkZl1W80Q=;
        b=QQOTACiu6SbLhuqX1uk5zEnULRucuRoBgBDX1qhXJ1DiwmGIL/vud0Fpk+l2nBmYH3
         c60h9TKhK0YcQ4hgXMnYOb6EsS3ZVriv2wiOxN+A+XYh4F2AWqxhoTvXuf8mg+JK+Q7S
         lipxG9QpG2splQM2Cog2PFArHDKM6MfE9YnqFkvurSb8WVhrAtxrl03AhO6jLoRHANTm
         oJnKen1XwWL70W6bAC08uDGUK14Or81zK0en/8vzdoPIqC3jCxVul/4QXdydJVSLZf8+
         E51yfiob3PYmqybiCvaQ/xr3MFX1PA8VeWX4frVzIZAM9PElFNS6acN2wyD+HVc3/3hx
         tgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698158404; x=1698763204;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RVfnC0MCsDIFfQP9HhvY1WxiIH7/vUHwUrkZl1W80Q=;
        b=LXhzFzPT8swFH4MsI5G35QHt41tU56hj8D0cve0oN3oRopKECDdpsf2eTqYfmzqoAE
         lGZSupoOlQdH/SCT8HMBTjtxZ1suQwP6QCUpatr2Vl0tZ6LJ/v4w6p0i1j9y9OjCLdqZ
         PR9siALzFU/tFNs+2VruBABpuHOAvH5P/oAO9sQTki3seDgKt+8J3kidGR1YBYufsgXW
         roCzQ5xNvGDSelkWvB5ptADwP2slpUQ1ANQ5lHiuBaMNWc7yfgclJb7/vksyDaNTV7ra
         0OcSUzUhJi6TubP5SOTIrCFlD0Xsu0cc9hIwj+y4omF9NGdYjWGv5dpd0+1ugyYKEGUD
         o7rA==
X-Gm-Message-State: AOJu0Yy4RHw0FErZo2N11IgQKaSmtWAp2e/orTe3e/7vtnss6pNwQmDI
	RHj7LOK6K3gJIDaJkCXt0/x7EAggw0M=
X-Google-Smtp-Source: AGHT+IFgDfdFdcwMFH9HKBvggrlNi2W8/HCd8Cnc0WHajEkAkY+LxC7X2dMUN2o3si+nTPAVkJZWgA==
X-Received: by 2002:a05:6820:8c4:b0:581:e819:cac6 with SMTP id bi4-20020a05682008c400b00581e819cac6mr10098488oob.9.1698158403911;
        Tue, 24 Oct 2023 07:40:03 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r134-20020a4a378c000000b00582014b0138sm2059333oor.39.2023.10.24.07.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 07:40:03 -0700 (PDT)
Message-ID: <eb7d9b49-959b-4c86-9581-f0b76409c40c@gmail.com>
Date: Tue, 24 Oct 2023 09:40:02 -0500
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
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
 <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
 <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
 <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
 <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
 <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
 <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
 <3a488d09-a66b-452c-99e4-a7521c80252c@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <3a488d09-a66b-452c-99e4-a7521c80252c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/23/23 08:49, James Prestwood wrote:
> Hi Denis,
> 
>>
>>>
>>> I'm fine with it as an argument to the StartConfigurator API. An agent could 
>>> work but we've also got the optional identifier to think about. I'd prefer to 
>>> use the existing agent API for getting a passphrase rather than a new method.
>>>
>>
>> But the identifier is not supposed to be secret?
> 
> No, the identifier is sent plaintext:
> 
> "Optionally, a non-secret identifier for the code can be transmitted to support 
> the case where a PKEX implementation may be provisioned to connect to a 
> plurality of devices and needs to know which code to use to process a received 
> PKEX frame. If an optional code identifier is used, it shall be a UTF-8 string 
> not greater than eighty (80) octets that is provisioned at the same time as the 
> shared code."
> 

Right.  Basically a unique identifier of some sort so a shared code can be 
looked up from a set.

Regards,
-Denis
