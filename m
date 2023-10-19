Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65527470
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR5hoxzT"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41b09c75bd5so55471931cf.3
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733763; x=1698338563; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8OaWqjUMXlL0Z8b64jHd35s0ugFCEZhus3WfsLD4UU=;
        b=XR5hoxzTPHZKtWcyACHERyAgMUH2qMWNIhwqy+W9xAsdySX+k6w/Scfc4houRIgBvQ
         jWlSIu+YnBk9aI+gcXRMd8m38piKR9DQb4CfbW0JBS/a6wkdoOopDNGrJV/NM6xeMJCJ
         xtlK+zDzScKmqhhj9ev01KufP9t1knaoBziOx1IjQIXKWSSutb5zQPdF/GaIDIXvCzmM
         dAJXjjSTIbrnlyLcT/BWwfrV0tmznpVaJUrmIT21ARXNs01TPphjvuFD0OKcXq0loMuZ
         VO+1u0avG4/0KWi5noS8onVa2Un4w3nv9er1qU4stL52DiM9arS9um4DMxCflQMSZZFM
         AD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733763; x=1698338563;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8OaWqjUMXlL0Z8b64jHd35s0ugFCEZhus3WfsLD4UU=;
        b=mVag1SYXRRaMBdOmkWoF2O/Ndcd0UCBZF5HyO6kocBsU+m0I9omtEWp8W9/BKe0TnN
         jqBG+iFWhnRMIgJa2nbKctkQzO9BfZoDSzTaVipgMm2jSc+8zRVhxDLPo86s3SAthOxX
         aAY+vpMpaamjK9QJdWJ/ENdBAdgCSRrGi1ibmFVjbuVFiTVt0oEOx1VFs/YpCQrrh0wR
         98uANyb6t/QnNDXh2fmOrnbdLb4dZRwSytV4yCvrZKZQ9YYoQIx5SL0ywg2ffAfSeidY
         qCASm8edDBfJ+fSfUbc3bDdriN98AVFTBFj6L3aZUYbTEhtcyTKv4dTNZV1Cld9Hjqgy
         sREw==
X-Gm-Message-State: AOJu0YwmpxffNEU4ihIClDMgUKMfMAH2/C2svlZJtGdqvKxLzq8ccbkP
	L2yn+IJV1lcWhcpBs7PKQk8=
X-Google-Smtp-Source: AGHT+IHHjNIQpl1WsNqGPbp7YoLtOkKaHWvfYHM0mks+UZxufupvJqiNdXc/WNrHEv2s/0eN3xuM3Q==
X-Received: by 2002:ac8:7e8c:0:b0:418:273:c337 with SMTP id w12-20020ac87e8c000000b004180273c337mr2751250qtj.61.1697733762948;
        Thu, 19 Oct 2023 09:42:42 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id l4-20020ac84584000000b0041b9b6eb309sm837882qtn.93.2023.10.19.09.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:42:42 -0700 (PDT)
Message-ID: <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
Date: Thu, 19 Oct 2023 09:42:40 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/19/23 9:17 AM, Denis Kenzior wrote:
> Hi James,
> 
>>>
>>> WPS auto-generates a PIN, can we do the same here?
>>
>> You mean auto-generate then have the user (configurator) share that 
>> out-of-band? Sure, but its probably just as easy for the user to type 
>> in 1234 or something as opposed to calling the API then reading back 
>> the generated code to their enrollee. Or maybe I'm not understanding 
>> what your talking about.
>>
> 
> I assume the shared code should be of a certain size and complexity, 
> no?  Just like your web browser can auto-generate a strong password, 
> same would apply here?  Also, PINs for WPS had special rules.  Don't 
> know if this is a concern here.

I guess my question is really how you communicate this to the enrollee.

The use case for a human user really comes down to not wanting to type 
in a 64 character hex string :) So auto-generating a complex code 
doesn't make much sense in this regard.

For a headless device auto-generation just won't work since the password 
is baked into the image. I considered generating a single bootstrapping 
key and bake that into the image (no PKEX) but I question the 
possibility of offline attacks. With PKEX the bootstrapping keys are 
changed upon each protocol run so I think there is forward secrecy 
there. Plus PKEX uses mutual authentication to prevent someone from 
coming in and configuring the new devices who shouldn't be.

> 
> Regards,
> -Denis
