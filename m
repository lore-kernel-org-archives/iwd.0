Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2515A4B0
	for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960373; cv=none; b=IMMSpVGf9y01YRE5SVehpRSBQrMQ2aswtPTYXlJB+HvR3r+cp/k8cYaZHn43jdBVfgqu+mStd09/63jNlcirnWjav3fTqSndIkcLZPyDoEDYDnIGi23rkg6gMAUUAXr1iodyJsNthkkJP2a6/PgqVIhjVKo9lHC++EKzEoyiVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960373; c=relaxed/simple;
	bh=pDY5LSXKwpL8zlRghVe9CY3w4MVkd6nn9WbbI13c55E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WCTPQSeF/TorFxNTixz6+8G2+6eGSqGpdFjvK0TBKFHGrqZqAZeDtclBSV+VBQJxPE2X8tFBVzC/dgHSdz+AZ73jq9utzGUEbJGsXArmJMLPrY7ZeqMw0OVMRVfodpuja+PiAEDjeqL7W3FWyO5G9WfEj/H1zuznz1RrkfXqw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq6xkCqE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq6xkCqE"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78f03917484so462748585a.3
        for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713960371; x=1714565171; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxfxxxAOF0yzFbMvUoe4cwxC7xXVXSEB9S+dmknPLNY=;
        b=kq6xkCqEoF9a7NAirMW3Q6LM30UNednWIMRaf70SWdBXU201b5X0vmXGac5UnpxYDP
         JI/aHgSFXaIyDjeEvRpRc6HpmRsVmx/OBxnvtgnvLTNTWZbwS8zRgRI4x8H+UzwAGZs4
         AttRsJNpqodO/xYcLLCwarfohdOrC/TwLnwQaytEjPnmeI2JvOEKB/wxZyhP0yw5d/K5
         rBDXkf23PgcRTexL1SmMqhNjD7nn8Z4CziNSLZzVeG/TS9H+xQwheBFd63jMnZSADDVb
         wGzjka6kVPjFKktet7T+ztDTfepHx4c6OgFhNjZLdjeWUwxJJRHQ6oVT3zmvhDD/aJlu
         DIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960371; x=1714565171;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxfxxxAOF0yzFbMvUoe4cwxC7xXVXSEB9S+dmknPLNY=;
        b=iucFB3fgVaRD11DsU166hpaDiC1dcAyMGzgywAdaE1qFUZndUtie+8MSGVE65VzLu6
         eLenaJBu4jb+g6aFDwu/4OezlQtM6Er2IWvvnDsSY15cNjRsTG5wLQYRe3BlVJnV03bH
         xOGUQNVfNp1X9gQlKcZfYgFU98e/VIMvuEYZNWaoUqcnkuwTaqSqMkqkoeoYaq0Z0Xv5
         VKq6IvMpj4MoqWLZB80+ylr37sUui3bCVY632npGZ7VIAgL2baUlMqPSrpsSN3Q0R8Yu
         NjYPeeed0ECWsboDtskvbgQDbR6Z7t2RZvluLfMw7ydBVNVGWUqVBXT6b0PSSnXoQCS6
         Cmng==
X-Forwarded-Encrypted: i=1; AJvYcCWowBfVbBVGckQZK6t3x3B7i55ItFHvX7zJCKJicUedmTiX8u4sNlwgaE076U9g2RmoUcbUr1HD+4iDq4QJO0Pl933N
X-Gm-Message-State: AOJu0YwJgdr/kxXO5I65NJDWVQQ2c5B6SC0gwhgJEjTYSMiOzNIA0FHA
	BBP4m4VCO+2qigco+v1B7z3FACqBiC3rnxT3Kqu/xgx+x3a4CXuwbSy//Q==
X-Google-Smtp-Source: AGHT+IHYHmrIODXXjwzY+1dLFEk94M76Gcp6/n3DkBsQ7m7QAdmMo1z9Tajw24TOBqgom2DxBWP8rw==
X-Received: by 2002:a0c:c212:0:b0:6a0:49c5:c2b5 with SMTP id l18-20020a0cc212000000b006a049c5c2b5mr2429576qvh.28.1713960370860;
        Wed, 24 Apr 2024 05:06:10 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r15-20020a0c8d0f000000b006a045780b77sm3393748qvb.51.2024.04.24.05.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:06:10 -0700 (PDT)
Message-ID: <5476c11a-764e-43fa-9ac3-52adb811138b@gmail.com>
Date: Wed, 24 Apr 2024 05:06:10 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] ap: add support to handle SAE authentication
Content-Language: en-US
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <20240421125050.6649-9-brandtwjohn@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240421125050.6649-9-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi John,

On 4/21/24 5:50 AM, John Brandt wrote:
> When the client requests SAE authentication, and it is enabled, allocate
> an auth_proto instance to handle SAE authentication. This also adds a
> new function to send SAE frames in AP mode that can be used by the
> auth_proto instance.
> ---
>   src/ap.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/src/ap.c b/src/ap.c
> index 14268551..ab0cbdcd 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -59,6 +59,8 @@
>   #include "src/diagnostic.h"
>   #include "src/band.h"
>   #include "src/common.h"
> +#include "src/sae.h"
> +#include "src/auth-proto.h"
>   
>   struct ap_state {
>   	struct netdev *netdev;
> @@ -132,6 +134,7 @@ struct sta_state {
>   	uint8_t *assoc_ies;
>   	size_t assoc_ies_len;
>   	uint8_t *assoc_rsne;
> +	struct auth_proto *auth_proto;
>   	enum ie_rsn_akm_suite akm_suite;
>   	struct eapol_sm *sm;
>   	struct handshake_state *hs;
> @@ -2595,6 +2598,35 @@ static void ap_auth_reply(struct ap_state *ap, const uint8_t *dest,
>   				ap_auth_reply_cb, NULL);
>   }
>   
> +static void sae_auth_reply(const uint8_t *data, size_t len, void *user_data)
> +{
> +	struct sta_state *sta = (struct sta_state *)user_data;
> +	struct ap_state *ap = (struct ap_state *)sta->ap;
> +	const uint8_t *addr = netdev_get_address(ap->netdev);
> +	uint8_t sae_buf[2048];

Could probably pare this down a bit. I don't mind if we leave a little 
room but 2048 seems a bit much. In a commit we've got the header + 48 + 
96 bytes for the scalar/element + 32 bytes of a token + some other bytes 
here and there. You could probably at least half this and to be safe you 
could:

if (L_WARN_ON(len > sizeof(sae_buf))
     return;
> +	struct mmpdu_header *mpdu = (struct mmpdu_header *) sae_buf;
> +	struct mmpdu_authentication *auth;
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
> @@ -2664,7 +2696,7 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
>   	 * than State 1."
>   	 */
>   	if (sta)
> -		goto done;
> +		goto have_sta;
>   
>   	/*
>   	 * Per 12.3.3.2.3 with Open System the state change is immediate,
> @@ -2679,18 +2711,32 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
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
