Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712918BBB4
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377159; cv=none; b=Jr9yz2hCn7U39uoCK7IfSyYSVL1esAjvK4Ghx6F/y4AUMbMBXgt3+4DogZEvD1tLRHkIV9ag4LMTPtYjbN9zrkM5e+vq2OuKUgkGiElO4FValhZO4U+iVWMFGSbbj/J/scORJ3IdANyOUPrt7gLQRX7oA3Tfz7o5eDLf29cFtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377159; c=relaxed/simple;
	bh=NTXDWY6W7HhbFF0r5L+ThJssk1e/xcO7KMeGFhBx2os=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GXusjqBmHZWv4t4XNOnJ0xepdVmUCma4tG1RJ03Yi7Ggymi1Ox9/2eCMIlAS7XhiVLis5/jH4b3bXPgN4vxB4tHQtx8+CbVxhk19SFBsltnegGW7Vig+jFUFoIqGLTM4a0LQ96cqERh2KWRztGibBxbzPmrmbahiF00sN0rENaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh8g9lWg; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh8g9lWg"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-277cfd3f07aso1408282fac.3
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725377157; x=1725981957; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoIJ1hg5e31iL0n5JLWVVqKgB6j6TCPhFDcVaERYch8=;
        b=Nh8g9lWgROQI7bCxaUxT7zZfJDeUr/f/9sDc8jEUEP2v5B3NK6SX3MVqKtbA2vitjW
         Eqk3a7FNPYe5zTN8X/4Wv2lSTUBp1XYBhQXHZvjcsoua3mdees6C0r1JAsduoIbRmflj
         iVbJYqYLTxqRyVjXVYAMzD4HIXu45ibc6aSXflqcllZb7TWQ8urLrs1D7L0gduq3Hmkl
         QqyNwKuQXjZjEIujldFuCNk42ftOsxoor3jcy5Cm+BrkY9t7TQDgr0c+NVnhNX6+FPmk
         MPwBKIMvOqh8+RpSLgE+5ZJvMThwmllq+o865WEd/fHvUylqVJDeS4xuygM3hrkJUFTJ
         6ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725377157; x=1725981957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoIJ1hg5e31iL0n5JLWVVqKgB6j6TCPhFDcVaERYch8=;
        b=E6GLYNeLhswJNjd6HZGIL7GCXrS7BfwxCyBL7hHyKhEO8gfOaJPCEfYplCn0v3bTUI
         O+aWAJijZZTotr6Kv0TvdZjJR7rU8RCQMJvvlFVbj5AMXN4t/mXRm+WykjaFZ1O5cwuQ
         TSF8cHpPCPvPPRcDxUahUCSoqFiQsQ9jczijyzVvVH/9XhZAwEModnNg6uMVwekToobH
         YdqgouQAM2cV2bTHa/eZ2ZnwwsAjxodwk5NXDKD1LL61xAIPUBY74l9MrIsqhrmV5oBA
         9EBW7E4xHZ0Sq2DlDlzsaq0jG3UdaE551sWMdRtYkSx4XRaV23ypQJvUcTjc4f6XH1Ed
         e9+w==
X-Forwarded-Encrypted: i=1; AJvYcCVhDgyV9MF038XA2lgL5jMEOKF8b/x/sCgD4Wzo6JMISmBk0kmWCVkMk01iRgxdvW5w8GY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7WiAGhm22D5iGuIaExrrFTbee6xL+1v3gDSWaovRvQ6pw4Kgm
	0nKDrqqkmJZaE9Z5la+cnZzdVNw5OeEduO1fUr1Nafpts+XZWRhegTeChg==
X-Google-Smtp-Source: AGHT+IH6fygRpDu8Viot7F7uPqKhP/WC8RreLf2bW1Jt/PVc6GHodqkhtYTlAKfRZPbxQcOYXPDdcQ==
X-Received: by 2002:a05:6870:b413:b0:260:e36f:ef50 with SMTP id 586e51a60fabf-2779006e97cmr20190140fac.2.1725377157232;
        Tue, 03 Sep 2024 08:25:57 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2782b9355cdsm72006fac.39.2024.09.03.08.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:25:57 -0700 (PDT)
Message-ID: <3c32953c-aa70-4b14-a8e3-7b950fb15250@gmail.com>
Date: Tue, 3 Sep 2024 10:25:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] doc: Document station Affinities property
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240828192428.902761-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240828192428.902761-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/28/24 2:24 PM, James Prestwood wrote:
> This documents new DBus property that expose a bit more control to
> how IWD roams.
> 
> Setting the affinity on the connected BSS effectively "locks" IWD to
> that BSS (except at critical RSSI levels, explained below). This can
> be useful for clients that have access to more information about the
> environment than IWD. For example, if a client is stationary there
> is likely no point in trying to roam until it has moved elsewhere.
> 
> A new main.conf option would also be added:
> 
> [General].CriticalRoamThreshold
> 
> This would be the new roam threshold set if the currently connected
> BSS is in the Affinities list. If the RSSI continues to drop below
> this level IWD will still attempt to roam.
> ---
>   doc/station-api.txt | 17 +++++++++++++++++
>   src/iwd.config.rst  | 16 ++++++++++++++++
>   2 files changed, 33 insertions(+)
> 

All applied, thanks.

Regards,
-Denis

