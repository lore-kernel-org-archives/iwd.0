Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30F12AADD
	for <iwd@lists.linux.dev>; Tue,  2 Apr 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070606; cv=none; b=aDLmL74ILT7+jSyLvUTavuHgU3Y0flyGec59vUDXU6bP+VgiwuWvWu2gY+oOUl/dJ4kGzRep8dGfT3P1kXCWVSm/sYR3/k3OugcU43psTwpqfy4FlnM5HwaJf8oqOcl+CNLPWOQ1h73tYW4Ne3c/dHFIwUiA6VEI6ZuQdPw8yes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070606; c=relaxed/simple;
	bh=a/nIr1FLOdYgln1nA04DKnOj66AbsBz3C9PsoXRtRDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rX4bmtKBi1jog37l5FOcotsMx6XmquT9Q+izCbZNl7k21JTp9LKiGwBdnMOZ/9hVi9Kt/wmvbMgEGEF49ihkylYCXqolZpe5w4Qfy7bMfhYkeaeofvpPFqN1iuyPDF3g+giem+3AkNd08XHl5ipwx7wYi7+puQ07O69Tkv8Bzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRR3OuV8; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRR3OuV8"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22e6b61d652so391925fac.0
        for <iwd@lists.linux.dev>; Tue, 02 Apr 2024 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712070603; x=1712675403; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT/7nSLLXNMotBuFv2AHKMFLApZq6vciR1NhGPrp37g=;
        b=ZRR3OuV8Ko4LByO91hBwhvEo7zBKUfz5ab7gfG1RBtY7ak6PKznj8rB8srDTINQXMU
         N66d0rHpDGvvGyb/95N4kD8/O3dkXaajNSbZicC55cs9PN0wna1vuj+/fI8I431FUDkR
         VKvmm+1LYXCb1wdRads7PppuXKDD2Pfo0WASoft2lPxY9yl6Qrw4RIUQcAQKjKMuUjnC
         4x14YgTRZTKPkdZ7v6tL4Z82UlXpcvvjEtqbz8nTac2W57Z3zDkZKVS3qSh7rVpsWRSJ
         doYpOm2C9rl5zQCc/46F5lPcp75KKl8L+wFUbO6A3NbKhT3BOleh9/Die8neycapyrc+
         xN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712070603; x=1712675403;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT/7nSLLXNMotBuFv2AHKMFLApZq6vciR1NhGPrp37g=;
        b=Sco4YNNv7m5kS3gF1fpS+QBaOD7oC9YDcP6csSQYN5QbGKGQu8xShe5lcymMoMT8L9
         uQgE3vbrzNX/xeh/G1NDVigsCDSXoK8bBkaipzun192oF/uSTx1kWMNMKJjzfmSgoWmq
         nx58oBIFjjXE2SOuihUyP1kSFNlu3XYCGUzZMt44wT5gIHQ1IHwKpBT6xe2d0I70gQb0
         Tx9QH9ceEWAiLnWkemTB2vUgKDVPjwD3tEqoTwzzcZatY2GKqxsEq7TvUsEK0flM2Vep
         ji8wVc/l7rUp70P9mKfLDLOWtXCGhINkrrhM0+e110lEN0KNd/1vruo2wnTaOXJHULQk
         g10g==
X-Forwarded-Encrypted: i=1; AJvYcCXM/T71TdtGXU05rTrAjqFNzD/p3oW2FZC3cOMAqkJNN0w4kTxKfu5ZkGpETu36NpycbRLhG6x96KmWEdyEAtABQyXr
X-Gm-Message-State: AOJu0YzzNmZgBAas/pzRtHQT7lI/tUvtqtKLDe/ZuzK+3CZu/fRQMiQ8
	xpjiXCmuGjp6mvPqScVmZc+JNh7PeFvQdv9F+JCt9I+aAIOqkMr7/D/1f5d3
X-Google-Smtp-Source: AGHT+IFdRjiwWEYki9momtDbwU3j/LM5iaCcCeKs8gdB4k2inB9f7Akz9zvR3bupaRwFrdk0u8l69w==
X-Received: by 2002:a05:6870:42:b0:22a:8443:45bb with SMTP id 2-20020a056870004200b0022a844345bbmr9214590oaz.47.1712070603399;
        Tue, 02 Apr 2024 08:10:03 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y25-20020a056830109900b006e6faef4a6esm2314227oto.69.2024.04.02.08.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:10:03 -0700 (PDT)
Message-ID: <ebcfd870-b9a2-4215-b652-3008d3d2b6b7@gmail.com>
Date: Tue, 2 Apr 2024 10:10:01 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dpp: prep for moving AAD within
 dpp_append_wrapped_data
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240327151957.1446149-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240327151957.1446149-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/27/24 10:19, James Prestwood wrote:
> The AAD pointers for DPP are specific to the frame type. This is
> currently sorted out by the caller within the respective frame
> building functions but its quite unreadable. There are some comments
> but lots of magic numbers. This should be moved within the
> dpp_append_wrapped_data utility but the first step is to make the
> frame buffer continuous. This will allow the entire frame to be

