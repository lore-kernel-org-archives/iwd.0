Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448D126F16
	for <iwd@lists.linux.dev>; Tue,  2 Apr 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071170; cv=none; b=m+2WLUes+mPmI0hLAYcl+uI8EhWOAiP3ThaYLR03RwfyO2RWhLbUHLWXOOyRWBv2cxqDporCX9kX76rnZO1fGSTkBvMk7vgZ3sTYEnxXX65gb8b6eL2Phspmn8yX8g/RPSc01kkc9dFsIBBdF0hluyicZ1CR/VA9vf9D+PXhr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071170; c=relaxed/simple;
	bh=0uVZXjh0uD3k7UT7QSQhMAvONbLZigZjCxLgf3vX6WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FDTjtETnzBdh7F28MBM67xL8CHiSJc8ndBCwIKQsb5ZJH/1/1bocTDh5Huggn0WcJfzRW8aZpasZduA66UIlrieYuvYMFvLQ9HjyXmffpe/thD3t6HPKISBBliFTfah0YQ6a2baJ+a0TWBQpjkizYvxbYAXiX7J1/EIrDqDxqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjKFes34; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjKFes34"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c4f55a1bd6so442869b6e.0
        for <iwd@lists.linux.dev>; Tue, 02 Apr 2024 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712071167; x=1712675967; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8rzHYUvV7VuXeanyerj4KxdBd5NW4soBunYHKjk+mI=;
        b=jjKFes34ynmG7WH5SijruDsKRKtqZn74N6vO/95pswHAEiCVJuXw0YgMN6lLVu+BBB
         udop3zuj7DNxshx1NTooTPJYQFuIxhLYZgNk7ctHR0K5Y3/CX9TYTABOQMoYbWiXaShS
         KEWUEX7J1h2pjkEsAoSWLYgHS41yn30OJbWIz+Y50z/sCpeOB5qivGKiZ++1OGkdtzTN
         xgVR6rlgpE41hHe99SnQfjJiUHOUa/4PNT+ognFJQhyeseQvWSehVzzDUDS/70BV0QyE
         Aw/lMGYaaZEgEdgdHneJj3ZLB05zTVulW+DCSNySNTgRnumMOl87HXPiNeOWcz43VmPl
         d6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712071167; x=1712675967;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8rzHYUvV7VuXeanyerj4KxdBd5NW4soBunYHKjk+mI=;
        b=qRWQg8r1LNX1hGoto6Gs/WTMLOIvlZC1narrBhC6oNEIihYo0xzBntrl4w8XfELpKM
         ri547pwKpRupEgzLIOVrTnc+z8OO++tKJQhE7cDr5HvkWi4pCZD1sKwGGaYM0MZ0ipub
         uR7Y2VVU7mpJyfPFwexAncBbyntWPfV1XUFHgeTD6vFkdrn3mJZ88zx1foIsElHbqAF9
         lipQtsmEcKK1sYdrpyEqU+n1U+3MOGRSO+mU0I7QwEvUAgZSN9dyBl9QvAkYDD1/t9aX
         acLVfEPiRIfGQdmoKCmULTMU55hZqcnWHztRuHR0rV6PPKaOuHM2eyj4tbqF3GlLLA8d
         lcQA==
X-Forwarded-Encrypted: i=1; AJvYcCU22yEIRo+xHWT1Icc/eijbA3Bysm46sCaYCw4dl+O5GK/Ap85bhPHlvVyu4ScbIvsPyr2Sbb9dPT+oT85fEn3OaD3Y
X-Gm-Message-State: AOJu0YxRyR97jAhKPUgquMjR0A8XDLpmuQecYkhyYo7CWOB91rN56TWB
	nz6mrSYgVS9yX3x0J6LktWnRJtpPUpgC2PFe/YWRexmIRE0/d8K/lPhZ8qQN
X-Google-Smtp-Source: AGHT+IG5hCk2bv9u30EiIVtYaqF/sUTjQmVz1SZOJBapjcsRcGEO+adC+Sl6pRQe1d8PZp3Dy4UdDA==
X-Received: by 2002:a05:6808:e82:b0:3c3:a682:df31 with SMTP id k2-20020a0568080e8200b003c3a682df31mr14762626oil.13.1712071167709;
        Tue, 02 Apr 2024 08:19:27 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i10-20020a54408a000000b003c3e3cdb1dasm2138616oii.17.2024.04.02.08.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:19:27 -0700 (PDT)
