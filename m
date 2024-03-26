Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261226296
	for <iwd@lists.linux.dev>; Tue, 26 Mar 2024 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411220; cv=none; b=DP0tdlpKh289hz4f/eBvYjeocoR/7DPNwK/9IP6COpacwZEV0gmJVwx7bKJSZAFHqa7MzQoUojGQLHiCcfMed2/tFPjtrS/YZUSIXb+eQfwLljpJ1YE0QdlBQGMMI2yfseiiNkpXSlwanqVTRXyqA4yac4g3CNXNY1qTHAF/a5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411220; c=relaxed/simple;
	bh=N/FIJujeCOXsJMYwOEGA3ukgNR4TdG5GOI0fLEmoORw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mBgyAUajba+Ri+JxWbHBm489D1JQk7RyY/9XOvQPvwZfS12TuM1SJovidVhBm8Ar02916rCjGhHYBm7bTo4GKQK5MPWgJ5ZvTQLXoYDGLWnc0C16PHLXOFRGQI2pS1U91zwD5pj6FNlUnxPw1uaE7P2OffoWPTmV+67HHgTbf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CQGZxQx+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CQGZxQx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711411216;
	bh=N/FIJujeCOXsJMYwOEGA3ukgNR4TdG5GOI0fLEmoORw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=CQGZxQx+79+jWtKCpJFuQzslbvqGlI8sawRRXr6lDCwf17aqP6e76251R8K6NjpV/
	 906IxhmFbsgy/a3xUSmE/mL7PXs1d/H+pEzxSxwsCt0Nv1oVwwUD/pjXnL+ISP2b2+
	 wGnQCl03z9yKz0MCD7XuPxXnNnFh7r6/hksv3iMwiBnWmFxvu3XFw2EJMhG10geYaX
	 Cc9SUwvgyX9KWGhjqxub+kgPLlAqvSRApbPsOkILJDfdmsQsrwbbsW5PK1rkgwZ0Oe
	 uFQWnfEPEYYEM0lY3ZHq1UVXXxqnXWg0vVAB5EfP5zqjhRmWixakT2Mjy8hdodufUU
	 JHu0B3oBvPvzQ==
Received: from [100.110.102.249] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jwhiting)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8E5263782087;
	Tue, 26 Mar 2024 00:00:15 +0000 (UTC)
Message-ID: <27a092e9-2f44-4a05-aca8-655bb1a90efb@collabora.com>
Date: Mon, 25 Mar 2024 18:00:13 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Register EAPOL frame listeners earlier
Content-Language: en-US
From: Jeremy Whiting <jeremy.whiting@collabora.com>
To: iwd@lists.linux.dev
Cc: ed.smith@collabora.com, alvaro.soliverez@collabora.com
References: <20240325234126.510777-1-jeremy.whiting@collabora.com>
In-Reply-To: <20240325234126.510777-1-jeremy.whiting@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,


Hold on this change. I just tested on the device itself and found with 
this change I'm unable to connect to either my usual wifi setup (home 
isp router) or the ios hotspot. Will discuss tomorrow with Ed but I 
think moving it after all the possible auth failures is making it never 
happen at all in some cases.


BR,

Jeremy

On 3/25/24 17:41, jeremy.whiting@collabora.com wrote:
> From: Ed Smith <ed.smith@collabora.com>
>
> If we register the main EAPOL frame listener as late as the associate
> event, it may not observe ptk_1_of_4. This defeats handling for early
> messages in eapol_rx_packet, which only sees messages once it has been
> registered.
>
> If we move registration to the authenticate event, then the EAPOL
> frame listeners should observe all messages, without any possible
> races. Note that the messages are not actually processed until
> eapol_start() is called, and we haven't moved that call site. All
> that's changing here is how early EAPOL messages can be observed.
> ---
>   src/netdev.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index 09fac959..d6dc7004 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -3011,6 +3011,11 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
>   		}
>   	}
>   
> +	if (!netdev->sm) {
> +		netdev->sm = eapol_sm_new(netdev->handshake);
> +		eapol_register(netdev->sm);
> +	}
> +
>   auth_error:
>   	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
>   				status_code);
> @@ -3099,9 +3104,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
>   			netdev->ap = NULL;
>   		}
>   
> -		netdev->sm = eapol_sm_new(netdev->handshake);
> -		eapol_register(netdev->sm);
> -
>   		/* Just in case this was a retry */
>   		netdev->ignore_connect_event = false;
>   
