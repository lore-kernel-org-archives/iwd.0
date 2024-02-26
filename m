Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13A1BDDC
	for <iwd@lists.linux.dev>; Mon, 26 Feb 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962356; cv=none; b=ElbbcjbDwv2HV7DaqQ731NL1vpwmLnfyprPPtFrmenO1IM5Klb+yY3dOVPO99cweWP2UeLf/Aw7fyOmaKEhLinfyHyIcxg5vcMcobRG6WvXbn2gmZDEGIY3FM9n6P8/koO6/GR7HQJEkb/XxEtKF1VmsRAb2NvlgLw3u3sptp/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962356; c=relaxed/simple;
	bh=gGb98IPCIDM3Cc4zWrDoYjsYWNmjcTeH6eaBaqtJnzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eoUs0NdjE1iBhCalrLE8UuXY7wtKzon4A41PShBE3ZjiksrVPNm0ERDgCwmfqznbWGG9+8edwEXcCatZpdRXd3REuyWMzw2BMLdyipoDoH7nUkEG8GnZmenBpTmEvcYqb7h59nBt631aPYZwfqU/QXLBcjsLfCpsogaUSHaVDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF/FoqXC; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF/FoqXC"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso1991004eaf.3
        for <iwd@lists.linux.dev>; Mon, 26 Feb 2024 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708962354; x=1709567154; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD4cUJk5g8Cg4BN+FR/n6v9cKX8z5YjuKMo3tvxSTjY=;
        b=VF/FoqXCOcPEnb7YL6xyYqUYKs0zgscuM7iaoTdDHbqlV8rAirH4kmsUU7xjoZXHmq
         fLOdIX8xQKN2fvfjjIp5PV3KrEI4wYY/8ZrIQ3b75kaxJbMYOxOuvCqLguU37zAJ5Uri
         pbvT4BvLUIVdBO0GHLTGtCO54xMKVe8/kq9BaBQAPDYyb3/p1cxs7ILDlTa2PA/ZEGKL
         o1nJUhZ3+Qjc2Rc1YcUulUv2ioEnlbyHpxHu6I2nTjObafIIsCt3Apos4iSn5R11DBmx
         qNROLx6mPhu9FPS72IQng/KKldSPD3EG3IeSCvtFiAb1++qRQ6sNuVHbA93dnqLs7SJq
         2+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962354; x=1709567154;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD4cUJk5g8Cg4BN+FR/n6v9cKX8z5YjuKMo3tvxSTjY=;
        b=xOoamEyj+7yyJzUkWE59qUNZsCaBemvHQZMjMcNx39h6hBRR5Xd2zrKWb+wTWjpoa8
         VH5toRoltdt9OC9YKS2h6Tx7pgpQFQoyvKQVGkvKJpC9Hn6BfzZ+3/uFJFa3rsCAix3L
         FB9tcHR+uMBNAExObuXwfRwCV8Jspwp3HBLMHRnNQzk0zje9f3knk+5hpgj2H07WTa5P
         7LM0h3rOrQL1DvsW3/KJy0Cu/+qw+E0y4bFQCuWu9vNBR+rqO2Mk2lpviyyYKQP0S+zI
         x1g6oNgOUo2u0WtwHE+f5g2wrAZf95ma+U0ovWs+wpB6rY3Q9TITQmL0cZxVH97fJzrw
         VfZw==
X-Forwarded-Encrypted: i=1; AJvYcCWwBIW4wlScyQK3gnLNXkqZ9Hwq3reT4xdZzl8e4DdjHinUGTnglbL9Zkhd9UlbNejLiA3hJk1JM4iWrz5eeGsp8p4g
X-Gm-Message-State: AOJu0YxCX58CqEmpSLaMMy/FtmPyKCFKmU4iwhL9CqNie+KeRZcaOqMf
	kmU/pXSCKcL2Xlu57MqgmKl90WLlU9SDHPUXbTySF4r0T6fwLjTvcFoph5I9
X-Google-Smtp-Source: AGHT+IGdbvcBB9ZRqKrhBUsyKlbFPiCcttgje+8pUCOSJE5mevg9G3+ygybUdlYZh8MbjZy97qwO3g==
X-Received: by 2002:a4a:311b:0:b0:5a0:8b6e:3f81 with SMTP id k27-20020a4a311b000000b005a08b6e3f81mr2923039ooa.4.1708962354344;
        Mon, 26 Feb 2024 07:45:54 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t11-20020a4a760b000000b005a05e230e47sm1297121ooc.15.2024.02.26.07.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:45:53 -0800 (PST)
Message-ID: <c6991716-53cf-447e-a3f4-2d48d7b04188@gmail.com>
Date: Mon, 26 Feb 2024 09:45:53 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] station: add channel number to diagnostics message
Content-Language: en-US
To: Ram Subramanian <ram.subramanian@getcruise.com>, iwd@lists.linux.dev
References: <20240223200944.1343893-1-ram.subramanian@getcruise.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240223200944.1343893-1-ram.subramanian@getcruise.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ram,

On 2/23/24 14:09, Ram Subramanian wrote:
> As a small convenience to the user.
> ---
>   src/station.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

All three applied, thanks.

Regards,
-Denis

