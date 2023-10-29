Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217AC8D2
	for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB6vvcb0"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b3f938331fso1956208b6e.1
        for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698618153; x=1699222953; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFxnNbEAH8yU7pd3nNR/zV+lqu+8T/+mAbG4/NM1uG8=;
        b=fB6vvcb05NkiX8nfZ8ysWgTEC15ow/3V9d+GfNHlWQd3ZcxYAY9nFQoPEEVzHix2lN
         eet/De/2P2V+jQhc/HNJ+imb0VlNOSJ/mwhsaOY8P9wgyawwUImEw/Jklhyy76OzqbVb
         /oQBytMoI+jB2r2ZGtyZoENLUtdB3mC2sHIybt1bqcfVS8hkaK/ZtR7iKoyFKuMrDmNz
         mfi0RDKQ0UDMwTUU72QkEx2Db5plQry+XlT4TppTUjhlBdClCERPYsBjEFj6/RvHs3PH
         O46wXhWH3X4vHNEUVSznOXmbPsD3NF9KTvB9znvTHtep/X60ztIWU2IxXpPMivcNABdN
         AdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698618153; x=1699222953;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFxnNbEAH8yU7pd3nNR/zV+lqu+8T/+mAbG4/NM1uG8=;
        b=BOGeHW5z+1AKaCdyKtGtF2uN6EiYqgdGp1cjCC2pRQYsoqD5CKxaHQRm0xQ8PsHKCH
         JWIKjFiKY7S3TLZZziTmpj2qzfkWY+Vx7W24rVqdvq0K47jIssNJbBgaZCBkTl/FhSKn
         4py3DhGnYEYfpwcrDqkfs3OmTVIX5E7pAw1E25+ta2/CuOoaZtLYeksR0rZVZjiMenub
         VdmSdoZb0NaGpDMNOceKZ+zdLYbFcYHCLnO8cxyyLYZPZ0aiSrgggTj8bOuf1IYWu7DI
         mlK5Lq0Mdq84xnv5UuyynmWj5cgW6NYWMK/59xEFp8C50JtGjY2f9ggtyr7p74RBEsfG
         WTiQ==
X-Gm-Message-State: AOJu0YyIurtOsv6pgcSXZ0P0udJPjiN9/J1iidAFKRcJF1+O9OpOk75f
	+gG0ts0xtJhoAgkVvNNocqyQkYhrZEA=
X-Google-Smtp-Source: AGHT+IHdKn/Y6lJevn9LJ2jpdf0v1yQ4cxlNmgKEDQHrVyrx/iUj7GGKlIR49ou/GYikaadlEejkNA==
X-Received: by 2002:a05:6808:14cb:b0:3ad:c018:7d9a with SMTP id f11-20020a05680814cb00b003adc0187d9amr8063955oiw.13.1698618152952;
        Sun, 29 Oct 2023 15:22:32 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y25-20020a056808061900b003b2f369a932sm1155079oih.49.2023.10.29.15.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 15:22:32 -0700 (PDT)
Message-ID: <ddf3d2d7-ebee-4350-bc80-8949e6b9fe08@gmail.com>
Date: Sun, 29 Oct 2023 17:22:31 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] dpp-util: add crypto for PKEX
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-7-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231026202657.183591-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/23 15:26, James Prestwood wrote:
> ---
>   src/dpp-util.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  35 +++++++
>   2 files changed, 310 insertions(+)
> 

Patches 6-10 applied, thanks.

Regards,
-Denis

