Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13E1D63D6
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779097; cv=none; b=aSWS5X1EmYqM88CcJERE9E5R8a1lXmVlcdGqL+PxdNuq9YdhMTOc3U1a33MjZZq83HbDQ/IiGAzsNNCVZPAlG8cXz+IXz4iEcQCivkE8Lw/lR9Q93RM2nhiStw98aS2wmjbfKAZ/3QsuHmgK9TKmcWPm83S3Ii8YsCo9riE91YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779097; c=relaxed/simple;
	bh=HnYn2YewHQLs9bQMjWRagNGiofjS30WcT0OOCdD0CnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jj4x8fQBAEgWNb9Y9oMhKfi9u8QcKA83Vtn1oU3/nT7QJ9ikq5tHGgeaHwHNAH1wp2xRLmpC8kIemvyFVKlBmcsnaqCOcGkXu4rwgFgsueq0ahkaz0L8tgYhvLW0kmWI4yXlcEaTb6pHlkmsAlmsQM2FbLwqGEVD66IikCzgOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYu3Gfvk; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYu3Gfvk"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e60fca5350so575371b6e.2
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729779095; x=1730383895; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkGAftoQ5FYuPt8NYXCnY5aPhRO2LxJPZhG0K4XoRJo=;
        b=jYu3GfvkGkOjrk2j1IVLjBlD9Rgj6T1tanvZYnaFWsZZrQsJaA55Fv6VjscpJatwyG
         DdjDHOpo5oX+1lXTXYmimJkIgQTDFmoUlZsTNXw7I4iVwT10SHQQTxUSFUrZq+rlAWNG
         ryNbDrP+qRpltP3h6YcE7eEqC13EyCPYG5/T+JutcghZBnISRD1gdYHegGORum1eJpve
         xyez22lSyKuyyCHcg056fSdllx+eOBxh3gJJneQOkI9ohlJzwL8EgY092NDpMDwRwxDG
         2+O+8Ws/MCBIDQeFfEZ1mMM6UF5ACIr0ehaKI2K1bz5MQm3woOVSnVSR67WjTkkJQNBe
         2m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779095; x=1730383895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkGAftoQ5FYuPt8NYXCnY5aPhRO2LxJPZhG0K4XoRJo=;
        b=iv6TPTFGZatACek7G00ArNnEOGQM0xXkxmQoeDRYKEuM9D/AxcOp1pOnaZuiVxZCk3
         e3crR/EsbsAZtNrtnN/2XMxajqSdEkgp/+6/1nqENAUP8Z7XcruqkE92H6vvZdHf2Oyo
         pRZA7rzdd1sptEA0ATFkqt+c62TSTC04kDu/US8LZ4cbfQpanHsgp5tEzEikIXoMKNvT
         2R4kriyU4JOoLw0E+qKV7e9r67gcnH+F8WUHX8SLPRJ5WdwiSJOmwIrWUSvXs65n635Q
         dLOlR8PIxdoYBUAAmnmJtnZjVvp2GExTTcU/UFQB9wtUIia4/XESvC91ZQ+GF3oHqTRj
         NWKw==
X-Forwarded-Encrypted: i=1; AJvYcCUd5nGzgXkYESjOV4sU5NesMX1RYF500Cz/wvCMJ84ov2HjZzkj4Jf81jBmtarclbrsIwI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwsB5mYd7ZaMlLuIrL/oT7xaWKKzqNKYgvqsrGRla/yQnyJ9PZa
	BLecVv278KCudDM15fsCixYKedds3k36mUjxd+j1Op+gSfisu25NmXguZg==
X-Google-Smtp-Source: AGHT+IFVHJXwHjkJ0cxIjjdx4FPG8qgkzJPeGZ28Jv+Q2gvRjhFPsyFhXhORYpCA3BbEbW/Rc+nnvA==
X-Received: by 2002:a05:6808:10cc:b0:3e6:1cf8:e080 with SMTP id 5614622812f47-3e62cbe5ce6mr2077659b6e.37.1729779094679;
        Thu, 24 Oct 2024 07:11:34 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e61035fca5sm2253549b6e.55.2024.10.24.07.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:11:34 -0700 (PDT)
Message-ID: <f7e3ca50-8e54-4117-b613-66c188da7851@gmail.com>
Date: Thu, 24 Oct 2024 09:11:33 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] frame-xchg: add multicast RX flag argument
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241021124228.145516-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241021124228.145516-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/21/24 7:42 AM, James Prestwood wrote:
> DPP optionally uses the multicast RX flag for frame registrations but
> since frame-xchg did not support that, it used its own registration
> internally. To avoid code re-use within DPP add a flag to
> frame_watch_add in order to allow DPP to utilize frame-xchg.
> ---
>   src/ap.c         | 12 ++++++------
>   src/dpp.c        |  4 ++--
>   src/frame-xchg.c |  7 ++++++-
>   src/frame-xchg.h |  1 +
>   src/netdev.c     | 14 +++++++-------
>   src/p2p.c        |  5 +++--
>   src/rrm.c        |  2 +-
>   src/station.c    |  2 +-
>   8 files changed, 27 insertions(+), 20 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

