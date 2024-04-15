Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073545B693
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180275; cv=none; b=ZBCY2oO9KxFNGoaBa/pPCb7wd4j8b3UrWbOYQh4DsniSn8AdkeDVmhhqP033WvXu8qKL4BXUHM88crc0hZfARXEkwpO6jKVl+LzTahwsM58sFsXznMCwM8mjIBk6B2Z2P7Gkq4R+34ZH0c3oAl1Z9ntr34nF5h8hcmb+Od0+9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180275; c=relaxed/simple;
	bh=I2zZz7MfES2j8A6Ea/7K7kYIV/68MEpSIYA44XuPqr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b8oOyK3olnyKN29+xFcfJgA4Ic6kuPXaFM4pmrKEraBKKn2srqFnVshAS16nMwfLbfEVfF6cXnTtt02DVXDLRuy7khA2J1YV7TIFzC2NU+i9mpSc1YlHm2ZNDSb9FG4RFRAuEq51rz8gX/mhsGDRYfJTCAqnY1lBFTO+yrWPxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB7/uX5z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB7/uX5z"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so2768927b3a.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713180273; x=1713785073; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXHKsg10utUSsrhydWZR4RG9Uy1fWQk1RcLktTfMk7k=;
        b=iB7/uX5zMyinsiqCOtVrntWrIU73m7hlPCvp/N4/R9LWWLVfnz5BUthvx0kkC80tSC
         zp2y6tFbk/P3WglIOe1US4aPfMhOIEgQ+msWFrz4RQAbcUcmkzmN6YE2hrU73ef1CI0j
         YaLuas8uNa0UtWX3iux2+aYliOSBHgHGx3K9V6Li49Xg6Jyq1RyJr1HpFzzdX/a79b84
         DSUYYRngZerZNDSfidac1YrA15OaUGSkTcAoIXjdLMeBQ65N68uXmlZfUnUON/uPmO4n
         UwrdueKrcLMOJx2el7uzCZKK5QjAvVXBN9PJ/rr2qGVcgmzVluO3VMJ4mz2f1FoWEzm8
         89bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713180273; x=1713785073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXHKsg10utUSsrhydWZR4RG9Uy1fWQk1RcLktTfMk7k=;
        b=Xv7g8Fzb1MjrpqIK8Kiqrw89rG3CHAE77I7P2KMc2tCx2Ca4Cx9wX08y0z59OjDYzq
         kfc3iDpEbQ76XMf/9Nqu2HcOb+HW2SvxwTL20D6ZHPAWuy1Qx+vBy6MelxUajiFAM2Nc
         Q0zVyR8kvZ8VzbGOJexBP/Uoom0OFT558QHytqPVmburVaifMcEDg4lA41L0J2pZlJ2/
         D/m3kGc5G7lkbSU5T+DMZchJ9Nu+xPTgii6eOP3pjbtPioWcUufMyHYCdR5j9kAKfziK
         2V8IXldy9cZJyuhzyaVfursjwYjxmBKyoWnpQI57pyidrhTun7PhgRJev81nHg2+pWLs
         eYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2RigPxtPcincZ3P5tBa8wQmqHdvQP7jHtm21o2bcwNHJaYkPmBSO/KVbRBiFEcv4sPqc3T/+dhl7Nyc6FpNLORKzE
X-Gm-Message-State: AOJu0YyLeLEhEWRn27Gh0iIJuMG+y9eC8WbXdEWqvw9hwZ/ldpoUWgaS
	EfAFM7FnRZmo47A4olhR1YO9n0ig4Szkx+2RmY3XXAf3IpU6Bg1o
X-Google-Smtp-Source: AGHT+IFduQg7jSu8tsfOJyvxYvYtX5vjbW+ANO4YMXSU1CcUSR7cfhFxYgz1+pDtjSUz9JQbj5E+lg==
X-Received: by 2002:a05:6a20:a11d:b0:1a7:aa2c:6126 with SMTP id q29-20020a056a20a11d00b001a7aa2c6126mr9619889pzk.46.1713180273065;
        Mon, 15 Apr 2024 04:24:33 -0700 (PDT)
Received: from [192.168.254.88] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id z3-20020aa78883000000b006e5571be110sm6974110pfe.214.2024.04.15.04.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 04:24:32 -0700 (PDT)
Message-ID: <7978cd1a-8122-4b6b-9e38-b7d65a9c393e@gmail.com>
Date: Mon, 15 Apr 2024 04:24:26 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NT/VHT errors filling log
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 4/12/24 10:41 AM, KeithG wrote:
> Group,
>
> This is on a Pi5. this is with the 'current from git' build of iwd.
> iwd-git/now 2.17.r0.g468cecdb-1
> These are new errors which are showing up in the log and recur a lot:
> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
> Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capabilities
> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates

I added these recently as well as a small modification to improve 
fallback behavior for calculating the data rate. This isn't coming from 
the driver, but the scan results. Apparently APs sending invalid IEs is 
more widespread than I thought. I'll need to change this to instead 
maybe a single warning, or maybe hidden behind an env var.

Thanks,

James

> Keith
>
