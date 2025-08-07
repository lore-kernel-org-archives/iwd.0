Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FD1E520E
	for <iwd@lists.linux.dev>; Thu,  7 Aug 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607588; cv=none; b=BARwE+nm3aaR7KmjAH4YVZneNS1lEPkW9vplXQUO+lj0wR1cDAmmGOfw6bXC5i68Op15zQzxKXVkth/boq//n+KAHnmU/xYoUTBk7Ra4wFWwvRmqjLSOlhkUMLZIa3sXQrYZY4IGPREvyPl8ekfs4kI/i9tUg0LEJ67CDyO4iNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607588; c=relaxed/simple;
	bh=nJbxQzMlMoy7ZmAICzcT14yD758JbY5LbmdQr5REgtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb0RHBjWFfUpOv0X3T2Mr5CPE4X5oAzrs43yzbqKuEQ8oWnCSy6Lq6qmncVD0dxIVY7gBH+3SszNAKJV6htq6ZdySH7/eK5RmKRIs7SBcYIM6V8u57iADFFpRoNEWlXLzcH09vq099fTaPl9CIO6jqSniZdur3p2tNPsBdp2ip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNNzuwSr; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNNzuwSr"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30bcbac6f69so550254fac.1
        for <iwd@lists.linux.dev>; Thu, 07 Aug 2025 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754607586; x=1755212386; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syr4O7ZX1YUgjJhn12dXx7VXuBkzouG9Q6D3e78ZT8Q=;
        b=LNNzuwSremBkbDgTuXA2oavt1bZB9Jaqb4APtRY3s5xJV93Uhc3f60P9Xw09yf054h
         wKXcBs3ZGDtWol4+FbozTxWWpe49TdW388XIvnHwNfno8BDcSd1qnJ1ccOuMjFd4hmne
         xyNxlv38wOEeitqg9wUNQ4nIsJPq8A4+ofa6tjDyw5bSlr+yqToy7ZwBXJalqoU4uJtf
         MA7Tfk6bmw+H+JQKO5ynuO0IJ3phRBi0N520Etrtd0nqqrMDrzb2i37bw825Juw56gfM
         jxJJqQ1xdxggxA5xeHr8CvrN9jxYWQ+epHpfSFsInwJ05UGexgYEn1aQYhMfTbbGeRxp
         U3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754607586; x=1755212386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syr4O7ZX1YUgjJhn12dXx7VXuBkzouG9Q6D3e78ZT8Q=;
        b=Za9GraFa0NBvq7pdugToLbb3GnWmB2ZiyurwDlMjhOGjzIMmv4pVEhRlYD4ciMSxz4
         JF9JAViEyHJqerNGSyN4cJro0aXRBGia82MLjMrewvQlKxa1tkn35B5gbAzmkonF0D8Q
         0m5Gqn7P+6cmUSDuCHvv29zDZiwYmRL6fEPWQU0o+RU4a9K5Zgau0JMEerEeeE/WlFIl
         yklT6ysIL57+ApcyHuZjtIlMvhLo8STVP3gktfCctd19cyXLam9Pvo4vLW5rHHyZMoGA
         iMqdnb2E7qCUYZQ4ASnn0Zu4oTHeD5ipGTYIP9rsmE9MhrSWfYewdEQr+EkR4TfHmEKO
         aB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzntCpFT1YDKjEFSAXPvBwosZADmH7f1kOcjg7kZ2NYcR5LcKe3zoPTRRt9PPUzNN3PnA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxja66UA9zmTZ30QtRHXdNdE67hZvKTxrymeDj0JSrwRPwGJ9SM
	0hYkQZBYtWKIH4qTzN9MZMlmwXK1tWRN5wx93ww7mcuyG1fHJzUXQnP4
X-Gm-Gg: ASbGnctELVIYezownqbbR6FWeJiP7C+sw5WGKPfY1jeX4uZE88/LWSgYrmpgOdKzUzf
	0Ei1kAvtwDm3r/jq6Iwr4NoOFOdgG7sOQbYXG0AFT2xJ9KuYtCzJczI3f9LXItvJhTMvgmcHOO0
	krFJnSHR9izYe6iJbQGalJeV6swkCbLUufDW7N5AkWUiwnXc4du7U9A5GIrkzkKUyFILA1NQJbi
	nTB4sqmTUBqaz6PHa31f5l8D0WKjOUxtc/9RWTpUCA2q2AOTu9i1XJzqq7xwCbBTUny1kXp/Hdm
	jtkK6rutYNw6sDmb+LQ+RWXCY4eL9fQRzj6Bb4OAlMrQAb1A6bOPKHlP9te8bykQ+APySJ9AAe5
	KpOjI1zztguYgRRTZvvQT22k3vyNE9CXGt942+9LypUjEBoHarHWlS96c731R2rZRpgZYioinw5
	k=
X-Google-Smtp-Source: AGHT+IGPl0uWD9l4Yia4ocyonvwWUvwViXgysJypDQ1n1WJmHe4iitdWbbnVf8X6WPngPiH/8wIE1A==
X-Received: by 2002:a05:6870:b622:b0:30b:e02b:c806 with SMTP id 586e51a60fabf-30c20f4ae94mr711226fac.14.1754607586115;
        Thu, 07 Aug 2025 15:59:46 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-30bb4ad8af7sm2661646fac.28.2025.08.07.15.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 15:59:45 -0700 (PDT)
Message-ID: <b389c7b1-795e-4ca6-8f99-6105ff714489@gmail.com>
Date: Thu, 7 Aug 2025 17:59:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add STA inactive and connected time duration info to
 diagnostics
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, iwd@lists.linux.dev
Cc: wlan-kernel-dev-list@infineon.com
References: <20250807085857.4170-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250807085857.4170-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gokul,

On 8/7/25 3:58 AM, Gokul Sivakumar wrote:
> ---
>   doc/access-point-diagnostic-api.txt | 6 ++++++
>   doc/station-diagnostic-api.txt      | 6 ++++++
>   2 files changed, 12 insertions(+)
> 

Applied, thanks!

Regards,
-Denis
