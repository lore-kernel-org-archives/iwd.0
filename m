Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49A15ADB8
	for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960369; cv=none; b=F8zPHslc7PVaTwMOvwWXUUZkn0mqvbbB++p7MEJjNYFp8KIZQwUKC+jcDWHHiKiIMJRayaaTxSNunBOTPN3C5ewMX+EIkwj0oVsExPR+gEV6lCL6/IgMMpvDlFWeC1qcIQk7d5awNwvogQjaqbh5z609nBNqv4rYaNBE0TcivHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960369; c=relaxed/simple;
	bh=II5ebyMvL6/myktoCW5gfqsMZOl5ajNqtYKR9F7biz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HxE9xb6kckQ1ZABlCte3cSnYYwWi8z1pHGsJVj6FY+YP3g0yDPoIeHHypwuZabj8z14odNOWB5xaMX6VHbkuFyHcQaGbmtDyFkCWKA+/Kt1cYFRkKxpntOUnD2Qg8RzQB3d/pRAb9pK2W1t09Ho/SnYhUyOZj5maQU8stma7ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKIVZ92n; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKIVZ92n"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b24162dd6so34399416d6.2
        for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713960367; x=1714565167; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6N6j01XhlIPYgDQ3zXaS92eHIuBl6EoCln/t4XX+hw=;
        b=eKIVZ92nIdA+v/08cKdFrbvXPdY/d780eombHZNwDhoh48KLAJax/10Bozyo32YLZ1
         ql8f0z21l2DGlreKCk6cIGjciHJZ+VxJOsbJLwxMRnEyrvISDL+nWSakl9cuCS72qFUX
         lCpxLSpTWOf7xmcgac2c3YyAUr6kFetew3Ay2uYK4Z8pmJjLXnzU2tqLEUwXOeq7DhEN
         dW/J0OeLkTLp7gkk1dxpowhSYmp/CR3gJk6cu5HCTmeqlcnUIJzLv5tXu2mhXic8A/PG
         /GZiBSJoAVCNS+qVVpfdd/66NK/OPXlMBQ7ldrEaEtu1u6hhkyA0A+kZKTogiYVh7Grq
         jKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960367; x=1714565167;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6N6j01XhlIPYgDQ3zXaS92eHIuBl6EoCln/t4XX+hw=;
        b=JMr8RBfVSqLp3+eh0Ya7cSfGsx8teR4CH9o7k+bN7uWg0ZkjYpy0fGMVqQjaUeFzLV
         OQUAVo+3vxQpSUTF3vm3qq+1FfKXsTYGcrWBEMUpV6N6B8dxsmRqg5awK8gkH/zwJuVG
         L+PK0LmI63pRFt0g5Zm0ny9UX7IbvH/r2Bu3CQCnGXoTAixK6WhwgKIVwk2v8PaVhfj9
         /dsvmtgZOiAs9UhbfIUP2Hu5kWKD3NFkSJk58FO0YXJ2xJbv9BAXWJT8TAZp7U+tsxeT
         VNEN3luOs9Rhok+oZy6GhrHG4PmAjWSvxsxkFMkkCulqJKMDlcpT2F5lJpJNHUYIV8NI
         9CHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmC7DOaSQmeyrC6wfRiXuBJvvxJn2aL4MevJROEjZICTrf2p13kdCJGgNkK0Xq0LmWAuESujovG1pau7FbRXBwDiFU
X-Gm-Message-State: AOJu0YyCyMIohqelWYWo4jnWG36+85i6sNNdcwxxAiXUQkXEEZQzcWFt
	NRUwOkBaHSuq9ErhMrvCNXO02iMoDRgmBCIIMkLsSP4R+2H0icv5EBCyFA==
X-Google-Smtp-Source: AGHT+IFllAHsSJ9x6bPpLA/eeREXqmpzy6EAHxqpVYR+Ib8cjzHRegssY6QCVk11iGQmJsFuWoVNLQ==
X-Received: by 2002:ad4:4082:0:b0:6a0:8610:8e62 with SMTP id l2-20020ad44082000000b006a086108e62mr2012276qvp.27.1713960366683;
        Wed, 24 Apr 2024 05:06:06 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r15-20020a0c8d0f000000b006a045780b77sm3393748qvb.51.2024.04.24.05.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:06:06 -0700 (PDT)
