Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C322B676
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803684; cv=none; b=Tufdiggh1wUQwFM/F0kD/VA2H6gL2CR75Y6n2qK7ZX+RfQV5VvBsCdSmWQ4nQFg5Vha1SPKAy8/zzHwYL0gKfvb6BFm88E7p5/YOC01bQyVopdpr9ozNOwFDdTecgmDkna308UxF7aK8CNO2Uw+4sVwFs87Wr8JPPIA9s6e0kBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803684; c=relaxed/simple;
	bh=NwCSwijrqz4T749QTxVF/giuU2czRDtJtHecbGhIXuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBbeAcQRHDT5uq3RmiKtPrpLCSXyIE6fgD8pQwIG2mL616DDAeKw8HZh3OfrIJRkJtw+AUj1gT5fHZp65eY1acDLNIxAWHGTyaCQZBOcYzLAFjm/JVvQbp5JzDbrhooPX0IdNoW2jecyBBwrFAkWEPQgGPykyg6bC+p1Hab9k7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/JRNwSm; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/JRNwSm"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71808e95ae2so1015927a34.0
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803681; x=1730408481; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRquLpBPFB/M9Bhca9A0Cbii6LzyWcpzeLaBo9u5bD0=;
        b=h/JRNwSmX9THx1NBGBhQ3Fj+hCNA/zlRnDI9zih6vUIuBDyujnOmslmmgCFT7HTQpx
         cLGMrXv2gg/xsZPaCd09XfVqzcLq1YKz+u24Jfphn0hz4xHGWdM3m2ji/MDl01SZDsxU
         gDbbHz3X+xwWxRqK5ZiYUy+zIDspnxo6iq8mROn+8Lu1BmK4sbntVmnwHFTnrDNh5TAb
         gR7FqXDtLhi7qtiZ93s8PfWD5vCr1IhzwyzqGtZ0g/Ol0ZxFVrwtt1PiNPN2tAsFNXuj
         3z8Kx1BC+BNbpqgxYAiNrMURt5ny7/x/g4B9PV1TL92UELEbPoqcfBYf5Onjw2hZDYWf
         /T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803681; x=1730408481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRquLpBPFB/M9Bhca9A0Cbii6LzyWcpzeLaBo9u5bD0=;
        b=p/xtwHO8GYBwy2hWjVcp+KBAs0wWt3o37Cvss1NGPOnsJqV0ESgrYoiHyf/5XD/oA+
         RJMkf7yq53oTnLj0bE8g3DTS1+UWscCBrZrrl+yYu9JIJMiV+lN44Lc5PbE0CPJoZecJ
         wNgj3ppz+EZh42RY9+DDuAQ8VnWtzIx49KmnF/F5uKduG3R2vhiDai/ljzfL1055+VFP
         ZPKRqy49Towkwd2WFeEO4PZNmFf0RZy3vax0hQCHU1DjYRV7shjTyUymSXd89wAK3EEe
         6JePN0TTmKAmjk7/ieY1edPyDPIIa9bFNlXptbxfdr1TebSgzFoCJjqC4XClHJkoAkoV
         uGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrOh5fI0nn80vQSF03N2f5UVxxiwI/rjcwxeAVzZb2RkBo4AQAsPnWbJb/wrtp+x5GV6k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxUCZY3yselpHTLjyLLDQHJoKoLt94ylINNMrleBOIcRSEp8nyB
	quLp/4JGAmv4E3Oh/yi9Ie3V0OrxEhHj2dHxR500jbh0u21Opf1v
X-Google-Smtp-Source: AGHT+IGDdHTdPKqDn6BbCtkuQgzdJnlwRd5/d1nwMjpVwiLgh2azzmaEppM3OyY2GmcoxPn9qKU4CQ==
X-Received: by 2002:a05:6870:89aa:b0:277:fa33:a19f with SMTP id 586e51a60fabf-28ceba86ca1mr1947245fac.10.1729803681112;
        Thu, 24 Oct 2024 14:01:21 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-28c7925bb55sm3235488fac.21.2024.10.24.14.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 14:01:20 -0700 (PDT)
Message-ID: <36cbf092-9a4e-4748-a0f9-404ede666f44@gmail.com>
Date: Thu, 24 Oct 2024 16:01:19 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unit: add test with list of known unsupported frequencies
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241024184338.186018-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241024184338.186018-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/24/24 1:43 PM, James Prestwood wrote:
> These frequencies were seen being advertised by a driver and IWD has
> no operating class/channel mapping for them. Specifically 5960 was
> causing issues due to a few bugs and mapping to channel 2 of the 6ghz
> band. Those bugs have now been resolved.
> 
> If these frequencies can be supported in a clean manor we can remove
> this test, but until then ensure IWD does not parse them.
> ---
>   unit/test-band.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

