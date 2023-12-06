Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7048CEE
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIIB6QkZ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58d4968c362so4439845eaf.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701880839; x=1702485639; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtbCE6Meg8G/vtyes3XeHMHVDF1qp4j6Ha/dYv91lAc=;
        b=nIIB6QkZooL3yt9iTuEw2UXh4D0WXQNwBZSKpyEE9qQDFf6OVoRn+p8VfJjW7Z8hJs
         tT2fKIJ5NmEGdUm5bGhfVqaCDNCUPu4FrRAzYlPvF63HvVY34vdYT2tNagH6N2thNVOW
         GcqWldsE4SFWStVcWZe75xJAYTEtoUzujIXkz4+quC6aWllmr1bmo142Pm22FZ5ub0Qi
         RICcC7cXmGADm0DEIPGbp+0zj4oyP2o+x3l6zkxs1KkZTC7Pb0260IJzxDAvjG1RbF19
         4J5v2/d4p0LACNUBdRyh6WTxeuQxgeglUMYxlmxh0ai8XZ3VJxxxg1bpwW5ogCjSRH8W
         Zzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880839; x=1702485639;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtbCE6Meg8G/vtyes3XeHMHVDF1qp4j6Ha/dYv91lAc=;
        b=hYJaBgqyQ0/fu8KDPWpauizyhKtNK0PZUOWBal4S4Y0xPPiag/dYf0I63ef5g9XBNl
         kJlfxexNPa2MDkdFPym/7+/r1KQZ+/8iClDurcX20VQ/+PRISnRBZNu66zARXiy9t7pW
         9Y6cI+hDDfC1X19CKEf8YhhUBuOjHgeCE4oEU58EkTlNpONhtUmmtjayJ1yixWPkUyNX
         Rhh31AgvC4OGv1vUOgrNtXLYLSyDYawOUKF6it8oSXgLAfKn3anWr1JFMOnwEqA7/tkT
         r8ENQ3Uq4Rhrd9VPGpcMTYfd3E227Ax1C2DKt4Wn0ne1TF3jSDp5WwfqJeiaHtj+9JSP
         /Z4g==
X-Gm-Message-State: AOJu0YzCaY5wZBINHnk+I+aE/mfPEYxXn9TogE4qpj+sAmZ+4t7XL9CE
	wKh/rPTRaeFSSaCoFVMOqIb9TW2xVW0=
X-Google-Smtp-Source: AGHT+IE1bV+HLp5oUg0y/4Zys5bUBAC7mURZaByDoQv+m4/I4Rn+zpsbZl92I1fcTy1Vo5CqHaRCvQ==
X-Received: by 2002:a4a:6241:0:b0:58e:1c47:8797 with SMTP id y1-20020a4a6241000000b0058e1c478797mr1021014oog.12.1701880838916;
        Wed, 06 Dec 2023 08:40:38 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w23-20020a4a3557000000b0054f85f67f31sm45756oog.46.2023.12.06.08.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:40:38 -0800 (PST)
Message-ID: <054746c2-f399-4c2c-b041-b76e7a34ada7@gmail.com>
Date: Wed, 6 Dec 2023 10:40:37 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] netdev: add netdev_ft_reassociate
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-7-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231206150708.2080336-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/6/23 09:07, James Prestwood wrote:
> Essentially exposes (and renames) netdev_ft_tx_associate in order to
> be called similarly to netdev_reassociate/netdev_connect where a
> connect callback can be provided. This will fix the current bug where
> if association times out during FT IWD will hang and never transition
> to disconnected.
> 

I like it!

Nitpick below...

> This also removes the calling of the FT_ROAMED event and instead just
> calls the connect callback (since its now set). This unifies the
> callback path for reassociation and FT roaming.
> ---
>   src/netdev.c | 44 ++++++++++++++++++++++++++------------------
>   src/netdev.h |  5 +++++
>   2 files changed, 31 insertions(+), 18 deletions(-)
> 

<snip>

> diff --git a/src/netdev.c b/src/netdev.c
> index f2e887b4..7d52ffea 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -1409,16 +1409,14 @@ static void netdev_connect_ok(struct netdev *netdev)
>   			scan_bss_free(netdev->fw_roam_bss);
>   
>   		netdev->fw_roam_bss = NULL;
> -	} else if (netdev->in_ft) {
> -		if (netdev->event_filter)
> -			netdev->event_filter(netdev, NETDEV_EVENT_FT_ROAMED,
> -						NULL, netdev->user_data);
> -		netdev->in_ft = false;
>   	} else if (netdev->connect_cb) {
>   		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
>   					netdev->user_data);
>   		netdev->connect_cb = NULL;
> -	}
> +		netdev->in_ft = false;
> +		netdev->in_reassoc = false;

Why do we set in_reassoc to false here?  Shouldn't it be taken care of already 
by the associate_event?

> +	} else
> +		l_warn("Connection event without a connect callback!");
>   
>   	netdev_rssi_polling_update(netdev);
>   

<snip>

> @@ -6256,7 +6265,6 @@ static int netdev_init(void)
>   	__eapol_set_install_pmk_func(netdev_set_pmk);
>   
>   	__ft_set_tx_frame_func(netdev_tx_ft_frame);
> -	__ft_set_tx_associate_func(netdev_ft_tx_associate);

This part probably belongs in the next patch or even patch 8.

>   
>   	unicast_watch = l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
>   						netdev_unicast_notify,

Regards,
-Denis

