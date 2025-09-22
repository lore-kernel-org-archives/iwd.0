Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D228AAE6
	for <iwd@lists.linux.dev>; Mon, 22 Sep 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577879; cv=none; b=QtWWKg0frdz8Pn+evf/hoE+q0dgT2S9S8ev2D/vMtVEQEJ1MA+PpP+BZ4VfnXlkKIL87Iwcu1TlslOVk3kFpoumZkfxziaW0zBwEbj4PKvfDoFz0/8s10LbpFNsZ4McQltgskLgIdpsE1D/U9e6U93onmEcIw+FCG2wP3Bi9NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577879; c=relaxed/simple;
	bh=DctToKb4kM7UbcsO7dkhZCDi0QNP9Js1e4kFYyKmgEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VIEAGojLu+/QYYVjTg6tQ7Idu4EnP69xf25b1eKRzy8RHnHnYU5xfgMFS+Pp8bR/kRl+t5gDK5TGQpuZNX6TIpxmO4d/dQ+d3z2Gm6E+WgOl6hvwV9s5xBKb8CM4z1QskwKEktBMX+k/naUTlMVEhdd8s1JhdYbxDnDXC4meYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwFeQNNZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwFeQNNZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so3625902a91.1
        for <iwd@lists.linux.dev>; Mon, 22 Sep 2025 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758577875; x=1759182675; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OPHoF7gP/G6YK8MU/0LA/LcKyCyo87HVpm6ZG19HgQ=;
        b=EwFeQNNZOtqsmJ6uJwFrzjZxdCQoKz+Eu18k4p5HA6r0qC0Nq4vbgp/sNJp/1QR7iD
         hOdciqHe5SujTI04Z5S2L97WZVhKAPU2Dau9FkcWX+DQWR2SA3YbNqhYxU8LW8DKlZwS
         DN1ZyfH1uPOVEFM2z2iqbAsO1XidFkANR3wP7C1TTlWFR5RLGqaPENkDnIPr7+URdFSJ
         12Wsb3f1oNkKxO2/sHnvghiVN83HXQWld/OobhHKf2tEJxHvBduczH5GOjQlDvUeyxZM
         zZtv+AX0ySPos+5DKjiO9TekDgxrl7IMwkcrMvMnQasa2cMz+oMvXtKcyb01AnwZsB+v
         QEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577875; x=1759182675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OPHoF7gP/G6YK8MU/0LA/LcKyCyo87HVpm6ZG19HgQ=;
        b=jAzFO3HG7pLEp3na242gVnlZbhLjWEJjDMcmR3w1Nc0+aTnTCcWrnB+1zUX6xGrAS7
         V6Qe8ytshsrVMHOJIMpBOUV7scxsqR59oSDKC6bOuBOH5Ys/x13nMdWmFtbhvFpH9f5p
         Maml23dvdy1yskWlXWnPtTV9XK+LfZaPjs1gfsxa/ghiJAhxNV+Yz8c67HJLyiJflxso
         E4iRGTxju8EQYRTm7J4EmwqVsMOKD2ucU+B/jrMn2mPA3UGjGie7/Bpu81ZecaaMYRcB
         OTHid71601/8AHTvVFaEMNRQr8YaITHKdyJYVuAwvis3G/uTkiN8v4vC8dh3wscm1hFC
         JbqA==
X-Forwarded-Encrypted: i=1; AJvYcCXwfqczv7/im+CpRbZYGLGHtuGSkOaGnYBgguE4h0T0fCpV+R2mceUrsgh+ha336lqjVg8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyBo+yNJJDdO+EgSRovsXojiP/n/ZOxzK5GDo67sLwDTcCzq8dh
	m3ubzFPNPayZ5b0tfDQS2w2XYPzzctXXWdfQb/VnxMO8aC/oWkRIumASk4eaBw==
X-Gm-Gg: ASbGncsx2y65IMwjXkFNFty6mgoJA7vR64XbuvxffmmkpWLo42tp4dKwSy1O2KQ3Pu/
	OA5K0OuO6v7BMFJ9yy2JdyCSvOod/JZzIS897phOcZyyqsMUBXkcNFZUAlkaNYFb+Y51HrQa9x2
	pMK0Qk3li7YV7fd5mbmDGUIYDX7mppopZsgn+6yOtl+c8v8QvKAMe0Ix9yG6UJJe7qldqRXTBXb
	iGRuNY3654BQk2V57wdy5vmQ2ymZvGpfn8L8Viye9Xsx14TFTOsowgKBuu88BWp2ebhJvqOx8mW
	3LBqWuFr/8OwJaUhLLWXVH1GPQ4qatTNPF0W+LKj3ciVjw847TwOiOH0h0Se7R8wjxzKD0tptTi
	tZDp1w0en154xJbnVgKkPbnUJDg==
