Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F102D60A
	for <iwd@lists.linux.dev>; Tue, 14 May 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689556; cv=none; b=O0sWUP7WRKIEFBIqaTApkCBdkn/QVMnfUyOmLZCKvOP5xdtztwzAMskOhE5RybEtR/GY1lnqjxR63ko22krPzZp1g+Fe+VfmnXLF37s1VywS/p1acjIO0yN4JmwucBAp3KZYuAZu1xKAsVui9rn9R97ti4Tp6wNxPbiK6EU4PqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689556; c=relaxed/simple;
	bh=K0sk8GtD/vrM3LOfTyMq1Gtgbh16+4KCaOdih8F2z2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q7ReACPox2xXMPHaAGDQRHPwdXMTZ9q6QEibJpfDiNBsuGT7aF5lX6+HZV/dmjvdcsJOp0ecWNV196Ok9KFu/D9nXuxhBDcTP5F/1lz+c805rLAQY9iEZ36Uup5fEvPtkkxnriD52zWpg/Po2Fw704zy1/RUEQ08G/WsQyFKskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVEy1MA1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVEy1MA1"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43e18255597so13348031cf.3
        for <iwd@lists.linux.dev>; Tue, 14 May 2024 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689554; x=1716294354; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKZiCnlFXvj2xeWc1/fIKNUWhxwmEXn6EBqOUlVPyYg=;
        b=KVEy1MA1eA+t8MiZY/RX/pDFATgN0TWpRbiWQVxGXsl8g4cGkgNO4kIbrcRBCaglX2
         VPcnNCxpzXDGrQV4SVuybdS/fGgHyZKB8AtbgDoBlCLtabU30QbDgag8vRM85ex9sVna
         Jou2IccG4t33z5sSBT5k9nhBYDiPLM25o6pQE+kvZ9q/8oEJkoTVJZa0V4aDFrmPGv/v
         tVQsuzb6R7Wtnk3ah22J2hig5Qm+aL3lXl9VfE1YrDgXyAI9v/heud2fxiAnqFu4Crs+
         MSgmsgMOnDbioTldPGn7TTftFfP2kiV6P+rpklqzLdkdrDUyYjxS5pK3qdX5usuTq+0h
         VZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689554; x=1716294354;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKZiCnlFXvj2xeWc1/fIKNUWhxwmEXn6EBqOUlVPyYg=;
        b=sLHkzhwSOZfJldDjH4p8RyJsvMXsr9/T2t0ShvwNf1ikqCrxUDI8av7/mo4+cCtq5e
         93YRLsg8SSJ3sx4S25fiWqW3tmg3Io5GR9BJUTpqgx8W7HFi5eMi7vJo5OkdKfYxiQSY
         vDt+pn26v1jwpEro9isaQS9VK0hs8dpORhqItHaRfEOdMM2DUqltATLq9gQhf42nzgK3
         wDEgEtSyl/S5n/KKa/nKvwV9DKhX1IfAvJFZWMg1HMljKOiOdRj60WDzRp7cR3ddgjPj
         JnuXW6GpUb5iQa1jHoicRTRfxnD8d1488pNyY6LyRPaE9yyEW58Eno2b2tCGUnt8rYnS
         w1cw==
X-Gm-Message-State: AOJu0Yx2o3mUvYlfWeKqdMalev5Z6+slFgJ08t5/W9OZSR+FHaJWd7/X
	EqFUJbGdOfDQFEIoj8TWeQube2DSTPLK3m7fDjH/UjjjGr56MBvLme3vUw==
X-Google-Smtp-Source: AGHT+IHa14bUWHM8xGgavj9OWjEWDLOQH0ZOmkOLO1TUqLpSQrA7CyfpNrNU8SRzPyMFNAtIuoCwQw==
X-Received: by 2002:a05:6214:4985:b0:6a0:590e:d616 with SMTP id 6a1803df08f44-6a1681a3bbdmr138110856d6.29.1715689553626;
        Tue, 14 May 2024 05:25:53 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f188842sm52918356d6.56.2024.05.14.05.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 05:25:52 -0700 (PDT)
Message-ID: <ce68de5c-bd18-463e-bd1d-7ab1ea300944@gmail.com>
Date: Tue, 14 May 2024 05:25:50 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: Create ell directory for ell/ell.h target
Content-Language: en-US
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20240229195654.1579749-1-prestwoj@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Denis Kenzior <denkenz@gmail.com>,
 KeithG <ys3al35l@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240229195654.1579749-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/29/24 11:56 AM, James Prestwood wrote:
> Both ell/shared and ell/internal targets first create the ell/
> directory within IWD. This apparently was just luck that one of
> these always finished first in parallel builds. On my system at
> least when building using dpkg-buildpackage IWD fails to build
> due to the ell/ directory missing. From the logs it appears that
> both the shared/internal targets were started but didn't complete
> (or at least create the directory) before the ell/ell.h target:
>
> make[1]: Entering directory '/home/jprestwood/tmp/iwd'
> /usr/bin/mkdir -p ell
> /usr/bin/mkdir -p ell
> echo -n > ell/ell.h
> /usr/bin/mkdir -p src
> /bin/bash: line 1: ell/ell.h: No such file or directory
> make[1]: *** [Makefile:4028: ell/ell.h] Error 1
>
> Creating the ell/ directory within the ell/ell.h target solve
> the issue. For reference this is the configure command dpkg
> is using:
>
> ./configure --build=x86_64-linux-gnu \
> 	--prefix=/usr \
> 	--includedir=/usr/include \
> 	--mandir=/usr/share/man \
> 	--infodir=/usr/share/info \
> 	--sysconfdir=/etc \
> 	--localstatedir=/var \
> 	--disable-option-checking \
> 	--disable-silent-rules \
> 	--libdir=/usr/lib/x86_64-linux-gnu \
> 	--runstatedir=/run \
> 	--disable-maintainer-mode \
> 	--disable-dependency-tracking \
> 	--enable-tools \
> 	--enable-dbus-policy
> ---
>   Makefile.am | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Makefile.am b/Makefile.am
> index 5ed6ab37..be287572 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -710,6 +710,7 @@ ell/internal: Makefile
>   	done > $@
>   
>   ell/ell.h: Makefile
> +	$(AM_V_at)$(MKDIR_P) ell
>   	$(AM_V_at)echo -n > $@
>   	$(AM_V_GEN)for f in $(ell_headers) ; do \
>   		echo "#include <$$f>" >> $@ ; \

I noticed this patch was still in my private IWD tree and never got 
merged. Could we take a look at this? For me (and Keith) it appears to 
be required for debian builds. For whatever reason that build system 
triggers the timing just right that the ell/ directory doesn't exist 
when copying the ell source.

Thanks,

James

