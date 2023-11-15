Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B913DBA5
	for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAKR6reT"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d2efe8c43eso566914a34.0
        for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700075255; x=1700680055; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+84BtoJ1wV3z8vgnrIEhdNXShCC5shZBCi99RfuEt9s=;
        b=eAKR6reT2ZOIkC50lF220wpd2UaqCFm5QL9zTN44C0fez+npnwq4Pq/xFfL5HVBg4R
         YEXRic4FUSrZzudK7ceykS5rj2TZ6E5kRmvAPcf7InOEh8UdzcDwt3PlLNFGqDaeU0kz
         3Tov4P3tgbZ9Ip00/7RnOtnzd983OuV1QYxijQ06CWNaY08JLAo2L++kkBUNdLAKIJnO
         GabgVD4QwOhkKNmKD5KI2dvWFvD1vLh53IXPd3OM0GKe83xVPaoDDSvOfYX5WlZQdM3r
         8kklL+JQN5PsPS+8Li8LuqMuTV3juUyHNqACraGJ5zvMVZfrdjjq6GwxPLywbsJC/I0r
         D6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700075255; x=1700680055;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+84BtoJ1wV3z8vgnrIEhdNXShCC5shZBCi99RfuEt9s=;
        b=MlvsahsmAculfdlVsEkGuf/jsfK1WuHGi5Ie1NRvCa/2a7fhnICdhlTlQa5NrLyIS8
         TUVhpl/229Hj9keVKbANIUVmGTFKy76OGAK5AX9E0CMIRvrrad+nXvFCNG+HWHFsv79t
         5XMkk/iyl9Ilyo6W78RA08XmUE5QA5yX6/vQfwjaTlA6qbQBi2KwFELzHSv5+GCO5pDi
         pzG4GmcILmst7Bmypd8HZLDRSzhFdTzazQEpyRetSxLTg6TV3+KlZQA9WFENzo6vubNE
         Pfp99nC+ipumyn9ALhSmREeB0IB7L1GtfyaQcPZl7u9KjWG+SE17rhBFDQUNGhL9mGNq
         DrCA==
X-Gm-Message-State: AOJu0YzQU7caiU/PpmRcE5wEM1DcwG1dCiT9w28LZ5M5KHnChFFk0b7f
	sGpA5zahcrolfg4GoNHpND+6lNTXyDU=
X-Google-Smtp-Source: AGHT+IEsJvG7h03AWWR2TlcB/U08ji13kYMFFZMe+KTRmQgXX8Q/lipJ0ZPpbODjz4GNw58BPmZxiw==
X-Received: by 2002:a05:6870:242a:b0:1e9:b0d6:81fa with SMTP id n42-20020a056870242a00b001e9b0d681famr3201029oap.21.1700075255272;
        Wed, 15 Nov 2023 11:07:35 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056870a34400b001e9ce1b5e8fsm1852832oak.15.2023.11.15.11.07.34
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 11:07:34 -0800 (PST)
Message-ID: <246db269-f53e-41c2-9784-19fefc596a2a@gmail.com>
Date: Wed, 15 Nov 2023 13:07:34 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] netdev: Remove improper use of netdev_connect_failed
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231115000547.1139157-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231115000547.1139157-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/23 18:05, Denis Kenzior wrote:
> When a roam event is received, iwd generates a firmware scan request and
> notifies its event filter of the ROAMING condition.  In cases where the
> firmware scan could not be started successfully, netdev_connect_failed
> is invoked.  This is not a correct use of netev_connect_failed since it
> doesn't actually disconnect the underlying netdev and the reflected
> state becomes de-synchronized from the underlying kernel device.
> 
> The firmware scan request could currently fail for two reasons:
>    1. nl80211 genl socket is in a bad state, or
>    2. the scan context does not exist
> 
> Since both reasons are highly unlikely, simply use L_WARN instead.
> 
> The other two cases where netdev_connect_failed is used could only occur
> if the kernel message is invalid.  The message is ignored in that case
> and a warning is printed.
> 
> The situation described above also exists in netdev_get_fw_scan_cb. If
> the scan could not be completed successfully, there's not much iwd can
> do to recover.  Have iwd remain in roaming state and print an error.
> ---
>   src/netdev.c | 35 +++++++++++------------------------
>   1 file changed, 11 insertions(+), 24 deletions(-)
> 

All applied.

Regards,
-Denis

