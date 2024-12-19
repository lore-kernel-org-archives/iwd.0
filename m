Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5419DF4B
	for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627793; cv=none; b=tmmIv3mDYgKyENtLQTyQtyb0u7hKMuoWh9lsgg5CwlZRirT4d0I9OWFSt2KVU9VyM6PB98HclgMZw2KVn6ZZ10HuwqvtkCeenlGT0pDByuhHTG/LuX/Vvv6eRbf1we6iJGzXSnKBC6AbE5nXu6csEVjwniumY8+oYC7XEldJzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627793; c=relaxed/simple;
	bh=mQGcwqBtWVPWe6i8YY0uZGtYI+ZvcAE46fQ92MbN40w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aJx5XKQ19f+dUaONSYSzZ9j+lW5c8EeAmlCC5Uu4ovrAlFnlJMELAYDJrmpKmEd1xSJibcUCJ9RNvW1Ok5p3qvHDRDiodRRCREJ0EawhtvPNn8Ug5HQmiRH+kq+CTe9CsmK+doOPL6vU77usHf3RS7X23A+Qzk1mVIEpYbYXDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm49+LqU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm49+LqU"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e161a957so77818839f.0
        for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734627791; x=1735232591; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IgYZGUExroU/tGngMZZ4x2ZOjnpSLmrGyKbefDEft5U=;
        b=nm49+LqUaqVYEhsxPJ+8GRfbOp/sck2FtZ+6sXe/Q5UNWyzJqWHj707h9tmfK8jht0
         FATXMAycDd+f1B9Vao6ifX4vB1VRTyRRF1Eqccfs6O3b5/NoES+60lOig9dtYPp+fCvI
         Rd/Ocu7I3lest8Iy5cYWI2njUNYvFiEBAh+4ODAQzoFqypUi5CPx3/ot5ic/vbr0Esmn
         l9pPWwMhx0n/YWhFa2lEJJw24qtDAshk7VJtXOnPo9VIDfeO5gSCQ3NiZCcWjrl2NIEi
         GMH3TPvjxb+vWrPOmjxbAfL+n/XSq/p6NFxvplK4qFGOSQ7MW74a30hdFdtBCVvVwhJg
         hEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627791; x=1735232591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgYZGUExroU/tGngMZZ4x2ZOjnpSLmrGyKbefDEft5U=;
        b=SHjKdbNQ+0mJ/e/ssWA9NmDhk0Er62fHQ3Od7gvly/BY7LGfJguOiHKrnbr3NGL/eU
         5gSx7DIx2/zDKHibBMoK8nJonWpugocj4wu5T955kxbzWJwUPqt0vvurQL7+uPJnTRPq
         /Sh7MmgYujJPml0NRrBwIs/M8pLlSPZL/bArz/+83b1lb3W80myZLeePCNqw5Ia0AZ/a
         011aKmeY5Gm3WqCO2fqM9cCJV1oHzrf3hVqpzyni9p0Ql4FRuQv4AH7d9EI2rO5uGIsp
         XlK5Va5J9KyCIMBI5bC1dOOwMO+R2kQJZrB4oDZMfL0TYMkVqpyKdlRwy2wMf7qNqasw
         gMMg==
X-Forwarded-Encrypted: i=1; AJvYcCX/St787T6nMGSDKD3jZQ1HNOAcgfVg06HZ4NhBktHAj1FmXB4MglmW1edpICySzU8vBGQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwugCNK/Wj9c2E+nb5TIGAzuaSGN3nJoEjWj6p3wJBhXIBPQhFc
	PJu1TGYskPp8ldPBAjRlzbzNtSE3NTS903JJWnerqYYx6452/hTi58IBJg==
X-Gm-Gg: ASbGncv1fEJSHHl+wzCUPPWYyo7D0jrMH5prH5oAbUN0XCbgT6arT3HNap/aNrqEBxZ
	LLACugEoAoybJpd0QYCa8v+tu4dza+YicaRxSuqCeCfwaYOeqg3pppm6oK0xgbCsSAgAldr5/pA
	uP035cE2ds12pWbBs/yGXBbdJhZqnRTt+0ZkRNX4k7a5/wmEnpYOqmNjoAb6WIUQ5r/UtW2WrHL
	n7XzyeHG+nOCJLPUxMAVAZOTxNJIoyT/dMYx7SWJdQQec5+Fzwt1WL6XQ==
X-Google-Smtp-Source: AGHT+IGnbL+FcRDD8GeSM4uFX4t3MHuIVTkX1eyU265233Ao3xsZr9VSbEwfu+T0D0MXPQBTjLKJtg==
X-Received: by 2002:a05:6e02:1561:b0:3a7:7ee3:108d with SMTP id e9e14a558f8ab-3bdc51018e5mr80433295ab.23.1734627789652;
        Thu, 19 Dec 2024 09:03:09 -0800 (PST)
Received: from [192.168.1.184] ([136.35.146.47])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3c0e411e868sm3904905ab.53.2024.12.19.09.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 09:03:09 -0800 (PST)
Message-ID: <fdb51a3a-fcfd-4158-a8e6-f712602e56ad@gmail.com>
Date: Thu, 19 Dec 2024 11:03:08 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] netdev: destroy auth-proto in connect event, for ext auth
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241219124442.146136-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241219124442.146136-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/19/24 6:44 AM, James Prestwood wrote:
> With external auth there is no associate event meaning the auth proto
> never gets freed, which prevents eapol from starting inside the
> OCI callback. Check for this specific case and free the auth proto
> in the connect event.
> ---
>   src/netdev.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

<snip>

> @@ -2821,6 +2823,16 @@ process_resp_ies:
>   
>   	l_debug("Request / Response IEs parsed");
>   
> +	/*
> +	 * This should only be the case for Fullmac/External auth. Here we don't
> +	 * get an associate event, so we need to destroy the auth-proto now
> +	 * so eapol gets started within the OCI callback
> +	 */
> +	if (netdev->ap && nhs->type == CONNECTION_TYPE_FULLMAC) {
> +		auth_proto_free(netdev->ap);
> +		netdev->ap = NULL;
> +	}
> +

Would this be better done in netdev_external_auth_sae_tx_associate() instead?

>   	if (netdev->sm) {
>   		if (!hs->chandef) {
>   			if (netdev_get_oci(netdev) < 0)

Regards,
-Denis
