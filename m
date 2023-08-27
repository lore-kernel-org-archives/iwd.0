Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447C111D
	for <iwd@lists.linux.dev>; Sun, 27 Aug 2023 19:00:37 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bda8559fddso1982215a34.1
        for <iwd@lists.linux.dev>; Sun, 27 Aug 2023 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693162837; x=1693767637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqGbIwlU5Lh/jy00zPPRhFEfVyW4UnyldzIS4cw/SPs=;
        b=F293XaQaTSRBXziNfqvoS+ZrmWPsZG9Nqkf+IKCp4UrLtdydT3OYCsAGPr8Ubj8QQD
         I5a6p9/p7PMWxTWbA5Nrb2NLMR2VDEZtXMnNwWzj93dGSNzkiV2yC8rMu+esdQ3Zupd1
         OeGRTXUsdpSeAWVUI6M5MoKdkuEK9ePMfLBWbpQ1TcvjirvARUKdeJF+azhKT63qW60J
         gPMOTFrWKdsex9a+EH9Xq2omioFHMjcJUJomdQQSragDp3PmH9sM2em6Kkq3vorIkkbn
         RYR7UVO4m2BdRDHyMUQz3bGOk9LJQa0QEsRp+sktDXMV9lh/G96Ujj5pSZl1Dg6D+OlE
         Uh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693162837; x=1693767637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqGbIwlU5Lh/jy00zPPRhFEfVyW4UnyldzIS4cw/SPs=;
        b=hvJTYl1hhSEX5JLg9VzCsB0jB5Qi8BmBc9fWIZVJNC0x7c0C3mkNkCKynJ2Ox5VDwS
         03fDUSThjby46x0lbfEJ0y3lTZe7dsKEO9aX7wb/djYWRS1JpGV7OsFlh8KT1HpjblM0
         Ac4O1xBJfJrnA81wUZ+NmYaqlaJPeWC5cKB2ZSL46UJ7LL4jlp4f1/f3Wvb8PqM9IT3w
         cWFTYeEKCmL5Kl1vhXMEbc1oUqfd15hYu3VaFv7aAO5PTqucHB1DWfPJeZc+uAAcSY5e
         lQ7narag/NyFZg1fWjWvof0aHIpiIysGaA/e6DRBoHWXBhzelNt6rDdo28yjPqKNx/JK
         YPew==
X-Gm-Message-State: AOJu0YwRIWZZCYpE9zg/Kruh9vCYEkBxt8/rikWz5PDpcqlLUWt7dcLF
	n5jilWPjqW9NtpTl3e5laig=
X-Google-Smtp-Source: AGHT+IGcnOSO6MNVMmzA1cBY8cIAIuBGUdEeH/3J4eGfed0lthT3mnjmRQ7sblwiItlAfh61XKg5hg==
X-Received: by 2002:a05:6870:6489:b0:1b7:60a3:4104 with SMTP id cz9-20020a056870648900b001b760a34104mr10454148oab.13.1693162836646;
        Sun, 27 Aug 2023 12:00:36 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ee24-20020a056870c81800b001b3d93884fdsm3358008oab.57.2023.08.27.12.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 12:00:36 -0700 (PDT)
Message-ID: <e7036c7e-30ea-4832-866c-2795babad145@gmail.com>
Date: Sun, 27 Aug 2023 14:00:34 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] ft: track FT auth/action response status
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230822152931.276136-1-prestwoj@gmail.com>
 <20230822152931.276136-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230822152931.276136-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/23 10:29, James Prestwood wrote:
> Certain return codes, though failures, can indicate that the AP is
> just confused or booting up and treating it as a full failure may
> not be the best route.
> 
> For example in some production deployments if an AP is rebooted it
> may take some time for neighboring APs to exchange keys for
> current associations. If a client roams during that time it will
> reject saying the PMKID is invalid.
> 
> Use the ft_associate call to relay this information to station to
> handle it rather than acting like there was no response. For now
> this is being hard coded to status=53, but more could be added,
> or the status itself could be returned if there are other specific
> status codes that need to be handled.

Please update the description per reply to this thread.

> ---
>   src/ft.c | 37 ++++++++++++++++++++++++++++---------
>   1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/src/ft.c b/src/ft.c
> index c51a1288..8dfc1cb7 100644
> --- a/src/ft.c
> +++ b/src/ft.c
> @@ -58,6 +58,7 @@ struct ft_info {
>   	uint32_t frequency;
>   	uint32_t ds_frequency;
>   	uint32_t offchannel_id;
> +	uint16_t status;

Might want to indicate that this status is for the first step (authenticate/action)

>   
>   	struct l_timeout *timeout;
>   	struct wiphy_radio_work_item work;
> @@ -155,6 +156,7 @@ static bool ft_parse_authentication_resp_frame(const uint8_t *data, size_t len,
>   	if (memcmp(data + 16, addr3, 6))
>   		return false;
>   
> +

This is spurious?

>   	/* Check Authentication algorithm number is FT (2) */
>   	if (l_get_le16(data + 24) != 2)
>   		return false;

<snip>

> @@ -836,6 +836,14 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
>   		return;
>   	}
>   
> +	info->status = ret;
> +
> +	if (info->status != 0) {
> +		l_debug("BSS "MAC" rejected FT action with status=%u",
> +				MAC_STR(info->aa), info->status);
> +		goto done;
> +	}
> +
>   	if (!ft_parse_ies(info, hs, ies, ies_len)) {
>   		l_debug("Could not parse action response IEs");
>   		goto ft_error;

Should the status be set only once ft_parse_ies succeeded?

> @@ -843,6 +851,7 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
>   
>   	info->parsed = true;
>   
> +done:
>   	l_timeout_remove(info->timeout);
>   	info->timeout = NULL;
>   
> @@ -872,6 +881,7 @@ static struct ft_info *ft_info_new(struct handshake_state *hs,
>   						target_bss->rsne[1] + 2);
>   
>   	l_getrandom(info->snonce, 32);
> +	info->status = 0xffff;

Why is this needed?

>   
>   	return info;
>   }

<snip>

> @@ -1165,10 +1174,20 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
>   	 * attempt so clear out the entry so FT-over-Air can try again.
>   	 */
>   	if (!info->parsed) {
> +		uint16_t status = info->status;
> +
>   		l_queue_remove(info_list, info);
>   		ft_info_destroy(info);
>   
> -		return -ENOENT;
> +		/*
> +		 * The status may have been successful but the IEs were invalid,
> +		 * treat this the same as no response.
> +		 */
> +		if (status == 0xffff || status == 0)
> +			return -ENOENT;
> +
> +		/* If the AP rejected for some reason, relay this to station */
> +		return (int)status;

I think this entire step can be dropped if you make sure status == 0 is set only 
if parsing succeeded.

>   	}
>   
>   	ft_prepare_handshake(info, hs);

Regards,
-Denis
