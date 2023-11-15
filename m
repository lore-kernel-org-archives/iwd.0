Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBE28E35
	for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/B7z5l5"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7788f513872so439684485a.1
        for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700072842; x=1700677642; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpPz4Br/4Dq5oSJo1ev8bfRjoUq06wvrlB64POTylZs=;
        b=R/B7z5l5i/lCn1ABDkVRNk4iykhKLuuPeVKxDLkyOLtPIGANiGXgG7DkF99ct4T3o8
         T+rmiy2OHdLtavDK5VWzpptYL/LNHvRmmgjtEwNH/QpCBePHp32VJlX0VdBXN/WS1gYE
         4MGxQOd9n6zxSRjkxH99kcHY5yH9Y1AFl78OUm5Q71S5XVHt6E3FjDVGAaBSoIZuQLuW
         VFSt2eM9gVa4HiAm9pcOcEAcE8sq2f04K81ITFYLpQ7JpR+wMIZKK5Cw7ubHpmzCtUgJ
         m2QMxIpBWd5h/RgOdcEzBh/huOf1ia9uEIAXiIx/u9+jJIitHYzktMeaBxHoaMgWauqq
         jtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700072842; x=1700677642;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpPz4Br/4Dq5oSJo1ev8bfRjoUq06wvrlB64POTylZs=;
        b=W7lczYQ4U4gVlWdQaketAeUtERiZwNOLjje02E9/zpyvrsIywMILIzuacKKeODLnyk
         NCgFIW8VsPHji1JsFwXMsuY2YNsIGLhUgy8gmmgWzpf5D3bwrZWDQnKyY+pTjMUtBjwH
         2uq+gChRvVC0eMxPwNlKp66nZ7prj0XsjxOGrhcqWxdwXtfpYl26BhkStAyOJKz+ZuDW
         ID3GhsOqyGDIs4bYt55AApo7vNE8ZGTgQBj7+qKtW55ftyCPSQlMjZIe2XGQqNFh2gaP
         Qu+TrOYMxvPxA4o3JN3ThrKax9RaEZgnOLR+j++WuoN/EgFAXwk2qFJWDkVZQRbHliTD
         rfEw==
X-Gm-Message-State: AOJu0YwLvYGi25fdXybQvZQQSzPLgvCuePpqGjbxXke/3Rk/8hOxIb7n
	OEr5YuL9uNABj/DaLaX8eDo=
X-Google-Smtp-Source: AGHT+IHag0jWEhbAPFg5Qwz/f21gbPhgClqW/dSEeFxXfZ/0SQdNvM4zMTvcZa6Br0qR/VOLQJcxvA==
X-Received: by 2002:a05:620a:28d4:b0:775:6a23:5389 with SMTP id l20-20020a05620a28d400b007756a235389mr7401163qkp.40.1700072842150;
        Wed, 15 Nov 2023 10:27:22 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b0076ceb5eb309sm1635565qkp.74.2023.11.15.10.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 10:27:21 -0800 (PST)
Message-ID: <196053b2-0bdc-41ca-b309-09680343b079@gmail.com>
Date: Wed, 15 Nov 2023 10:27:19 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] netdev: Separate connect_failed and disconnected
 paths
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231115000547.1139157-1-denkenz@gmail.com>
 <20231115000547.1139157-3-denkenz@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231115000547.1139157-3-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 11/14/23 16:05, Denis Kenzior wrote:
> Commit c59669a366c5 ("netdev: disambiguate between disconnection types")
> introduced different paths for different types of disconnection
> notifications from netdev.  Formalize this further by having
> netdev_connect_failed only invoke connect_cb.
>
> Disconnections that could be triggered outside of connection
> related events are now handled on a different code path.  For this
> purpose, netdev_disconnected() is introduced.
> ---
>   src/netdev.c | 45 +++++++++++++++++++++++++++++++++------------
>   1 file changed, 33 insertions(+), 12 deletions(-)

LGTM. You may have already thought of this, but I do still think we 
could have a case where an AP could send a deauth during key setting 
right?. So key setting could still succeed but station would get 
notified of the failure via the netdev event (in 
netdev_disconnect_event), not the connect callback.

> diff --git a/src/netdev.c b/src/netdev.c
> index 327be768d3d9..e31a51617671 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -839,7 +839,6 @@ static void netdev_connect_failed(struct netdev *netdev,
>   					uint16_t status_or_reason)
>   {
>   	netdev_connect_cb_t connect_cb = netdev->connect_cb;
> -	netdev_event_func_t event_filter = netdev->event_filter;
>   	void *connect_data = netdev->user_data;
>   
>   	/* Done this way to allow re-entrant netdev_connect calls */
> @@ -847,15 +846,6 @@ static void netdev_connect_failed(struct netdev *netdev,
>   
>   	if (connect_cb)
>   		connect_cb(netdev, result, &status_or_reason, connect_data);
> -	else if (event_filter) {
> -		/* NETDEV_EVENT_DISCONNECT_BY_SME expects a reason code */
> -		if (result != NETDEV_RESULT_HANDSHAKE_FAILED)
> -			status_or_reason = MMPDU_REASON_CODE_UNSPECIFIED;
> -
> -		event_filter(netdev, NETDEV_EVENT_DISCONNECT_BY_SME,
> -				&status_or_reason,
> -				connect_data);
> -	}
>   }
>   
>   static void netdev_connect_failed_cb(struct l_genl_msg *msg, void *user_data)
> @@ -900,12 +890,42 @@ static void netdev_deauth_and_fail_connection(struct netdev *netdev,
>   	netdev_send_and_fail_connection(netdev, result, status_code, msg);
>   }
>   
> +/*
> + * If we have a connection callback pending, either through netdev_connect
> + * or netdev_reassociate, then invoke that callback with the @result and
> + * @status_or_reason.  Otherwise, invoke the event callback with the @event
> + * and @status_or_reason.
> + *
> + * This is useful for situations where handshaking or setting keys somehow
> + * fails (perhaps due to rekeying), or if the device is removed / brought
> + * down when keys are being set as a result of a rekey
> + */
> +static void netdev_disconnected(struct netdev *netdev,
> +					enum netdev_result result,
> +					enum netdev_event event,
> +					uint16_t status_or_reason)
> +{
> +	netdev_event_func_t event_filter = netdev->event_filter;
> +	void *event_data = netdev->user_data;
> +
> +	if (netdev->connect_cb) {
> +		netdev_connect_failed(netdev, result, status_or_reason);
> +		return;
> +	}
> +
> +	netdev_connect_free(netdev);
> +
> +	if (event_filter)
> +		event_filter(netdev, event, &status_or_reason, event_data);
> +}
> +
>   static void netdev_disconnect_by_sme_cb(struct l_genl_msg *msg, void *user_data)
>   {
>   	struct netdev *netdev = user_data;
>   
>   	netdev->disconnect_cmd_id = 0;
> -	netdev_connect_failed(netdev, netdev->result, netdev->last_code);
> +	netdev_disconnected(netdev, netdev->result,
> +			NETDEV_EVENT_DISCONNECT_BY_SME, netdev->last_code);
>   }
>   
>   static void netdev_disconnect_by_sme(struct netdev *netdev,
> @@ -1440,7 +1460,8 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
>   		 * CMD_DISCONNECT
>   		 */
>   		if (err == -ENETDOWN) {
> -			netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
> +			netdev_disconnected(netdev, NETDEV_RESULT_ABORTED,
> +					NETDEV_EVENT_DISCONNECT_BY_SME,
>   					MMPDU_STATUS_CODE_UNSPECIFIED);
>   			return;
>   		}
