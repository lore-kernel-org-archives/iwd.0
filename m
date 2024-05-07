Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9415F30F
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096656; cv=none; b=PD70iIz5SIc9S/cnMEkY3G/hS81KsL7wNsaaUDWcgIdbV+MzUi+sf+S7IYrRZZLxPQ9q4VtvGJuYAn1OzXdCnZyiOSh4KdrDqk+3pdTHhQOf6jxNtcZOZtuYgn7F1xh1c2IEVntWgKoqFER2C4r4jvcZ2CksCAB28VU3pxYneCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096656; c=relaxed/simple;
	bh=6+LIU97D57sC7w7PS3yuOlZgIB1ZTYJT1MFtdK5Y6tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C0jwlhoFyJnARJm/2UKaT3am9YJVZ6ndmDNoNCg5L86YU9exmuIEW2cs+vP8J38udTAj5BM8O5C6p9SNhj8+ptJ9LWzKob9w0hjh9N2Xc6gRnOWxoJk29cBA3uxEa6gNmfFBXNt833rdLGPUqvUAxq+zJSMYsQ4HmSwEEsIQgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW3G1XQr; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW3G1XQr"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ac90ad396dso1940279eaf.3
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715096653; x=1715701453; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yo36KEkDyqziRdvwcAWUvn2c90F+NeopogRc/YwwSrM=;
        b=PW3G1XQry9YLe+kB/0gjxZk+xefSFroxgJfus78lDw7027H/NSnPSaYYMSJWyaCsne
         FlucBVoB0MHOERKJWBc/b1LbmxoEQO7jm3XzZwlL5FIML+2VW55mLNhDGdCb3elxTnP3
         aLVAVjMOLi3jG8qqjOFDHQRMZLlIygr0CXUZIATH7ZR+aLQOWWil1ahGpsK7iMPFuyNf
         +xomWgHbybqhrsq9XIB56Sod/Ns9R+gi9e87tmjPbc7qkHVyp6W1j6D58FE3pUErHGs3
         xJspYEb7laTdPgGh+Kr+uSqZi1EIACNyriFU1CsPPRF8/PIH1fsD5qNvLvoNrgb8lZ1q
         x9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096653; x=1715701453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yo36KEkDyqziRdvwcAWUvn2c90F+NeopogRc/YwwSrM=;
        b=pVqiER8nYJPiCqUeRk/LlH6XZ3lXaLYTAwGc0AFmpS/liLto1fV74V7Eq6g7bmOZt0
         BzNHa220ZSoHuGi6SF+ZdINNMCgjUXblwHX4dQhTKsi/36pk3+6nU5Gjx3jUOTH337Ku
         pFwaib6n+HbeqgXvSBKC7wNZs3By7epeQ+egoYo6Ov8luCrwxTtIbVMaWnkD/mlAuHFd
         ni5FLE+D2+Y6JJZouY0DhfU8U5+NXaE+wIjT1ONKS6zgCmP0qwd2vrhIOw9975NgFGKE
         E6qXgqMWpA4F28uk1Rh70nmuvizl4qOmvw4migcAqhOeuWUePHAwIbJo+/YMYCIylN6t
         R+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJKcpiqo+Ls2G/Cw30gxMk0HkTDmT2OZV7K9TPetaOnRjmMcpcDpI1BKtpjTODjHQ3P9kZ7xYzEdr2IVC1qph00z+p
X-Gm-Message-State: AOJu0YwBMCBZpHYjjMvWpp4VbNH/8BJm/1o8pHQ3rgtwfl6kdVR3e0dj
	dIv0YXB7wn+gcZLnU+xS8wC6yJm4DsKuejeo/9PxpkaUqx5nHseeb8BaeA==
X-Google-Smtp-Source: AGHT+IFuyQyhT+4Y/CFgryLiMjUCIHpQl9CsbEPZjRiomnMuYIXVhwYWCyMIFsC50RbUuIfXJ2e0hg==
X-Received: by 2002:a05:6870:214f:b0:23c:c9bf:8316 with SMTP id g15-20020a056870214f00b0023cc9bf8316mr16267704oae.23.1715096653597;
        Tue, 07 May 2024 08:44:13 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id eb4-20020a0568306dc400b006eb7a3ae6b1sm2515544otb.67.2024.05.07.08.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:44:13 -0700 (PDT)
