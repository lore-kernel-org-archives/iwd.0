Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D8ED1
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMdhDnpi"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6cd0963c61cso879362a34.0
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 18:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699582611; x=1700187411; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bt5G11fqaZ/+DD+ItTWwrE0pljpf2ftqULRpsFa+7wM=;
        b=bMdhDnpig2kIkS5wuvNYGJO2WshRdN6FFUHGxx4g3qyH4m0dJKjD9eJaSEhe91I1ZY
         RCS0TC52TQaGmNXW2xlbK7nb21TAxlZEb9oaYuS28xuSsbTlXHD0ZQ+YtIa5G3Ihqp1A
         Ru84ylKz3033AZPmkWyTlxoJbLAZt8Uu1CQ6mFopbZCILuV+o57TorpGRJuWU6WSMn/U
         SJarY+wfoCaDi/RMXu3zRi1Ib9iOJE8gEsex2FRRD+qBtMj9D9d9/VHgn6EoA8OXTnaq
         9T7ZyLShZele/71aOmvK+8Gck1/5uRfhC3Tch5AqyJBHCoNJwKc8uO3NYEZCS4xlJUfN
         +dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582611; x=1700187411;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bt5G11fqaZ/+DD+ItTWwrE0pljpf2ftqULRpsFa+7wM=;
        b=w1dyWsSZhIBjCgD+p9AEvDxW0hEdCP6DIbBrEtwCcwN3o3/lkI8QtTrSrbOOnKm3Kl
         CVCEG0YOQPmtbqwd/Xas2LQWs50lG0/psaP3i2qH/HXU6TehA/szz9Ass3PEQHnBPCGm
         3JU3IZzlDlHu7hBRekEmkucJHG5zcKpgBSJJwQikRZCeIYYaZM71CfpYNP8dFfiy2iz2
         tQpgyscjj8460qTBCOwaeGSrOSbIEyWDj5tE5JeEqga1q/taEtgDX38xxrIXD6fjNLG0
         I0xBR1CtNng886WB/Hjc0BcldAQxYD9ImCnh5PD6W+0Bjfb06qy3+/gqBJA2aa3NWwTJ
         eaZQ==
X-Gm-Message-State: AOJu0YyoH0PzEW3xJrgCBESkueFcnGnV5nuVbJ204X1vLuLGEaQ3/hBi
	2k+fJ89iSpKugAtHlzebLtE=
X-Google-Smtp-Source: AGHT+IFqxoNZtDy8H8zkOoZr8AhqqKQG6M9j9UZ/id1zvmH8zkkS4G0Zt45pwemtUAgNM7j3Bms/9g==
X-Received: by 2002:a9d:7b4e:0:b0:6b8:8f20:4cbc with SMTP id f14-20020a9d7b4e000000b006b88f204cbcmr6266277oto.13.1699582611404;
        Thu, 09 Nov 2023 18:16:51 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t26-20020a05683022fa00b006ce2fce83cbsm2432173otc.25.2023.11.09.18.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:16:50 -0800 (PST)
Message-ID: <002d388a-1830-4955-9c9e-df2d405c269b@gmail.com>
Date: Thu, 9 Nov 2023 20:16:48 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpp: fix removed dpp_reset in Stop()
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231109172522.37912-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231109172522.37912-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/9/23 11:25, James Prestwood wrote:
> It seems in my patch reordering both stop methods lost the actual
> call to dpp_reset().

In the future, lets use the Fixes: tag for commits like this.

> ---
>   src/dpp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

