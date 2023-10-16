Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68731A9F
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCDfP8pE"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2b1ae4c21so2264542b6e.0
        for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697480591; x=1698085391; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBDG/9Q4Cup5TJVwWJiZqhI9K78TTFSF9l2r+zPOxAc=;
        b=aCDfP8pERZtmFRV48iX6dnWzf0qcKJLu9ntA6cjQR3S94el1Csgk5eV7TD0tgUsZ2c
         aU+HdJCNLK1Y9/RoOXjjc3c9bpnk3GTTaZTVOajbAU1pHeRBAW/UpKzabQbXpqwo4wCq
         hLzQ+otQdkBtw4glCQElfEaj6C9wkdsY+D2HC4QHI7OWtH5Duu58cUIlKvoCHfCO2EsY
         53N8s+4emewIR2Cz8/w9gepNyTiGLiuMZzgsn8qFV1tDHQGssE/pxIzwTsFd5ZYg1U90
         /qPUChfT+CEIrXig1afrBJ86IbXQFdPt38sLXAM9B8FYJsFGyQyL4afae9GyXDDpFDdz
         1rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480591; x=1698085391;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBDG/9Q4Cup5TJVwWJiZqhI9K78TTFSF9l2r+zPOxAc=;
        b=pr5cjt8VkhxSvoG7HFkOYOG+qhuk6/x7oyPYOMjOF0FltOCs2orIx9wN0cdTF7ht6k
         /RvGw02TiV2FcwlMAxcCwnEY9d52jIwls750tK/rEyiNpJCUwtNIMqwncgGmHgVJ73Rr
         bziUd5be/IluAfZvvFrFOk7WIcwVs6JCYhY3+tpPvHt297skoE7T5QzRw/BQ4tJCR1pQ
         mvyKytbXPvrtDTW3xG9xvVZkx3mQHY9Bdw8TPfxAXRMV8/mkyffWUGvNJeYeZyA87Rg9
         TgKEk9l2R7R4MB5Lw16SirH0K3xAqNsZcGwKWSBCjC8AtIi84hhqO3KPu0japhf2bDpU
         iK2Q==
X-Gm-Message-State: AOJu0YzZ34er2zj0N1C0srirCE+zVzgjQixhz2CR7TEjDy9mUFF7WsIt
	j3icjbK3qqC9c0K61qbUIy9YNSY8OIA=
X-Google-Smtp-Source: AGHT+IEab2zlfu7qv+nlQCtjlxyXUdyDu1UiQ+EcRCDRyhc67biqg8bM+sfd85NnpFPVbpy3jFvERA==
X-Received: by 2002:a05:6808:1a22:b0:3ab:84f0:b49d with SMTP id bk34-20020a0568081a2200b003ab84f0b49dmr168891oib.3.1697480591796;
        Mon, 16 Oct 2023 11:23:11 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u15-20020a056808150f00b003ae12c14061sm1956923oiw.30.2023.10.16.11.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:23:11 -0700 (PDT)
Message-ID: <1f8d6377-f528-456d-8323-9a4b2618062a@gmail.com>
Date: Mon, 16 Oct 2023 13:23:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iwmon: print HE capabilities element
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231016144248.33462-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231016144248.33462-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/16/23 09:42, James Prestwood wrote:
> Adds a handler for the HE capabilities element and reworks the way
> the MCS/NSS support bits are printed.
> 
> Now if the MCS support is 3 (unsupported) it won't be printed. This
> makes the logs a bit shorter to read.
> ---
>   monitor/nlmon.c | 112 +++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 86 insertions(+), 26 deletions(-)

Applied, thanks.

Regards,
-Denis

