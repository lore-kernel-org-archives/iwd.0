Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA433FD
	for <iwd@lists.linux.dev>; Tue, 26 Mar 2024 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711428135; cv=none; b=iYr5jhC2L5Qa7qFsL0X3L5QMyCxhllO/bG90pzrUepa6W6a//Jr668Ne7VdyB61lP5BNKqaoe5Y/4NLwoH9Ja9ueqMFMh3HkFDJi5Aie/o8meJMOF6dnHELjUsMMIzJnpCi9QnPg2USqInQui8Foc36Hh6CBcyuvkXu5sGVvV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711428135; c=relaxed/simple;
	bh=XTPzAOSw7pnmHOzm7x4NIE1fi5yJWZLMeKn08+MS8Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ucy8wed+Z1XR/HLw74NO+6mECr+tbzs24DtHsgR1c1t4nOEMYay0PHaItQf9P9oVVZFje5ViKJYDg19aiqmKIR8lf+xHFzpO3yWR9GdQchjVCj+hHlRQUmmZ3caDq3r7+hzHt7kLLQ0CLRnNvGWH4chE34uXOkyScpQ69/iIkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nELNSN1R; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nELNSN1R"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c397193878so2925674b6e.3
        for <iwd@lists.linux.dev>; Mon, 25 Mar 2024 21:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711428133; x=1712032933; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUUdyvNpdUkXnaqPGb8hINsrE2FA/9qHI3Setz+tIg8=;
        b=nELNSN1R4MGq9N6QM7280m+gYFrw1NRLicXCjtMP4RjckBKyibUKx9BZNFFCgk5goR
         89ZWwtYQlzMYWUZhv5urL3qxNY2luJueMzaa9CqX4MM/ueeZQOIbPF/gF8jN3db7vnQA
         ox9TUkI5IxUTHkoL/OC7eCqE2XAn4BWaSJZpvpfMZUG3X77BMQedPH666YJU2fncr/Bl
         psZyTkYm3n424KwlWxvBgE6vdBPtlUNABt4CoNxT4RdUSODOrAnQHOgIfo1fkda80iWG
         6hYza/aDQa11ijd367BEjcTTXzmapLHcyoTO8Y+b3zGPhQk09MjcSQIdja7ApFizY/27
         TJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711428133; x=1712032933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUUdyvNpdUkXnaqPGb8hINsrE2FA/9qHI3Setz+tIg8=;
        b=C6eAjazXelgbXMfXhpBD5z2Z+6IqKWdRcOtQtaxM4sTxdGe9lh5+pLnkODn4i+D8wl
         6t0o4Iaup2OCOPGzxFT3rh3EPF5+Ox7Pf0kGY29UezsBZ7vBEVy0al9D0gFBi1XSsH5j
         kgdIsAZMMuD7bp4szci9m8WjuI4h8vv2yNVS9yr6sRQ97mP3OAh/omj5sy0Sm27fP6We
         QVST1u1VQpmiTUqs9R1q38U/VLjlLP3mWuqezYb4pblKmUBHoyrhYfiXfiihK5oKe8fR
         6/2aUjaxC/amzwHMnriLVuNsqfuUjX22NpHgtl7Si/LEnbseK75MVdJYSsJsf/BQJ+yR
         FNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNDxMbOEzTddCaqvdtkA4fYO3VTgJIGjLwv+++QgPSM7hdn7bxr/KVjXchHp3DNAqoUIUfZaI7vnI3jGK5TqSWSoUq
X-Gm-Message-State: AOJu0Yz3qOCoYp6G+kVXPQzkjQQTdulZoeSonO+hDuM2CE3yCIZTOQot
	llfDIJ6MnKlZ7GDL/HyGQ3662HP5rqWrFYQ3biEexugtBJntHgUj
X-Google-Smtp-Source: AGHT+IEmv2rOBT4YSFhe/5AWFIwCRKJ6bIZhrgiRyNky0lyjoqr4DD4ecm4XjC7kv0/MKahjhInJlw==
X-Received: by 2002:a05:6808:4496:b0:3c3:c119:417f with SMTP id eq22-20020a056808449600b003c3c119417fmr13023251oib.21.1711428133113;
        Mon, 25 Mar 2024 21:42:13 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id kt4-20020a056808704400b003c1e577140asm1341026oib.25.2024.03.25.21.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 21:42:12 -0700 (PDT)
Message-ID: <f1d1abea-7810-4a9b-ab44-8816c76b3871@gmail.com>
Date: Mon, 25 Mar 2024 23:42:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Register EAPOL frame listeners earlier
Content-Language: en-US
To: jeremy.whiting@collabora.com, iwd@lists.linux.dev
Cc: ed.smith@collabora.com, alvaro.soliverez@collabora.com
References: <20240325234126.510777-1-jeremy.whiting@collabora.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240325234126.510777-1-jeremy.whiting@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/25/24 18:41, jeremy.whiting@collabora.com wrote:
> From: Ed Smith <ed.smith@collabora.com>
> 
> If we register the main EAPOL frame listener as late as the associate
> event, it may not observe ptk_1_of_4. This defeats handling for early
> messages in eapol_rx_packet, which only sees messages once it has been
> registered.
> 

Out of curiosity, is this driver using CONTROL_PORT_OVER_NL80211 ?

You should really talk to the vendor about getting the firmware fixed.  Why are 
EAPoL packets making it out before the Association event?

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

You can't really do this here.  In the case of SAE (wpa3-personal), a successful 
transition from authenticate -> associate returns early:

                 /* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
                 if (ret == 0 || ret == -EAGAIN)
                         return;

It is probably a good idea to only create the eapol_sm state machine once the 
transition to Associate has happened (in other words, ret == 0).  However...

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

netdev_authenticate_event doesn't cover FT cases, so most likely this simple 
removal here will result in FT being broken, or rather re-keys after FT.  Thus 
special care must be taken for FT.

>   		/* Just in case this was a retry */
>   		netdev->ignore_connect_event = false;
>   

Your original patch was took care of both cases, albeit in a brute force way.

Regards,
-Denis
