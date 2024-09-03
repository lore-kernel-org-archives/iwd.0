Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BB1AD254
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363898; cv=none; b=FdT7wPLD86WmUr0lGMYRxLAllNsNTWMTqUv+SJ4MuP73dvmVMyBaAsWJpHzgR3D84FXIRPyuvbWq+5/L3s2rD9jfIZ76tif6QgT2PuhGQiQ7ha64OV5cLXbk6Al3pZciK/yyLp9ms0IBochnrZc+hRyY7SE8pVVbrnJ4GJLINnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363898; c=relaxed/simple;
	bh=KZ14GZZLnQ8AkepNxVFsjPxJy4B2YoXnxs600PDBL9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5WOa6/AwCBjtbz+VSRj7HpJ+KKekTDLEFPnJL8eXrYPpvvDHkVYhPm1PBxa0hqvh90iQE4FIL1kMrlPt/IpgklPikfO9QQS9Tef1Tfugq6Uc+4AoLewajbcWkh03+taCtHX3mvcc6TO7NmOa7C012vdWLDJ0RxY7mrtXDRTCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVR9s8vd; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVR9s8vd"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so174950a12.2
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725363896; x=1725968696; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5lvrMAS47XXK4ZE5gOrbjWa8zGzxDAJlEVyGVEAnHQM=;
        b=LVR9s8vdTLjSUun2pvBcfUk/oguYz1S39qScx7oRKLSFoBY39vGkKK+ZJ20yyw0BrJ
         wu7LFv7t7IeLdqR7llotTFBFDkSnRwsJzX6W+ccXCtfFtdtHMTJkKhI6UCW38caGbWJJ
         kDxMw6LHZx/dsnBN8AsJlSXTedh1pKhWHWsXRFA5L0BdnDxv1GEZwZW5186WZrjByH37
         9OUjrrSPvgNliUL+X+MWbIMDd4kt/12zsSkanK+rKXNban0bosDudN/RVfvCh3V6+hq3
         A9RrWTuYNYHM+9P6YSxxdTGH8V3YOZCRV80A5zxLcrQtADrlhmwJ70wCB6HRP+JWSs5c
         4xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363896; x=1725968696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lvrMAS47XXK4ZE5gOrbjWa8zGzxDAJlEVyGVEAnHQM=;
        b=Y3V4++MV6b95SRmX1LfpUVrZDsLe6875JgG6Xsh8O+vuHh0dlKxKp9SFrUBq6+ga7x
         r3jKr/XKxwqdT5rMAhU8GlH3HgCi+S/M3Mv3rvKXYAibN4CGj0qyMrjqzvM8eTFD/bNG
         uJN8Ak+PJUz97wiPFDDJ4Kazc96X2pCfyhYOwHPOPY7QsMNSkQ0I3u3YH42gvHPEbKyM
         CRZ+vRMEu7LkBBCN0NJXdazJfwh61suR7XLiWAIVn4WY6p4b5V0qwIrXoTQYeMBUe2Ob
         6wO6WFO1dUEprLWT+7wWNIj59X0qW6h9L8m8IaUtyDuEgS/aRZGoEmf0Bu8mbU+Uwu8r
         v6Pg==
X-Gm-Message-State: AOJu0YzManWvE95aSSAgnHHdMw2uvZQivY/uqjHx0xhPmwJujkT/n1sQ
	pGTPiQ3t46rbYq8G5DNkaYCHlIL3gwmEhSozldQV3gkVq/B51Zta
X-Google-Smtp-Source: AGHT+IHSL8onOcZY6KRGaxI2absdVfcQYnwr8dEIlInMKY0AN7+Apl7ZFFUy20KEZS9weIcZHC4rBw==
X-Received: by 2002:a17:902:d2ce:b0:205:4362:9987 with SMTP id d9443c01a7336-20543629b09mr104622815ad.1.1725363895203;
        Tue, 03 Sep 2024 04:44:55 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20545539a62sm50408275ad.122.2024.09.03.04.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:44:54 -0700 (PDT)
Message-ID: <4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com>
Date: Tue, 3 Sep 2024 04:44:53 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
To: Daniel Bond <danielbondno@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAO=WXSdnr7q2uJwEBvmrsfu+qpVCSTj0WVkKeRmPZi=TgTfYcw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAO=WXSdnr7q2uJwEBvmrsfu+qpVCSTj0WVkKeRmPZi=TgTfYcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 9/1/24 11:34 PM, Daniel Bond wrote:
> Hi,
>
> There was reported an issue reported in the Arch Linux issue tracker,
> which I also experienced on my hardware after upgrading iwd to version
> 2.20. What happens is that iwd constantly segfaults with messages like
> this:
>
> [  279.974994] Code: 00 00 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56
> 41 55 41 54 53 48 83 ec 18 48 89 4d c8 4c 89 45 c0 48 85 ff 0f 84 f3
>   00 00 00 <80> 7e 20 00 49 89 f5 0f 85 e6 00 00 00 48 83 fa 01 48 89 fb 49 89
> [  280.685109] iwd[1648]: segfault at 32 ip 0000788413f05de6 sp
> 00007ffeb3d023d0 error 4 in libell.so.0.0.2[1ade6,788413efb000+57000]
> lik
> ely on CPU 1 (core 1, socket 0)
> [  280.685125] Code: 00 00 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56
> 41 55 41 54 53 48 83 ec 18 48 89 4d c8 4c 89 45 c0 48 85 ff 0f 84 f3
>   00 00 00 <80> 7e 20 00 49 89 f5 0f 85 e6 00 00 00 48 83 fa 01 48 89 fb 49 89
> [  290.573368] iwd[1686]: segfault at 32 ip 00007c0b35d49de6 sp
> 00007fff86c509d0 error 4 in libell.so.0.0.2[1ade6,7c0b35d3f000+57000]
> lik
> ely on CPU 2 (core 0, socket 0)
>
> The issue seems to be resolved by checking that results->sr is set:
>
> - if (!results->sr->canceled)
> + if (results->sr && !results->sr->canceled)
The patch on the arch issue report looks good to me. Can we go ahead and 
just send that patch with git send-email?
>
> More information reported in the arch linux gitlab issuetracker, under
> gitlab archlinux org /archlinux/packaging/packages/iwd/-/issues/5 .
>
> In advance, thanks.
>
> Br, Daniel Bond
