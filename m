Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CB1388
	for <iwd@lists.linux.dev>; Sat, 30 Sep 2023 02:59:05 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3af6bd48093so1234801b6e.3
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696042745; x=1696647545; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RA7niQdF+guDCDqj2yzzeEz8UsWYX/hB1neIMmee2oM=;
        b=TJ72sTUQk7bQsQOayKi42IQicbrAMnR7PkKgyjauoWZzJ+t8NmqoBFBD18r6tiPMLR
         9lIVTKXpaoqmng4MbTkFZrRNzYpP84cCk4X/Q/ZxsRXOxsOzz02gAX5zzJ6FW4CVBmi4
         7UQIHFrEfWGKKEzwvpW8ypZflUzsYr33IzTOQln3VwmbDhoJ8zP/fxoH0MfQbyxx/zTh
         dlQK3XMTtNQ6wPMal5ToLgDn9PXjfdB5qxcN1C4x5rF2vsdYoAl7DM1YJoJklTirxMbn
         9Dy8bz4Ri+LUNcN3P302Nqk6LKfHGN20NdBC0BOsSWK2sLOXmHI/PxHU3iTFQzAwe1gg
         nTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696042745; x=1696647545;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RA7niQdF+guDCDqj2yzzeEz8UsWYX/hB1neIMmee2oM=;
        b=MTvftw6sBUQc+UJwSETf564AQs9j0+VsE1nBjUwPj/gKunmMGVJVYj18insg8ujypW
         0tMf0q2N2zYh5jFLXdn3hN9aATpXRPp3R1lxlqDRD454irY3FSxK4RJWb4zjSVSF+UZZ
         jUS+hbCZLcUnmw+wV1QXmbqOMAWuMIU/jm3iu7d5pglOFabg7az/E+IJY9aFfLggu9Ty
         twv2680lbC2s4Kd8B0soGTGRhTtgUMBOLaq6q4uSBWYZuJNmoqUfgHX0ihq5VLY+0Msg
         Qloy8SDLKYIfCbneRNGF6q6wz2XYcGtB9WlJiXqVAkmL9mi/pC8l4vicfFem6W50N21S
         6IOA==
X-Gm-Message-State: AOJu0YweKwc4pHifT3sP7G1JrxpLwb196dknLPnv1jSfs0Ql6cDk4LGL
	cMWJjfQdrsATh9wh5glZOIU=
X-Google-Smtp-Source: AGHT+IH5wkyp8a6gC0xCifmZO8H5X/4MCGRIyDrBsM63sB7IMFdr0/ZYacGhG7uyh61ifupHje+Ulw==
X-Received: by 2002:a05:6808:138a:b0:3ae:24bb:3816 with SMTP id c10-20020a056808138a00b003ae24bb3816mr7538605oiw.14.1696042744753;
        Fri, 29 Sep 2023 19:59:04 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l24-20020a056808021800b003ae5aecae24sm1402749oie.52.2023.09.29.19.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 19:59:04 -0700 (PDT)
Message-ID: <b1b52ddf-9440-b9e5-fd3e-c15f39a2a631@gmail.com>
Date: Fri, 29 Sep 2023 21:59:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] wiphy: make wiphy_band_is_disabled return more
 descriptive
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230929161959.3840935-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230929161959.3840935-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/29/23 11:19, James Prestwood wrote:
> The function wiphy_band_is_disabled() return was a bit misleading
> because if the band was not supported it would return true which
> could be misunderstood as the band is supported, but disabled.
> There was only one call site and because of this behavior
> wiphy_band_is_disabled needed to be paired with checking if the
> band was supported.
> 
> To be more descriptive to the called, wiphy_band_is_disabled() now
> returns an int and if the band isn't supported -ENOTSUP will be
> returned, otherwise true/false.

Returning true/false and -errno isn't a pattern we use.  I changed this patch to 
return -errno on error, 1 if disabled, and 0 otherwise.  Also fixed up patch 2 
as a result.  Please double check that I didn't screw anything up.

> ---
>   src/station.c | 4 +---
>   src/wiphy.c   | 4 ++--
>   src/wiphy.h   | 2 +-
>   3 files changed, 4 insertions(+), 6 deletions(-)
> 


All applied, thanks.

Regards,
-Denis

