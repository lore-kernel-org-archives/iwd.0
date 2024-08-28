Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15F42065
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811811; cv=none; b=U++Z5awR+PQDh76UFIa466hk/s9qInjlgHksQxwbwYndnhdQdbuxb6bupRbpJIxwOkvSLRaYa0LIaks4rpH1RLdi4vQz8R/6t82jw5XOlGkBOsSY4EwNu8sMze6WRTpLrOgjCjnf1DcTLvf8H+ZDS8NXZcOwdd0ctj4U1LMJ8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811811; c=relaxed/simple;
	bh=Iw0j+L8lJaI9jEplxV/WMjVYxN/Ca1s3yk2UpkxCZFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bUJc6tZ0pxsdS4jaWDnNsOLg+cwRmaLYNxl08Jpy55wCeGroaJjzFACIftiUSU8U5zrw5ysF6BVDUObHGf50cV4Nj67dwIkNa3eOz1PwwvFIZkAP47BIxB8CkzcyfGvgiigIH818lcA0DUBstvvyqSM3m6xAqHLxhHOxMygGy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMGPzOCs; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMGPzOCs"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db1d0fca58so915791b6e.3
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724811809; x=1725416609; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T17fVVejQCOmFR81E3XCOa8rcgWv1f5XPSuFtI7mBVs=;
        b=MMGPzOCsVcGs/VmqX9yHKrsV+T+O+VITaEu3XnXlsAg/go2wVlo6cUdHX/ljQJoRA9
         wBYhaEALKPMWeQA2IrkU5kXSZDaFIxqBjeDduas13+UZ7yI9jmsUTy6nEz8n1hApCJJ+
         yWd1fTlsUZDjfEGThylPD92DmOIZWdmb92JQE2CjBOuOv0ZyNnUS99WoeSyz0O5zHm07
         s+Db86KUGbMA1keavgcX4tE/vJIuJI0zdZhWV8j5c0o0t/W9S7rtqp13QvwO0WHknD8K
         8jalNTCiE/0Ed+dJ9lV/OgxpZb2L5HNdhaJDSfsI/g3TseswTOjm1OoQNUiIfm05b2j2
         mVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724811809; x=1725416609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T17fVVejQCOmFR81E3XCOa8rcgWv1f5XPSuFtI7mBVs=;
        b=irsP3gaAdm5EHtq/FHcnIxyOFJUprlxuLK4f5RR+StcL0uiMePn9DHcyeJk4gG082J
         xtkObX15MC9etro6j6SkKpaIqkjy1aPBL1CICFIPEU0rnB8iFLgG3RpsnZ6ar/T43Lb8
         qiiwX438UCJHVEE5luoKcIdgb65Qf6ReBUeb8kPAv1Nfnzey5gerVxflxgRhEgZskqkQ
         uEPPyxhI4n6/Wscu0LvBV0e9mNG/78GSf59VPFVqPGjCzG2d5LDITN1ekz+0dxNYoP80
         i+vL2jcrVP6JOfofgPqjQhzfPcHEN9HXMmIlL0gShHb3j4rWTnzjU2bVZ8+krXDUJKiG
         T5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfVdKnPpcsdHbzFERjueP1MaPzML8EgbmL5mToWOEoqrvYEmb9p4GfxBw6dUvQ8S4BnMw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxUisGdsmf/F1e/UDIacfAnw/byUR4mRTvW1ip8lQ9DbGV3HTGv
	hqyIkV7zUjXiGCyMKZOpEP+iZziLrZ50WaJR+EaupH1MF8jSBsMD
X-Google-Smtp-Source: AGHT+IH4ghZ8xkNvQqj3vl8omo2WHGcMlXvdu5pos6CTETHXxcYaEWoILCxLnRhw9OI+yogLELe0Mw==
X-Received: by 2002:a05:6808:3c98:b0:3dc:172b:dcc3 with SMTP id 5614622812f47-3deffb9e8e0mr864425b6e.34.1724811808809;
        Tue, 27 Aug 2024 19:23:28 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3de2252d3basm2919432b6e.2.2024.08.27.19.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 19:23:28 -0700 (PDT)
Message-ID: <4c5400ab-d416-40d0-8c4b-b64c773d69e6@gmail.com>
Date: Tue, 27 Aug 2024 21:23:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: deprecate UseDefaultInterface in docs
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240827141810.750603-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240827141810.750603-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/27/24 9:18 AM, James Prestwood wrote:
> ---
>   src/iwd.config.rst | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

