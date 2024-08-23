Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686598488
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434283; cv=none; b=bLCJnNV9H6ZsGeH+36h5st1+YoSR9r9QfFSHfHW5dmdrPyS2GRt1+WVX0AwqfY2c6eMSg4YXH+gaKuqEZswfPlcTi6lcjrJYeT3RkSFXZtu/A7H5ASegjqKXygzXd4xIQwcStqxKG/KmJlaenaNyh/dFcXyDbytAUVYl+XoIW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434283; c=relaxed/simple;
	bh=hDe/+HazXrZ8gIaCzCOH3S88KUS9QIS00IjIfV2iwa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OZnjV7vzPRZqA3QcJhhx2FlFsHeDoL0V3oxCKGHxfnaOIcJ8Ems623HJzlBwgFUgM5KudcZskcK0mgrzHhaLFLfu+sJCljizIGtQmWNs5Hv10d5WejsfvDWDMMecyXRy5Ldgq8/IqlYC8ksKuvLVGX7v9BPI+f/1IFQjxnVQEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9WbZvWV; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9WbZvWV"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2701c010388so1396907fac.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724434281; x=1725039081; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dnLnTh119A3RWkef9yN2B3w4lQzPk9GOiDwkQpiN8lU=;
        b=X9WbZvWVdxWYwi6R6nVIcsfxkK7EMqXyeebNavBtMa77jbg/aeCVPfcOCogdpvh4lt
         aKGuWEZq6AhNvzT/knZBWe5u7LTZs92hHLZf3jaY61UaSjBy6kkjXxkZD0gMFfacJXJy
         Hy5fPmHJm4LeYqmLIEuaxBArGxHCP9jdmpPcOvWIJEFWCKd2+M7hJPumzOuNsXWZemng
         ir8crmbT6mU9adNgTpR4OdOo5MPaz5itxLNASzICOu24dcQV/c2UoXKPBCKWQLGxjgBZ
         o35Pw87lBGLSYgiW7NYJqCHAAlEsmlpAUrvLTn6U/+GdTteL4HWVRPBc/mbvczODWOzK
         1IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434281; x=1725039081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnLnTh119A3RWkef9yN2B3w4lQzPk9GOiDwkQpiN8lU=;
        b=K7xehsQZENi/IVNcnkWf8D8Qffpx9wfaFuB5aeCvO//4h3oTgecjFtylCvpR6YNQJn
         u96J1w8gUbNfILkffSnf88vwVYesHk715xfihuXmF60g7QMxLRBADuFDuJK/1ZQYJVir
         F+V9vyMDZ2/YQhCSavGRgYxX68MWGwTNFM27m/15O4DMs+zs8uvj4W24HQgOZ3z8lW5c
         Aq1bbkg3oxGKZP5IwBQjDj4rzv07qbrrvWc3tFLNTxHhPJlKmcc2idwYKhEO3VdRStY1
         Vnl0ciIsDNAm58kBiBE1sZSA7qeYKC5+1TxQf/dsFD4whMnr7wPpvoYyKCeQTtYuW5Hn
         /ydQ==
X-Gm-Message-State: AOJu0YwwPwap1bKSqDH+CBZwVYRBEinGdwE91V3VWu7A6FsGpHFWf5CD
	dE64DXPQNEhbuPPp5ymSP2NmOuVQQzoh2jJz3cN/ftj3r0HkTysdd/s+dA==
X-Google-Smtp-Source: AGHT+IEqr5azCfSWay59GK95wh9fi8qlW2QldvhtsPDhmZcsqdWN4EsHYUHpzZJTJiv8xPz9Ly88xA==
X-Received: by 2002:a05:6870:1682:b0:25b:6d53:d294 with SMTP id 586e51a60fabf-273e64e6edbmr3470222fac.23.1724434281377;
        Fri, 23 Aug 2024 10:31:21 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-273ceb6bc1bsm972539fac.44.2024.08.23.10.31.20
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:31:21 -0700 (PDT)
Message-ID: <1ebd99e9-447a-4db1-9256-bd264d22391e@gmail.com>
Date: Fri, 23 Aug 2024 12:31:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: Print rmnet flags
To: iwd@lists.linux.dev
References: <20240823160901.474421-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240823160901.474421-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 11:08 AM, Denis Kenzior wrote:
> ---
>   monitor/nlmon.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 

Applied