Message-ID: <21968340-08b2-420f-95e2-7b6e6ccacb6a@gmail.com>
Date: Wed, 24 Apr 2024 05:06:05 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] sae: refactor and add function sae_calculate_keys
Content-Language: en-US
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <20240421125050.6649-5-brandtwjohn@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240421125050.6649-5-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 4/21/24 5:50 AM, John Brandt wrote:
> Refactor code by moving code to the new function sae_calculate_keys.
> This will make it easier in the next commits to add SAE support for AP
> mode.
> ---
>   src/sae.c | 83 +++++++++++++++++++++++++++++++------------------------
>   1 file changed, 47 insertions(+), 36 deletions(-)
>
> diff --git a/src/sae.c b/src/sae.c
> index c133386f..314fc28f 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -683,10 +683,9 @@ static bool sae_send_confirm(struct sae_sm *sm)
>   	return true;
>   }
>   
> -static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
> -					const uint8_t *frame, size_t len)
> +
> +static int sae_calculate_keys(struct sae_sm *sm)
>   {
> -	uint8_t *ptr = (uint8_t *) frame;
>   	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
>   	enum l_checksum_type hash =
>   		crypto_sae_hash_from_ecc_prime_len(sm->sae_type, nbytes);
> @@ -702,39 +701,6 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
>   	struct l_ecc_scalar *tmp_scalar;
>   	struct l_ecc_scalar *order;
>   
> -	ptr += 2;
> -
> -	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
> -	if (!sm->p_scalar) {
> -		l_error("Server sent invalid P_Scalar during commit");
> -		return sae_reject(sm, SAE_STATE_COMMITTED,
> -				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
> -	}
> -
> -	ptr += nbytes;
> -
> -	sm->p_element = l_ecc_point_from_data(sm->curve, L_ECC_POINT_TYPE_FULL,
> -						ptr, nbytes * 2);
> -	if (!sm->p_element) {
> -		l_error("Server sent invalid P_Element during commit");
> -		return sae_reject(sm, SAE_STATE_COMMITTED,
> -				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
> -	}
> -
> -	/*
> -	 * If they match those sent as part of the protocol instance's own
> -	 * SAE Commit message, the frame shall be silently discarded (because
> -	 * it is evidence of a reflection attack) and the t0 (retransmission)
> -	 * timer shall be set.
> -	 */
> -	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
> -			l_ecc_points_are_equal(sm->p_element, sm->element)) {
> -		l_warn("peer scalar or element matched own, discarding frame");
> -		return -ENOMSG;
> -	}
> -
> -	sm->sc++;
> -
>   	/*
>   	 * K = scalar-op(rand, (element-op(scalar-op(peer-commit-scalar, PWE),
>   	 *			PEER-COMMIT-ELEMENT)))
> @@ -823,6 +789,51 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
>   	/* don't set the handshakes pmkid until confirm is verified */
>   	memcpy(sm->pmkid, tmp, 16);
>   
> +	return 0;
> +}
> +
> +
> +static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
> +					const uint8_t *frame, size_t len)
> +{
> +	uint8_t *ptr = (uint8_t *) frame;
> +	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
> +
> +	ptr += 2;
> +
> +	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
> +	if (!sm->p_scalar) {
> +		l_error("Server sent invalid P_Scalar during commit");
> +		return sae_reject(sm, SAE_STATE_COMMITTED,
> +				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
> +	}
> +
> +	ptr += nbytes;
> +
> +	sm->p_element = l_ecc_point_from_data(sm->curve, L_ECC_POINT_TYPE_FULL,
> +						ptr, nbytes * 2);
> +	if (!sm->p_element) {
> +		l_error("Server sent invalid P_Element during commit");
> +		return sae_reject(sm, SAE_STATE_COMMITTED,
> +				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
> +	}
> +
> +	/*
> +	 * If they match those sent as part of the protocol instance's own
> +	 * SAE Commit message, the frame shall be silently discarded (because
> +	 * it is evidence of a reflection attack) and the t0 (retransmission)
> +	 * timer shall be set.
> +	 */
> +	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
> +			l_ecc_points_are_equal(sm->p_element, sm->element)) {
> +		l_warn("peer scalar or element matched own, discarding frame");
> +		return -ENOMSG;
> +	}
> +
> +	sm->sc++;
> +
> +	sae_calculate_keys(sm);
No return check here. Its likely an impossible scenario (getting the 
x-value) but for consistency might as well check.
> +
>   	if (!sae_send_confirm(sm))
>   		return -EPROTO;
>   
