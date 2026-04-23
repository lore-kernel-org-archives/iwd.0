Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2206318EC4
	for <iwd@lists.linux.dev>; Thu, 23 Apr 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954161; cv=none; b=NeU408OfDk/4uWXqLNqRO2D6PlACYiWmlbFJV93Fjb4KLwGvfPTE0Ot5VZxDUqvMokdYsRCbnD56ifuLS7gUsgtb+NWxSbd0/TXAs3toYXT1+WwNLFZJUyQdAJL7D35aZjQclyLOWcbGPCZcWKMu6C9JfiI44Pl4S0j+9WPhcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954161; c=relaxed/simple;
	bh=TaZYMrLDidEW/SDORmPsMxRlK0B2yzsO+STL19YMD98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyDer59/MvLTbdHfRD3+Mvujduaxz1OoP72AiPsbSz9WQURZpGu6mypJAqs36JZxZ3pDH4JAfmVBfA9GCRQupNDdckrB+T4pWQKm+gsQaNdocAYfYZTu2lWlw6LoAIZmeHCj0XW6g10vOZx8F8iDQvoZKtP10nyEBKGyOeTW9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvP2kAVs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvP2kAVs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fbca04006so3458238a91.1
        for <iwd@lists.linux.dev>; Thu, 23 Apr 2026 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776954159; x=1777558959; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2T/S1vQBym6iCp+Q9IihzcYLByKwSKfgLbofz4ECAkk=;
        b=nvP2kAVsEoMHJPBQpaALDvPbhBvwD+NpS0lFc0Q02Lj8U4wdDdh0bIi3jMdL0N7UxB
         qC+iD+D/RtS9mIfAu4bEJ94PZdPQRr5TdCH7X8yOB0sBAJhABvZbzjG6m5fu5mJK9Hvo
         g3uUqAcxdrKKXi39+QgvvRRQi8qJY38C6cvIGY5x+LWPu82BjZZW6VBnvj4qlo2HPTEB
         QfMfMi2G4C8E9IKToPEzUjf4eTTfbc78nrldjqAW7XHo7W4IijkEw6R9VfJMpyk0TozJ
         aecG54f8XfWMp3Zz0TOcZTZBf5cGzhR6mqR8VcG9PrSU21ZhKm3NIMpiunol77NcjJ3B
         i+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954159; x=1777558959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T/S1vQBym6iCp+Q9IihzcYLByKwSKfgLbofz4ECAkk=;
        b=Qg+/2lbBefyoU2DvJKDxWSWe/71udxIT9CikMFlhpaRHqOkYPXu0mls0sBRlU64oIH
         j8U3fTMacqQ2dnj7mE66eeMofC5LUJPnFAR/tT3GBaaMX+slnXmHWuPzN0AQpGZVfqrf
         0btzBasazDxTXXL/NyhR3PGwCMBZej0TQ+QGOrTFgE0yCAoiuySWieuCX1e3KZcFtSnZ
         XYx6W4BIuVwaLBTpRBSFQCyJ+tOBez65zgF1ij+nUX9ZWCFJHuUIjB9keEHQXC3b22k7
         /zLjD3MkiQU67iOaRnTTNkIkjNmfRi7J+q3c3N5Lq/9djumredRH3gnIk9I8vSuNblYX
         UPlg==
X-Forwarded-Encrypted: i=1; AFNElJ/jxGuKPOBSTrNneS6kqWUgedLhuniR87yy/WQbulH3fpiryEdECAbCP0H4BNeMOwGrV0I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0UsG/snasx+c6qGhsFQhFvKk5v98i7jTyX1o/C1gSTxk055lH
	a4foJdkMrh+/HodgAKtp90yOwWvs8TMTpps1+hTcI+zByFL0d3Cy5urr
