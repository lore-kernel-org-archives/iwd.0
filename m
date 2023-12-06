Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DED37160
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id8ESJQH"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59056609abbso386744eaf.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882517; x=1702487317; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPwnkOqSBg62CU2ySSSlscTq8HqjfgkmG80dCwZbYPE=;
        b=id8ESJQHDY/lkxHo7CwAMJCtvGtN8xMkaIIZutQt/5DVdlbVPb14oVFO4WqP4u6NAr
         lTpavEQpYOUwYmsdqNmuvdKeqQBn5egy7ZxuYq8osp4ylPq2DwIz3M1qOnFp+3E8845/
         ChjdX/6RVVGFKaBnqM9+2WxgRWyHxAECXJbZrPyJNM6waFJiV86psjwfqakQO2OZ2Wr3
         ykqTuTze6l6JTFCXl/lDYp/F4zut23o2WcYtW2YHEFigwpJZUPOYVbWwizqSiWiAxBWR
         PWzvFvdyo4mcTdh6CG23M3AQ5akjVeL51ujEqXFFgnceKNSerkT6UU+hAMoiSr2bfS6j
         d/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882517; x=1702487317;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPwnkOqSBg62CU2ySSSlscTq8HqjfgkmG80dCwZbYPE=;
        b=SBr7ANj2U5N/ggxXSxx5UUSlyTeKoJ0pHOctiCESVmTYYUZhR3C9ldo7X0JAaJhMAc
         t0QexCPu9Gh4gp6pwdgf7Z8iyx7gSXj60HIe810BZna7lak7aGEU1X1+Env1lCTQ7Ug4
         K+8eCPAMKTu0QJcdOEZBMdjg4EjzAo+czoizZHyFjCnQu5ZmUbeOKltbDYJzQ27U0l/s
         gzi6XtQv+d+SwihQ0I5uz4t0cDl6rnRXP8YN1jEJgbsLuZMFuKwsYAdDqkAftHeKvhno
         WLl9QwqssQ0Pg2yEzuma+nP/3m9IJ2vbczkTxKteIAY7uTtHfNNC7b6ot81vz2rX/1k6
         3dFw==
X-Gm-Message-State: AOJu0YxsUCbLO2IAw9ZhAU6fWudo0gmwMx1sTdGXtuoCmTXMUiPEb0jB
	HcWuRivD7Ae3cY63x21dlMQxPKowS+o=
X-Google-Smtp-Source: AGHT+IGqgORWP/tETm1fKJREgp7o/vcKvnfgWiEvPPJg7n2KvTB0N421I5Beyuov2VMyPgxHRP3DpQ==
X-Received: by 2002:a05:6820:814:b0:581:ea96:f800 with SMTP id bg20-20020a056820081400b00581ea96f800mr1485934oob.6.1701882517029;
        Wed, 06 Dec 2023 09:08:37 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d4-20020a4aba84000000b0058d1f2e1c8csm52751oop.40.2023.12.06.09.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:08:36 -0800 (PST)
Message-ID: <03c0874e-0f64-493f-b9c8-cb302045938c@gmail.com>
Date: Wed, 6 Dec 2023 11:08:35 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] network: add support for SAE password identifiers
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231205154647.1778389-1-prestwoj@gmail.com>
 <20231205154647.1778389-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231205154647.1778389-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/5/23 09:46, James Prestwood wrote:
> Adds a new network profile setting [Security].PasswordIdentifier.
> When set (and the BSS enables SAE password identifiers) the network
> and handshake object will read this and use it for the SAE
> exchange.
> 
> Loading the PSK will fail if there is no password identifier set
> and the BSS sets the "exclusive" bit. If a password identifier is

I'm not so sure about this.  The trouble is that this logic is sufficient for 
the initial connection, but isn't sufficient when you consider re-association.

> set and the BSS doesn't indicate support the setting will be ignored
> (with a debug print).
> ---
>   src/network.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
> 

<snip>

> @@ -641,6 +657,32 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
>   		psk_len = 0;
>   	}
>   
> +	/*
> +	 * Sort out if the password identifier is required, should be used, "
> +	 * or should be ignored.
> +	 */
> +	if (is_sae) {
> +		if (bss->sae_pw_id_exclusive && !password_id) {

This likely needs to be taken into consideration much later, when building the 
actual handshake state.

> +			l_error("BSS requires SAE password identifiers, check "
> +				"[Security].PasswordIdentifier");
> +			return -ENOKEY;
> +		}
> +
> +		/*
> +		 * If the profile contains a password identifier but the network
> +		 * does not support it IWD will still attempt to connect. The

Password identifier is only used by SAE H2E.  One can easily imagine a weird 
network of mixed APs with some being SAE H2E, some not.  This is why I didn't 
bother implementing this, it is a half-baked feature.

> +		 * caveat here is if the connection is successful the sync will
> +		 * remove the password identifier entry. Though this might be
> +		 * unexpected to the user, retaining this (invalid) setting
> +		 * isn't worth special casing.

And this doesn't sound nice at all...  I think the setting should be preserved.

> +		 */
> +		if (!bss->sae_pw_id_used && password_id) {
> +			l_debug("[Security].PasswordIdentifier set but BSS "
> +				"does not not use password identifiers");
> +			l_free(l_steal_ptr(password_id));
> +		}
> +	}
> +
>   	/* PSK can be generated from the passphrase but not the other way */
>   	if (!psk || is_sae) {
>   		if (!passphrase)

Regards,
-Denis

