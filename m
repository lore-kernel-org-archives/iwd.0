Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF114C5B6
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071399; cv=none; b=L9ruTusEDTw3rqz6G6j4FtaOIqU1dHMTJ8LNYC+jjcIsAbqTJntw6NSDJ4IWyBSMnzPp+U6yXjxhjvPMvMVM2jrM2OkhAW7an1Ih96vrGoTXhdZIDxBEG6KKYbC5kLNk0bxYc99d5l3osIgacfCYpNNDbMiXTkSY5Zu89Mvdv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071399; c=relaxed/simple;
	bh=J3aJCafLzbdczO3QAdaNzAK2myOEM4lq+r3md/MhAYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c3UYp2ii+fNpfKaadYq2KNMuJ9Z68ttLP/+g9sXiamfrEDTTdXF4gY7OGTVeH1K+qnR2BKDcCGb5w2cFkJXy6abDm5tbiUXV8WupH/zwvRCybz6emZXI1AZ4gr5vMyeD/4oBuPdmThC7vQKnFWDcvr8VhxrxkHFJ0F5AtmImbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvIOvFIT; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvIOvFIT"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22007fe465bso1597362fac.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 14:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071397; x=1709676197; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bY/n7sXsWKbJs24mnqi1Ws5DFgyK85c4F/wkj3/477g=;
        b=KvIOvFIT5VXmINdll37WcsZYOe6HXQ4cyVTDQjdHlSPfvO2UCF5GypoHvbnIVdFr0j
         +Q36mTBrLt+QwrnMe+GZvDjCvfVJAVN7F44Dz3JMWzV4k1psinJWpisb8RunCR6QA5Cv
         YUI69y4w7E8h7GB1yuG1HKOL4IWJ0i5MMvJTded6l7FU2RM6d9SicDiM+yfQ/ejGxy+W
         PLTfbaisn/xOl5LxTvBys4s46sXQfobJgNU0S6yIqPAM58pO1Iq1mZ0HpaSiBZCrSDd0
         l+6TbQjPVBVubd6Y2jkfujjg9xq75bKXlTGAlyvDUKdlc6Bf/ONEzQo0QpsAGM52yD00
         yrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071397; x=1709676197;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY/n7sXsWKbJs24mnqi1Ws5DFgyK85c4F/wkj3/477g=;
        b=kmn9c21El33QSNxo5Ijw4c5rTSgZg8Kor8OS7spA1MYDJBmpNans8WvFtNFj4+PxPZ
         5q12E0QU0ioQeyMFJHcRLjZGonzn4JnPjOYfXYvttxHNHwijr6riPEwN211Jne2v+YQV
         uZG0NIIYrWn/GBFouP5MtWzqI78+wVmSQR9KZDjVU0rbvgJGvNLnqs6J/HhhBUN2cOzA
         J4rREHVoC9HIjyz712NH6mWVf9f75pUcaVWMZ3PmRpJ+CUB0OPdma+njLRQO3CKbsJqI
         5WE2ifSdeFqXV13Y2CM8YJulPu4oCLmqQuK8AiPirXmrnRf8ffAZ8QAXhwvsp2L2q3MQ
         aFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo/BoXZKhq/kLK4+Vr8psNoZOKIUA9gQYZM7Q0G+msXKoGOwVYBsViQqXRPtgrH44ycvT0PC+DvudH0Xxu5k9Jxgki
X-Gm-Message-State: AOJu0YyxUfFTUUQAwZnXtLbFjNUyxyTXpxb/gxBNVhbZARvJgnXbLcUX
	d7wFj3nlFFBl16SYO+oKr5ZFR8gzcqYMXr62H4+0vIs/U5W7o1FH
X-Google-Smtp-Source: AGHT+IHRy9Rson5YQ+vyy5ewbCWGaIuO9AVhDxEuAfkFvkdPpD5T4TGNT/9G8FCUkmypMcXP8KaxmA==
X-Received: by 2002:a05:6870:514f:b0:21f:828:7a7c with SMTP id z15-20020a056870514f00b0021f08287a7cmr14639095oak.6.1709071397382;
        Tue, 27 Feb 2024 14:03:17 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id nw15-20020a056870bb0f00b0021ebd810c92sm2255317oab.41.2024.02.27.14.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 14:03:17 -0800 (PST)
Message-ID: <e764060c-8289-4c6f-88e2-73457a7629b5@gmail.com>
Date: Tue, 27 Feb 2024 16:03:16 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: fix uninitialized variable coverity warning
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240227211618.318442-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240227211618.318442-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/27/24 15:16, James Prestwood wrote:
> Same as for aes_siv_decrypt, check num_ads before calling memcpy.
> ---
>   src/crypto.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Both applied, thanks.

Regards,
-Denis

