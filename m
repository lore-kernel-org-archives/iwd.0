Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078842BEB
	for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6fXj9Wz"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58111e624bdso3507889eaf.3
        for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556120; x=1698160920; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQk+ZyzVF/PXIPIQFGfZVtkBS/2YOsG1cRSPHX6cKso=;
        b=A6fXj9WzjzPoLAhk8kfl2ih/PZ5MIPrN5BySU9ohbnv2bNDYgjeJ+AIMjNYUrgkhjC
         8abe39fotvmGMUMxFfffctzGU2qhwYkO8K2n5ILD4SuUCrH9yniq0v1M6ADhfruEq4Dp
         zyrwvmbhMXP6I5hHC168W/9TVDwPRNhao0mwzY8oNjwR1Vdlrud357s4uiR6tHS4O/e9
         Q0G5f7C82MvJzvSPEsCB2KRzh3IwxfPi5Zkgk98OFh2T3V71csON5xTSlmERWCowbLGV
         IoyigvfWl/RjJeYnZygQBNcqRsQoXzsYddTTxSPeuepbqtP5WWWmCH95EomCjdNRuXHW
         CdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556120; x=1698160920;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQk+ZyzVF/PXIPIQFGfZVtkBS/2YOsG1cRSPHX6cKso=;
        b=arfhcZbJoB2Uz5BNQV1Tqh9N1qJAtf1iynZTJFRYhJ7KYQivzbnp4udEXXGkQWuBj8
         LF6CXTmCu/0kpntJVDrFy93Z+XkWcjtqE9y26EPTWzxNvSZmAeE8Bk/1qtmmMGVfNo8X
         fw1qq5B9q6KWnqULp1GjfMQVihI/E6yw0cSxhK9yGcqlUKFfrOrISrUZEtDxa0IRjUMx
         dSW3BZ7l+nfTw0OgOfpAqb3bYSg+FAL+KQXPFukBU98TAeU5okazU0lg9K3tkirkLyYa
         5UYX1dcv5rCdtbMEViRZvSN55mkX7KJ1z9yL2eJtmKZcQHu+5bTbNFAstA/F9hxOHXVx
         mHYA==
X-Gm-Message-State: AOJu0Yyc3i7O4ehbAoB0sNYRItDSE2nOSbnJfNmz4XZQm9pSMyIGTHKG
	KWYsuUscxwBYmv/IMh1dP3X0Y8AAEbo=
X-Google-Smtp-Source: AGHT+IEqca7OZgsH0h6Hz7+XwDx0/iSjYNLtB28tBGmxLmQOaIS3lG2FA0RXFftNcQBqyEoN6KoWPA==
X-Received: by 2002:a4a:e0d8:0:b0:581:e750:9995 with SMTP id e24-20020a4ae0d8000000b00581e7509995mr1033406oot.3.1697556120413;
        Tue, 17 Oct 2023 08:22:00 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x5-20020a4aaf45000000b0057aef3cab33sm276247oon.21.2023.10.17.08.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:21:59 -0700 (PDT)
Message-ID: <e784e484-2217-4a43-b25d-2b7607bffea9@gmail.com>
Date: Tue, 17 Oct 2023 10:21:58 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] dpp: rename auth_addr to peer_addr
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> This is more generic and with adding PKEX it makes sense to
> refer to it as peer_addr.
> ---
>   src/dpp.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 

<snip>

> @@ -2214,7 +2214,7 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
>   	if (!dpp)
>   		return;
>   
> -	if (dpp->state <= DPP_STATE_PRESENCE)
> +	if (dpp->state == DPP_STATE_PRESENCE || dpp->state == DPP_STATE_NOTHING)
>   		return;
>   
>   

This chunk seems unrelated?  I dropped it for now.  Also, there's a double empty 
line here.

Applied, thanks.

Regards,
-Denis

