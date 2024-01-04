Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748D28DAB
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr37Ag4e"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so517976fac.0
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704391077; x=1704995877; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVTDmPfDBHTI3oMQl/jbCl9D4M0OD/0ogE6p/0AekDE=;
        b=hr37Ag4epYdsUkXYFrZWrqgDAIBay68OtpK5HAW3OtPULIVUUPtFDmv2Gkbe8GzFlM
         DIccsPa0pkGo5JeOtYcR0KrRsLwmQK3lUqjhTn6INl/iR0qQoC32HFWxWJ7kMEx2Sic/
         F8CnLGeF5M2KpvFj2hjIB/1dypGSqG33YnisrD01vQPxF0j2kMg9KgSL9+G51v43HUH8
         l26c4dz6KLO/jgEgfxl35Gn5KHHljue0kpciGVuFuPApsTPerMf7flMkM2N4PNcjZgmh
         tyJbRiiXoKv2w7a0dpldDO93no33MHG5eed5jnpzpErQlPkf/yV4LqXlAMxVO74WvL4K
         ZNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391077; x=1704995877;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVTDmPfDBHTI3oMQl/jbCl9D4M0OD/0ogE6p/0AekDE=;
        b=q1vLHBfkNJ87E0fY86VGqJNFCNNb5yzPUeolHh29g3nVBpUASY3XXvpKLgr6FcuTj1
         lONPW4LOwKoxwSTQXaZePqMxrh9fvuJ/ZI6AZp+kPpm+5Otta9aSNa4P54weQ1QQS0w3
         f7BiUifseFq+FMpsIPwLb8cJHkR9p4BJ2Zdak/NvFZiGbClEpGDAdFi+f10tciga0uUY
         SibotDCc4H6onTSS9sg1M8JedUB/zCiBvx8X+1Qd8izDW6UVCSPIaBUQ8v/WBuyVQKEr
         62ZO5KBn2VAmuNrgLocxk0OHoh0ucINaapkCA6tfJGUpbGIxpVoZPotqlsdFsKb/kZFq
         GK3g==
X-Gm-Message-State: AOJu0YxuWBRn/HsqznsDjJFMDsmDfXS5CN9EH51XccRYs76N8P21W44Q
	FY1wbq5tA73XibMUWNrlXBNGKbw7d1o=
X-Google-Smtp-Source: AGHT+IH7+i3MXCc2iHN1K0IGiffwEf/pyuMXvOrSakqMhSZy9Yqyn2GKbvvBTS5nZhl1vKJnUgz3HA==
X-Received: by 2002:a05:6870:4612:b0:205:c5c3:3776 with SMTP id z18-20020a056870461200b00205c5c33776mr862650oao.47.1704391076827;
        Thu, 04 Jan 2024 09:57:56 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id te11-20020a056871880b00b001fa3c734bc5sm6484012oab.46.2024.01.04.09.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 09:57:56 -0800 (PST)
Message-ID: <72b862e7-464a-4750-bf02-d7ae517ed6c2@gmail.com>
Date: Thu, 4 Jan 2024 11:57:55 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] station: add debug events for internal states
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240103184638.533221-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/3/24 12:46, James Prestwood wrote:
> This gives the tests a lot more fine-tune control to wait for
> specific state transitions rather than only what is exposed over
> DBus.
> 
> The additional events for "ft-roam" and "reassoc-roam" were removed
> since these are now covered by the more generic state change events
> ("ft-roaming" and "roaming" respectively).
> ---
>   src/station.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