Message-ID: <8ca6644d-3555-4b93-8ce2-c3d7eeb4ee13@gmail.com>
Date: Tue, 2 Apr 2024 10:19:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dpp-util: move AAD logic within
 dpp_append_wrapped_attributes
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240327151957.1446149-1-prestwoj@gmail.com>
 <20240327151957.1446149-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240327151957.1446149-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/27/24 10:19, James Prestwood wrote:
> Leaving it up to the caller to calcluate the AAD resulted in lots of

typo, 'calculate'

> magic values, and any comments associated are spread out within
> dpp.c. The AAD values can be calculated entirely by the frame
> contents so move that within dpp_append_wrapped_data.
> 
> The caller now only needs to pass the frame (after the mpdu header),
> the length, and the offset to where the wrapped data should start.
> The new AAD calculation includes all relavent comments so magic

typo, 'relevant'

> offsets are documented.
> 
> The reason the entire mmpdu_body is not passed to
> dpp_append_wrapped_attributes (and one byte further) is to future
> proof for DPP encapsulation using TCP. For this, the category byte
> is omitted and only the action byte and further is encapsulated.
> Having dpp_append_wrapped_attributes start at the action byte
> allows it to work regardless of 8021x or TCP encapsulation.

Can you make the outer header its own iov?

> ---
>   src/dpp-util.c | 167 +++++++++++++++++++++++++++++++++++++++++++++----
>   src/dpp-util.h |   5 +-
>   src/dpp.c      |  99 +++++++++++++++++------------
>   3 files changed, 218 insertions(+), 53 deletions(-)
> 

<snip>