X-Gm-Gg: AeBDietIS2VLtx6eqziwYWukgklbs8V3FRosqGQUFhAlvAtMWDkrp2KHDTbkslB9IGZ
	sZ22zzIcp6LPhp5V2rT82X65vj2hgflDFTaciRv8xpQC8m/11cAUMxtnjvZKzFFWB1MH3u1xO2I
	KUohPwQMi99b+oQ56uU8k4vymiYeNNmA8pO+w1wbTrW5Gc1lmZdLTa3K9I4bFS1GJr9GIO+j8Te
	l1M/KEuSxLASNCuf8aTlMfg+chm6rPJX7lUJlbSD/omZbA2arHy1T5hml0C46AuGiEn9hrROwmw
	WAFh1YL7NZ9CspOSRDgHPcNQQUMKgZZGEH5Vmg/xtzoLJ1yy861pR9q4ax0oYRKPbeNEk0jyZhH
	X2LlBqvn0qjqgVyQjfg+AByONd5+N+C5WpZKMU3oNkx0dx/nA5YKwM/xRBGipT1VJVNKYdJTeCu
	mmzLLHEgLoKbrdL32heDzYBlBasSw79dDfQfdVSu1UoJD9GEIHbJ0AyVmBE4JDMGu4fvxMp7bA9
	xGxBxg8/eZTfXHVGn4VciZoXRj6kcRm1qPY9GrAD9ij7J8=
X-Received: by 2002:a17:90a:da8c:b0:35e:581c:6bca with SMTP id 98e67ed59e1d1-361403ca597mr28868350a91.3.1776954158748;
        Thu, 23 Apr 2026 07:22:38 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fb9b121sm10775253a91.5.2026.04.23.07.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:22:37 -0700 (PDT)
Message-ID: <6aca9ccf-a21e-4f67-806c-c534068e26a6@gmail.com>
Date: Thu, 23 Apr 2026 07:22:36 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: use SAE PWE both for fullmac external auth
To: Jeremy Blum <jeremy@jeremyblum.com>, iwd@lists.linux.dev
Cc: denkenz@gmail.com, marcel@holtmann.org
References: <20260403175038.4533-1-jeremy@jeremyblum.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260403175038.4533-1-jeremy@jeremyblum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy,

On 4/3/26 10:50 AM, Jeremy Blum wrote:
> For fullmac external SAE, iwd currently forces Hunt-and-Peck and does
> not include NL80211_ATTR_SAE_PWE in the connect request.
>
> This prevents successful association with H2E-capable APs on at least
> some fullmac drivers, since userspace is effectively constraining SAE
> to Hunt-and-Peck while not advertising the intended SAE PWE policy to
> nl80211.
>
> For fullmac SAE connections without PMKSA reuse, request
> NL80211_SAE_PWE_BOTH and stop forcing Hunt-and-Peck on the SAE state
> machine. This keeps the fullmac external-auth path aligned with the
> actual SAE policy instead of hard-wiring HnP.
>
> Tested on a CYW43455/brcmfmac fullmac device using firmware 7.45.286,
> where this change fixes WPA3 association and traffic on H2E-capable APs.
>
> Signed-off-by: Jeremy Blum <jeremy@jeremyblum.com>
> ---
>   src/netdev.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index e639a1f8..94520b5c 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -2600,6 +2600,11 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
>   	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_pmksa ?
>   					NL80211_AUTHTYPE_SAE :
>   					NL80211_AUTHTYPE_OPEN_SYSTEM;
> +	uint8_t sae_pwe = nhs->type == CONNECTION_TYPE_FULLMAC &&
> +				IE_AKM_IS_SAE(hs->akm_suite) &&
> +				!hs->have_pmksa ?
> +				NL80211_SAE_PWE_BOTH :
> +				NL80211_SAE_PWE_UNSPECIFIED;
>   	enum mpdu_management_subtype subtype = prev_bssid ?
>   				MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST :
>   				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST;
> @@ -2618,6 +2623,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
>   	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
>   	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
>   	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
> +	if (sae_pwe != NL80211_SAE_PWE_UNSPECIFIED)
> +		l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PWE, 1, &sae_pwe);
>   
>   	switch (nhs->type) {
>   	case CONNECTION_TYPE_SOFTMAC:
> @@ -4218,7 +4225,6 @@ static void netdev_connect_common(struct netdev *netdev,
>   					netdev_external_auth_sae_tx_associate,
>   					netdev);
>   		sae_sm_force_default_group(netdev->ap);
> -		sae_sm_force_hunt_and_peck(netdev->ap);
>   	}
>   
>   	if (sae_sm_is_h2e(netdev->ap)) {
>
> base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc

This looks good to me, though I haven't tested it myself to confirm. 
I'll wait for Denis to comment but I'd be ok merging if it solves you're 
problem.

