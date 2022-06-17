Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3E20E1
	for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 19:14:45 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso6665909fac.3
        for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PrKEI3YxnQifc9+JNotLTLoyZaWwa0xDfWhSufYAT5s=;
        b=DcqSgt/OhmYuwUrfFFT8nYsBsFog+pHEVE8jtkNOOvg0ATOu6SyPSzOCdkyLdVr220
         BXDjG/7WWA40Z0faiN6X4WnQ5SMKT1gg3TV9Bbie7q2ybO+H0Z1Vf8KWRMtMY6HcQCjD
         X6TytctZrAHm2rmzWkEmh6caFS0y0HpGWa85I2cEJJ6bNEWkxUaKmEEHW6EepLSKrYrh
         8/lck5JL4mTZNRRxcjiPGlos8v6tdw66JTPINzReQb51lqTkTL0qAClhirKBCtfVyjmu
         3RZ3a51tr05QG0+iXUQcccsAxhwiELsocKWNkFApWrl8PX2/3j2KmZs0xS4nN5OWpl4i
         JQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PrKEI3YxnQifc9+JNotLTLoyZaWwa0xDfWhSufYAT5s=;
        b=0LEyr6+qpK7tto2HjgUUtZ0SmYkYpSZCe7q52P3gJRmY3KPwv6vudVGyRIMskrhHAy
         0bJwrzJYozh0tpucF5VmDpbJqZChuJB0VtqZaGTiPQMa55J0QDccmA47W6jf5dx5Cwj2
         qyT8/IXYVd0bAWtIYc2pLZYWiCC/gpM7yv7XbakGz4prAkg5JbywnCrPenkcWsYHkI3u
         +7lFyypa5YL5VtKYgJ5iUSm2Sdd0x6hbsxrfcT78eLFiCcVQ2JeSGGSsM/LcVow8R1/q
         XE7SPGFjI79Ge835sjrZp+YvBon0fk6yc9DnTYyD8gzMa7lOLjhbPAY4yDhUF5F3Oov0
         6wbw==
X-Gm-Message-State: AJIora/gemNcH3CHBOh4jdLAgj1ILp7qzyrePm6c5okEj1OqSqNXU59z
	eS/bdeQVG49iZv5ZWRPYH49MW+m9kEj6V8lw
X-Google-Smtp-Source: AGRyM1tVbJsAosNh3JHo+rN3at4CXbBdMruBdTc8YMcJsKmC0OrSt5Y/jUtSyf/+HWo+cVOmr3ywvQ==
X-Received: by 2002:a05:6870:3309:b0:f5:d369:d126 with SMTP id x9-20020a056870330900b000f5d369d126mr12035499oae.98.1655493284656;
        Fri, 17 Jun 2022 12:14:44 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w21-20020a056871061500b000f349108868sm1793188oan.44.2022.06.17.12.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:14:44 -0700 (PDT)
Message-ID: <5f0137ee-d8c1-c53a-066e-5959d217e942@gmail.com>
Date: Fri, 17 Jun 2022 14:11:24 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 03/15] station: Move netconfig_reset() to common path
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-3-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-3-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/15/22 19:02, Andrew Zaborowski wrote:
> To avoid repetition, call netconfig_reset in
> station_reset_connection_state.
> ---
>   src/station.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

