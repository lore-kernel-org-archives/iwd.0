Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570820338
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGK+N2X9"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5842c251d7cso1210454eaf.1
        for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 10:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699640370; x=1700245170; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTByHM3PIsINt2H4Z8X2lN6AhscEfVkNaQgSLncj2cU=;
        b=BGK+N2X9kDcUXVSC6Nrc0fypBMVPbrATQuqtr/BNeWnXYSUEj6RUQqZHCZ6iF9O2C4
         UbHVO4k31qJoPpWSX9Mba0IRi9lSjlbH2QYtWBesyLzVDEYWMPTihE1565LwkVI1CZum
         4nq0VOWK7cifHlMokNqZJKACBlp/lcneQH/rnrNOfexlY6WZZ3HX4bYmUR43okkcJGZs
         ZSPytjdzRR7gUZgWr8zDkoQYy1esD/sV2Q5YVyqKslCglhYxZ/f/OELMV/31+2abqzuR
         O2yxKDZK1bCezkwvCEWKOEgLjcQnG2QnTlhTlkDrgfq3RfLp4zhAShEtt6mpvB4RNH9J
         isgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699640370; x=1700245170;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTByHM3PIsINt2H4Z8X2lN6AhscEfVkNaQgSLncj2cU=;
        b=ec8eWHxzH2YQ80SB+Qm3+zrcK+WvXxBy77iydz3R48LSpHgtylIJp+sPBlDwZIp53o
         3g72Y6FnMejIxYjP1Snh9cyD/Qczt4nhPOkFAo70zLSdSxQ84aAJ8KsEBtTdZJRxiAkf
         3LAE/lxZOQz0H8LH+XfNSQDpwKHSmQVB2ocDL+VUoT0/F4vGmgR5eIKhUjMHyQbWtMNT
         dvEJSgMuXSplXmkGOwHB/pghqUEyv81mUqdY8ZzFe34fhR6jxKTUvk1HiZ9Qzlo5rRjz
         tG7aLNoQM9BERr++z5BmBCCS8qtpgkRchNNuEAXJ6J0dzokh+xoh1GxU6e324mxGKSFB
         NzMA==
X-Gm-Message-State: AOJu0YwCDTHImuDRVzIXJoEpmqQ+TKWDm13q1g/R/XDZb2rhHnx0hMsU
	FPA07a/96b8vJTgqD5mD/7m89G2avUs=
X-Google-Smtp-Source: AGHT+IHUmSOwyilWmbWKuvGFkImsIMk1C/y+qVAOhj7mri2XppzkEjVgZk3i6mS5sO8q83ub1P79Pg==
X-Received: by 2002:a05:6358:7e04:b0:168:e4d0:a743 with SMTP id o4-20020a0563587e0400b00168e4d0a743mr9316530rwm.21.1699640369102;
        Fri, 10 Nov 2023 10:19:29 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a28c100b007749dc7881dsm2200qkp.48.2023.11.10.10.19.28
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 10:19:28 -0800 (PST)
Message-ID: <2df078cc-dc9f-4feb-ac13-0789681b0b3e@gmail.com>
Date: Fri, 10 Nov 2023 10:19:26 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dpp: add station watch to DPP
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231110141620.80195-1-prestwoj@gmail.com>
 <20231110141620.80195-3-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231110141620.80195-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 6:16 AM, James Prestwood wrote:
> DPP (both DPP and PKEX) run the risk of odd behavior if station
> decides to change state. DPP is completely unaware of this and
> best case would just result in a protocol failure, worst case
> duplicate calls to __station_connect_network.
> 
> Add a station watch and stop DPP if station changes state during
> the protocol.

Please hold off on merging this. It works in practice but isn't playing 
nice with the autotests.
