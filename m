Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBC199239
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532415; cv=none; b=c99dv9V5UlXYZZdxicgtPVYkZf32vrJVgnovOGsEt9jSQ2lBXnnVswzi2tHbNIvTj6eG/YJshkIPIzL9ymU3ywb3+uPoANDpdSwLWBrxuNvdKJn+SIqL8cffS7spiVw8OfFlZfZ5HnYw2GbJCdNHRB6/nhXZiJia5JO+1FCGQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532415; c=relaxed/simple;
	bh=bybfaXfgbtNGGdLtm7141OTyYtmlkFBX8f1wUPZjxvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPwWj2z0uEy3ynsprGU5wrvynNVX6PCnYfh/ejrT7yB3VZ9PVwmOAAkEuDHZE4NmqKtvDZRV7TIbpWWyhVtbTTuwPrsLqklAjWsxVlRdPcqXcWWTEtnGJOdoVJYO2oLKmblKjY1fEcuPaXe9VP8PyxTOILXLvwpVIGnaPRQkRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1b6CQBr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1b6CQBr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7181a8af549so1495936a34.2
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729532412; x=1730137212; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAzHim7sFQ0of36vdSnssfuxZxKixkd5wGYcLqi11JY=;
        b=L1b6CQBroIHvBCk0CLVz8MjMpjG0W0rmXIPat1VI8lH3JGaU8EbcDn/ulpVQplEar4
         fasyJOkrwNyOVEpDSuAS2eVb5lQfjgN9yw7cInbt525E5vPODFnugjRpOl3pHRmivMP8
         Fzi4/ZFO6i/DvcONXXAjK+bbArieD0twDGLqr+R88i70fB1qAmeCBfjLzU+o8mPfe34j
         V73q9DJcy/0q0LWIkUfE/uYgSVKcTzxZK76rGJlw99h/tZ7TZ85pen9Ko0miFseBr/dV
         eEhu3qlBH5aPVcfhIihxAlVp+llwvV3v+/cuFGhuGjazGoPK0ZPOcOQHl17gRZhT7pyl
         qd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729532412; x=1730137212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAzHim7sFQ0of36vdSnssfuxZxKixkd5wGYcLqi11JY=;
        b=Zvz/OGKsm0UnjN3mw8F9usNjxXTd2ewDytcQ1rjWPWbjeJEe/EpTOnbfKKKYNjYLtm
         S6By9j0tupZ8KjwfvnI8gGFt5b73ng8Ewtn2g63n8rqU+G3Ms990A9aqhce6R8++BUbi
         AsiwkZCXSDUiaiUYheqmYubpPnxRWjbnW928Gy0xQhqJ2A8a0G/2T0SL/d2vUMlsB/sf
         fcGVH3jXrTbErCfqD/bk4AWorI0FGspd7/omj9Fvoq4J/OazPRcDz/9TxRnLcIPzLlik
         B2GE3L0YWW/MMgJGnTecR6vDXOEO2J3lp8NXb/NJz4/aHlNCqA5EAAijyHDfMwptzTZs
         Bowg==
X-Gm-Message-State: AOJu0YzHwyiMqB22OjKsbaq4V8M57ey9iM3H8AtUFP1k9OTMzNQh+viD
	uQsSSkDz4D1ki6xOPrsYtgYuzUIALvFTHwsQxbkh4eQqRo5gkwXQ
X-Google-Smtp-Source: AGHT+IGi9Y2XLFKiGpxewEh42XRzm7SVrb0dIWbHWAEQwtX1q3uAxjLHsUJXDW8a4eo79q90OO7q6w==
X-Received: by 2002:a05:6830:4386:b0:715:4cb1:4414 with SMTP id 46e09a7af769-7181a6eee49mr9789370a34.12.1729532412167;
        Mon, 21 Oct 2024 10:40:12 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7182eb50327sm856957a34.37.2024.10.21.10.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:40:11 -0700 (PDT)
Message-ID: <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
Date: Mon, 21 Oct 2024 12:40:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 James Prestwood <prestwoj@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arend,

> 
> I have not seen patches for OWE in brcmfmac. Looking at the supported ciphers:

OWE is an AKM.  It still uses CCMP/CMAC underneath.

> 
> Supported Ciphers:
>   * WEP40 (00-0f-ac:1)
>   * WEP104 (00-0f-ac:5)
>   * TKIP (00-0f-ac:2)
>   * CCMP-128 (00-0f-ac:4)
>   * CMAC (00-0f-ac:6)
> 
> The error message seems to match with the above.

I've never seen support for OWE in brcmfmac mentioned.  OWE requires 
CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive the PMK, so 
iwd can't support it on FullMAC.

Regards,
-Denis