X-Google-Smtp-Source: AGHT+IEGDEOio7hNIS8cbyaGlRF9HINXPlO4fdl3Dv4AUZULHNApQLis/f6qEWJHs8InT+PD56VRaQ==
X-Received: by 2002:a17:90a:fc45:b0:31f:ecf:36f with SMTP id 98e67ed59e1d1-332ab7d9c4dmr258839a91.1.1758577874924;
        Mon, 22 Sep 2025 14:51:14 -0700 (PDT)
Received: from [10.113.169.105] ([38.76.119.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed275e795sm17221883a91.19.2025.09.22.14.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:51:14 -0700 (PDT)
Message-ID: <cccd50aa-6a4a-43e4-b0a4-98326d7f14fb@gmail.com>
Date: Mon, 22 Sep 2025 14:51:11 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry: Is WPA3-FT Roaming Supported in iwd ver3.9
To: amit kumar <amit60700@gmail.com>, iwd@lists.linux.dev
References: <CAJNKUtceMPq+Yijythto5YW6a3k3B9oxApve4Pss=g2zAdEKhg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAJNKUtceMPq+Yijythto5YW6a3k3B9oxApve4Pss=g2zAdEKhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amit,

On 9/22/25 2:23 PM, amit kumar wrote:
> Dear iwd maintainers and community,
>
> I’m currently working with iwd version 3.9 and have been evaluating
> Fast Transition (FT) behavior across different security
> configurations with standard Cisco AP (It supports FT roaming).
>
> In my testing:
>
> 1> With "WPA2-FT only" security configuration, connection and roaming
> works flawlessly — the device connects and roams as expected.
> 2> WPA3-SAE also connects without an issue.
> 3> However, when the AP is configured with "WPA3-FT only" (AKM suite
> 00-0F-AC:9), iwd fails to connect, logging:
>          iwd[440]: autoconnect: No suitable BSSes found.
> 4> With the same AP's config, wpa_supplicant is able to connect and roam.
>
> Upon reviewing the source code, I noticed that the AKM suite for FT
> over SAE (IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) is not included in the
> logic that identifies WPA3-Personal networks. After adding the
> following patch to ie.c, iwd successfully connects to the WPA3-FT AP:
>
> ----
>
> diff --git a/src/ie.c b/src/ie.c
> --- a/src/ie.c
> +++ b/src/ie.c
> @@ -1338,7 +1338,8 @@ bool ie_rsne_is_wpa3_personal(const struct
> ie_rsn_info *info)
>           * 3. an AP should enable AKM suite selector: 00-0F-AC:6
>           * 5. an AP shall set MFPC to 1, MFPR to 0
>           */
> -       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256))
> +       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
> +           !(info->akm_suites & IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
>                  return false;
>
>          if (!info->mfpc)
>
> ----
>
> My query:
> Does iwd officially support WPA3-FT roaming? If not, is there a
> specific reason this AKM suite is excluded — such as spec maturity,
> roaming logic limitations, or security concerns?

IWD does support WPA3-FT, but based on the spec an AP should never 
advertise only this AKM. It should include plain SAE as well:

2.2 WPA3-Personal only mode
1. An AP shall enable at least AKM suite selector 00-0F-AC:8 in the BSS

This is also in the comment above your diff. I would definitely file a 
bug report with Cisco if you're able to, or ask what the intention of 
this configuration is. It really makes no sense IMO to have _only_ FT, 
i.e. how would you associate initially?

I'm unable to find anything online about "WAP3-FT only" and I also 
checked the settings for the AP vendor we use and there is no such 
"WPA3-FT only" option.

Relaxing this requirement in IWD is of course an option but I suspect 
Cisco is going to have compatibility issues across the board due to this.

Thanks,

James

>
> Id appreciate any insights into the roadmap or design considerations
> around WPA3-FT support. Happy to share logs or test results if
> helpful.
>
> Best regards,
> [Amit Kumar]
>
