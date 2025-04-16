Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426EDDC5
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824017; cv=none; b=fhYDkRjMEWTYqxTAI+OZn6RPcV9S0gjfnponQMlUP2jApVwEk1JtaU8QI2a6O+CaQTSw8QjCScV8qC3IzKF+FDTAMbHivZ7N/UY4nk6mY2kj+TfQLJxlGavZ+6YBq8dWAkFnLuqc8oXLIS9bypMyiWluD0LP93cdX8VrI/9Vmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824017; c=relaxed/simple;
	bh=jjUnbCm38GjjdJtt5itEKlra0AN07zKqpBaQFvOZcrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PP3gl8LwiR53Y37aN7VK0wTuyW1LxTXpURR7huqUcutgnMw8sskrqxlUg8r64oLsHkDubg7QyCb8K81z8IYU0uHo7qpiNOLEikXUv7dIERhZeIebL+TEJgibVoN6xes11Jl/fJPsAjnPqnIrtZwOtu66KmfoI0XKliwDj7nBE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azQaz7Fh; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azQaz7Fh"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f6a92f234dso4142225b6e.3
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824015; x=1745428815; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQG2R6ilBet8/j7TRV6pkf/Ai5/Fp059PGhwk1+M/Uc=;
        b=azQaz7FhbB3nY0Ygul7txZzYTkuo5VETiSBV/pT1qHVidUYj0OWvqWGIA/azyfyT+5
         c3Ikz2tpyGeoX2hhEjrBsq5iyBpdO7OcUilZoYVA4bNzj+N/LnVGQEag9+TRGT/NJbeD
         tiheqrEj1EGXeHK3pfqTAYVbakjfqmdx+lRoPfj85YrhJcxvGmwm5QpNgHmAf4A6OJd5
         OzjDWMGG/zMLkua3MOkKb7Dk08p5qEUjvZW0jDZNqe/8L2XX6hOl48+qucqsCKADr+BA
         lGstJMb7I2Pk1vNC6x9CZbQG+a12f0L+y2GYWLc5f1ewdZJrOdl9zriHzuSNWQtxBHM/
         YggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824015; x=1745428815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQG2R6ilBet8/j7TRV6pkf/Ai5/Fp059PGhwk1+M/Uc=;
        b=Wo32giw7gaGpzWm9G67EzuaBnwnBtZAxjt6+U5cEQ1f7uhbS4geekVzsBd95dEZNDB
         dRy+UtVEBusCJeyykYAwerzyNChfE2fgTdXYeLflfi/R/MqeeMxCjlG1VxohCsiq9j04
         mQ+/P9hDOHMLwiT11ruedu+OQURZUqc4IIkFcKYz7238A+pn6OuZO8aSlp/sMD2N7Pld
         Cyq3Sdd31+g5N/oPuZlygZf26AJxeva62wTFaApt1QZCgn8lDGd30YSgJRhFS66dk1F8
         1QYFJ2d3ndyvFPhZLYreewgSD8MAtKvIR0JDOqB05tJvOmfXotw8zVLDG8yLbNm7/XwG
         +4fA==
X-Forwarded-Encrypted: i=1; AJvYcCWK6HPOCJEYojQ38ZISI+nBzvHFiaxNvZvuw2AYGlp+1Mo9Hta7BneY5MN3tIATjoYryQ4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9x387gU7R1ad46kRLqoBn5EKl0GUmtQ6N6MixStDrgZmCmqcm
	2zAWNUNWryO7NaLcsxBI6TmC8LCYJwQsw/uakzfA4f8XnJ8q0NFF1oVqJQ==
X-Gm-Gg: ASbGncuOjhLvyXzEZ2qfRn1sznKmT6Eq7be+3u/7Up5K583peClVApmMbl4chq1YgMO
	dRpjlInWIbqV1GSqLnLCvbDUm6YU7HQQ+Gr0Ug8+CVp+vRPkSps80ArzlgvHDQRtTgvrAJDagJS
	xUKbNXP2759WgcIVIwk+8AMTKVSVKUfdiYuXLNECvEft8dJYTQ0ByBF/M5hQAcuPy03g4fPy2SK
	T3TJRkX86C2AK8dCQM1qsEoJ0vE0KgUa5Zb/6w3zE9GwA8LLNEwyRmhmUKzuipTzEej5TDZloff
	7RwoI8+KGSWMJprSyOrMVJjwDj0KfOFfa18YuZFJZr87NTy7IxW6ayw7v8ZunGkMF+9C0nChw2k
	NiJnxKw==
X-Google-Smtp-Source: AGHT+IGEuCzEiWKf7Zr45zlBbTeSMXMbMz/2m2IXVKEHK6PS2qZ2o0hYCckI5VvbPYQWhXhRF+nucw==
X-Received: by 2002:a05:6808:1986:b0:3f6:abbf:bb88 with SMTP id 5614622812f47-400b022ec4emr1803249b6e.29.1744824014894;
        Wed, 16 Apr 2025 10:20:14 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4007639dfd1sm2838285b6e.31.2025.04.16.10.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 10:20:14 -0700 (PDT)
Message-ID: <b527f1e2-a619-45e9-b551-50482ba26588@gmail.com>
Date: Wed, 16 Apr 2025 12:20:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] scan: fix out of bound array access for survey
 results
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250416123414.114231-1-prestwoj@gmail.com>
 <20250416123414.114231-2-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250416123414.114231-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/16/25 7:34 AM, James Prestwood wrote:
> The survey arrays were exactly the number of valid channels for a
> given band (e.g. 14 for 2.4GHz) but since channels start at 1 this
> means that the last channel for a band would overflow the array.
> ---
>   src/scan.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Can I get some Fixes: tags for these?

Regards,
-Denis
