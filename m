Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576D612B
	for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVuPFtfg"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-581f78a0206so2199925eaf.2
        for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698617097; x=1699221897; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrBRTMDRsB6Z7zlM3yf/xG/pYvyrCfq1MUldR4hQp3Y=;
        b=hVuPFtfgWWloTA8qrj1JxGME5yHCrasLt6jOpJL3XtQvjngPstNTwGheRC5eLqXrko
         JwU2CwPbBKLEBysLtbZrZvSAZabODIrUMBJrIKQAtLML/x7tcAUO/e2HCRV1zy19IE9D
         W64dWJPrxOyQOwd9kTgodXFAbVafEzaAnHwas34wSpO/JQ0OoEHlTVzbRLTKPssyW0HZ
         a0HJt5NfCA7njDFf+0Nouy/b+Wh30sU+UOLL5m4WaGhLwY3SnSptGfsAQYmBAeSC2ndS
         1AbBY0h3enEpyCJiyjmZvoyfWRM6fyuhW7O04wdDEOZwwpOazP5KYshBWJprI/i3zRKu
         W2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698617097; x=1699221897;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrBRTMDRsB6Z7zlM3yf/xG/pYvyrCfq1MUldR4hQp3Y=;
        b=erMwNc8rmpHhXlFTvkD8k2J0jlLkRqFkRmO42fgGK09tvHJr+dZVwWS7dsVLkaRtg0
         Vc6MSubc6DEsy7arEqnCZRdi1TdpYt1jjw1xBqicBfdSeg5/XneQCyZj5ncFQrEXn1SQ
         2LBpsvNSTsJQ9yE2jmaZbaqdvPDg/LhChh2xYfZ7WR1bPAyug0uf95izYzSPIsozkwUh
         Pm+zvPxgKXrmmS5i/GMfJMtxZlgZGD8Ldg5hlvRLPugobQycYGWkoW3yIvr7W6pf7Sh6
         Eto/Yu2jqFo3JjFBKCoWLQ/Q5H1CWxigmUDksA+EH5nze59HvRxy281e3DKZ8RdSjnbI
         /G2g==
X-Gm-Message-State: AOJu0YwAMkt4UopC50Y+DdfHCa75WfnQffGjHZIoEV4zNJA+UKoTjWNe
	mGWYAGCXQ92vO0NpEwnf/VI=
X-Google-Smtp-Source: AGHT+IFERscmbUSR1p0pZpZ5ItPsmEi8ojYJ3pIxtDMGJjN+SvTA6qfeiF2STi+XCAgO8v9TJ7VzLA==
X-Received: by 2002:a05:6820:a90:b0:581:3e09:2623 with SMTP id de16-20020a0568200a9000b005813e092623mr6983754oob.2.1698617097450;
        Sun, 29 Oct 2023 15:04:57 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u33-20020a4a8c24000000b00582014b0138sm1515575ooj.39.2023.10.29.15.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 15:04:56 -0700 (PDT)
Message-ID: <428501e8-9ad3-4b83-adb7-e60530e98270@gmail.com>
Date: Sun, 29 Oct 2023 17:04:55 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] dpp: remove connect/scanning and resume periodic
 scans after DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231026202657.183591-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/23 15:26, James Prestwood wrote:
> When DPP is started periodic scans are stopped but never started
> again. This means if DPP fails IWD will never resume autoconnecting
> without some intervention.
> 

Okay, but why are you not removing scan_periodic_stop() calls then?  If the 
intent is to use station_set_autoconnect, then do that.  And this probably 
requires a separate patch.

> This also removes the internal scanning/connecting logic from DPP
> which was done for two reasons. First its unknown how long the
> DPP protocol took and its safest to explicitly scan to find the

Isn't this being done by invoking scan_active?

> target network/bss, and second the connect logic was flawed because
> station will not transition into a CONNECTING state since
> __station_connect_network shortcuts the state change. If DPP failed

Okay, so use station_connect_network?

> station would never resume autoconnecting, and if the post-DPP
> connection failed the state was set incorrectly so station would
> also not resume autoconnecting.
> 
> The downside of this is it takes slightly longer to connect after
> DPP since IWD must scan, but the DPP logic is simplified and keeps
> all connection logic in station.c where it belongs.

Well, the downside of this approach is that you're relying completely on 
autoconnect logic to pick the right network instead of having DPP connect to the 
network that was just configured.  So if autoconnect picks a different network 
you get results the user doesn't expect.

> ---
>   src/dpp.c | 76 ++++++++++++++++++++-----------------------------------
>   1 file changed, 27 insertions(+), 49 deletions(-)
> 

<snip>

> @@ -315,7 +313,17 @@ static void dpp_reset(struct dpp_sm *dpp)
>   		dpp->retry_timeout = NULL;
>   	}
>   
> +	/*
> +	 * Set station back to its original autoconnecting state if an
> +	 * enrollee and DPP failed
> +	 */
> +	if (station && dpp->role == DPP_CAPABILITY_ENROLLEE &&
> +			dpp->station_autoconnecting &&
> +			dpp->state != DPP_STATE_SUCCESS)
> +		station_set_autoconnect(station, true);

So what if autoconnect was false originally?

> @@ -830,16 +805,9 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
>   
>   	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
>   
> -	if (network && bss)
> -		__station_connect_network(station, network, bss);
> -	else if (station) {
> -		dpp->connect_scan_id = scan_active(dpp->wdev_id, NULL, 0,
> -						dpp_scan_triggered,
> -						dpp_scan_results, dpp,
> -						dpp_scan_destroy);

Likely this needs to be a filtered scan (with SSID) as opposed to wildcard.

> -		if (dpp->connect_scan_id)
> -			return;
> -	}
> +	dpp->state = DPP_STATE_SUCCESS;
> +
> +	station_set_autoconnect(station, true);
>   
>   	dpp_reset(dpp);
>   }

Regards,
-Denis

