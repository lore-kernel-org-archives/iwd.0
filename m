Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C663A0
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l44ZVYpQ"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbbdf0b859so4074426b6e.3
        for <iwd@lists.linux.dev>; Tue, 09 Jan 2024 19:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704857602; x=1705462402; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikRok4lwIdjONCMQb4t/dzCEoWhhY/HIVyNp13xL7Oo=;
        b=l44ZVYpQawdZPOzS/yR21TxYXwwwKqs28TBerZmscDKsnWU54OEFtAh/ddN3usoiI7
         viE0OrAIojGZRkYKjs0pJOMrRBYi0FZ93Rq5KLStdTLU4o8sgAmvtKFGooyftCSnvupD
         1TMcKM5PMlnTH8xrAS7IB+1L3aqKcn9pZbNEhgveIaakUfO3yP7zQdTkP3PIZGUodDTG
         FECgeEqHioCe39GPLB4HBviSkmi5iIeNMpmdPUwt9m67aLefcgNkfbi9/UlN5GW23Of1
         Y8fCB0u8sHDtiQcaBYxOMMCZlBhSA5RswFwm/mqsHTPUCNusmmH5peeqbQXcjxUk7MFE
         47+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704857602; x=1705462402;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikRok4lwIdjONCMQb4t/dzCEoWhhY/HIVyNp13xL7Oo=;
        b=GQ2xlx8pnCC6vp8YhMqMzwFL0ZPKlU/zcNlQq5z6ejp8sDeHwJa4lQ0irI/axtLsCg
         hLVuUnQjFF8E9+JROt9rdljv7jePj1YlJm+2K1xW68QsxXs9oIBDapZkn4k9+CUK/jsY
         ZsxMaD6QA41n3oCnZgU0tXiewfNxl1eRZn0NX7QEAue4M/m5CtJOr5++PFHX0OT3OFbU
         yFEAEr7pqoTyXurlS9AJql8mqF8MydJ42CXEPZB86UOpf1/Qij8ynW11A2DFqO8NDbWW
         /43SGX+sO4BxvmMBnOkmh0f/2vfl04jMhGeacLeMIg5Wi4cAV7D5PPQVgud7oFgxsYma
         Ha9Q==
X-Gm-Message-State: AOJu0YxcVoVz+Vw6VFfW8iX57QdBllIE3gcZ+YVeuVkmnvpYGnzCjoRw
	3gy3BfM2kKmZ12rTKw7NC55O3Gyp+Zw=
X-Google-Smtp-Source: AGHT+IEBbgKfeD3VhS9pHRoK+//wMp2YAoiGVjTne0wIQA7dQyqL/rRWPLM9zn/n7a492oKCW+XgUg==
X-Received: by 2002:a05:6808:2025:b0:3bd:47ee:5f66 with SMTP id q37-20020a056808202500b003bd47ee5f66mr488309oiw.20.1704857602268;
        Tue, 09 Jan 2024 19:33:22 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m17-20020a056808025100b003bd40a6dd34sm341072oie.43.2024.01.09.19.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 19:33:21 -0800 (PST)
Message-ID: <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
Date: Tue, 9 Jan 2024 21:33:21 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Log falling back from SAE to WPA2
Content-Language: en-US
To: Fiona Klute <fiona.klute@gmx.de>, iwd@lists.linux.dev
References: <20240109095926.1541238-1-fiona.klute@gmx.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240109095926.1541238-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fiona,

On 1/9/24 03:59, Fiona Klute wrote:
> I've had connections to a WPA3-Personal only network fail with no log
> message from iwd, and eventually figured out to was because the driver
> would've required using CMD_EXTERNAL_AUTH. With the added log messages
> the reason becomes obvious.

Interesting.  Last time I checked only the quantenna driver used this feature 
and it wasn't very common.  If it isn't a secret, what card / driver do you have?

> 
> Additionally the fallback may happen even if the user explicitly
> configured WPA3 in NetworkManager, I believe a warning is appropriate
> there.

There's currently no way to force WPA3-only in iwd.  Either configure the AP to 
be WPA3 only, or have the AP enforce transition-disable bit.  But this typically 
requires iwd to connect at least once with WPA3.  See 'TransitionDisable' and 
'DisabledTransitionModes' in man 5 iwd.network

> ---
>   src/wiphy.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/wiphy.c b/src/wiphy.c
> index 766df348..5530e9c6 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -248,6 +248,8 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy)
>   		 *
>   		 * TODO: No support for CMD_EXTERNAL_AUTH yet.
>   		 */
> +		l_debug("Unsupported: %s needs CMD_EXTERNAL_AUTH for SAE",
> +			wiphy->driver_str);

I flipped this around and made this statement an l_warn to make it clearer that 
this is an iwd limitation.

>   		return false;
>   	}
> 
> @@ -312,8 +314,10 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
>   		if (ie_rsne_is_wpa3_personal(info)) {
>   			l_debug("Network is WPA3-Personal...");
> 
> -			if (!wiphy_can_connect_sae(wiphy))
> +			if (!wiphy_can_connect_sae(wiphy)) {
> +				l_warn("Can't use SAE, trying WPA-2");

And made this into l_debug.

>   				goto wpa2_personal;
> +			}
> 
>   			if (info->akm_suites &
>   					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)
> --

Regards,
-Denis