continuous -> contiguous?

> passed and dpp_append_wrapped_data can calculate the AAD offsets
> itself.

I'm a bit confused as to why?  Whether we have an iov or a contiguous buffer, 
the end result is the same, no?  If you want to omit parts of the header from 
the wrapped data calculation, wouldn't you just break up the header into 
multiple iovs instead?

> ---
>   src/dpp.c | 239 +++++++++++++++++++++++++-----------------------------
>   1 file changed, 112 insertions(+), 127 deletions(-)
> 

<snip>

> diff --git a/src/dpp.c b/src/dpp.c
> index 567fe8d2..5aac22a7 100644
> --- a/src/dpp.c
> +++ b/src/dpp.c
> @@ -648,7 +648,7 @@ static void dpp_frame_retry(struct dpp_sm *dpp)
>   
>   static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
>   				enum dpp_frame_type type,
> -				uint8_t buf[static 32])
> +				uint8_t *buf)

Is this really needed?

>   {
>   	uint8_t *ptr = buf + 24;
>   
> @@ -672,7 +672,7 @@ static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
>   
>   static size_t dpp_build_config_header(const uint8_t *src, const uint8_t *dest,
>   					uint8_t diag_token,
> -					uint8_t buf[static 37])
> +					uint8_t *buf)

Or this?

>   {
>   	uint8_t *ptr = buf + 24;
>   

<snip>

> @@ -780,42 +779,39 @@ static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
>   	 * In this case there is no query request/response fields, nor any
>   	 * attributes besides wrapped data meaning zero AD components.
>   	 */
> -	ptr += dpp_append_wrapped_data(NULL, 0, NULL, 0, ptr, sizeof(attrs),
> +	ptr += dpp_append_wrapped_data(NULL, 0, NULL, 0, ptr, sizeof(frame),

The sizeof(frame) is now likely wrong in this setup.  No error checking also 
worries me a bit.

<snip>

>   static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
>   {
> -	uint8_t hdr[32];
> -	struct iovec iov[2];
> -	uint8_t attrs[256];
> -	uint8_t *ptr = attrs;
> +	struct iovec iov;
> +	uint8_t frame[256];
> +	uint8_t *ptr = frame;
>   	uint8_t zero = 0;
>   
> -	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev), to,
> -					DPP_FRAME_CONFIGURATION_RESULT, hdr);
> -	iov[0].iov_base = hdr;
> -
> -	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, 0, ptr,
> -			sizeof(attrs), dpp->ke, dpp->key_len, 2,
> +	ptr += dpp_build_header(netdev_get_address(dpp->netdev), to,
> +					DPP_FRAME_CONFIGURATION_RESULT, ptr);
> +	ptr += dpp_append_wrapped_data(frame + 26, 6, ptr, 0, ptr,
> +			sizeof(frame), dpp->ke, dpp->key_len, 2,

Same comment here

>   			DPP_ATTR_STATUS, (size_t) 1, &zero,
>   			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce);
>   
> -	iov[1].iov_base = attrs;
> -	iov[1].iov_len = ptr - attrs;
> +	iov.iov_base = frame;
> +	iov.iov_len = ptr - frame;
>   
> -	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
> +	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
>   }
>   
>   static void dpp_write_config(struct dpp_configuration *config,

<snip>

> @@ -1211,26 +1205,26 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
>   		json = dpp_configuration_to_json(dpp->config);
>   		json_len = strlen(json);
>   
> -		ptr += dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
> -						NULL, 0, ptr, sizeof(attrs),
> +		ptr += dpp_append_wrapped_data(lptr + 2, ptr - lptr - 2,
> +						NULL, 0, ptr, sizeof(frame),

Is sizeof(frame) correct here?

>   						dpp->ke, dpp->key_len, 2,
>   						DPP_ATTR_ENROLLEE_NONCE,
>   						dpp->nonce_len, dpp->e_nonce,
>   						DPP_ATTR_CONFIGURATION_OBJECT,
>   						json_len, json);
>   	} else
> -		ptr += dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
> -						NULL, 0, ptr, sizeof(attrs),
> +		ptr += dpp_append_wrapped_data(lptr + 2, ptr - lptr - 2,
> +						NULL, 0, ptr, sizeof(frame),

and here?

>   						dpp->ke, dpp->key_len, 2,
>   						DPP_ATTR_ENROLLEE_NONCE,
>   						dpp->nonce_len, dpp->e_nonce);
>   
> -	l_put_le16(ptr - attrs - 2, attrs);
> +	l_put_le16(ptr - lptr - 2, lptr);
>   
> -	iov[1].iov_base = attrs;
> -	iov[1].iov_len = ptr - attrs;
> +	iov.iov_base = frame;
> +	iov.iov_len = ptr - frame;
>   
> -	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
> +	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
>   }
>   
>   static bool dpp_check_config_header(const uint8_t *ptr)

<snip>

Regards,
-Denis
