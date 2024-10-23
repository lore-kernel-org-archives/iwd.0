Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CA15746E
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720708; cv=none; b=jHbbqyHjLAQADd+/+eMim0+EELpZy9VsZyKTZH7iTq0MK1ZNkMqCWo+bFhY0iBer8t0da/S+Abuyh5yGQ3ASOVx2ymjsT8jNSyTLJv9Yx5jIGG8SilyfZXwDayXGdXzesXNvtJUzTMEYrDqIVFqsGupj2k2vzVf1LLXNtr88QvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720708; c=relaxed/simple;
	bh=WD8RhJ7sAp1Vaf5mLJUydsQoHeZj2c7homb1HAQrTUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RjT7ILZbDDSvYJx4sAAYakTCQKEGdOq+psDb4JlqBonJNeDP2oG0K4XU54TOb9rxqcq6KKkrYXyahTu/aEllzVCc88GpSVIDqJMl3P5NHQ6PV0LFM9aZFHZ6BDUAdEUr50uCcAqROMsh9Loev5OgOyMHm5hIqrNg/TUEhvlpuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLK25HrI; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLK25HrI"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e604425aa0so199888b6e.0
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729720705; x=1730325505; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5U9pObWhrb6PrhBUuKuOavPq45h3Cky/NZPCdVW5cCg=;
        b=JLK25HrIHQsbrTT0waKvrF5WCWzlBIzjVlvAhGEfzbWOUbC8xx2htHXVLoiMzqseu1
         EioIWXrPZd2wftyBqkPTC7jHqy9SEJBvTFrrsk9ZJTJUIL1pNnUrOBQ3E1cmCXos4h7y
         jsMVRS56JCGWmTNj0gs/KcwV1tutnNGd8UwbN59sgqlzJrX2QXh3TLEwMJ/G+cZLAGFT
         b3FpDsYfEuv4Bjd6J448Zypx1YQWPGEf+lXtJPyAwPJik37EoDP48E1zRw0UplBJPSpc
         gQEOxQWy7o9u/GQDNMJl5YYcBJ+bva5q+AfdC7O4/ywX0hNPWYmrJI/l+ISENzDmd+Xd
         DaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729720705; x=1730325505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5U9pObWhrb6PrhBUuKuOavPq45h3Cky/NZPCdVW5cCg=;
        b=dlG5UA9LG5c5JquT3OvNnycnBVgRCOH2vmpR77NcBkq++x6eG2CAssRkd/9QzZsgy4
         MSXG9pCMfr+hx2FE85MkiS+cbGxoCcVyCEeQUBFTHqbDXmaDn7ZERZWcwUVnTBMd1ZNk
         FwgTNy0gT2zi+obTP64PYC3dUIG2AJNbEHozTJdp+IaB8FdwlEMRGZZY89mKTtlTTUi4
         hugqJcmEzEs/zt6y+e1go4xjVP8DeJOfpWAB6LRnUHmtRb7/x3qlWnoSc11iIvGxfHsd
         /dfObdxAesbJGmh9APKDSqXYjvDr16nN+S3m9y94faGWGhKXsyfag4wRy0t2EKie58J2
         JIdA==
X-Gm-Message-State: AOJu0YyJdJH19vH3GVkn6bWR0+8itF6BwzsHcr2xgsWxTgCyCrTiQTrK
	I+oty2OhlMx/rA0vfxU+rcv1kaApQsH+c09K8itbqA14CZsdf5mP4u8LMQ==
X-Google-Smtp-Source: AGHT+IEziKg7c1hEhBuVBo5sqNMFbULnS9EVVeVf+P+D4jPmAuyk3tr/9q4La8Gs+ddExGdZgB1cpA==
X-Received: by 2002:a05:6808:2e8f:b0:3e6:22d3:c85 with SMTP id 5614622812f47-3e6244fd866mr4634906b6e.5.1729720705466;
        Wed, 23 Oct 2024 14:58:25 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e61034f0besm1969235b6e.39.2024.10.23.14.58.24
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 14:58:24 -0700 (PDT)
Message-ID: <e7584d9d-2d6f-4702-a3b9-c78b5e53eba8@gmail.com>
Date: Wed, 23 Oct 2024 16:58:23 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: Comply with doc/coding-style.txt M13
To: iwd@lists.linux.dev
References: <20241014154929.1318721-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241014154929.1318721-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 10:49 AM, Denis Kenzior wrote:
> ---
>   src/backtrace.c  | 4 ++--
>   src/eap.c        | 4 ++--
>   src/frame-xchg.c | 3 +--
>   src/netconfig.c  | 2 +-
>   src/storage.c    | 4 ++--
>   src/udev.c       | 3 +--
>   src/wscutil.c    | 2 +-
>   unit/test-dpp.c  | 4 ++--
>   unit/test-ie.c   | 4 ++--
>   unit/test-json.c | 2 +-
>   10 files changed, 15 insertions(+), 17 deletions(-)
> 

Applied

