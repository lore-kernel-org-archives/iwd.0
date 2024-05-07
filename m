Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC815F414
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094722; cv=none; b=MbF6z5rhg+r11xSBpIrdP8BuD9pHMBYcuGZw+l3MuCadiUfb8gxA9WCdk9ZM8wg7hxJCv+sHozJEKyYZ4OHyT6/SOfOyk+YpN74/gSpqWWvqVtJo1X6QvJjPFUiQhvju114ENEf3ZbC+bTfmsqO1Z+pWdxPOH8pFaLFOGl2jErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094722; c=relaxed/simple;
	bh=7+L9Lv82Mty3NETGPTOMveDYqBrbbW4g1I+S7gWuBhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=clDRFUAH+okwb3EhA6ddE1e2Mkxy1amIhES9OjpTIb+WJ2BpOpE2clCXLd75vkjJRjEq/4XeUvS8T5GJgmw9ZMpBIK8mkcyWp5uIHbN5EX27rs6oRimr9FWZSX9do2HEs2QtdSEyE9Tdb1uRsFNfZFagvvtR4LcEM22ZER3ohI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8p5vmHr; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8p5vmHr"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c974a0647bso1005348b6e.2
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715094720; x=1715699520; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfmS4GYwMDoZxTm5Xm/9YNc2xG7Kb4bHfxBOrnhxVkc=;
        b=g8p5vmHrkH6cMSF7ba3NjUQBmRJiinA5Dg7jAa7m5NP1EdIKzJn88CRiyE5tyA8GcQ
         C+2slH7zgI6SlRFbMrhV69v3/hXC8nB7jNBXy5iUKACXRhj4CY6kWYNQWvT2vIxYBLuP
         L+4Wyh+Rr540tHi7yEd1yAgTrkIZPS0xMmzNCStHTbTXQWZQmHlFkoHAxmhhMY8DtN8T
         LktnbZFXTc+kCZZRQnmexbSBvRY0G+cUlApSAmWx1jr90jfcNsDKuEGLCMoM+ByvkHZu
         HZWbLeAh2gztJwlMbQ++jY+SbDyGIQdIY5zM/SigwuGgPa/ca0B/dW0QklZciPOedlWd
         6b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094720; x=1715699520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfmS4GYwMDoZxTm5Xm/9YNc2xG7Kb4bHfxBOrnhxVkc=;
        b=VA0DMkNMpEI6rlefmEq5+mzPMM7yJRTRF56WgarYPH3DdjOM27AQ0d+9612/VV4clJ
         BnL3Vi0krpb/BFr2RE6rNBPmPj1Wib/FJ/AtKtZlxelJBALPG/dfWzwDR/5o6IGMKSSf
         8Yt0pYyR1rUNw2h+EMPI5viIFeBEOVwS6bL8q2BP/73eaS1+69BOu9uo+g1HdJSwf1vR
         uy2gmAEnTBuCKL0lw2pIFlWJQTId3ZeJBMky8D0LyCWyqcwq67yjYeB13VR6eqZ0YeuJ
         c9uNwNoqcwvl46im1c7PG98Rz2qY/CPt7YFNX0izyP/WIDTWqZIaGY3pGasDylcelUVS
         avrA==
X-Forwarded-Encrypted: i=1; AJvYcCWpkhSi0V41V8l1UI6E9Lt+ZTocgRuQAesSyycnLEWg1KvxV9Pzr3yBQqqwN6dJCuRim887N2OU68JkruPNrn6FGH4h
X-Gm-Message-State: AOJu0YzewKWGQkwXQ42B1rgW6kyfnmDd2acs02Y0U9JX/1DU7z3Xk0HC
	QA4ObAsy00U1ZVKp2suUecdSIKHf1fgWwus3s3tVq041jwdq6QfZMXwfBg==
X-Google-Smtp-Source: AGHT+IF0Ay53PGOjZWZjZ58NqhEzPVnxaJEbzcFR4aGVIqklvwycNnznS1HTdZMmkEm15pwRGTStVw==
X-Received: by 2002:a05:6830:ecb:b0:6ee:6eff:ff4e with SMTP id dq11-20020a0568300ecb00b006ee6effff4emr13682610otb.22.1715094720442;
        Tue, 07 May 2024 08:12:00 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ec4-20020a0568306e0400b006eb7e17aac5sm2499919otb.73.2024.05.07.08.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:12:00 -0700 (PDT)
Message-ID: <a7cdf7c2-a787-4dd2-8e57-677a8334575a@gmail.com>
Date: Tue, 7 May 2024 10:11:59 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] sae: verify offered group in AP mode
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-8-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-8-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> When receiving a Commit frame in AP mode, first verify that we support
> the offered group before further processing the frame.
> ---
>   src/sae.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sae.c b/src/sae.c
> index 7ba9b0eb..7405a561 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -216,6 +216,18 @@ static int sae_valid_group(struct sae_sm *sm, unsigned int group)
>   	return -ENOENT;
>   }
>   
> +static int sae_supported_group(struct sae_sm *sm, unsigned int group)
> +{
> +	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();
> +	unsigned int i;
> +
> +	for (i = 0; ecc_groups[i]; i++)
> +		if (ecc_groups[i] == group)
> +			return true;

Function declared as returning int, but you're returning true/false here.

> +
> +	return false;
> +}
> +
>   static bool sae_pwd_seed(const uint8_t *addr1, const uint8_t *addr2,
>   				uint8_t *base, size_t base_len,
>   				uint8_t counter, uint8_t *out)
> @@ -1053,7 +1065,8 @@ static int sae_verify_nothing(struct sae_sm *sm, uint16_t transaction,
>   		return -EBADMSG;
>   
>   	/* reject with unsupported group */
> -	if (l_get_le16(frame) != sm->group)
> +	if ((sm->handshake->authenticator && sae_supported_group(sm, l_get_le16(frame)) < 0) ||

nit: We still use 80 column lines.  This line is way too long.

Also, this if condition will never be true due to sae_supported_group returning 
true/false.

> +	    (!sm->handshake->authenticator && l_get_le16(frame) != sm->group))
>   		return sae_reject(sm, SAE_STATE_COMMITTED,
>   				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
>   

Regards,
-Denis
