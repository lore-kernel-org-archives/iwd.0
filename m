Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831220DC8
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709101595; cv=none; b=Qm877lu2p+pZnER7qhoH2AR42DlTr3hc5iSiNAumXSVMbdv+XuUepPKPFLnrDZpIzBe5MHKIXPS60LfD7d8y0oFf5Bm5FVuMx1cd5K5+eU3NdgC64h1g9ArKYlwciv+3G+hK6OCGpk8UIv6NZb7/kb6OyO2vhYJ03OnEyMEGEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709101595; c=relaxed/simple;
	bh=fZ5cFxAy1tMLCzSRXexPtimiPLZO+1RML0azjDx1Xag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=p2K0RwMh0xxojM39PEYJS7EeZLV/MAZTlC6P8JGH5uyeebfeGC7QFtoMwOSZORLPXG0j9jYz8rVxAlD42wPzROsosnFJjDOCsl0/RW1f6Ej/QG+DJ404NZlMltlziP+33WcgxjD6z0Tb6XyBSmMh9SO+phKpQ7KaPulTZOlZwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aedb1.dynamic.kabel-deutschland.de [95.90.237.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F58B61E5FE04;
	Wed, 28 Feb 2024 07:26:23 +0100 (CET)
Message-ID: <259df0b0-4961-4818-8342-e87117074048@molgen.mpg.de>
Date: Wed, 28 Feb 2024 07:26:24 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eap-wsc: Silence static analysis
To: Denis Kenzior <denkenz@gmail.com>
References: <20240227212521.1510693-1-denkenz@gmail.com>
Content-Language: en-US
Cc: iwd@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240227212521.1510693-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Denis,


Thank you for your patch.

Am 27.02.24 um 22:25 schrieb Denis Kenzior:
> static analysis complains that authenticator is used uninitialized.
> This isn't strictly true as memory region is reserved for the
> authenticator using the contents of the passed in structure.  This
> region is then overwritten once the authenticator is actually computed
> by authenticator_put().  Silence this warning by explicitly setting
> authenticator bytes to 0.

Too bad. Out of curiosity. What static analyzer is this?

For the commit message summary, I would be more specific. Maybe:

Zero authenticator bytes to fix static analysis warning

> ---
>   src/eap-wsc.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/src/eap-wsc.c b/src/eap-wsc.c
> index 65a97da4ee5e..789a20f032b9 100644
> --- a/src/eap-wsc.c
> +++ b/src/eap-wsc.c
> @@ -695,6 +695,8 @@ static void eap_wsc_send_m5(struct eap_state *eap,
>   	size_t encrypted_len;
>   	bool r;
>   
> +	memset(m5.authenticator, 0, sizeof(m5.authenticator));
> +
>   	memcpy(m5es.e_snonce1, wsc->local_snonce1, sizeof(wsc->local_snonce1));
>   	pdu = wsc_build_m5_encrypted_settings(&m5es, &pdu_len);
>   	explicit_bzero(m5es.e_snonce1, sizeof(wsc->local_snonce1));
> @@ -797,6 +799,8 @@ static void eap_wsc_send_m3(struct eap_state *eap,
>   	uint8_t *pdu;
>   	size_t pdu_len;
>   
> +	memset(m3.authenticator, 0, sizeof(m3.authenticator));
> +
>   	len = strlen(wsc->device_password);
>   
>   	/* WSC 2.0.5, Section 7.4:
> @@ -975,6 +979,8 @@ static void eap_wsc_r_send_m8(struct eap_state *eap,
>   	unsigned int auth_types =
>   		wsc->m1->auth_type_flags & wsc->m2->auth_type_flags;
>   
> +	memset(m8.authenticator, 0, sizeof(m8.authenticator));
> +
>   	if (auth_types & WSC_AUTHENTICATION_TYPE_OPEN)
>   		memcpy(&creds[creds_cnt++], &wsc->open_cred,
>   			sizeof(struct wsc_credential));
> @@ -1022,6 +1028,9 @@ static void eap_wsc_r_handle_m7(struct eap_state *eap,
>   	struct wsc_m7_encrypted_settings m7es;
>   	enum wsc_configuration_error error = WSC_CONFIGURATION_ERROR_NO_ERROR;
>   
> +	memset(m7es.authenticator, 0, sizeof(m7es.authenticator));
> +	memset(m7.authenticator, 0, sizeof(m7.authenticator));
> +
>   	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
>   	if (wsc_parse_m7(pdu, len, &m7, &encrypted) != 0)
>   		goto send_nack;
> @@ -1084,6 +1093,9 @@ static void eap_wsc_r_send_m6(struct eap_state *eap,
>   	size_t encrypted_len;
>   	bool r;
>   
> +	memset(m6es.authenticator, 0, sizeof(m6es.authenticator));
> +	memset(m6.authenticator, 0, sizeof(m6.authenticator));
> +
>   	memcpy(m6es.r_snonce2, wsc->local_snonce2, sizeof(wsc->local_snonce2));
>   	pdu = wsc_build_m6_encrypted_settings(&m6es, &pdu_len);
>   	explicit_bzero(m6es.r_snonce2, sizeof(wsc->local_snonce2));
> @@ -1123,6 +1135,8 @@ static void eap_wsc_r_handle_m5(struct eap_state *eap,
>   	struct wsc_m5_encrypted_settings m5es;
>   	enum wsc_configuration_error error = WSC_CONFIGURATION_ERROR_NO_ERROR;
>   
> +	memset(m5es.authenticator, 0, sizeof(m5es.authenticator));
> +
>   	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
>   	if (wsc_parse_m5(pdu, len, &m5, &encrypted) != 0)
>   		goto send_nack;
> @@ -1188,6 +1202,9 @@ static void eap_wsc_r_send_m4(struct eap_state *eap,
>   	size_t len_half1;
>   	struct iovec iov[4];
>   
> +	memset(m4es.authenticator, 0, sizeof(m4es.authenticator));
> +	memset(m4.authenticator, 0, sizeof(m4.authenticator));
> +
>   	memcpy(m4es.r_snonce1, wsc->local_snonce1, sizeof(wsc->local_snonce1));
>   	pdu = wsc_build_m4_encrypted_settings(&m4es, &pdu_len);
>   	explicit_bzero(m4es.r_snonce1, sizeof(wsc->local_snonce1));

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
