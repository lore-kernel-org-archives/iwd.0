Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79F815AAC6
	for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960525; cv=none; b=jAVhxcdTrqOXJGaPxsN6FC6kBIMlclnuitGEq5zvKqjK7ncD+1WVB29X9LmLj+CtcDwwkQpaH0JNGmfinz8Kd4CWgtV8mIQjyMgEcujz/G4JDF4zm5pnpbTQkxXfQ2cBt0NyDru4XOXaI7hQRI/qX1QS0nDUR+g7Mijdi2nPCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960525; c=relaxed/simple;
	bh=q/xSWf5W7Z/dK6C7dEA3TQSgHOsue3iMkqbYwlyfq0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FBmP4elWqdjk4fNlVHtibusl1EszIVaqZ1ZHYyIAWAJS/EKRtSujfCBIjWFI0nw4bA2iNC5ZVuJD7nFZmM5+ylClwkbNCyZRmfv6vHA7cvbzG9hmdU7FBprY5vTb02CbY0hs3jdzGQ12yLfesquSSUyuw3y3iIvqZSgUgx4hUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJQLAmMD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJQLAmMD"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-699320fcbc1so39656766d6.3
        for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713960523; x=1714565323; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0aP+gPH6cs9AJ+njPaazHOYyA+ti5esWeL+quSkL4s=;
        b=SJQLAmMDqG7s7j1ja2XWmSKFXpEWmh1TlEheCDUUNCCzGQmvNyAycJvFYAUC6KvoTM
         6gIygjEaLQnYl4SWQcm8texGMMHpxfalDBKT5yJLD61Cavt6b3XUC9ZeGSjunqeRWrhn
         gqbDIzrvYuMpC7PYHNHvew+oyyu/HlR7kBCGK1enEV2bsjtP8UUoZXP+xtxD+TTW6qd7
         Uq5210lNRpWLf2o+feqq7wTLD0/zyoO0zTzxmttukJk9Ywt11O1GlvJ2BXH+QcAyAUyQ
         gFaWQdMzC7ZavAovfvSA4zmUmju9lvuvoYg1OHR4byj1LnmiAliPawiEF0Xd5Ig64StU
         6kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960523; x=1714565323;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0aP+gPH6cs9AJ+njPaazHOYyA+ti5esWeL+quSkL4s=;
        b=FTKwXa0qfTXsVwaRK8P4RiGBx9a8pZLKx5WfvBpaGeaWWbdhzZ6g/8nwzfytYiGhtL
         q4bVDsnbeSzNs30QnSbJ8ny5ioembJytl+bYjn/8Z+17g/6FwIIbsKcbK53R3M+3Wcwx
         Hl9Vd5F/GStbnI9suKJHt0XB41E8phkjO5Yll0TvvTBQTRXtXYC2NHPtvot9IxHHRmO3
         hQKzk4FNCd/hrBgkUR1suhHhRp0ByXhxiwlVhCAK2wmuQBjZE0bRpt5bcxNS5GzTGIm4
         rdbPH7bcY9tvSNdtje8NQakAPpUGZxPBRw+d8WGOJk3Po/LbpBPPtM6AIRfhf3RfRQ3s
         pBNg==
X-Forwarded-Encrypted: i=1; AJvYcCX52LZVxCgyEIdQNfvhvnC1Rv6V4hnMeFJhPoLQGHjfhDQRkGBXYuZER6OCxZf4O0+u36oDGGG/LAnbVy3SySERkdYb
X-Gm-Message-State: AOJu0YyuulsYfaqLTr4gvWbMsgAp4gHARWiSn+84i2VUh1UqzzPVM+St
	HMMk/kNclmEYljkg93NIyBYJ/tpklt8YmYpuFegr2hmUVsgXtq8Z
X-Google-Smtp-Source: AGHT+IGm4IotmymYrf2RSA/jiwkS8HbbxBd6UuUsVjEzNMxFiNyW+Ffzv2dYExi8RyfSkZcnwLFYlg==
X-Received: by 2002:a05:6214:a68:b0:69b:fb9:9a75 with SMTP id ef8-20020a0562140a6800b0069b0fb99a75mr2121587qvb.49.1713960522717;
        Wed, 24 Apr 2024 05:08:42 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r15-20020a0c8d0f000000b006a045780b77sm3393748qvb.51.2024.04.24.05.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:08:42 -0700 (PDT)
Message-ID: <34794f6d-211b-4f91-91f7-4de8ab063841@gmail.com>
Date: Wed, 24 Apr 2024 05:08:41 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] sae: make sae_process_commit callable in AP mode
Content-Language: en-US
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <20240421125050.6649-6-brandtwjohn@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240421125050.6649-6-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John

On 4/21/24 5:50 AM, John Brandt wrote:
> As an AP, the function sae_process_commit will pick the group offered by
> the client. In a subsuquent commit the offered group will first be
> verified before calling sae_process_commit. The AP will reply with a
> Commit frame, calculate current keys, and move to the COMMITTED state.
> ---
>   src/sae.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/src/sae.c b/src/sae.c
> index 314fc28f..2c97d94c 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -48,6 +48,8 @@ static bool debug;
>   #define SAE_SYNC_MAX		3
>   #define SAE_MAX_ASSOC_RETRY	3
>   
> +static bool sae_send_commit(struct sae_sm *sm, bool retry);
> +
>   #define sae_debug(fmat, ...) \
>   ({	\
>   	if (debug) \
> @@ -797,8 +799,12 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
>   					const uint8_t *frame, size_t len)
>   {
>   	uint8_t *ptr = (uint8_t *) frame;
> -	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
> +	unsigned int nbytes;
> +
> +	if (sm->handshake->authenticator && sae_set_group(sm, l_get_le16(frame)) < 0)
> +		return -1;
>   
> +	nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
>   	ptr += 2;
>   
>   	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
> @@ -824,20 +830,22 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
>   	 * it is evidence of a reflection attack) and the t0 (retransmission)
>   	 * timer shall be set.
>   	 */
> -	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
> -			l_ecc_points_are_equal(sm->p_element, sm->element)) {
> -		l_warn("peer scalar or element matched own, discarding frame");
> +	if ((sm->scalar && l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar)) ||
> +			(sm->element && l_ecc_points_are_equal(sm->p_element, sm->element)))
So we isolated this check to only the supplicant side now, but do we 
also need to do the same check after the keys are calculated for AP mode?
>   		return -ENOMSG;
> -	}
>   
>   	sm->sc++;
>   
> -	sae_calculate_keys(sm);
> -
> -	if (!sae_send_confirm(sm))
> -		return -EPROTO;
> -
> -	sm->state = SAE_STATE_CONFIRMED;
> +	if (sm->handshake->authenticator) {
> +		sae_send_commit(sm, false);
> +		sae_calculate_keys(sm);
> +		sm->state = SAE_STATE_COMMITTED;
> +	} else {
> +		sae_calculate_keys(sm);
> +		if (!sae_send_confirm(sm))
> +			return -EPROTO;
> +		sm->state = SAE_STATE_CONFIRMED;
> +	}
>   
>   	return 0;
>   }
> @@ -1008,7 +1016,7 @@ static int sae_verify_nothing(struct sae_sm *sm, uint16_t transaction,
>   	/*
>   	 * TODO: This does not handle the transition from NOTHING -> CONFIRMED
>   	 * as this is only relevant to the AP or in Mesh mode which is not
> -	 * yet supported.
> +	 * yet fully supported.
>   	 */
>   	if (transaction != SAE_STATE_COMMITTED)
>   		return -EBADMSG;
