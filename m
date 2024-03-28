Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440F12F38D
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639306; cv=none; b=uGA/cOT2hpTWmopHSArHhhPPn6temSclGBicjGM4XOVZZTSuoCdKxBlI99Eg3sEicULc+iy8052Mp9f07ooJy9f3AsFhFyQAULPVNbh93RLSq1L695cQPrRaYjy13M/Ln2F8a3XgOpD7+XbcFaoz8r6fj0Plb4pRwXx9BHWi0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639306; c=relaxed/simple;
	bh=Ebib5BvbkANW8wZpDdGV/A5qonaMYLj7VbMHvBaFiFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ihetA/YT81EZvSMNausZD90jCqXAak+jqwWEArYkZQOlBgNdbw7ehAzlJ6uHoTi+SxBolBw3wZF20vjirRWwW0H2sCSQGqwBx2ThqunmH6HEaphCB/yfWHZ99dcTCQjwSmmPE2KbvtS0lIp+7qj1AO514Sd5XlWdg+3VSEncWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UccxBNj2; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UccxBNj2"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a467dae51dso367603eaf.1
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639304; x=1712244104; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZUNh9c1bR1+z3P3ZutceUXZxtiDVc1bqW5R4HTEpO4=;
        b=UccxBNj296PdsKqxbx9wR9e37OM8Do/UGU4bvS9CBvAICAhk2bak+othPDxRiS/QIx
         elEj3cNCmlP9ki05M62gPnsiBImiFX71LgeGc/4NAnHlQ9AGSu70uC2XDACC93vyCoh+
         iA2Jtbjw9w/gb7UmMNfHRjU0sxrqPCIE31l9wSusAT3Bpum1EsbVRFcxi44aphJadgJ8
         zxsl9kHJlF8rflZV294M1TJ6mjh9MqcPfLQaqBgcjl72XMUrbE+Vo+fLK+AH38rvHJ58
         IBgUn2qJoA1zkHBgHdAlKE9+Z6smooev3TWMgdjP3s42wW6TXsVmwFcSUCoJ1dSYn7CQ
         XOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639304; x=1712244104;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZUNh9c1bR1+z3P3ZutceUXZxtiDVc1bqW5R4HTEpO4=;
        b=rL3sW8SNtGOskUCuvUO/fDQpwZ+yho/VT6T5j8TnhfvZzmqV6bO4gfJaRWzU/Qbuge
         bdse/khP//wG/1+7eeggqH9hm/B1GFymPj4+Fn5NlTXhPAJMy+nOESd5X21rqyH0LaEI
         ++cD8jZLN9IRxGhLfmWyycQrx6CJ+V8+L3BrobVLULsi8U4GdD3BN9Hx4tDN4PsMwWk0
         QppVmV2Ux7UwvwtHAVOzJTiCj1ItqUKrG+Krq9GgboHu5jf3EWgSsayjnb5Bwsm1FrTM
         D5xbhAVv4XTMof3ON10gJn06RrjnecTqC57uMPuleNqsneSt1FG5pdpm659Vm1Duz8zA
         J4OA==
X-Forwarded-Encrypted: i=1; AJvYcCXKSqUoThW4vKvd8tkWmJ34Nr3I9ouE6lZlFLITn6WpHLvy8tvOGTO7t/wQe/+gO9pjlXoDY5xl0gBV2Y1AIc4eXlCM
X-Gm-Message-State: AOJu0Yzrae/zJ7gUXQpTt/1CsNBaYh/uuGhpSrzoVKuHY/g7kC3k1HNJ
	NPBQq3fvKMD0a/L0aEtodC/zFPOF93VwSFeElZF9nikCql8aY2vd
X-Google-Smtp-Source: AGHT+IGLPHijaSfv3zNlF/zELYrFagvqalK+inzWLjyEzDWFbbVOC88hORI2bhQjrUEqleZFxaqhOg==
X-Received: by 2002:a4a:d24b:0:b0:5a5:2244:6b1c with SMTP id e11-20020a4ad24b000000b005a522446b1cmr2942910oos.9.1711639303930;
        Thu, 28 Mar 2024 08:21:43 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ee20-20020a0568202e9400b005a549dabb99sm325688oob.43.2024.03.28.08.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:21:43 -0700 (PDT)
Message-ID: <53aafc22-df24-49a0-9e27-7c614a9ef19c@gmail.com>
Date: Thu, 28 Mar 2024 10:21:42 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] band: make HE/no-HT rate estimators return more
 descriptive
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240328142622.1490115-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240328142622.1490115-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/28/24 09:26, James Prestwood wrote:
> If the IEs were not provided return -ENOTSUP rather than -EINVAL
> or -EBADMSG since this just means the AP doesn't support those
> capabilities.
> ---
>   src/band.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

