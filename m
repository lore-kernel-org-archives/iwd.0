Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD5145B2A
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936612; cv=none; b=I8mYAdUega1o4gkplanaHJNWzxVDW869Qj9Gte2zhwQkCYVaP9XzpYiNhiEr3w9nsIR144S8CI4vIgUnumzLWDHOmWqdCTl3jpxwtRJ4G9DUa6NQJElS7xxw5WAL4D2oN/rlxYWNaaokbjbc4gP2JFe/Z54bZhjP2qXQ+goct64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936612; c=relaxed/simple;
	bh=9bBDaIRb/aesbQnt5YpXc0fWCDFAycW4IfYv5Or+CeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IYGXjr0RjMu8gtJSx+ffLNhnsaLZ/Q0cNsjgSHPKrcgS0aATqOKunwu5u/tUkHpQFh/RuIhzSc57xyy3T/x5DFb+swIzOPKn2B0pwFPFvI3Js6yzESCj10pHzuUpSmZPvXuPUBM8Z/62BLx/J5Felq6hR06rK1L5QqHfcyfJ1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRQ57vFC; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRQ57vFC"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5994e320086so1846053eaf.3
        for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705936611; x=1706541411; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rv8r9fup9YqZDZPE8h1ygvGzYIQdoeHyW6FmTcK1vIk=;
        b=iRQ57vFCCLhJloHXer84nQBFq2qr61zv6sAOfUqWn2WNx3y3s8lxM64ZCCVs3I9Ft7
         5XjLzSMRMfLsu/SNCFuIBioG7d2Bb7D6sE4OIDo4N7S/GKXYWjQ7nH8+wKrZIIVAp+Sb
         bzj7TQ60UrTireTSwq8HLfZEtIOCN8GeS4lNjMWrzaKsCygTKWxd/yU4LxvO5avC347p
         VDcQBIRwEu+67g2v/RjqUI3rqr8BTCk1kv6Cv2z0sM5RUKe+A+UtBETq1h75vHENRgfW
         RnBjDuLkoVbGG6cpWKVGOlQteki5+TRvAzGRDO3+q27EKsHmMDpbJN5exIylIxyzVe/l
         AOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936611; x=1706541411;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rv8r9fup9YqZDZPE8h1ygvGzYIQdoeHyW6FmTcK1vIk=;
        b=XWGoiJDitRNaCBPAHyXTT8ETAsArjU7bvzSCCd5Sj/GxAyRPbQxXn44Cj4rJQzvOug
         KMgV+A1HWTDc6NougXIzcWhVUoqrZHVqHNEtlDZBVQS+doIXnxnCiSU2jtVYMcORKmG6
         rW4vATnWMCJryAImhjykVETII91lp/100YcYk540L2N+pMIhNhY0yjT72whmZBW8n1E+
         Is6Hy5rEWW0/I1CoSgvy7WOKLqCBKA2KFISl+MKXaC1oAQ9K1cWNL2lyoQofFGTLChlr
         wQdU9OFgjKFIZVDzfajZtqXpxZZok4fVpMAl4fpt9oU6Q6WnBufH0NrFroEamC4OCfKi
         qKEQ==
X-Gm-Message-State: AOJu0Yzz1YS3Pd7vFNmrwGpC5E9uRREDOfekq4D/mC4YjhCpaVOL61hc
	0FQU4dlmf2cJiW7oIyaLktNBMts1qjfKkbgIQJT0kHkjkrbz5PXY
X-Google-Smtp-Source: AGHT+IGXlNGzbyixVt+KtAFNWQJ68Abu8XrER7I6HeVVbXMO7Bd5R8vp0Y2xwiQhhNDY8wwIsQhA+Q==
X-Received: by 2002:a4a:eb81:0:b0:598:88ee:936d with SMTP id d1-20020a4aeb81000000b0059888ee936dmr2446741ooj.3.1705936610733;
        Mon, 22 Jan 2024 07:16:50 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u128-20020a4a5786000000b0059870bf6492sm4346429ooa.21.2024.01.22.07.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:16:50 -0800 (PST)
Message-ID: <20fb2c69-c58d-4598-b7ab-31fdb34df542@gmail.com>
Date: Mon, 22 Jan 2024 09:16:49 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test failure in unit/test-wsc
Content-Language: en-US
To: Andreas Radke <andyrtr@archlinux.org>, iwd@lists.linux.dev
References: <20240122105312.66fb4dbf@workstation64.local>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240122105312.66fb4dbf@workstation64.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andreas,

> 
> test-wsc: unit/test-wsc.c:1123: void wsc_test_parse_m2(const void *): Assertion `prime' failed.
> FAIL unit/test-wsc (exit status: 134)
> 
> Any idea how to solve this or is this one expected?

Works here:
[denkenz@archdev ~]$ uname -a
Linux archdev 6.6.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 14 Dec 2023 03:45:42 
+0000 x86_64 GNU/Linux

Looks like it is failing in l_key_new(), so the kernel is refusing to load 
crypto_dh5_prime.  Probably a kernel misconfiguration or regression.  What does 
strace say?

Regards,
-Denis
