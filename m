Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9C13E043
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573301; cv=none; b=OT5mXSADXDe13ZNL+rcuOmhjdK4fv7ylUjNI/brxIkqXwr8/k/9uGMBmvOIDWJZ11q+2mkRtuZ3KtyTGKJzYsT5nEPKhHrk8fYbG6qVxFVIsUTjMA5dSz5A1dCh+3OdACX0jjs5vb7Hm7xPeUlZ7eMR8F1cVGv6QpvygzLKncmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573301; c=relaxed/simple;
	bh=NEN9/W9H96QkjvEMIvSZFIDGKMbThh957oLcl9D0opY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bm9OQBjjPmlxdohkGicmY104l0rASIY2Fp0YXadzUGF18TagD1oDT97zSLRTWln9Kahx2rOFNUNgfbnggJKN5vXrx91oboihblKSpbGOmAk1nwqVsYaECwbAHtbnM/rTk7rjUPI1Wcv1zdwCRG9bpaHKiO+dUOqhnEBWknwCXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtDeCr2d; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtDeCr2d"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a550ce1a41so148724eaf.0
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711573299; x=1712178099; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=976hSKmI6Z3JQaFjKARzLF3O5JJIHDsaOI22Ae6MFH4=;
        b=RtDeCr2d52IUGr1fRdppUpM49O/B1PbD0CKhXNRA3ZhLMUFBesZhvaDm/JRRaXbYvn
         LWaBRZoEHomV+89h8ikafecUbAOo8mMQo1Ox5RTZmzovxwj68GI3TMirblUJO9HO6OF1
         XXFvI5yX4/P91B/ISC07TVae+J9OyqlH+WokiYEWlE2S5vwbfIw+y935CGxrlk3IgYZT
         Yhy7+RiM0J2B7fshwPp8sxuG1mVVw3tcH1cvpPi1AjTXG3R4BeeONXlJaDu76NeS/OSV
         WqFEfzviu8njJoeN2FwaoYZEOI0FFJBPsx7kgR1VxaqUfbFccBnifm1Q8uoE39JiGDlG
         9oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573299; x=1712178099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=976hSKmI6Z3JQaFjKARzLF3O5JJIHDsaOI22Ae6MFH4=;
        b=tfRGHGD+9Q5Ay6HaoKfvUJY0jYDb1EI+gJxU4V+ji95unrnT00HDqR/sVrLsRzbvzZ
         6F7ZZJmymxrRSv9rl/uzRcrVUmf4/ElpUGx5PeXmdIinK3atWPMH+I3Z9dE+JtSOIBm8
         wSTHiVvkq/naV7CiJ2p0JVhTdhBMdH4Jt4/SLyogLdLV0ekM7UuoauGbAaJqZEEpmqzp
         r2se2K4d1XDT1BNIy/I1EYiyz+lQ3b67GWKAMLQlDDPAdPr1GlSsfyDHpSyfiiZNxH9f
         y1PNqN8nHWPvvQiheiRqQk4383rOIspYODQ+bBk4fVXjZVNUbH6Drzxvg4PDDIPZhoYU
         xbUA==
X-Forwarded-Encrypted: i=1; AJvYcCXY9ohcSRBaccJZNkuc8Zc4vILL6PzAxbKVn2P89vdArKNfK7usnK9pi4iB76xLj6iIw2TkgvegNer/gBF9mkz+PmsG
X-Gm-Message-State: AOJu0YzBvfzdVXBcqmf1QPrWTXdRlf09SabSoPvJTe2ZwUT1kLo2QQbK
	Mbr+SOljCGArSNAipPatpHeNMoo1pn4tJYYN5e3VCIdNf6VmRPsV
X-Google-Smtp-Source: AGHT+IHM6IJ5Q10zjno03R01f0IpveZdic0d1jRGcWgDl02jh60sNuX9AsivQfWtdmxe38cOpuSEQA==
X-Received: by 2002:a05:6820:2718:b0:5a5:21df:7eee with SMTP id db24-20020a056820271800b005a521df7eeemr1282350oob.1.1711573299072;
        Wed, 27 Mar 2024 14:01:39 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i10-20020a056820138a00b005a53ef7337csm158oow.31.2024.03.27.14.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:01:38 -0700 (PDT)
Message-ID: <fd511498-2a6c-4646-85b3-4f2f3f6f379b@gmail.com>
Date: Wed, 27 Mar 2024 16:01:37 -0500
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
References: <20240327184927.677804-1-jeremy.whiting@collabora.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240327184927.677804-1-jeremy.whiting@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy/Ed,

On 3/27/24 13:49, jeremy.whiting@collabora.com wrote:
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
>   src/netdev.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 

Can we please use patch versioning?  I can't keep track which version of this 
patch I'm looking at now.

> diff --git a/src/netdev.c b/src/netdev.c
> index 09fac959..886a85f5 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -2896,6 +2896,14 @@ static bool kernel_will_retry_auth(uint16_t status_code,
>   	return false;
>   }
>   
> +static void netdev_ensure_registered(struct netdev *netdev)

The naming could use some work.  What is being registered?

> +{
> +	if (!netdev->sm) {

I would do:

if (L_WARN_ON(netdev->sm))
	return;

....

> +		netdev->sm = eapol_sm_new(netdev->handshake);
> +		eapol_register(netdev->sm);
> +	}
> +}
> +
>   static void netdev_authenticate_event(struct l_genl_msg *msg,
>   							struct netdev *netdev)
>   {
> @@ -2982,8 +2990,10 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
>   						NULL, netdev->user_data);
>   
>   		/* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
> -		if (ret == 0 || ret == -EAGAIN)
> +		if (ret == 0 || ret == -EAGAIN) {
> +			netdev_ensure_registered(netdev);

Nit: The whole point of EAGAIN is that we're not proceeding to the next stage. 
See src/auth-proto.h.  You should only be trying to create eapol_sm when we do.

>   			return;
> +		}
>   
>   		retry = kernel_will_retry_auth(status_code,
>   				L_CPU_TO_LE16(auth->algorithm),

Regards,
-Denis

