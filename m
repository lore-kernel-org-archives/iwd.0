Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD13D76
	for <iwd@lists.linux.dev>; Sun, 23 Apr 2023 23:52:40 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-38e2740958aso1389409b6e.1
        for <iwd@lists.linux.dev>; Sun, 23 Apr 2023 16:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682293959; x=1684885959;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qws63Or9AE04fPrz+6xgsioGA8f5qCay8N36ZdC6vO0=;
        b=ZLFb+Q7wf++zbynlfFNBEZiDgziowJUW4GlLFwzpbaMYMNF6mJ/Ajs0lqH/0TnVhMx
         5YUhItIn1315XknJ4/ZlhjWg/jtGY85fmSWeU8t4kmm8Q5uYdpqAe3w8Igeerly8374f
         L7U2wn1Sgx/07Ws4y9YArZF0SFcq7IIATxRPhDqumSGo13zoKFxw4R7bKmSYFvBFzYGg
         3ofV6cScusUt8cua1uD77EXbMmsJixmNs3L/rf9hz0lapvM1dspSe0fyOlB3dLtDwZMk
         GQIZo49cVlksoBz5MRhAWt+RapzhF5nfsFoVJ6RRxrPIeEEtgSrzPuAUC02Gor8+mSpz
         rhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682293959; x=1684885959;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qws63Or9AE04fPrz+6xgsioGA8f5qCay8N36ZdC6vO0=;
        b=cxx6Byppr0OafB9WAfItbtOW1n2gBWfN/qZKtktk7OTZS2hAouIV/6XVgzmihjbWDh
         +zrQrqT5vE/I8e5yDR3hrlzcWUxUwwZmJ32ehGk6UMJylU+uKaaoOL3bNOJSuRXq/oES
         JVkAntvLxKq5jtx5EY6bMn9aC6Ph04Q+5dGqrtcE1LGuLFHi0zbxab0WpB2kzS8dtgqm
         W4Wfbv4kqsMvRg3WwNIQwO3bW7hglb5Bzgxa1O/8b0Y55E3gjYGh7hqBgcfnb6opygcL
         PdbjUJ5T3mgD3cA7VZwmxX9Qe7B0JK3xw4XojJQQKUOt45kEufTmZuMYfJPQ3ECS55eW
         PLEA==
X-Gm-Message-State: AAQBX9ffQfL24nMqSHkqG4djVTkfu6FChH4wzEgTKtTvjwsaX5sD4lqP
	BJ2CjLTNrDijbiLGkxAK5i4lpl49u0TyJw==
X-Google-Smtp-Source: AKy350bPgOZUqAUYqW9Wf/FSLngE/PbqWRFgEzHhl3q/7r69C2igZZvPpM87XCQ4x2RZYjGrb9TTgw==
X-Received: by 2002:a54:418c:0:b0:386:8f22:ef53 with SMTP id 12-20020a54418c000000b003868f22ef53mr6087866oiy.30.1682293959352;
        Sun, 23 Apr 2023 16:52:39 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u2-20020a05687036c200b00177c314a358sm3955312oak.22.2023.04.23.16.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 16:52:38 -0700 (PDT)
Message-ID: <a87b28e8-b4c3-a7ae-e01f-9e48731f7d78@gmail.com>
Date: Sun, 23 Apr 2023 18:39:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] station: delay roam until fully connected
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230417185457.1000642-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230417185457.1000642-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/17/23 13:54, James Prestwood wrote:
> If DHCP/netconfig takes a long time to finish IWD could end up trying
> to roam to another BSS. This could happen if the signal strength is
> below the set threshold while connecting. Once authenticated to the
> AP IWD would get a CQM event and start a roam timer. If DHCP did not
> finish before that timer IWD would start a roam. IWD would not handle
> this well since a roam doesn't trigger DHCP to start and likely the
> network infrustructure would be very confused.

Typo here, 'infrustructure'.

> 
> To fix this continue to delay the roam attempt until IWD reaches the
> connected state.

I'm not convinced this is the right approach.  If the signal is bad enough that 
DHCP is failing, then delaying the roam is probably the worst choice we can 
make, no?

I would think the better way to fix this would be to track netconfig state, and 
if it never reached a fully configured state prior to roaming, reset & 
reconfigure upon a successful "roam".  Note that since we haven't signaled 
"connected" just yet, we're really still just in the "connecting" phase.

> ---
>   src/station.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 

Regards,
-Denis
