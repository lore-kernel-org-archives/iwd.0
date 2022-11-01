Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304A7B
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:51:04 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso9173819otq.11
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXHrFqXmDWe9qT8fhWyw2jpEsvpqXaRBfbugStXTlrs=;
        b=Vn1EZA2T/yCydbsDryIAAGKbZmNPXgneOFmczUifzI/nZFg4Zl6x9yYxMMqmIlIa1s
         PyqNM8CUwYx/dYTHoYTLeI4l5GPSf0ZgrqEkKRghawA3Tr0HqKVDk8ng56dnwvDfYwDu
         MgcV0BBr3VrARmw99omlXHfwrqba0cZ6KuSB/CwXtIXgxUv5CPBZDEuR9mXbmQvNmNlv
         D+CO2z6h52hYmVhKYHaf7PD+obg5rAA/CDugqBwuBi61wN8ASgu8tM1jvulpeA/wm40j
         ZVmgvn2f/Q6LrxiB9dAz9C8gaaAo+Ks+VdSR+4l8avpTPRTMPfI3Prp3o1XxZoouhNUs
         XjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXHrFqXmDWe9qT8fhWyw2jpEsvpqXaRBfbugStXTlrs=;
        b=OukhAf2LpansQ+t7LJo/ycztKg3xj1APc0T88IBpUFs9k1zBSoRtwZjre/T+aJXOnW
         xh/ihtfV2Mbnd9WCcod3QO4nhhvk14eollLwr++w69zmE0gjxCt1eBXNSWe0qnw0Tcb8
         5UxMKN0uhNgFF/31rSjBe7332HJXKiwkZVQzq1Kp+1OCLRlSJWgYp5omGaaIEjmbZRx2
         fqavDY/a2yOPwmuqiGaVTY88rETNmhQD9ikCWSuDeIXtkKArq1KSkPkvscZwrh4lctuq
         1FYrOWO2ocg+QW/CqyfNTMrxLz8ZeLg8WniJSU3ZQSzJjGR46ZQiGDZjf702NDwHSNn5
         vedQ==
X-Gm-Message-State: ACrzQf2c/3pHhxo5k+yIHPbvP7fB+erUxeCwOOi+MNRtSCWZbWaDjgMJ
	5X7EA8hR/U48zVtEPHD0zFU=
X-Google-Smtp-Source: AMsMyM5a5w/2j1e31Ojxj4dg5ZSlPf2GGjGW4DSEc2MwGnUFRktykestCjMb1JFq1aYcRAzpM4sQ3A==
X-Received: by 2002:a05:6830:618c:b0:65b:d2db:5f77 with SMTP id cb12-20020a056830618c00b0065bd2db5f77mr10342902otb.348.1667335863972;
        Tue, 01 Nov 2022 13:51:03 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a13-20020a4ad5cd000000b0049427725e62sm3787804oot.19.2022.11.01.13.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:51:03 -0700 (PDT)
Message-ID: <e4734c61-da2f-233b-6583-253126540db5@gmail.com>
Date: Tue, 1 Nov 2022 15:51:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/17] hwsim: add remaining ciphers to supported list
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221101201747.143379-1-prestwoj@gmail.com>
 <20221101201747.143379-10-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221101201747.143379-10-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/1/22 15:17, James Prestwood wrote:
> This list was not updated when adding the new ciphers which prevented
> these ciphers from being disabled.
> ---
>   tools/hwsim.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

