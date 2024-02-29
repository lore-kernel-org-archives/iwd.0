Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA21552ED
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239106; cv=none; b=gAIcErvas2wSGFrFTnHVeUp0rIuq6kQ35IIwYtiRbiLUZahTFzWJOxAyzafy7t7RoJ6evkAOC2ppWq2IsMf0wTZJQIrrqEUgYeoS7a8uFvBRKKXl4U2MCq+VCEweGPn+AGvfLCln0iMK4cwY0du0kuNLNGkP5SkhA/VkIvEjOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239106; c=relaxed/simple;
	bh=ouae2JEwIjzCbn3nFyzx79snoyvJoPUABa0TP9kSgBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rsteVcG9FvRrxnQrlAAoxdTpGs2pDBSZBGKszNxQPzXe5lyKCtrAvLVni6vyKMvrs1oB55YmA6iU387B9xWEcK1BJkWtxIGRus15BqNm4Lh0owt9o80DJFbbXtwzxAcPC+Ru7Zxr6bq4fElO83GKJgBxRvYzVDRzNwpBkgbCnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi060eyL; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi060eyL"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a0eb434eedso460995eaf.3
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709239103; x=1709843903; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdedUkbLF1llqXR1IbJfHgCiyusGbtQMIpq7JQM5AEA=;
        b=Wi060eyLpq7kkWGzjOWoa2eb43PBjQ5V6S9ZZs4ILdJ00mXQO7GRozD1E+si8xJeNA
         AYIAHIaRi0WPNFLl2lgFHOe3Ma/nxng424J1SHyzMReiSo44AtUmSl+zZ7YwhUL4We8k
         FY2ImKqBKe7bSJV2h5E6r/x6qz3xSQDZX+SM83EzlKR1mTYl6VGxendYVAzO6xysMw0W
         /6INdF7ZTrC4xtB91YCGfSmuD8YMoqQ/E8+SfU92XcoGH5xZEuxEnWiAkJJk3oLNE8Q6
         yafZzSHxrpXMZnFD2TjvBXLIKc0s4pbbY5GVZzyOGNIZe6sqbk8UhfUvjG52pRB64C6S
         PHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709239103; x=1709843903;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdedUkbLF1llqXR1IbJfHgCiyusGbtQMIpq7JQM5AEA=;
        b=hOVf3MmjVeF8e7oFskqdPzShyQvkJ96KkWHSpQFYkTC0tou1zqZao6opVsXhZzqryS
         xvPge9CXxdd5jI7RcT6jDsbsQJBaLOwRaiG3nGVLF01tlbRopYuA5dWahxNTL+bnZtCq
         bRMUhC2cK1gaRvVoXh2S/77TSZ0NtgOOEKRUB290jxajkecOrJWoV2CSdQmVcIEKk/Ey
         0q1LIkS/oqd7Hj1BTpHmCDhglI8NVkrl6oC7JksQxpfxoaJon2MBUGtZ5MFJj83oLgJG
         QS9VZYXv1Yo2Niy+A3EwTz5fHV5noQm2Tfo93u+vhxNxfqrN2qqUoXckBqqb9epfRbXZ
         ImIw==
X-Forwarded-Encrypted: i=1; AJvYcCVtIjD9YlgXm6iHdn8JyG3ucoX9EGDZOc+rcB3gLTInSAn8N5C9mgwvzmeG+BqvqKq1mUsb8XubislSr8uVPDXbX2SM
X-Gm-Message-State: AOJu0YyAPPJ6BfpAr9FC4GIaz2uoz6RVpFGrV0cpkQmowoonsF2YQ5gQ
	wXTXtjXReG6+UOdG97jgq/u3EaZMH/IUsqu2g7Vslz6fE3ACHUXlRSO+xn7G
X-Google-Smtp-Source: AGHT+IGV3rSeFFQ0utDzjzSLjtzE1zAzQQTxlwY30ny9CRw7AJrxJWZjJvO5NQSkwyJt+4wS5QcHVg==
X-Received: by 2002:a4a:3512:0:b0:5a0:f6c6:295 with SMTP id l18-20020a4a3512000000b005a0f6c60295mr1232018ooa.4.1709239103361;
        Thu, 29 Feb 2024 12:38:23 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v18-20020a4a2552000000b005a0c9264b9asm428186ooe.39.2024.02.29.12.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:38:23 -0800 (PST)
Message-ID: <4d2a5d58-adc0-40d2-ac94-45c902135eb5@gmail.com>
Date: Thu, 29 Feb 2024 14:38:22 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ap: check that the last band_freq_attrs was set
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240229181217.1503555-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240229181217.1503555-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/29/24 12:12, James Prestwood wrote:
> Static analysis complains that 'last' could be NULL which is true.
> This really could only happen if every frequency was disabled which
> likely is impossible but in any case, check before dereferencing
> the pointer.
> ---
>   src/ap.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

