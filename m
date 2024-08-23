Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D118593A
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429435; cv=none; b=WFGLvaE4uMRSLa3IIRDfNCGGp43ve2EYoelBfY50xUgCduaN/mdaVkh4wNI098PGO3kGzyhHRKcU8njzQKZ5dqKpNL6JmbxJkm55OV9ONW3aOtwrP4JpQIDr4LISiinfAwEbNK6ovjN50Kd4kduhL6KMonLarS9j1KbTSdC6Wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429435; c=relaxed/simple;
	bh=g6YP81Ncgdo9shGagQcfCyUSt4+Q0DunxeFCePJz+q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YZY+IbZZJN/5A8crkOVpHwCB70KDdPvSfqR9kexjeQ5iWYHW11+rp7wKC9Kla3B7xDromvWTYaCjvTpPR3Q7aEOBzb7tolipvs/n32xctrw2pRUy91EyxAXqWCYJf95mYtVxFLowDVVhadZJATJjImG1iPqHWAlZqXeBaICYQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C02w1SdR; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C02w1SdR"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27018df4ff3so1642491fac.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429433; x=1725034233; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FWx8m41bP9xcoP+HPwphiJaK7iJtekGwJm+HWTfrO+A=;
        b=C02w1SdROVGhrIMOSL6t4FQ6SQwpfeSP/mZ56WGpBzU4hl0xEwA9DyRJE4snBJRdrg
         wEcw1fGnP+i0qqZVs+9soO28xfmAFFwhitKGmXE1ZcReECzDLl9KzIenKFV5cioUHeNP
         a0V7uU9PNIpcV1t4Q8YIF7hYLD47McHRiGYVn6oC4iXjrIpYmbu0doNAWkuStrnh/M4H
         Yz1hyK9M/RNc9XBf3PXM2g5nCT9Xzb/HqCT2EaUrWpUQFRLMA/u/oUeRSNQ3c7Vk5kna
         g1OIhCvl+yow6vWJRUPiL8NWjCe8Vq/5OB3vUeJDU2YqYB/p5bmdIQCtYOU/ExyDRDin
         2Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429433; x=1725034233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWx8m41bP9xcoP+HPwphiJaK7iJtekGwJm+HWTfrO+A=;
        b=Hkgc7AkqH0n5hDmAQrti17+/mfN8ZT7XorbYXsG5nafWVGb6bBXb3kwQK0GBz1zjt9
         vxKq1TZqymRnTbGsXr+jaU+YdgrV6MJVBIu6AWy93Brz0Ypxj5OH+5fANOCVipMmMaC2
         orXOs8rmlzk6DOqdTsnjeUep7MNAmkItjdRA92+Pq+LpR+rJkjMhC+UlYZsTdMyou92T
         W1YoQKYwgj2KIP020fc+ShkcqrneLKCa6b2z/8otHkh/hiVbz+xT1Usf756cW2H+fBES
         seKU3KapXy12IICG6bc3cG5rHdd3qrOxfuWuD0B05qAv4DGrzZVu1R1OMWRj28CarbSw
         HqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY7BpYD/aTbOrEEhVzr3RFroO3vx4VNBdTQNDA3l5VzGnFnvtTusVGAh6/zK0FGpNBa+o=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7+m6yMJXAWdyfgbFgVddRuGKxz2I641I+H6vQG1LVLeU5y/3P
	b134dINjaVNlXhtduMZcW+dKlIPppE8pF3XhB/IXRzAflsA5nOB6
X-Google-Smtp-Source: AGHT+IE6lDe3Yx6oD47H4YwoILlCVFvp2JvB4WVAD85RuxacKD2/A00ds6YTiuAx4QvatCIuxAvBow==
X-Received: by 2002:a05:6870:ac09:b0:25e:368:b5a4 with SMTP id 586e51a60fabf-273e6476c6cmr3115407fac.18.1724429433410;
        Fri, 23 Aug 2024 09:10:33 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-273cebc4e53sm932651fac.50.2024.08.23.09.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:10:33 -0700 (PDT)
Message-ID: <e8ed4323-4ec3-43d5-be0c-768596430911@gmail.com>
Date: Fri, 23 Aug 2024 11:10:32 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] station: emit property changed for
 ConnectedAccessPoint
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240819175151.1310546-1-prestwoj@gmail.com>
 <20240819175151.1310546-4-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240819175151.1310546-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/19/24 12:51 PM, James Prestwood wrote:
> This was missed in a prior patch set. When station is connecting
> or disconnecting ConnectedAccessPoint property change should be
> emitted.
> ---
>   src/station.c | 4 ++++
>   1 file changed, 4 insertions(+)

Applied, thanks.

Regards,
-Denis