Message-ID: <1757c8ee-4228-4082-8609-f2920317eafc@gmail.com>
Date: Tue, 7 May 2024 10:44:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] ap: add support to handle SAE authentication
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-10-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-10-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> When the client requests SAE authentication, and it is enabled, allocate
> an auth_proto instance to handle SAE authentication. This also adds a
> new function to send SAE frames in AP mode that can be used by the
> auth_proto instance.
> ---
>   src/ap.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 58 insertions(+), 9 deletions(-)
> 

<snip>

> @@ -2595,6 +2598,38 @@ static void ap_auth_reply(struct ap_state *ap, const uint8_t *dest,
>   				ap_auth_reply_cb, NULL);
>   }
>   
> +static void sae_auth_reply(const uint8_t *data, size_t len, void *user_data)
> +{
> +	struct sta_state *sta = (struct sta_state *)user_data;
> +	struct ap_state *ap = (struct ap_state *)sta->ap;

This cast isn't needed?

> +	const uint8_t *addr = netdev_get_address(ap->netdev);
> +	uint8_t sae_buf[512];
> +	struct mmpdu_header *mpdu = (struct mmpdu_header *) sae_buf;
> +	struct mmpdu_authentication *auth;
> +
> +	if (L_WARN_ON(26 + len > sizeof(sae_buf)))
> +		return;
> +
> +	memset(mpdu, 0, sizeof(*mpdu));
> +
> +	/* Header */
> +	mpdu->fc.protocol_version = 0;
> +	mpdu->fc.type = MPDU_TYPE_MANAGEMENT;
> +	mpdu->fc.subtype = MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION;
> +	memcpy(mpdu->address_1, sta->addr, 6);	/* DA */
> +	memcpy(mpdu->address_2, addr, 6);	/* SA */
> +	memcpy(mpdu->address_3, addr, 6);	/* BSSID */
> +
> +	/* Authentication body */
> +	auth = (void *) mmpdu_body(mpdu);
> +	auth->algorithm = L_CPU_TO_LE16(MMPDU_AUTH_ALGO_SAE);
> +
> +	/* SAE elements */
> +	memcpy(sae_buf + 26, data, len);
> +	ap_send_mgmt_frame(ap, mpdu, 26 + len,
> +				ap_auth_reply_cb, NULL);
> +}
> +
>   /*
>    * 802.11-2016 9.3.3.12 (frame format), 802.11-2016 11.3.4.3 and
>    * 802.11-2016 12.3.3.2 (MLME/SME)

<snip>

> @@ -2680,18 +2715,32 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
>   		ap->sta_states = l_queue_new();
>   
>   	sta->akm_suite = akm_suite;
> +	if (sta->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256) {
> +		sta->hs = netdev_handshake_state_new(sta->ap->netdev);
> +		handshake_state_set_authenticator(sta->hs, true);
> +		handshake_state_set_passphrase(sta->hs, ap->passphrase);
> +		handshake_state_set_supplicant_address(sta->hs, sta->addr);
> +		handshake_state_set_authenticator_address(sta->hs, bssid);
> +
> +		sta->auth_proto = sae_sm_new(sta->hs, sae_auth_reply, NULL, sta);
> +	}
>   
>   	l_queue_push_tail(ap->sta_states, sta);
>   
> -	/*
> -	 * Nothing to do here netlink-wise as we can't receive any data
> -	 * frames until after association anyway.  We do need to add a
> -	 * timeout for the authentication and possibly the kernel could
> -	 * handle that if we registered the STA with NEW_STATION now (TODO)
> -	 */
>   
> -done:
> -	ap_auth_reply(ap, from, 0);
> +have_sta:
> +	if (sta->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256) {
> +		auth_proto_rx_authenticate(sta->auth_proto, (const uint8_t *)hdr,
> +					   body + body_len - (void *) hdr);

nit: This line is also > 80 chars.

To be more future proof, maybe:

if (sta->auth_proto) {
	auth_proto_rx_authenticate(...);
	return;
}

/* comment */
ap_auth_reply(...);

> +	} else {
> +		/*
> +		 * Nothing to do here netlink-wise as we can't receive any data
> +		 * frames until after association anyway.  We do need to add a
> +		 * timeout for the authentication and possibly the kernel could
> +		 * handle that if we registered the STA with NEW_STATION now (TODO)
> +		 */
> +		ap_auth_reply(ap, from, 0);
> +	}
>   }
>   
>   /* 802.11-2016 9.3.3.13 (frame format), 802.11-2016 11.3.4.5 (MLME/SME) */

Regards,
-Denis
