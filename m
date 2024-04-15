Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B17602B
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194110; cv=none; b=kCljUWnJw53DbRmhIgKsFVi4pQJioz9eGQcLWVZL2zg2FM2WTKam3DQIrVhta7rs6aPSed4KJgpYF3uhTAwo/tBt7bUiQDsnAMtNdDGgP7bu6Wv/XLYLl1k+y5Cy/R+c9kPYPMtOxT7yZ06ubjowdpTZ2SsXA3xeuB4rA02oVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194110; c=relaxed/simple;
	bh=iXqBpgfp02HohyXqrvmIgzaQSJWxDXDzTOZeZ5/Z5Xs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VWi3I/XpyCKl05onTCvDSMwYPu6e0Y8nIKUfTx8otG3/4aT1XlQi0Dxpzf7xQs8c2aO0j+zb//qZvGBW2CbjMOYrJf8GmA57q1PApUBRKwlhHJnQJdPScD7I+2twfKTuH4qxpai4dB40Sz1Sxory2zt8OZtynIU1Ea/1VBjzFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf3zsURV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf3zsURV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d723c0dc5so310881685a.2
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194108; x=1713798908; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K96iEZ1BuOWju8tqn4ED9Xpvmx4N9YtMuYsZUsJB2g=;
        b=kf3zsURVC1cj7rWyu9wTXyUfK+E8GafhImGSR6CWqzSAedubEbNNCXG+fc3a9hd4zE
         Pg1/PouEQK6z8FLd0HhtVzCmzFdnaMGiGATtTp1ZoXKyG+Af5497H6vIK6BlyXzxprYs
         CnR2GQ9fjJmxKzXi5D5TpXkUbnhnM34jM47QYxKe6jkXpaD204KtCkc8N8Y35vJtGqS2
         L/tNX2bjXrDF4W+PeKpitYdnaenymMuc9Lr2nYp47wfqQdJiDp66uCoxosn8Frvr6xd3
         DJBS/CMxLfBkwcLjckrOrgij5Ucw9A+LAWtgYaJf8P4Ozn1gMnlwWD2GaJN/MPcCyhFh
         UUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194108; x=1713798908;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K96iEZ1BuOWju8tqn4ED9Xpvmx4N9YtMuYsZUsJB2g=;
        b=qPheGzvk+slyR3SkXOhISewAW0F2mduZIF845pvqLqYBuGZQGtTO17e/0YelN+OI69
         VKo6WKmgPdKCwONWoT/IXLpCR5/ZruMd4pvgCEFKQGYMrEo1fTXNpzGfUHJ1JDbg3Oq/
         +ym8sBP9iC8LMhKULcYvZNS7955HB7JM5KUQivi4M83uprn6L92fBsgQA/BE6SJKJgHB
         tZu7ILCUJdMGR8+trpA/GACeKDIaaX4k9KgN8n1e4naSptOTMoLAsiR1tHlVh6M7Lsqz
         Bt4ocIzIUY00qXH8ftyeKa6PDgzTxT5Bo7XJrEQeMTCdz1rRZOSf/otMBH/e7zB7tTIf
         oLVg==
X-Forwarded-Encrypted: i=1; AJvYcCWmvof2NSsS6zv8lPB7HOscr/nroLz1ClBgS8e0U0YGYKJZV/DTJViGCvKEZX5APSLTvomePmUF+FCVskf64nGdY1Xk
X-Gm-Message-State: AOJu0Yy4X7cC4QdF1RJgzRiSZGsQJ+nDyjsUHuUD6YG+lMUD8qxLp/lZ
	VpwsIGQV9gSEjaviqigV7fYuyjYyn6ANLCB+F992yJc33scp824E
X-Google-Smtp-Source: AGHT+IHc/C8SJ8CBGSswruqOqJCBzjjhEgtlq5GzBmnuqVxLaPUXEyoFoJNRKV7Q4If12wPrMPiGkA==
X-Received: by 2002:a05:620a:c90:b0:78d:39ef:c1e4 with SMTP id q16-20020a05620a0c9000b0078d39efc1e4mr10715955qki.24.1713194108093;
        Mon, 15 Apr 2024 08:15:08 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05620a31a400b0078d677e72f3sm6441980qkb.118.2024.04.15.08.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:15:07 -0700 (PDT)
Message-ID: <8c99082f-fa0d-4c9f-87ab-e49dc9e0f497@gmail.com>
Date: Mon, 15 Apr 2024 08:15:05 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NT/VHT errors filling log
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
 <7978cd1a-8122-4b6b-9e38-b7d65a9c393e@gmail.com>
In-Reply-To: <7978cd1a-8122-4b6b-9e38-b7d65a9c393e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 4/15/24 4:24 AM, James Prestwood wrote:
> Hi Keith,
>
> On 4/12/24 10:41 AM, KeithG wrote:
>> Group,
>>
>> This is on a Pi5. this is with the 'current from git' build of iwd.
>> iwd-git/now 2.17.r0.g468cecdb-1
>> These are new errors which are showing up in the log and recur a lot:
>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capabilities
>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
>
> I added these recently as well as a small modification to improve 
> fallback behavior for calculating the data rate. This isn't coming 
> from the driver, but the scan results. Apparently APs sending invalid 
> IEs is more widespread than I thought. I'll need to change this to 
> instead maybe a single warning, or maybe hidden behind an env var.

I sent some patches to the list which should help. You may still get a 
warning for HE capabilities though, if APs are advertising the malformed IE.

> Thanks,
>
> James
>
>> Keith
>>
