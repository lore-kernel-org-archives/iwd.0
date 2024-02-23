Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55A8BE7
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700702; cv=none; b=PMoxrrhrdxeTddpQ9U12uLZnYNsvQWmSdlsxgGAduBSq9NYE2ebos/2+HaCTjdbI4KAdqaee83G6rr07eoBfiPkJCmWqYGR6ufPEzvMQwDENIY5KGb3HaCSeZAwQKC5sMcQsfMDBaPlclxFr/rPfmUP4b8VCfH0GLhJJq3HxD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700702; c=relaxed/simple;
	bh=4++f67AD9v0F862np+ASOEbkN7E1kRxZJ/4hzIWFMXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NR5VZtAnR8AwY5I/nKE7W6DP4IelkAYEmN1rcp0Px9chAuVVmCPHZ2PrWXZGm5KoEJQ9nlo2L1gE/74MvIj5fwumrTWxxYBk7NP5kDjsDLnMc9qFtcE8upq9C2tPpiySr/V/NHe6GMaUCKtxaZ1TEqpA86BykXDjtWrSWXrTPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSQzvyMY; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSQzvyMY"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c0485fc8b8so601237b6e.3
        for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708700700; x=1709305500; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/ys2n1q0CeXwHFcuubX9W+hZkCNbH2inpPkBBeRt3g=;
        b=jSQzvyMY9+Rbd1M1wH7J0Bj05cWyImoNRMMBjBHXOFNBUW6CRdCdtrNqFwfnN1r8Jb
         jzaUX1k3hZSQFG0RdTiZUA6kNvdait/GxbmMtuxl4hZO1k3QPj147WIFJHnRsxto0yBj
         cNPFltQPIBtn+fQrlC+TLPsnPI1aENdWxptvhq9/y6L7/Ve2OIBSICam1v8F4ItR9ztl
         tL+amxZDoLrQ9JOOzE1toh3TklKzXtavSGC8t/qJZDqfKfkfZ68Or0VrlyEBRcSzpcIr
         GQMz1k6BjV5kQwHNAr2EFMkxtyDBbc+/dMvgeUQu6TeyhAzT+4kL22Qut+ZUpFwHYLYq
         VVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700700; x=1709305500;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/ys2n1q0CeXwHFcuubX9W+hZkCNbH2inpPkBBeRt3g=;
        b=HzGw/+MzKgKpNIWYY98Bxcnq7/4Zbup1NG8p1rNmbqbWaMD36gSPQ+pVwzRfhNlvY6
         tSe36sdeo0W3JeeDAx0WFCHlwhuEMk5gDFDeMLsh9J+0ILwRJmlg5er2+fParr+va6RV
         OWakDYyhM25VppYg0k9mQrv9PBQwaDiJ2cEbEbm69jmUVQLI+6QsrKDROhOGRoHbA1Q9
         kf59IHaMK9vQFz+Hv35piO6WDEo1A6wHu4Pxvj8KAdW5jAQZL7FpPKjngslHc09fEt27
         Xd4brKwKMLOW70Zc0e4YmwKWWBIr7i44h/XTwFH6hhI0GbjU0Wgo1nPqh8+R3TZ9hFjn
         s/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUAOhFMbVUwSFHHaXFSXBEEHPcIe6Kw87SziMjtSlv3LL+2GL+WiaO5L3LJuwGt8SOxmCsYtbCpGQzvT4x8X4351Ods
X-Gm-Message-State: AOJu0Yw6cWFbd94d1kFB6rupSNic9KS7LLd65UMt8C07DIE/KFUwOIHh
	Awb9T5LHbyusRbrzNbCkWi2EzmDerSL+nwr21epvSJjcyIaYYxaWE0hwDPQT
X-Google-Smtp-Source: AGHT+IEbzdcKmWxxE9sjtsSAS2+Yvnn1Ay3Au/H6CJ6nrSo8Mb6Ul7q7QBjhXE6nwOmQple1zk/90A==
X-Received: by 2002:a05:6808:10ce:b0:3c1:784b:d67e with SMTP id s14-20020a05680810ce00b003c1784bd67emr107701ois.10.1708700699914;
        Fri, 23 Feb 2024 07:04:59 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bf19-20020a056808191300b003c0315ead99sm2464685oib.45.2024.02.23.07.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:04:59 -0800 (PST)
Message-ID: <c935faa9-b90e-472a-917b-4cfd64c9d7f3@gmail.com>
Date: Fri, 23 Feb 2024 09:04:58 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to connect to eduroam
Content-Language: en-US
To: Michael Yartys <mail@yartys.no>, "iwd@lists.linux.dev"
 <iwd@lists.linux.dev>
References: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

> 
> I'm sure these certificates are correct because I was able to roll back to a working build on Fedora Silverblue to keep connecting to the network. Unfortunately, I was dumb enough to forget to pin/freeze that working build to prevent it from being replaced by new versions as I continually updated the system.

Do you have any clue what changes you made to the working build?  iwd hasn't 
touched certificate bits for a number of releases now.

> 
> I searched a bit around and found that some other folks had experienced the same issue on Arch: https://bbs.archlinux.org/viewtopic.php?id=291921
> 
> That thread links to another thread about the deprecation of SHA-1 in the kernel: https://bbs.archlinux.org/viewtopic.php?id=292208

Someone should complain to the linux-crypto folks for breaking uapis and have 
that change reverted.

> 
> rochus from the first thread was able to connect to their eduroam network when they tried a kernel with the offending commit reverted. Now, I know very little about certificates, but no certificates in my cert chain are SHA-1 signed, are they? Could this still be related to the issue I'm experiencing?

I can't dump the second certificate for some reason, but the first has:
[denkenz@archdev ell]$ openssl x509 -in cert2.pem -text
...
     Signature Algorithm: ecdsa-with-SHA256

Do you have CONFIG_ECDSA=y in your kernel?

[denkenz@archdev ell]$ zless /proc/config.gz | grep ECDSA
CONFIG_CRYPTO_ECDSA=y
CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=y

Regards,
-Denis
