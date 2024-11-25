Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DD1B218B
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546599; cv=none; b=lW1Muu0DbtA+eYO2lJ1fbebDrIGpXLE5g1P7PAFfxJuDI2W6Za7CxFrzzoJTPxHF8lim0IWJDPRFw9oW8feFOwsDVkYFie6nAERWPW6WvYchvfyfAvISE8bUxsrjVpj9PmCDLeh/94bnBtsdlaKG4byv+jeGLLMFg4vy6bdPtVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546599; c=relaxed/simple;
	bh=KcK1rMV3LaTELB3efVEJDLMibDjSX72ZuFfgB4tgoaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pbqv/3gAG/yLwQrNsvsoxxsGMGTufS3qpa6BcSC60IOqTkOnf7GAtbKXRxRJaJcT3fVcM9P0xnlGSAfOb3gzdOUjWyOlXyqoS4dBNP4Omv0CWliv1YobU+e63Q9b495770f3Q0zPc1O33Irdlp1FI1poYq7NmR4ueAqmJq50Gd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT1011Ah; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT1011Ah"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-296b567bc30so1385828fac.2
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732546597; x=1733151397; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=roZJKfdHUlskll9WhdjeITfatnigVPm7F3KgZ/98ySQ=;
        b=LT1011AhJveLnmh/jbsKy3+BYEaXlN+aXgLm7GLGr90VE2CL5+knpyZ9+TM73MEuwb
         s46AS11xyG10tad1BQUYufsnO71XdjQCqC7S7mIxJR6434xQNArUYT8tcUIVrvj5e5RF
         XqCEMzKaFPOdQDjTw/+DlEbJejXSHreTWmhVnD0x6ou6+y1UxGzzJ8v8DezcbaaYgn4i
         L7MhoWX5QpyUMANdYfdHox8li0YeJdDE1ZbLBoedZIo0y0kVIqqTorBnxs3/p0YG/w3j
         h4vDvTqv8vde46g54Bjm8McYDy3lQsY68vZMRTwXfxv/ZGFrVN5g93PR7ao3AKahaQGk
         KeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546597; x=1733151397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roZJKfdHUlskll9WhdjeITfatnigVPm7F3KgZ/98ySQ=;
        b=iP0150hOIBZG1Vow8zza00n1PxOQhDjEpA/Q1Wn1PBQ86DIdA2AFKUpaAmHMsY4SLW
         CQ8pCUBKeTWXEd3VsbSe6s/+GFcAWUzKeodLw+Tkh3RoE/f8/u8LhGzC+Q0MqJlbtqV4
         JoUoUrvspjal9p+2cmpv0XYHtQx81+7Hy4dchpFozhkhYKTCT1KgbuIfB6YBTJ4Hz0ky
         Dc7Esht8frABiojw68bUGkGpPkf5swPMXyFeurHLnp5YKIj1S/5Ecp06PlL5GQHNUDwA
         QXNCXfHNQ1uk2RxlBwoEH+zfQ1qPDrbDzqcOPk+vUTkvO2xgp/IHLMLnsCwhscfa7aww
         LxVg==
X-Forwarded-Encrypted: i=1; AJvYcCVsgfhgVwu5sYRaVwCWubo0BsXyuhN7ZAcdlYCO0UiL7lPSrjNEs+gm0RkzQMAVsbpe98c=@lists.linux.dev
X-Gm-Message-State: AOJu0YzvVwSYIJnTrQO549Zen1BO1jdxkTgm1l9WFn7+J87d7ztl9a0u
	sTdj9iI3bAHqcrrDmEKyo4Jd42tGQE6t7LjXUjMx9vns8WhtGrNj
X-Gm-Gg: ASbGncu5hKozDKpIdod+qtQtN8TG6XFdLx8833PfHix3RmDW/lPRP0jyWOM4rb3yrQI
	c+i7pHmw7wjiNfkabPyG8vYym7f83OI3UWSz0iJCeUOqbcaO/dINTx2kD9uBveNhttayGVuQO61
	L4soCTMfXgupYMf9UhSa/pmFK2bQCd4Wd273Kbr0x05m3Jlf25zX7nRFWCpAizlY6RRlKOFS8FA
	I+XYebP9MyyCaq3KlJ6zPBQ9dq1LKodKEK9hdyuMS12E648TSOZtiXyIc2qC8+6YRlFBx0coYyc
	fUBC7hGSIzETbJY=
X-Google-Smtp-Source: AGHT+IFMqD5m9ZUFMTGUdcqZy5M/4qSMIpUrZKTfxuNr/aiSePWOCliz7nPYYxzqnTW6MibGH+1PXg==
X-Received: by 2002:a05:6871:111:b0:296:de10:4ef with SMTP id 586e51a60fabf-297206d2b48mr11015327fac.0.1732546596607;
        Mon, 25 Nov 2024 06:56:36 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2971d87e96dsm3122622fac.45.2024.11.25.06.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:56:35 -0800 (PST)
Message-ID: <7fd01a53-53a0-45b5-993f-6bec6ba16a1a@gmail.com>
Date: Mon, 25 Nov 2024 08:56:33 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] handshake: Add pmksa setter & stealer
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241122151551.286355-1-prestwoj@gmail.com>
 <20241122151551.286355-10-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241122151551.286355-10-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/22/24 9:15 AM, James Prestwood wrote:
> From: Denis Kenzior <denkenz@gmail.com>
> 
> The majority of this patch was authored by Denis Kenzior, but
> I have appended setting the PMK inside handshake_state_set_pmksa
> as well as checking if the pmkid exists in
> handshake_state_steal_pmkid.
> 
> Authored-by: Denis Kenzior <denkenz@gmail.com>
> Authored-by: James Prestwood <prestwoj@gmail.com>
> ---
>   Makefile.am     |  4 +++
>   src/handshake.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
>   src/handshake.h | 11 ++++++-
>   3 files changed, 91 insertions(+), 1 deletion(-)
> 

<snip>

> @@ -141,7 +142,12 @@ struct handshake_state {
>   	bool supplicant_ocvc : 1;
>   	bool ext_key_id_capable : 1;
>   	bool force_default_ecc_group : 1;
> -	uint8_t ssid[SSID_MAX_SIZE];
> +	bool have_pmksa : 1;
> +	union {
> +		struct pmksa *pmksa;
> +		uint64_t expiration;
> +	};
> +	uint8_t ssid[32];

I changed this back to using SSID_MAX_SIZE instead of the magic number.

>   	size_t ssid_len;
>   	char *passphrase;
>   	char *password_identifier;

All 15 patches applied, thanks.

Regards,
-Denis
