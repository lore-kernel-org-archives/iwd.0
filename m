Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F015AD9A
	for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960530; cv=none; b=RuDpTTM4pDC3ybHGGt5Y5viHxMTuR33sMOBDzyb4mWC/TUij/vPPMDNtMCB4q2EzUJTgSTNpwnBq8LNpKUWeRbDyeJNzKaqbmKGLuVOacg5zNPHPmbO+0p9fKW+GQ0rMZhB9AH089lurcdYLpLtYdd65XfbHO6QL75iHjF+6lyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960530; c=relaxed/simple;
	bh=KiOdXEvzJhIkOooxJp+5+rtYPdnG6yO3vDCR1eVgt5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j58sH20d+oo2oO22Edq0y9ak1uOAq+Hzs2/IylaLJK7xYD2mHZmJ74gR4X+KJB7AosIRHoRgR1l2/Bpz7d2Z7uDzUfZzOYt4JLouWiDuzaZR6NJrF5IQ57IUJUbOB1ZmCjwiSNNhRN+4e25HOW8UaFdM3J8fbTpwNn9QoBFH7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV6D9v+W; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV6D9v+W"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a06b12027cso7373616d6.0
        for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713960528; x=1714565328; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGhUsa+vksEzPGECeWuYKwk6kLL2R9F6JqQRLvHtx6k=;
        b=bV6D9v+WkHPQUTyowutHLAFg0CVvzAZuv7A7KvU7QMbc+Lk9T3xeqwFtYiJr4P11wQ
         AeOERcdfwHatmrcnjgnqJw9jkT5EcRfeXLZrOHTaKAsgCVymdNjRodypr7AX9flj3wRo
         kvVWqfXKl8HZl51s5OW9npZQL6m75aftfY5koql2ItpJQmb7v8GJ4D+0TxShH7FTrpP6
         o9c8ZvPFpkT5B7QO12duRV+43SFmz2Iphae6kV6TyP/xXKUoDN3rbJAUbUfYzFPRf3qV
         mIoiePPc/So13Ncz44vHgqhnxVhQmmrGNg8hvKW43ojkTv3G9aW9yYiOE5LMSZ2/bU2t
         v8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960528; x=1714565328;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGhUsa+vksEzPGECeWuYKwk6kLL2R9F6JqQRLvHtx6k=;
        b=q7BVZSh1i9aCcaDTbzZh0vPMkX8RNol3MOp6XEVvcqrjt28iDzy3qZvO7aC8tiWX3h
         k4PLF6JDjOr7vXkh9CtX5N3/OcTljJEZRjwGF4P2i77B50FY6I6kJ3KGXT2jVvM6lBEZ
         /eHsCpq7nwC5rB+AQMtCmUFEoWQ7IGrbFMI8cOev1Uvfu+1/YSlSNmwmlvjujLbF5bpr
         8pF297OmcrfxgK+1Je2HIrn3SYGN76RoVlQICXuO7Am7fMP4hTgTusoXeLQ2P3l/+wPP
         zC0HskRc56u0O5x1sOJ4p0FdEYwD8ImUEaZjtBFAy+fkg6n2nBdeQbkN4PvwJnufm0ij
         E9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX0/57ELr5S0WzIQF5Wg3MFE6q3kyXSAHI5K8SGQxcisEUZyFzZVopXqVW85WPD5Iei6WsWTP+aXfqpkCJTsWWWo4/v
X-Gm-Message-State: AOJu0YwXXVlOFbp96I4e3I8EO1qjGaWN2xMYAYewnlCntBOAX6KR9lWK
	2c95aZ18TqMLAMD/4MPUAsfeznVxog1Xu/Ulli91m02G6o0HcXJUulnBAQ==
X-Google-Smtp-Source: AGHT+IFoHVJwFhyoNq+tNazxIYjaGpa2aysImohkJP8gYzhxP0yEt0oZDhcc4dcw+tnZESeMeyf+9Q==
X-Received: by 2002:a05:6214:841:b0:69f:74f7:a96a with SMTP id dg1-20020a056214084100b0069f74f7a96amr3548853qvb.11.1713960528127;
        Wed, 24 Apr 2024 05:08:48 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r15-20020a0c8d0f000000b006a045780b77sm3393748qvb.51.2024.04.24.05.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:08:47 -0700 (PDT)
Message-ID: <e049836d-04cf-47db-82ea-a19997af8c46@gmail.com>
Date: Wed, 24 Apr 2024 05:08:47 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] sae: support reception of Confirm frame by AP
Content-Language: en-US
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <20240421125050.6649-8-brandtwjohn@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240421125050.6649-8-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 4/21/24 5:50 AM, John Brandt wrote:
> Experimental AP-mode support for receiving a Confirm frame when in the
> COMMITTED state. The AP will reply with a Confirm frame.
>
> Note that when acting as an AP, on reception of a Commit frame, the AP
> only replies with a Commit frame. The protocols allows to also already
> send the Confirm frame, but older clients may not support simultaneously
> receiving a Commit and Confirm frame.
Could we add some basic unit tests. Mainly just sanity checks that the 
message flow works as expected with handshake->authenticator set.
> ---
>   src/sae.c | 38 +++++++++++++++++++++++++-------------
>   1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/src/sae.c b/src/sae.c
> index 8a1e311a..da55c764 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -906,9 +906,13 @@ static int sae_process_confirm(struct sae_sm *sm, const uint8_t *from,
>   
>   	sm->state = SAE_STATE_ACCEPTED;
>   
> -	sae_debug("Sending Associate to "MAC, MAC_STR(sm->handshake->aa));
> -
> -	sm->tx_assoc(sm->user_data);
> +	if (!sm->handshake->authenticator) {
> +		sae_debug("Sending Associate to "MAC, MAC_STR(sm->handshake->aa));
> +		sm->tx_assoc(sm->user_data);
> +	} else {
> +		if (!sae_send_confirm(sm))
> +			return -EPROTO;
> +	}
>   
>   	return 0;
>   }
> @@ -1059,16 +1063,24 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
>   	unsigned int skip;
>   	struct ie_tlv_iter iter;
>   
> -	/*
> -	 * Upon receipt of a Con event...
> -	 * Then the protocol instance checks the value of Sync. If it
> -	 * is greater than dot11RSNASAESync, the protocol instance shall send a
> -	 * Del event to the parent process and transition back to Nothing state.
> -	 * If Sync is not greater than dot11RSNASAESync, the protocol instance
> -	 * shall increment Sync, transmit the last SAE Commit message sent to
> -	 * the peer...
> -	 */
> -	if (transaction == SAE_STATE_CONFIRMED) {
> +	if (sm->handshake->authenticator && transaction == SAE_STATE_CONFIRMED) {
> +		/*
> +		 * TODO: Sanity-check received Confirm frame from the client. For now
> +		 * AP-mode SAE support is experimental and we simply accept the frame.
> +		 * Note that the cryptographic confirm field value will still be checked
> +		 * before replying with a Confirm frame.
> +		 */
> +		return 0;
> +	} else if (transaction == SAE_STATE_CONFIRMED) {
> +		/*
> +		 * Upon receipt of a Con event...
> +		 * Then the protocol instance checks the value of Sync. If it
> +		 * is greater than dot11RSNASAESync, the protocol instance shall send a
> +		 * Del event to the parent process and transition back to Nothing state.
> +		 * If Sync is not greater than dot11RSNASAESync, the protocol instance
> +		 * shall increment Sync, transmit the last SAE Commit message sent to
> +		 * the peer...
> +		 */
>   		if (sm->sync > SAE_SYNC_MAX)
>   			return -ETIMEDOUT;
>   
