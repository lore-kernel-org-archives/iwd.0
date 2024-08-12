Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8979CD
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497617; cv=none; b=o5IklRBHHP/Ur/+BKnoasUaR+KzAYCnFkWzybio04ADYbHM1FfGOCRnVWTGn1N9RXLAnZdRMGhjkK9p4oBt7xAJ3Jx6YlfhZR9TVbkskAmJ8kMLCVWpVDMQDL37eojQn61pUJMCZ7R3M2gyQsM/haqQfteH9bmNfN8j4sntqrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497617; c=relaxed/simple;
	bh=rv6xVVv04oMbGlap8h00irmledpzrj2aMIEi1Wy3jUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NagQC/utMjg9SC5e6uhZlfanYhzbS4eBsvzP8Z/zlfRyuEHrxcNHSwzbdrccZXMPNQMZMM83pU+b+PnBXpqEBilw+QGbVbTXUwuCjb7HRqxaM2kjt/QhbYB9OW9J5DfSNZodrXlbb2SiDJmb5dUzsSYIoinC/A94lf1cQmf66gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duJOeH/t; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duJOeH/t"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5bf833de7so2686423eaf.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723497615; x=1724102415; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3l28/Riy5/D7Ue65bF2ZtP0GwDQVK5vh5vZF1OzQvqU=;
        b=duJOeH/tIRP075tIJhL3/GmqUpDPZvlCQgUESpjNUyJXfKHBRIAe8RpAs8CpdUZiIa
         5DHaOoJTF61Y1U1O+ovbmNw8mEiFI/8bXn+0zU95vMKqJxqlcjOe8+zTv4ZT2Fv+9QEE
         Y4YyyndCHJr6VP6b968UTccC1Zpa00HZXQkGhI/Hr0+a0oNmsXll+mT0s2PnhbczfD8/
         MmsqsHHS8D8gRxa1NLN4uOli948wOQKOf3D9l5u2bo0HvLDSZQwy0lAnnfSluLCx1OtR
         E9mj3PZ6NkzxuqrlTCjHqnyNlSVuEb4eZHBLgF4JVSHQZ+K8UHxHFiMaVNPtEaSo/irE
         3oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723497615; x=1724102415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3l28/Riy5/D7Ue65bF2ZtP0GwDQVK5vh5vZF1OzQvqU=;
        b=d2Nhrryuuj7S0Rx1+b6HemvtGOcEZd4jqVknL+aLf/n35Ycyz+Iligm9kWHkYDI8OP
         E63LJpLUU8pBrYVqeZnFqNoiqYqXuebItP0mauviHMakjASR+iuiDPBoxzmFr6+6L+qT
         1w7vkas5HGj+z0tJT5mnhBYMHIvRkfDZ6JWnMluEKL7pFeDiQYJk6OGIfocotTosrovy
         qaIdPqeoKXNtDU9F2K/leqyHlskL5IR5TkPGAVjgZRYIDrNssfvXFRhAzEBvEM9E4Lir
         8R8yDTurPlsu3yOMSxyZSABGzNgUJXl8ZFucClwFplACkn9dOPQ3Ke3949mEpTzlru1j
         k7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxAOqThlfxdjJnPue9gaowUJHBi33vx1KbjXIa637VDaZchfIOeAPiVbmp1JGp/orl0vUbLL0gUeRswC4wEHaO9Myo
X-Gm-Message-State: AOJu0YyzowyDe9jix4ZehJp/WmjHdJr2jIxloLmh/Npk8XfDuZGveU9w
	BvTE7iiyh7GBbt15ljVPodX9VxWSs6LgxWf299mP+B0n/V3EKmAj
X-Google-Smtp-Source: AGHT+IF1vyZIk+mkS4j6GhlZegX+LJZjIlpxMWERM2bmxwgOl/lg4Gmm015jjF0M3hRogoLDV8WYMg==
X-Received: by 2002:a05:6820:60b:b0:5c6:8eb6:91b2 with SMTP id 006d021491bc7-5da685a9f78mr1989961eaf.1.1723497615376;
        Mon, 12 Aug 2024 14:20:15 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5da628d8247sm302278eaf.1.2024.08.12.14.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 14:20:15 -0700 (PDT)
Message-ID: <e0959445-305f-434e-bd90-24dda66e61a0@gmail.com>
Date: Mon, 12 Aug 2024 16:20:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] auto-t: add SAE-H2E test for setting the default ECC
 group
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240812201457.187703-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240812201457.187703-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/12/24 3:14 PM, James Prestwood wrote:
> ---
>   autotests/testSAE/default_group_test.py       | 26 ++++++++++++-------
>   .../profiles/ssidSAE-H2E.psk.default_group    |  5 ++++
>   2 files changed, 22 insertions(+), 9 deletions(-)
>   create mode 100644 autotests/testSAE/profiles/ssidSAE-H2E.psk.default_group
> 
> v2:
>   * Include H2E profile, forgot on v1
> 

Applied, thanks.

Regards,
-Denis

