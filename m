Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C6230BD9
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316568; cv=none; b=hsyHT9E6sTGc7V91lP87lUbwASBjuHZNOUck2imhub3e3PWPx/1PUzbjdgKfeL4rcKRVfJD065u89bl4AKtietO7UQaaaIeSMwMupy1/RJcIWZ2QkxzPKiadb1KqNT80abFH7D5mhEQmBzORkGbYm0+etgzTHgvZnlGCrSvF2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316568; c=relaxed/simple;
	bh=oKND2uyKYQizQl68J0L4j1IUWlHHrJHVbT3GxXjUm+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KtUbr/PlvNeaBtTL0EB9VdyMe1kMavuhhgDY+yxEhGDT2nraGwpj/1WikLmOhNFhlq7kNAXtHclxgbRRsHUmrghE7yQlYe7B9yKI1QT55LxUdduO/B2+9h+nr9Tq/K2TqIYXTN2uwVrR6JshD3kf2FJRwmo9mm7Fw2QjaR3H0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNTMBxSC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNTMBxSC"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74381e2079fso93954a34.0
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756316564; x=1756921364; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ZFZ4BPym2PHzm0cEc4mq6WYHV7jeECzJNr18BBHiqU=;
        b=GNTMBxSCTVEYkvbpU6ZSFT+hOLNmPfK+f07mdRaP2XSpU8OKch5q1//+btZuqIDHgJ
         j7Z+4Y1jWeIJQsO5ZYf0jrkwMsgdBVYhsHovXrXvt33tvL0Qxhq6YfGc9ahwqoDnr8rH
         wF7n3wfgM+191zo9t974mgcn3AtIs7KRbxEBw99qMmjJNytuEITLhfPZdxNG30YplAbN
         1W9vWjpxk4wfhTekcb9vn/q8Cz0TdIpsaSLRZ6F08KL8JicI66VLKNL2IGYzvvjCDXck
         CDge9cHTLHCLZY/WRdvlFPpduApkd0QVkFwB86GKNcboIVSyKec5uLZDxofPVUQTegwd
         p2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756316564; x=1756921364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZFZ4BPym2PHzm0cEc4mq6WYHV7jeECzJNr18BBHiqU=;
        b=kfyzZOVDY+Dy9Lwlyl28RDGo/PFWEnqqObAUCTdi+gijnXuwPW1MzrCqUw0jJ89D9B
         6n9cJgwY9ltQZrSHQq7TkG5cZSnKTCKZeNZvw+CBM3GHFGvCkDqVqzUKvrxsgd3RZbay
         RIRhyHBMmHR5acspXgP+Zj24x9acRdsqfsfBlB9v+kRqf2/sQ7sPO5VXdSDYfEhExs4p
         2jQ/OW1h9uvICo0cO/spAU7mHYm9XlVJF0p7bfzN0GsCOmlcZe15mw9guJLra/uURLx4
         4vGJ3cVZPQdshkImHJw59S11bk/XFH6+ngVnaWafgELAM6H3RFdSeuR12+/XquZikKPj
         BUkA==
X-Forwarded-Encrypted: i=1; AJvYcCV05iMq2dC4RNq8BZMAT38fZYcuAhauBPjupGcR4wNjGkPQ11defrdyBXoIJ6VjOINFBCg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1LKgsn61SBMmPmBeCU5eTvEK8+EITwrSTJD/6FRVeaPW4IMZU
	hX8DwYoftJxquvOeez85cMvET3O0gjOJ+w6i0BGx9KKe7SBXExYkW4FZ
X-Gm-Gg: ASbGncu4HucdfpWmjz65mW+3klDjSeUI0Kmi1cmhdlP12K7OEPcujHXQ47ZI+X9E5uG
	Ka8CIsC5N2brTUGzBg+u+JSBM9xL5eGQEkUOxBrWH9kgl8pRA3gI7ExljgtRgkQR1ZP5VpLDxvE
	s2rZx2Df0Od55oqDNVyzpClPWums2h4MwAHxfF22ua1KGMr1GsZ1RJcnV8c+pwawWSNNkonfUDK
	kI/Z4EnCE4asP1112IemQlXFNHoMOXrrWE2qYO06PID6N5GU8sQ06mkz3iEvLHqJUNkNfI0HiDm
	QW2U8eosNHo4Vx5cwTbHZdDTiB26ik4KrGKzo/68AMEzBJivRPVT/zkjMcboXWiXyiuDTcsps+p
	nSwpM7j360ofqs+DQkbjPejyvub16yEkOtDmpwnmimoFlpccvpKl2H9rkSc70msX6mtg76enzxB
	4=
X-Google-Smtp-Source: AGHT+IGK+MotU2wL8vZz8wsVyjDde8sEMevQleBtAp3hw3ZCGqIWYWd5CoDqnE7P2OdKmLGgdr4zkQ==
X-Received: by 2002:a05:6808:2448:b0:435:e0b9:2827 with SMTP id 5614622812f47-437851bb4d7mr10129950b6e.14.1756316564200;
        Wed, 27 Aug 2025 10:42:44 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-437968c9728sm1999376b6e.18.2025.08.27.10.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 10:42:43 -0700 (PDT)
Message-ID: <8ce2c97a-6fdd-4ffe-a24b-d7d93d29b9e1@gmail.com>
Date: Wed, 27 Aug 2025 12:42:42 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] vendor_quirks: initial skeleton
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250827125501.477908-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/27/25 7:54 AM, James Prestwood wrote:
> This module will provide a database for known issues or quirks with
> wireless vendors.
> 
> The vendor_quirks_append_for_oui() API is intended to be called from
> scan.c when parsing vendor attributes. This will lookup any quirks
> associated with the OUI provided and combine them into an existing
> vendor_quirk structure. This can be repeated against all the vendor
> OUI's seen in the scan then referenced later to alter IWD behavior.
> 
> In the future more critera could be added such as MAC address prefix
> or more generalized IE matches e.g.
> 
> vendor_quirks_append_for_mac()
> vendor_quirks_append_for_ie()
> etc.
> ---
>   Makefile.am         |  2 ++
>   src/vendor_quirks.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
>   src/vendor_quirks.h | 39 ++++++++++++++++++++++++++
>   3 files changed, 108 insertions(+)
>   create mode 100644 src/vendor_quirks.c
>   create mode 100644 src/vendor_quirks.h
> 
> v2:
>   * Use a bitfield structure rather than enums/masks
>   * Rename API to be specific to OUI matches. Potentially to extend
>     in the future to match MAC/IE's
> 

All applied, thanks.

Regards,
-Denis
