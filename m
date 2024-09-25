Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22AE183CC8
	for <iwd@lists.linux.dev>; Wed, 25 Sep 2024 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276027; cv=none; b=UqFRmpQ/Y8UhLiW184PswxuRHQQd3yln0Sy7/aN7rnBxidmsi19+wCURgXVepZ44/Q0EcN/mgo2bWOcnfxZih6W/dfGIXr8mWk4QaNU2sUDh20Qioh/jQ8REqkh31PSJ272aj/bHnjXdZl8LE2rv9bjDng5debBTtoXsNn5zhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276027; c=relaxed/simple;
	bh=sN7+ggjn3TfzIhkYq75zkkv3nvPrw92Vtaf6JP5ztPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XvLaOzYFxdYQz35nR1/2bSuFxV5TYdCJm+2z4DSYqK7HdxdnJahyahV76iUYRzZcNBSlQRuoN+H/b9e4dJiJra7TGtinssf9s30ASKWR8fkuUC7ERyMDP6LZAk19YjvlC5348rKFQFPeZuiIfldReSQvTrfyEOL1JOq/soFFhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbb21FNS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbb21FNS"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e07e40e7d2so459533a91.1
        for <iwd@lists.linux.dev>; Wed, 25 Sep 2024 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727276025; x=1727880825; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVVzk9ocKZPz1GUneG+74zh3WDrUaDYEJfn9IgtWJXw=;
        b=jbb21FNS9dPKgI/UCjNIRnRtlQjIGS+DrG75EY8P+z7dm5k9LJhQlU/Bc+RfE2Ibsr
         H3yOoMIMaziHkCpI1H5yAqtEfv5VwfBEFeKyV4tqs0fU3Vx87g5LJdYfzEdXE7LUOydb
         SIxHJRwwemKo21iIzb/ZACoyKtGIg7hcGvR/WgJHFhpmqU8RJBXQE6hHkPPekizHH+LM
         L6pZAmyHcEyGk45dRHUJwy0wMqkX+0cR5k0+DS/AwjhYxrB12vftIWAdqbFOttPdcvND
         POw0hqEWEwjjFNPI/IWP4Ka4IQgeablOS28EqxUyAJt4cWgPahMbnhDlFSjALxQuXco/
         sUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276025; x=1727880825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVVzk9ocKZPz1GUneG+74zh3WDrUaDYEJfn9IgtWJXw=;
        b=wkzym5reZw6QwkTk3WYsSZDOVlRGEPt7JKOoa3/wlQfGqy4vEIOVkRMBDO/fPFg9fs
         4kaf9lG2n003bNzneJjPRQ+vA6DU8RgQVy/rEWwalgIjb/+PJNE1YelW6PEKJqfsK0mF
         yVLLn/sY9n6VL64H1K1Zbsoh6ORNWEfNf6/FN3QmrpJd/McyHyILuZ13PhphvH+ui2dg
         WYUK7KYFBUIqr45jMz0IiWdrNca40LV6wJXoWy+Phklsh/prZL8l0RbX84lr3YDZZzFj
         WnqF57p9wkbSfWisutReKDtxkhUdb/b/jVWZs4QS6StRJMGZVgqxbGQ3hV5KEv3OVXBB
         8oVg==
X-Forwarded-Encrypted: i=1; AJvYcCXFgu7pQij1xzMRhyIVLd+dDNCD0HicXhq6nl2CabTfiNjNV/6LSK2jiPeKHX16ohqFANw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyQo/pC6OvqqSWas7qpOcv4Dm+HJVTOOtBOAuqMJ60QGTOBWkpY
	FjFRrAtoX0WZfV95LxvahbsE3NJ40Xn3bY1X42WDx6O4a/bRnnbF
X-Google-Smtp-Source: AGHT+IEqtr3sEVlL1MwIPPi3jKvLMTd4wQN5CtzPSXt/FY2huRgdTB2POsGapMIFsqtNaD2Z0f7bRQ==
X-Received: by 2002:a17:90a:b887:b0:2d3:c0ea:72b3 with SMTP id 98e67ed59e1d1-2e06aff4a51mr3409464a91.34.1727276024861;
        Wed, 25 Sep 2024 07:53:44 -0700 (PDT)
Received: from [172.20.24.121] ([12.176.89.3])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e05b5c182fsm1995124a91.1.2024.09.25.07.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 07:53:44 -0700 (PDT)
Message-ID: <ed2fe8c5-7f0c-4ff9-90ce-c3ba55641b9d@gmail.com>
Date: Wed, 25 Sep 2024 09:53:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] manager: fix UseDefaultInterface warning
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240920163614.207001-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240920163614.207001-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/20/24 11:36 AM, James Prestwood wrote:
> This logic was incorrect here, we only want to print if the option
> is used, not if its unset.
> ---
>   src/manager.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

