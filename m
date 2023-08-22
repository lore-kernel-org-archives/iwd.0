Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFD1D31F
	for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 15:34:09 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59209b12c50so28339617b3.0
        for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718448; x=1693323248;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YRfSpJmY4Lbm0O5pnocvMEweW7fJmNbN9L39cYG7bM=;
        b=PwtnSYlyq2TNTeq6mZ/wRHaX3gRIJqNfZV5OpqFT+Mw2c9GhEZLLLIhrEMQcCz0df2
         aYbRyswnU53urV5VIHbNybrRly8Ey6tUEMiZwV3IZO1EvhRfp8lYZeXdURgJFMVe7I7q
         8oCh5os1Pc3ZlVvN+wmHuS267boZvIv8+Zh9Ej9ITN6jsF9Wyhuc8HR4xgTjTPwh08Dr
         TmAQSyln2G/iuxH3odYTyCT5lVD0oNP9RVynudq2XfG9AI1Pfkrrh2gGLHtu0wnZ2bdC
         Pf0ZLiAu1tQ8qjp78SjekzjfCBtCd4dLq38nv1ySFazFte93htwUOBlqD6FYX6mdXFjZ
         b4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718448; x=1693323248;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YRfSpJmY4Lbm0O5pnocvMEweW7fJmNbN9L39cYG7bM=;
        b=dzPtX8jq3zYI5XgplDHHaMc2XMeZgVZeWHHNGKjcRLcd3zLwZj3XtynFaU5tPQnj2d
         R5y24ruRZUAkzZZlKhq5X/sBE/KljHm1PzqHWkDfV1JOTVIvSPCyrgOFNWaT4BBuFXUq
         U0KAyCXTd4g6StEo5joll3FBcyodUyT2LGkgBNJlZ6Sa/7fryy9zOx+6dkcJuTkiZFMO
         c5++Gteijh3URf0bBCyp1CVMgztSIW5uiMK7vAXaDqcqGqYrNq3liUrT/HNeq1SoKjli
         BaOuTrxaErKyzhZSYHO4S7BtOQo+AgUrJfFivjSDFwCk9gDFX9oycziacZUCcAb9Sy1X
         WVDA==
X-Gm-Message-State: AOJu0YwFbRTEXgw01KtVsdBC65hOIDznd2GOmI5Wu7hdxyOIYkJyGEjo
	RPqm5w6vC5nxeP7HSu2SstWZRc5hsc0=
X-Google-Smtp-Source: AGHT+IGqdxj42Y+D1oXIdbkL4dsx8gJPvBTq1i+XHp6dCHbYK51dtkvisVXuItH988KgJndR1dOjsQ==
X-Received: by 2002:a0d:d752:0:b0:58f:9cd8:9e4d with SMTP id z79-20020a0dd752000000b0058f9cd89e4dmr11202535ywd.46.1692718448233;
        Tue, 22 Aug 2023 08:34:08 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x186-20020a0deec3000000b00586108dd8f5sm2830120ywe.18.2023.08.22.08.34.07
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:34:07 -0700 (PDT)
Message-ID: <ec8444b0-de23-44c2-aafa-dda322a2dd8a@gmail.com>
Date: Tue, 22 Aug 2023 08:34:07 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ft: track FT auth/action response status
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20230822152931.276136-1-prestwoj@gmail.com>
 <20230822152931.276136-2-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20230822152931.276136-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/22/23 8:29 AM, James Prestwood wrote:
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

This part is wrong, I instead made ft_associate return the status 
directly, and station can sort out how it wants to proceed.

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
>   
>   	struct l_timeout *timeout;
>   	struct wiphy_radio_work_item work;
> @@ -155,6 +156,7 @@ static bool ft_parse_authentication_resp_frame(const uint8_t *data, size_t len,
>   	if (memcmp(data + 16, addr3, 6))
>   		return false;
>   
> +
>   	/* Check Authentication algorithm number is FT (2) */
>   	if (l_get_le16(data + 24) != 2)
>   		return false;
> @@ -527,8 +529,6 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
>   		return -EINVAL;
>   
>   	status = l_get_le16(frame + 14);
> -	if (status != 0)
> -		return (int)status;
>   
>   	if (spa_out)
>   		*spa_out = spa;
> @@ -541,7 +541,7 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
>   		*ies_len = frame_len - 16;
>   	}
>   
> -	return 0;
> +	return (int)status;
>   }
>   
>   int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
> @@ -825,7 +825,7 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
>   
>   	ret = ft_over_ds_parse_action_response(frame, frame_len, &spa, &aa,
>   						&ies, &ies_len);
> -	if (ret != 0) {
> +	if (ret < 0) {
>   		l_debug("Could not parse action response");
>   		return;
>   	}
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
>   
>   	return info;
>   }
> @@ -998,7 +1008,6 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
>   	struct netdev *netdev = netdev_find(ifindex);
>   	struct handshake_state *hs = netdev_get_handshake(netdev);
>   	struct ft_info *info;
> -	uint16_t status;
>   	const uint8_t *ies;
>   	size_t ies_len;
>   
> @@ -1008,14 +1017,14 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
>   
>   	if (!ft_parse_authentication_resp_frame(frame, frame_len,
>   					info->spa, info->aa, info->aa, 2,
> -					&status, &ies, &ies_len)) {
> +					&info->status, &ies, &ies_len)) {
>   		l_debug("Could not parse auth response");
>   		return;
>   	}
>   
> -	if (status != 0) {
> +	if (info->status != 0) {
>   		l_debug("BSS "MAC" rejected FT auth with status=%u",
> -				MAC_STR(info->aa), status);
> +				MAC_STR(info->aa), info->status);
>   		goto cancel;
>   	}
>   
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
>   	}
>   
>   	ft_prepare_handshake(info, hs);