> +static bool dpp_aad(const uint8_t *frame, size_t frame_len, uint8_t *to,
> +			const uint8_t **ad0, size_t *ad0_len,
> +			const uint8_t **ad1, size_t *ad1_len)
> +{
> +	/* For PKEX frames */
> +	static uint8_t zero = 0;
> +	static uint8_t one = 1;

const?

> +	enum dpp_frame_type type;
> +	/* OUI field (inclusive) */
> +	const uint8_t *start = frame + 1;
> +
> +	if (frame_len < 6)
> +		return false;
> +
> +	type = l_get_u8(frame + 6);
> +
> +	switch (type) {
> +
> +	case DPP_FRAME_AUTHENTICATION_REQUEST:
> +	case DPP_FRAME_AUTHENTICATION_RESPONSE:
> +	case DPP_FRAME_AUTHENTICATION_CONFIRM:
> +	case DPP_FRAME_CONFIGURATION_RESULT:
> +		/*
> +		 * Section 6.3.1.4 Protocol Conventions
> +		 * All other invocations of AES-SIV in the DPP Authentication
> +		 * protocol shall pass a vector of AAD having two components of
> +		 * AAD in the following order:
> +		 *     (1) the DPP header, as defined in Table 34, from the OUI
> +		 *         field (inclusive) to the DPP Frame Type field
> +		 *         (inclusive); and
> +		 *     (2) all octets in a DPP Public Action frame after the DPP
> +		 *         Frame Type field up to and including the last octet
> +		 *         of the last attribute before the Wrapped Data
> +		 *         attribute
> +		 *
> +		 * Note: The configuration result frame uses identical wordage
> +		 *       but is in Section 6.4.1
> +		 */
> +		*ad0 = start;
> +		*ad0_len = DPP_HDR_LEN;
> +		*ad1 = start + DPP_HDR_LEN;
> +		*ad1_len = to - start - DPP_HDR_LEN;
> +		return true;
> +	case DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST:
> +		/*
> +		 * The AAD for this operation shall consist of two components:
> +		 *     (1) the DPP header, as defined in Table 34, from the OUI
> +		 *         field (inclusive) to the DPP Frame Type field
> +		 *         (inclusive); and
> +		 *     (2) a single octet of the value zero
> +		 */
> +		*ad0 = start;
> +		*ad0_len = DPP_HDR_LEN;
> +		*ad1 = &zero;
> +		*ad1_len = 1;
> +		return true;
> +	case DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE:
> +		/*
> +		 * The AAD for this operation shall consist of two components:
> +		 *     (1) the DPP header, as defined in Table 34, from the OUI
> +		 *         field (inclusive) to the DPP Frame Type field
> +		 *         (inclusive); and
> +		 *     (2) a single octet of the value one
> +		 */
> +		*ad0 = start;
> +		*ad0_len = DPP_HDR_LEN;
> +		*ad1 = &one;
> +		*ad1_len = 1;
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   /*
> - * Encrypt DPP attributes encapsulated in DPP wrapped data.
> - *
> - * ad0/ad0_len - frame specific AD0 component
> - * ad1/ad0_len - frame specific AD1 component
> - * to - buffer to encrypt data.
> - * to_len - size of 'to'
> + * frame - start of action frame (excluding mpdu header and category)
> + * frame_len - total frame buffer size

What does 'total' mean here?

> + * to - current position of DPP attributes (where wrapped data will start)
>    * key - key used to encrypt
>    * key_len - size of 'key'
>    * num_attrs - number of attributes listed (type, length, data triplets)
>    * ... - List of attributes, Type, Length, and data
>    */
> -size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len,
> -				const void *ad1, size_t ad1_len,
> -				uint8_t *to, size_t to_len,
> -				const void *key, size_t key_len,
> +size_t dpp_append_wrapped_data(const uint8_t *frame, size_t frame_len,
> +				uint8_t *to, const void *key, size_t key_len,

Why do you drop the to_len parameter?

>   				size_t num_attrs, ...)
>   {
>   	size_t i;
> @@ -488,6 +562,77 @@ size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len,
>   	struct iovec ad[2];
>   	size_t ad_size = 0;
>   	va_list va;
> +	uint8_t action;
> +	const uint8_t *ad0 = NULL;
> +	const uint8_t *ad1 = NULL;
> +	size_t ad0_len, ad1_len;
> +
> +	/*
> +	 * First determine the frame type. This could be passed in but due to
> +	 * The config protocol using GAS request/response frames not all frames
> +	 * map to a dpp_frame_type enum. Due to this, minimal parsing is done
> +	 * on the frame to determine the type, and in turn the AAD
> +	 * offsets/lengths.
> +	 */
> +	if (frame_len < 1)
> +		return 0;

This seems suspicious.  Should the error return type be ssize_t and should this 
be returning a -errno?

> +
> +	action = *frame;
> +
> +	switch (action) {
> +	case DPP_ACTION_VENDOR_SPECIFIC:
> +		if (!dpp_aad(frame, frame_len, to, &ad0, &ad0_len,
> +				&ad1, &ad1_len))
> +			return 0;
> +
> +		break;
> +	/*
> +	 * Section 6.4.1 Overview
> +	 *
> +	 * "AAD for use with AES-SIV for protected messages in the DPP
> +	 * Configuration protocol shall consist of all octets in the
> +	 * Query Request and Query Response fields up to the first octet
> +	 * of the Wrapped Data attribute, which is the last attribute in a DPP
> +	 * Configuration frame. When the number of octets of AAD is zero, the
> +	 * number of components of AAD passed to AES-SIV is zero
> +	 */
> +	case DPP_ACTION_GAS_REQUEST:
> +		/*
> +		 * 8.3.2 DPP Configuration Request frame
> +		 * The attributes begin 14 bytes after the action (inclusive)
> +		 */
> +		if (frame_len < 14)
> +			return 0;
> +
> +		/* Start of query request */
> +		ad0 = frame + 14;
> +		/* "up to the first octet of the Wrapped Data attribute" */
> +		ad0_len = to - frame - 14;
> +
> +		if (!ad0_len)
> +			ad0 = NULL;
> +
> +		break;
> +	case DPP_ACTION_GAS_RESPONSE:
> +		/*
> +		 * 8.3.3 DPP Configuration Response frame
> +		 * The attributes begin 18 bytes after the action (inclusive)
> +		 */
> +		if (frame_len < 18)
> +			return 0;
> +
> +		/* Start of query response */
> +		ad0 = frame + 18;
> +		/* "up to the first octet of the Wrapped Data attribute" */
> +		ad0_len = to - frame - 18;
> +
> +		if (!ad0_len)
> +			ad0 = NULL;
> +
> +		break;
> +	default:
> +		return 0;
> +	}
>   
>   	va_start(va, num_attrs);
>   

<snip>

> @@ -758,6 +758,9 @@ static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
>   	size_t json_len = strlen(json);
>   	uint8_t *ptr = frame;
>   	uint8_t *lptr;
> +	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
> +
> +	memset(frame, 0, sizeof(frame));

No explanation as to why this is needed?

>   
>   	l_getrandom(&dpp->diag_token, 1);
>   

Regards,
-Denis
