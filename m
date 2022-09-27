Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1D4C64
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 22:39:24 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id s125so13508280oie.4
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1nFuZvfCDuxRIPoOTDi9totiXw2ZKiN3h5D1vZrnXfQ=;
        b=RisaBoiF96N+0dIZJT4qSaqiXI8Chxco0DYWrWhDkrXJCtl24njDYJrpIJZNDfwNpX
         kiwDGnHbbhv2PD0SaTq3VqHOrMac10wcSpasoUdaHDGVx9aZSdP/PWFbdZ7757vQsgW3
         Hc7v64cqrrl5w7fdNhQVRtsZmjzI9oPL1lXn778eOmkVpL7reoQASZ9JfYp8Ec94yT1b
         wYiKdgTImz1aBNWT1mK78iggCJp1sk/+u2O/+Cnwhkv5t6ty6xrjF0zElv/2xwnKz5AX
         jkcTKQRQoQLGigsn20En0MrGG64p6GuBPedhIKfBGI6xG1FA2/ejaflH8Ksi+vTRAhLR
         DrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1nFuZvfCDuxRIPoOTDi9totiXw2ZKiN3h5D1vZrnXfQ=;
        b=E8HEbkNv5HJ7kZikzC2O+/9GF2Kxat2YApjIsoqW75AsIiJryMsSvgXznMJ5OaOyOV
         cRtspIQNon7v0hGGRiKoZ27m8YTBgJVXfrw3eq9evqz82i/v1O6D9I4n0hdlbzc/zVCC
         pWo+doOI2NT4zLXoQTUNUPh9Fq8QmW1/rlVnVtLpfMROu8ylqmoh/orxtryvglxM0m8b
         alav4KI9OzZkmrthBgGZbsqnq3gP6L2P/EikFVAC+9iix2BwrbYacE5JqRkb5DCngyGG
         N+bbCteQXsglme9r74nwA3urWsDvYhJ+zfUYghc1zcrP/jrtP6CIlOjaEI5WowFMgMp1
         GGEw==
X-Gm-Message-State: ACrzQf1nJqT2YCuKP/puckqUkJv0vwt5sqEUwLvydURVbMv8LcNP2dS/
	D9J+3wI6eYW/LCTxJupkCji97UMAMbs=
X-Google-Smtp-Source: AMsMyM76iImABSLmXjyEpDZt/SknUY1okhCguIEaUHGJwwKQOgZIUuVUycvy+fLWV+lHUm433zdQLg==
X-Received: by 2002:a05:6808:1312:b0:350:6c53:4d91 with SMTP id y18-20020a056808131200b003506c534d91mr2777017oiv.264.1664318363408;
        Tue, 27 Sep 2022 15:39:23 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b7-20020a4ab487000000b0044b22632d51sm1140867ooo.2.2022.09.27.15.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 15:39:23 -0700 (PDT)
Message-ID: <78b164f3-66a2-e66e-539d-fe8e219a2c1a@gmail.com>
Date: Tue, 27 Sep 2022 17:39:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 01/11] ft: netdev: prep for FT isolation into ft.c
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220927194731.269732-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220927194731.269732-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/27/22 14:47, James Prestwood wrote:
> Currently netdev handles caching FT auth information and uses FT
> parsers/auth-proto to manage the protocol. This sets up to remove
> this state machine from netdev and isolate it into ft.c.
> 
> This does not break the existing auth-proto (hence the slight
> modifications, which will be removed soon).
> 
> Eventually the auth-proto will be removed from FT entirely, replaced
> just by an FT state machine, similar to how EAPoL works (netdev hooks
> to TX/RX frames).
> ---
>   src/ft.c     | 319 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   src/ft.h     |  22 +++-
>   src/netdev.c |  29 +++--
>   3 files changed, 337 insertions(+), 33 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

