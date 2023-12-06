Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B647778
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfLrYRn2"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d9ac148ca3so1879220a34.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882032; x=1702486832; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ng++ZwWNV8ouhh/GOKQy8cNN4JDR9cCRH0k8Lggh/X0=;
        b=dfLrYRn2SJtVT4t3pgISls1o+pYZuEKojDuJ9QfiL8RRelKxhYYIqBXKIM3QMM1qUm
         ryksi4P9LqOJuG7d703BhWmKZU2k7pOurHhUns7FHwPGxUshcho0UAqEOYaOGxu9dzvM
         c5dvUhc8jIz4YbEUiN1CsXY190Z50k3JAficiD/cYiAH+MuWyauLc5qCbVD4lEjE78XP
         dKbxqZEUg/YfhlZ42qCw8xWdDyqM5dYA0e94ewVzv+GRT203EgT434OxU4pJaVTld+XA
         CDFNCpAfxQTdjfU0ZQNkV4Cj00DZEu6pvy0P99pCkfIRX7fbE4zNJg7h7WSl1t3jm9EQ
         aGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882032; x=1702486832;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng++ZwWNV8ouhh/GOKQy8cNN4JDR9cCRH0k8Lggh/X0=;
        b=FQtUrZciEAJvAnp7UJy2wPpRZ/v+9LmPWuE8SUBgL17UTj1dMXToWup6thetfUTd1y
         M1Qw1qNHXuikPaIbBTZsAXCpmgRoK2pDWGCQFNQE6i4W/KS3k/5XHiwPuAxfwaMc/iiu
         ohtpUVh/SJZC7QtL/avrVO3vU0lAQOsMaaM/1GNze/2enokb0O5Hl4HyD4nFhV7MafVU
         TqsM/LNVi9pjmXfoltktF74nldy2lAiecxpf2oFEIM6f3zLuAksJvADaabIl5B7MFjU3
         6F2MBRRlxCU0+edoxv1HFKe0tchV07OjXy6+jXrV7zJlH1HnGW4Uk3JCD9mFjkIQaRlD
         v4bw==
X-Gm-Message-State: AOJu0Yyt02pf1bOQz+ZRWVLZpyPBKfhIvYGZjFYyJe5ealVrBA8ze4K/
	jF1furkyOjvy1tHwimabjYxtGS2q5/k=
X-Google-Smtp-Source: AGHT+IHEyMkAIFoENqVORTQ9ylhtmj65fruQKgSlYqinZYhboB2nzZgqHof6RavLZskL/KcjJhKiIA==
X-Received: by 2002:a05:6871:430c:b0:1fa:dae2:8406 with SMTP id lu12-20020a056871430c00b001fadae28406mr1429509oab.0.1701882032606;
        Wed, 06 Dec 2023 09:00:32 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dx47-20020a05687076af00b001faf9c803ecsm49061oab.50.2023.12.06.09.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:00:32 -0800 (PST)
Message-ID: <2a454f5d-be76-46b5-959d-29104100b3aa@gmail.com>
Date: Wed, 6 Dec 2023 11:00:31 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] scan: parse password identifier/exclusive bits
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231205154647.1778389-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/5/23 09:46, James Prestwood wrote:
> These bits are used to communicate to the station that SAE password
> identifiers are used or required.
> ---
>   src/scan.c | 20 +++++++++++++++++---
>   src/scan.h |  2 ++
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 

I applied patches 1, 2, 3, 5, 8 and 9.

Regards,
-Denis

