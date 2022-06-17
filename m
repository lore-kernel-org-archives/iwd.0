Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647220E1
	for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 19:13:04 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id p129so6463635oig.3
        for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=nb/wa5kBy5Ue4P/aT88ZdPn4xKwDkwybvCobvGrQm3I=;
        b=U4BPDJwPIyYxmbWKsTZhuj6RxIabqzIo5K5ufKQ/smcIXx7cBk0CNVJsS2e8mKenM9
         KWbOMGBZEc+QSmlvCNUYsf9ofieCOyuqAFSsSPJB6o6LGWcNFErg12dlh+0htcoTuhwi
         Vr1WvnP14Cw0XYktNbG/FJ8K+hJcmDv4fbU8f24uuZRy/498os+EM410C7SoxxBgviAY
         Bub4i2NbZQhfq693utHM7seUBnzVdyUOggU4xBACoUmMtYrqDKglNpBbDx3gd/iP3MXI
         UZ6weeaPbwh6zw1WKBfqJHCVmQSfQEwGEjq+eGZvSvN4Lai9+XT5qpTogalorJNU3Yks
         bAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nb/wa5kBy5Ue4P/aT88ZdPn4xKwDkwybvCobvGrQm3I=;
        b=Nj/2eEs6aT8809yKiFlVue3J16ynBlJqP4Nj2oXio2mWz+1wMUD5xeorDpLgxbpBLm
         diPFaSARqRRQvpVFTwNmW/DAaBxFbMs/fHPS68/P9BM3JWQ4l44czCJzJGj0UTGPpUPz
         hHM38fxB03mfw25J8cqQOqhteKqGAW1pcVgx0MzTNL/yWv+bPX39hVZvIvupNdtZq4/S
         soLR5yBiopw29KxRvFXLkkSYMr4Vl+QMRq4ZA0DM1Lei01NFnqaRkB/2fZjmvbomBcCh
         7I5b5Lfx9h6h5t/oHcJ4o15pRAoIjsBf1Zjxl3ye4WpnprEBCv3bNfgSZiZiQS7IF0r6
         iN8A==
X-Gm-Message-State: AOAM532tfmoW1F+Sji2NS4SkGHs0sTKwk/O9dWpDvPzWmAL/KHrGeCA4
	viA1mr9ZYzNHHLxS+4l/5oo=
X-Google-Smtp-Source: ABdhPJxhZqrATPvVq2a2PMFOJAwUqsBWX66uToD50H0BsktbQjl9Ik1am77DOw9c5MbrvensFGjGxA==
X-Received: by 2002:a05:6808:1888:b0:32e:ff9e:cd31 with SMTP id bi8-20020a056808188800b0032eff9ecd31mr11022437oib.286.1655493183725;
        Fri, 17 Jun 2022 12:13:03 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n9-20020a4ae1c9000000b0040edc685e11sm3105322oot.13.2022.06.17.12.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:13:03 -0700 (PDT)
Message-ID: <584d007d-8a30-9750-0f88-b2d9a9a9ddc8@gmail.com>
Date: Fri, 17 Jun 2022 14:09:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 02/15] storage: Log a message on network file parse errors
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-2-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-2-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/22 19:02, Andrew Zaborowski wrote:
> Most users of storage_network_open don't log errors when the function
> returns a NULL and fall back to defaults (empty l_settings).
> storage_network_open() itself only logs errors if the flie is encrypted.
> Now also log an error when l_settings_load_from_file() fails to help track
> down potential syntax errors.
> ---
>   src/storage.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Hmm, I'm still not sure logging l_errors inside storage.c is the right approach. 
  I see this crept in when encrypted profiles were merged.

Anyway, I went ahead and applied this, but I wonder if we need to fix this to 
return proper error codes at some point.

Applied, thanks.

Regards,
-Denis
