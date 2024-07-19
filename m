Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D72BB05
	for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421210; cv=none; b=q7cCO1jDnMHw168kfR3t64L9MlxWb3MINI5eG+q+VvYzI+4OpNLCsxSMlQit2uV7P81IWBM4uWiKQIoHJk44buWzDe1eleK5XTrUo0a7jn8OIYUvminBkX2Bp50ZJHSgKbf7fXLGNAekBC+R6uIDS43tZwMTEhUMUblbMJ0YLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421210; c=relaxed/simple;
	bh=o+vUZA+x53qx+Sh7vyS4AGgGnBNIV5cRcLRBhA3pbX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=skbSCmlR30n0TREka5Vjpac1E6DRVFGNhPU4pGt/YIpyKxS6GBJKJTAE0J0htvg+ykwUlGL13Tqt3mQ333oEQlT1KZZtCC07pWi7X7ehcfoy7S/67K2EC1R9jh+57GsOD9ZAHheFnPhkrIsmoCPlHV33hBwbGnn7aRBRpTIrw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYfs90n1; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYfs90n1"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260209df55dso1009616fac.2
        for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721421208; x=1722026008; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTQXW+KGl5lZX9iad0toMM2Lwvk3xHZzJPfmsr2WPxM=;
        b=UYfs90n18DtfaUrzAtAIryTIUt6bx1qIGDyoIzKSIBeYZV6BHI5hd4HSuYal+OFFx9
         OeISOn9taDfFeE20OyuoT+8Ob34hABuberzzqipr1ItK5Kl0oMBwJNcJtCrL237A8xpt
         cJTse704OEbnU373A8H+5OrfNHyMdQLBjxZmX3qjDrK8nBe1MtcioBKoBaITpSGgP9XR
         AXjm714NNzysTu8ugQ/zfqyMFvcJxSt0kchU9pm41VyP0fE4y/5u7km/7CkJ5Q3vP07D
         joILAT8mtxfpBhyLvKDSmowAveOzsiI1n4hqV1PlziuoNy51NfNvLSMWB44B/Txqe8/5
         toiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721421208; x=1722026008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTQXW+KGl5lZX9iad0toMM2Lwvk3xHZzJPfmsr2WPxM=;
        b=HU9usFmA45P0TgKZYYe2GKESXZNV+hhUbKgTZ4fb+YVXxvIx96vcpQHf08TJbIeXrW
         aWBE+kKrj5JFtdJg62hAfBdm7n97rP0xFvRvuTT/yiOGBTDT+Fgon9Qd3mAirShR8tqX
         LN5r/VIeL/lMCMYtGB7SWqWHDBneTNnS4LWG1kY8+cR1zCOJrNb2zhragipcXId4Oxwk
         /slYbUwJrE4N+rsNC+EfRuj1bGRlxdpqCKoRWgJG0/14fP0CUOl7IJfeR+f57LaMLtSC
         oOfIx4rIfIycNaMcZle16y0bwta+Kvu4h0poutvxwa756lK+Ea/eb55g3B6eVtCdUvgR
         5YQg==
X-Forwarded-Encrypted: i=1; AJvYcCX208DqBLbuPQMdZSbDrG97ySKZgqKn5ZsFbgMMYfNazLZe1H07ikJ2SEKYVoPu4ie5+nHR7x1SJgdzpusDJKH4BOAQ
X-Gm-Message-State: AOJu0YzPRSinHSpaW32oedTc29fR4DKSbOVHAv9QRlyCKX4zFDf8SLOy
	IU4exqsvACH6tCnBb4Oh0f+5EvpwW0QjC5DVRzN0WHPxWMsouSo4
X-Google-Smtp-Source: AGHT+IEUo5ZEkY+Ho07ZS0pUzz2ulMT+RmNUcjxV2eCTFk3O7EGq3ZqVN2XxJ3oycnBaXm+1WOfRKA==
X-Received: by 2002:a05:6870:3041:b0:261:21ad:9244 with SMTP id 586e51a60fabf-26121ad973emr721265fac.39.1721421208364;
        Fri, 19 Jul 2024 13:33:28 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2610c715436sm464506fac.1.2024.07.19.13.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 13:33:28 -0700 (PDT)
Message-ID: <abdda292-7c90-4705-9c81-9e11ffaedd10@gmail.com>
Date: Fri, 19 Jul 2024 15:33:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dpp: relax requirement on IWD being in a disconnected
 state
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240719181926.3888420-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240719181926.3888420-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/19/24 1:19 PM, James Prestwood wrote:
> Initially this made sense and for a completely unconfigured device
> there is little to no downside to limiting IWD's state to
> disconnected (or autoconnect states).
>

What about periodic scanning?

> Where this poses a problem is if the device has been configured
> incorrectly, for example with an invalid PSK. IWD will continue to
> try and connect to the network, blocking DPP from ever being
> started and always returning busy. Even if you timed it perfectly
> to start DP between connection attempts it would be canceled right
> away when IWD tried connecting again.

As in station_get_connected_network() returns non NULL?

> 
> Instead we can relax this requirement by allowing DPP to start even
> if IWD is connecting, and only cancel DPP when IWD's state
> transitions to connnected. Since DPP effectively blocks the wiphy
> work queue once it is started it will prevent any further connection
> attempts until it completes.

But if iwd is connecting, station_get_connected_network() is true and we've 
already sent the connection request?  So, you're inserting DPP work which will 
run after the connection attempt fails?

Have you looked into how WSC does this?

> ---
>   src/dpp.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 43 insertions(+), 5 deletions(-)

FYI, CI is failing the DPP test for this set.

Regards,
-Denis
