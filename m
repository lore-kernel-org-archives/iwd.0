Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69331632E2
	for <iwd@lists.linux.dev>; Wed, 13 Nov 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519637; cv=none; b=YHzoXL5zVXMdodj/6yF/IGIKghEJZ6buCjYHTWCaAw0B2O9ZBJZzplkwt423798pbonyuCiqUt4T2yP/MaKn18B7Liy+dFeRT/Xt+Wc7Bn3Ss5edO4nngJ0xHG9Lt2lZR1gS+coF1Kn7UxkMFwKNnPtFQwqv2rd8YLEMLmMEM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519637; c=relaxed/simple;
	bh=eRnU7S1pYL2VvBmmqF7xuTOiilJ4heLgWYmQkjFlbBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KnAvZrx6JOC8qiYu7tgQ/BxDmewqjzvwQmfrAyQhC6T7gxmnEZxw8j7zr/sleoxab0NyTl2OmMxsvdZFrfdSZiEoH26QHTsh5zxqe0ZxRgE5vCnVkL08JoVU44xRQLzKSnppsuMlToNANeskMyMtVNwnVr67b8neDCiFkr42ExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+hq1VKl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+hq1VKl"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5fee32e76so3279295b6e.1
        for <iwd@lists.linux.dev>; Wed, 13 Nov 2024 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519635; x=1732124435; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GNnc/h18W0MPtPTPFtzJkWdM5LwcUQhoHlHoGHyBhc=;
        b=S+hq1VKlGnrWF1R1jzVYLmfY1KXrRHDpHqVHK5+4wygjEnbp+mf3U9vId2Wpgc167u
         iaiZBhNorcsJjv7F+Cus/3tojzoxtSMCT9ND3eEoND1ziunMV4bntc6+Ttp//TzoyF2Z
         yCeHT4GjWi9VZw05wQTBC2db5r1p9sVxsnQgtHavzmbe92wFWA2NHY2j2LUWM3duxanr
         rtVJ3/TeLBTmKnCQWHolEHG9unpPjZa/eQfO6suzfAOmLdrX2iOMijff3syRDslC1eFf
         rGky4W715uOktkz7FOKqvLSVc2rXPibtCVqxUtU46GYM//kot5l0w4jCqdehiNJpuog7
         n8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519635; x=1732124435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GNnc/h18W0MPtPTPFtzJkWdM5LwcUQhoHlHoGHyBhc=;
        b=ZBhKJYWV0qqEbnkjGHwRgH/7ixE+KKxKRLil47DLXey6i9asTtBUgA5WlmcSNChKW6
         QMwgfKVQPNpyQ8nginoA+hT5D4bjlb0t1HZkb2mJ1UYuuKqmAgjlj6kRwxJCdbpyTcTL
         bZUZbq29SEi1lnKlLUeBVjylKIR+79ZziaF9BA8bG4CRg7eEuwsJQBwGgUNfr7fd07zR
         1AFeuGoMDzC4qa2jbcPNFC/Hl8cOgymzs3Kkz7oLII8tAsjbc0gODg7Bp9QRX7uhraIW
         wdwIkYZH/F0yV6CsEKHEZty7/4SrvwCfaLUK7oSSQOzcucRj5HbW9IN3gBlRJ3BioLwY
         pzew==
X-Forwarded-Encrypted: i=1; AJvYcCUWcUeY0l9elKZL0rEBUUyODu5uPH/w0gp5ODWwN6eeLyvpLFSqESZY0bUzxDDrv86GUUs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzU65ATlupXhU9UQagbH/KyzcGWh4xwkB3cjvTCBLePREZrQgjk
	a2kY+fAV6uIDgyLp1nu0rcLhnaEhK5DXQY1FRfBqgnHXYYNiNhYbAQqsqw==
X-Google-Smtp-Source: AGHT+IEpG3zvv2boH8QE60pLIz4OsmKFSL6sqnjr82q8mGUWwmBGKKs4QikgMXhqkHINXOWVMQ0DVQ==
X-Received: by 2002:a05:6808:15a7:b0:3e0:4846:594a with SMTP id 5614622812f47-3e79477173bmr18765129b6e.38.1731519634701;
        Wed, 13 Nov 2024 09:40:34 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e7b097bb02sm745298b6e.31.2024.11.13.09.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 09:40:33 -0800 (PST)
Message-ID: <99959a1a-deb7-40e0-bf1e-949bfe5f2dca@gmail.com>
Date: Wed, 13 Nov 2024 11:40:32 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: add better info about the country code IE
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241113134212.20698-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241113134212.20698-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/13/24 7:42 AM, James Prestwood wrote:
> The 3rd byte of the country code was being printed as ASCII but this
> byte isn't always a printable character. Instead we can check what
> the value is and describe what it means from the spec.
> ---
>   monitor/nlmon.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis
