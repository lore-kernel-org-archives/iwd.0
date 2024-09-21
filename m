Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9B1F957
	for <iwd@lists.linux.dev>; Sat, 21 Sep 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726945152; cv=none; b=YJzDwvkaK0/NiqK8H4rJhRGqJdU98+jRoPU+j/k7OiVYV9IjN9XwWDivcFfW6eR79i9nNlIcmSqkVnJz8zS8v5HO/BzOKNZu07c75tQa6i7iALqQFfvTJUpF2xeeA9XLHBIypeK9SkeRX3jqGiFw2XMl3pWa3bNPOBFAUGGyAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726945152; c=relaxed/simple;
	bh=EfiF2xBhI2bMGlb/EL28ezKcPdZ96l0BoXtZmkQrHyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tssjmjdZv31VSH4rOt4lkEfV5t5RhpyVGmmk5vWSxnwkWwINwv+oEVXSkSL4u0JOC96kMQQtagbEoprb6nm1XojFP1kmSHLIcgG265DYt2QHdXQpOAVP9k3YMejR+K3aliLwKhVtyv4l8fmTEd/caC3aVDFvJ2KCsF8frJE6+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tani3YOb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tani3YOb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cae102702so24497255e9.0
        for <iwd@lists.linux.dev>; Sat, 21 Sep 2024 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726945149; x=1727549949; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rJY8WpFwszgN2ZRr3G8ecug3VZTy5JtaCunRMtx2wE=;
        b=Tani3YObp7/k87IyUmOhF319IZKObXEoxLdwjpSTCB6kaBXQmgxHwfrADrW/0VkpwN
         CNDNelurkUoXumYwytrnAeCPTgBlQg2+Gh8kvWrOxFTDGYz0+vXAL7JBy9mjEfM7CMk/
         aQ5LfuvJGg2ewGGufYvZV24ED+TXk4J/72/2N8flK6O8E711AYQYWAy5RBBqr8up7f24
         zfjRfw3w+2A6hVNGEO/1/596wqNbnZLwjFBv7wUb9d/5ZCnEiNlN4Bpvw4dnDZk92qEL
         Wxe/3MM+EIkdI7wb5DNgjR6UZV4S75BYaLS7oLPjUSxus8NWjAH6524If4bi8V2slvYB
         0HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726945149; x=1727549949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rJY8WpFwszgN2ZRr3G8ecug3VZTy5JtaCunRMtx2wE=;
        b=afzQYaQj5yIQ1Q47MKcWOFEVI2+3pOMw0Y9BxyGFB/OVz94u4ucjxtBmqOoV2SyaoH
         E5JfUsj8mNR9053j7mj6kKWC/MCdfsxV33Ph9g5U3Y3L8qvRomDcFT9KIE5nmwXwQxkZ
         UsVK9rOmwN/Vy81qkAgcUeVDvbMP8HQfeh4zQnPtCfr/f8t6o7gOVQKG7oWe/AMnqv3k
         6YFZsDup/MCIW50I1w3I/gGbMS66i4iC7CFyNRsxtaDjp20CYnnX6yPKBRYdc9nmYUc2
         sojZuPFkJtWdw7snbOZ4nfkBMDvxI7owK691IFNuil/YXuu6ea2h0EGCjnFIuboBgzse
         KSoQ==
X-Gm-Message-State: AOJu0Yx/ZS4gNIiX0ML2ndx5WRpm6tO7ThZ8VwYZW0AZBjEQJQV6/wa5
	KzSLTXNW9DIpJbiaYtMXvbSya2YhKJwOJ99Ae2ZLNNizzaC6JYRb
X-Google-Smtp-Source: AGHT+IHtnRssk378hMoM4NfZoxKX35JJXVSlmyqjdzo6Z/lAq2Xxugct6NHkiCqCimLInim2y9TDng==
X-Received: by 2002:a05:600c:1c84:b0:426:6158:962d with SMTP id 5b1f17b1804b1-42e7ad8ad03mr40620835e9.23.1726945148656;
        Sat, 21 Sep 2024 11:59:08 -0700 (PDT)
Received: from node-04.shui.loopb4ck.systems ([2a00:23ee:13a8:18d4:da80:83ff:fe9c:2d23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a619dsm84532585e9.30.2024.09.21.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:59:08 -0700 (PDT)
From: Yuxuan Shui <yshuiv7@gmail.com>
To: denkenz@gmail.com,
	ys3al35l@gmail.com
Cc: iwd@lists.linux.dev,
	yshuiv7@gmail.com,
	arend.vanspriel@broadcom.com,
	prestwoj@gmail.com
Subject: Re: [RFC PATCH v1 0/2] External Auth support
Date: Sat, 21 Sep 2024 19:58:54 +0100
Message-ID: <20240921185902.170612-1-yshuiv7@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823174220.498594-1-denkenz@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,


On Fri, Aug 23, 2024 at 12:42 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> This series implements External Auth support on Full MAC cards that do
> not support SAE offload.  I have not been able to test this fully since
> the brcmfmac firmware on the RPi 5 does not actually work properly.
> Maybe some enterprising person can test it on a firmware that does work?
>
> Denis Kenzior (2):
>   netdev: external auth support
>   sae: Allow ability to force Group 19 / Hunt and Peck
>
>  src/netdev.c      | 258 +++++++++++++++++++++++++++++++++++++++++-----
>  src/nl80211util.c |   4 +-
>  src/sae.c         |  20 ++++
>  src/sae.h         |   3 +
>  src/wiphy.c       |  19 ++--
>  5 files changed, 263 insertions(+), 41 deletions(-)
>
> --
> 2.45.2
>

I tested this on an RPi5 too, and indeed I am having the same problem as KeithG
as well. However I managed to get some debug information from brcmfmac when
running wpa_supplicant. Interestingly wpa_supplicant gets the same -52 error as
well, which it reports as an authentication timeout. But if I ask it to try
again, it will connect successfully, and there is no external auth related log
the second time around.

So I suspect this is a firmware bug, but it should be relatively easy to
workaround I think? Basically we also add a timeout and retry.

BTW, with the current version of this patch, if I ask iwd to disconnect after
getting the -52 error, iwd segfaults.

Regards,
Yuxuan Shui
