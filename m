Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4C14F9EB
	for <iwd@lists.linux.dev>; Mon, 22 Apr 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793939; cv=none; b=jPq26haAn0UAhF487RSVer9MN/f817qy6/5+YEwalMNJkIBY6tFD0/nMU2Xk+1ylr9hWFJjyo2rq1TQQuwtUwnCgesLPSedL2s4NXIwvdF4O3W2MbUFOU6mkEglQoVdqnJzuuqPaP+PTi+EIe2ssE+4EZ73U9JaxcZcu2JfqWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793939; c=relaxed/simple;
	bh=LajhnS8ShvKM5/Lnohmz5rjx/VjzDrXpidXV6QLT/YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=At8/hENwgDTzp+6/EIAg8UWwLbkNrieZpL4croNPuPdJrInXfWdYYMVwz5+LjaTZfpzs43wQRgNsTX4yPPZBFe3d2F58FtKXG/clGiXsxtkn0vLfbrJ9YfUQ+5dxkNzSg/nhLbpmQMDQx6EoS5QiCVTYcBnWkyHXOKFEL4kDc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Budxn5Te; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Budxn5Te"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78f02298dc6so358889185a.1
        for <iwd@lists.linux.dev>; Mon, 22 Apr 2024 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713793937; x=1714398737; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrzC4KJgLOx0FZtfcYnGplNrmlrr7l03ONxf67pzVvw=;
        b=Budxn5TeYAt5Uzif7qF/hU2q4hIor1fHbK86BeZ3hE+J7E2Rc57ZgWWjJeGRHg3iHD
         pPO0kImCKWghc9WbvYkFKxIuCglSJCB3V7bWwIhD3APmCGkpfFhDA80LCIfhijlM7LRX
         qRuEuwO2Y4pdu6+1y7pnjG/DkBL4oBQhVu2tdYyWiiUWeaEg1q/obn8a8sqWmMd9UHRx
         tdjfAxG5fhHPFSA/CK2zNaBDNDX4jG5doMp/50qgf8pDHENLju5P1N4ddmZ0/NcXHksc
         5lMIBscl2egxmRdNITGJsJeEVCKXwmR89Dwjr5lOCaT6Q9Zt8kGpQg8n7Av74lE/ZdId
         ndqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793937; x=1714398737;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrzC4KJgLOx0FZtfcYnGplNrmlrr7l03ONxf67pzVvw=;
        b=JhPwgWBzxrk7YJj7JMsEMjluUGWJRMgHwlHyQ211QnpTR9iIyQw5BKzmgsg6PtFP5g
         0bfKyu1U9I+0nZln96+0eGamaXhgtpC5Kjj2OC7TKioSvRsgr3Wu6yRERcrL8ONXWc2+
         hP6H2BWL+/Lnq/HGI8gc3rJ7GFARVL8Z9SLmv9QEsxtFLg71iY5jdggJffEugIFtd7dw
         vS3Bur/bBipKaZSiXaYViIl3Ni9FOP1ZhPPK5dsj7yf/4ZWfJfuDqomXd3eo/kl6ANkw
         E04fDRujL3SwZyAH8WXC7rGeBVxukqoWiMW1XpVmMAU0bRz7+nSAiUg1MpjSgpTWLD0p
         Yu4g==
X-Forwarded-Encrypted: i=1; AJvYcCXv2lYjA+R1qftuARbz9bPgoNb8qDEh29oFBM6JUJauX6Ja7bw3aF4OyBMK8TWSKZZjdYGm3LMmNjU/sjVVph2aNbnN
X-Gm-Message-State: AOJu0YzAeJ2ZbkJYZsVEKtk+0xNBi3dfDzb1Kb3yDSYGQSMD72f43Rmk
	yGsed19hw6LBgVC8hmiq+RC+LaFLpUFrGglcbDCGd9WpaUqrj62P
X-Google-Smtp-Source: AGHT+IGga+MU5yvElIwQU9TUBwfpbJMGXpb//E6jrTjcNeA02vJS0tagxlhG2dE7Nu0iDIMUA6mp6g==
X-Received: by 2002:a05:620a:20d7:b0:78a:5387:db81 with SMTP id f23-20020a05620a20d700b0078a5387db81mr15700380qka.26.1713793936700;
        Mon, 22 Apr 2024 06:52:16 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id m6-20020ae9e006000000b0078efdcd9aa6sm4304701qkk.127.2024.04.22.06.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:52:16 -0700 (PDT)
Message-ID: <13851d8a-e91d-47e8-b9c1-0b1e7369edba@gmail.com>
Date: Mon, 22 Apr 2024 06:52:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Basic SAE support for AP mode
Content-Language: en-US
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 4/21/24 5:50 AM, John Brandt wrote:
> This set of patches adds basic SAE support for IWD in AP mode. It has
> been tested by connecting to IWD AP using wpa_supplicant. Note that this
> does not yet correspond to WPA3, since WPA3 would also require the
> support of Management Frame Protection.
>
> Normal client functionality has also been confirmed to still work. After
> applying these patches it remains possible for IWD client to connect to
> WPA3/SAE network.
>
> Remaining TODOs are to include better sanity-checking of received
> frames.

I took a quick pass and I'm impressed you took the initiative to 
implement this. I do need to take a closer look from the spec side of 
things but overall it looks good.

Assuming we are compliant with the spec my only concern merging this 
would be the TODOs. You do mention this is experimental and certain 
checks are not done, but you'd be surprised at the number of people 
using IWD in AP mode. The minute we merge this we're going to have 
people using it, which in its current form would be insecure. I think we 
first need to get the frame verification implemented as well as MFP. But 
anyways, this is a good start and I'll give it a full review when I have 
some time, hopefully this week.

Thanks,

James

>
> John Brandt (11):
>    ap: ability to advertise PSK and SAE
>    ap: accept PSK/SAE in auth depending on config
>    sae: add function sae_set_group
>    sae: refactor and add function sae_calculate_keys
>    sae: make sae_process_commit callable in AP mode
>    sae: verify offered group in AP mode
>    sae: support reception of Confirm frame by AP
>    ap: add support to handle SAE authentication
>    ap: enable start of 4-way HS after SAE
>    eapol: support PTK derivation with SHA256
>    eapol: encrypt key data for AKM-defined ciphers
>
>   src/ap.c    | 135 +++++++++++++++++++++++++++++++++-------
>   src/eapol.c |  58 ++++++++++++-----
>   src/sae.c   | 175 +++++++++++++++++++++++++++++++++-------------------
>   3 files changed, 265 insertions(+), 103 deletions(-)
>
