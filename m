Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217A171AB
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665714; cv=none; b=QFGA//ONi55vg4yoHLVAuqoyx0Hzigbvm8VF/WgPAsecVB3PXH6HooX6g7nVgtm3QSnxeTT38jqq+AlHAg8GZQZEH4g7SAJul1CIZ2fLvIZ81vEjP0sH8ORkvs8dvfLPykj/VmspIXHsVc7nVUuFppRA3vpDSiaixJYucdHlVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665714; c=relaxed/simple;
	bh=R7oHGaf71u+g5AiQufxZPxH5aX2CkxP9JErXv0nyarQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1OZhR+Wn0e2wlja8h6PxV8kRgnM66vGmW9les2EgbF5U/oFFsSlbcmEqtaQsVYzD3/Z+aMjVYwT/my+0/juvhFbLLeITUVZ8C9ebxBsT3BYX/oxsZND+1cLEJ5OF9xHgBqy+yY21tiiE0cIT7dmgEVrZDMcZROekkorcAkZc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1Z80GSl; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Z80GSl"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c38eced701so904575b6e.1
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711665712; x=1712270512; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAg5VtUbKoyUNzDx5kRa/lZp/HEgSsfEaWSxn6wbSEw=;
        b=h1Z80GSltUEjtzCbXG5jSPsQgiUxcmFj9c9S2RqzhZhzVHAMhr9j/iK+BV6nGThUNp
         LjkETWu3zvvujN00v3bTc8K1J6GQX7giU8gbEa0JiNfNAjUwPEt7IhbFPWC8BVCskcm1
         gJ2x2DjFTgG7Yhs7imIkA6hEVdKbjuL4OkhiQR52OLGfJcOLedLF4kvsI+yPrsgqcgCf
         GHzMXhVj6/gmqL/86DbD/1OuB4pea04rfb+5KfshygFOsC8t2yPJ08m5X3G/fG+VsUXl
         u4pgL2C++UcsXVT/TcnyGzsqUdbYyjPDYwCGhZZ30/yY5N/TcVhqVOtzQbTA1nSpUZc9
         eqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711665712; x=1712270512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAg5VtUbKoyUNzDx5kRa/lZp/HEgSsfEaWSxn6wbSEw=;
        b=UVKGost1+XEq6M7IDmheL2PaJmuc9uQ0W8pix3IDbwSM65M0KkCdVxFYrSAJXX8wUg
         4mt82kljd2NWfymtZCgh1+bVFUeZYHCljc6hR0wPhmv3hTkry60TL1eLv/NL0wDP0LH2
         IiTEKN7RyBjt7Ph0mmlBU85ggGOiSZw9kUVXV9doq1MsdqdVBV42UH2IIz/POCPRbsMd
         OE2PCIJT99vuV8Fn5Jce/IqNXVHerFB4Ihw2xZWuCnFfeG/7FJ3LW/IaCP6sB/PO3G56
         GobCeBGQQsbyQYHd/sNjnnAr0pfAFBXwlcR3aW4pd8XLNzHvN4PIUIumABbHCw6cmuuh
         0FpA==
X-Forwarded-Encrypted: i=1; AJvYcCWcrL8bBt72UePmYtAH9tLpHkDbzUpUtyPZYLGJziZ/F8TXdwlpPZSXszv4Kqr42jPhd4LvuahU0bW/ctZLmkOY0hgT
X-Gm-Message-State: AOJu0YwIrkdsjlMW+SWWdUKd4RdkN+Lfxp2uTcvQd97ePkcgGvmzfK5/
	C1p7guILbkFXydw5Jtlz4xQPVYBdgoOPHHpdL+vxLMMiXhiR7HIiOUZ6pEEV
X-Google-Smtp-Source: AGHT+IE+4H/zKUGMKA5VHVVljGZoW78+2xjL2SEbXSeQ9ut4UV/W63mbF0ejZC9S2k34WTv0MUKmEw==
X-Received: by 2002:a05:6808:3996:b0:3c3:eecd:b8ba with SMTP id gq22-20020a056808399600b003c3eecdb8bamr904868oib.34.1711665711833;
        Thu, 28 Mar 2024 15:41:51 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cg11-20020a056808328b00b003c24de74c5fsm399050oib.21.2024.03.28.15.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 15:41:51 -0700 (PDT)
Message-ID: <b126d8fc-65b1-48b0-823e-7973b4140105@gmail.com>
Date: Thu, 28 Mar 2024 17:41:50 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Register EAPOL frame listeners earlier
Content-Language: en-US
To: jeremy.whiting@collabora.com, iwd@lists.linux.dev
Cc: ed.smith@collabora.com, alvaro.soliverez@collabora.com
References: <20240328223931.814213-1-jeremy.whiting@collabora.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240328223931.814213-1-jeremy.whiting@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy/Ed,

On 3/28/24 17:39, jeremy.whiting@collabora.com wrote:
> From: Ed Smith <ed.smith@collabora.com>
> 
> If we register the main EAPOL frame listener as late as the associate
> event, it may not observe ptk_1_of_4. This defeats handling for early
> messages in eapol_rx_packet, which only sees messages once it has been
> registered.
> 
> If we move registration to the authenticate event, then the EAPOL
> frame listeners should observe all messages, without any possible
> races. Note that the messages are not actually processed until
> eapol_start() is called, and we haven't moved that call site. All
> that's changing here is how early EAPOL messages can be observed.
> ---
>   src/netdev.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

