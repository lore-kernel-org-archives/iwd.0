Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70EA3D7D8D
	for <iwd@lists.linux.dev>; Mon,  4 May 2026 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899525; cv=none; b=b9A0pMD5Ak1omUCNDrCLLGYXdlSuoab8g6UbaaA8fDa9YZS1HZ6IFmGw3ThjlaOp4S+4pQljc0UrDapFjzKMKVo6x5g2HBE/VmR3bcmZy+ZT9xqjYPRRfcZxeVsI8iSzy/+BonjMHeWUGygDW6e3dDiUN/nLzwq0AJJsIi0284s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899525; c=relaxed/simple;
	bh=NmoK00K18ee0KWR0BRNW6Sy1q35LGoXy6wYg8Lac6Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PddRpRWJGlXTYI+t0Q2eXXJhDql1aQn1636QojDNnSQuOT04QCbyS7EGqB4fkY8uaWO/AG7WMPTZrRpl/i8BPkSB2kdXWLFcnj6bLllvxH/QFCiY7MjFB4a1EQhAp6hwDhPT8NuFCtEl+X2JwcedZIR054NH73VYiK4pEmjSjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKyhnEh6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKyhnEh6"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8f231f3b130so277904585a.3
        for <iwd@lists.linux.dev>; Mon, 04 May 2026 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777899523; x=1778504323; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ypd1QBD8IL5nEI5wKW5JxIvcEM/x3rJY8yhwAEDZ758=;
        b=pKyhnEh6j6UDUX/l18jSMyzHoE799u3+YCMlAYC5TF6EUna5yORk4Cp8eztM0aC8V/
         IdeMYCslt6wHDGdrySUom+d/cAZxMlXmJgzCLfEavV3YlIVnhpAoicxookSGhRIrncIM
         v3hBFQmAgfhd8W1oKfleTzum4b/AmTDlOdUcPq+hfjswBLnZznn6aFhMRiQF2lQ4R74L
         OK1b3GMaMABKva3Nizv9jriaXDgCUlsHO5+wPRMaFmSa/6gxtufATnjhJEq9VlHUn6gk
         gO+Z1cfXrvwsBR4wNX02PnCV8On1qpK6Me8ONQs4yDhM6n3LfHYCMXMEiRKxZ3AD/HQ0
         GjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899523; x=1778504323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ypd1QBD8IL5nEI5wKW5JxIvcEM/x3rJY8yhwAEDZ758=;
        b=FvHrEg6Fkrh93AtTEhxqd7lvmOh+pQV/wwgdCO6lZUi9szxOHj7UceokR9ExJZxlaS
         jPZO2XMuMlUcDj/2ojawFGQY2aFx4/5GZXGvfHcpSVd7oRZQ6CDz7SAjSE1pbJIpCtmq
         iq+UXqU2QZ1xEdPFUvoir/fIxwIr148w9jcpJ84iM5e/Uu/iIb8ktIQ8VMA99BN8JNG9
         SWGa0lr2uAQZ3Ynom2NfNCNvk2I0FzHUDyvexulJadfoz2pl3Z7uJXT3j+DNpRRo62nb
         olaKfxqOnz+WpSVVsPGb4l0bEN5hdWQWxDFEyYjrdXLb+us8mF1Oh6opxTiz/4j5xDOY
         hpzA==
X-Forwarded-Encrypted: i=1; AFNElJ+tQP9P+D4kWdLlQGcgRXo+KOAxz8t2KrPTH0k9sZt1kgmqPrtmW5MrxS2h67zzygCT9S4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzjiX9J+5hrJ7iSzdsn95LfgqzirO/QCFDNrxHSURis/9tyiCHL
	c9snf3fCVjKvwoCaka5Ph2hp3yAIoGvcnmI2fY+jXTGehVScc4hUUBlW
X-Gm-Gg: AeBDievtm8QoxdCprBdAmeYCEhrfui3mOqCfUJB+rYMzkq+Fzd8bq6vd0c20LSiB78i
	zPKazS0m1KH1svDNP1pdJMskomkRDnvMLuJItb/uf/+oBWVphYbP8q50zTJGE9J+xD/1T/hBdxJ
	6TKId18fA7bPA9/GWpPLTOvD70kXNxBJL9+48uFeLtCxxbRvPv47FBpke428uS9+A8Q+TuaapUO
	BqeRf3J3xFPVCpyP+k1G1UqAGQpxwMZL0XXXP2eQyIyKYtb/pAoJRbG8piErc2wSZaEL1UT4oXW
	YDjCbh3SovQ4mrawK2SC2Zpl7A7Z2mSyYbVooBXab3tRScPmWToqQwO5mu8EZx+8Xul7GvyA7Ci
	jUl6T3eaStzg2dQSGQ5QghuJgKejik/vH72dLlgetofBj0VhzMBX9G0we4svh83wxyCQ6lnCDVf
	uquEvKQWW2qz1wMKTOVqMSxEaw9ZbapZfIU7EOgThpY4oL6s75mOrcnfy/DjeBW9GXxlpDeUObc
	A31pZc=
X-Received: by 2002:a05:620a:4010:b0:8ed:c0bf:2c24 with SMTP id af79cd13be357-8fd19122e53mr1413514585a.62.1777899522542;
        Mon, 04 May 2026 05:58:42 -0700 (PDT)
Received: from [10.100.121.202] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd7dsm1031615585a.37.2026.05.04.05.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:58:42 -0700 (PDT)
Message-ID: <bcbbef00-5881-421b-8892-7be6c04b832d@gmail.com>
Date: Mon, 4 May 2026 05:58:39 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Complete list of AF_ALG algorithms used by iwd
To: Eric Biggers <ebiggers@kernel.org>, iwd@lists.linux.dev,
 Marcel Holtmann <marcel@holtmann.org>
Cc: linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Demi Marie Obenour <demiobenour@gmail.com>
References: <20260504045007.GA2289@sol>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260504045007.GA2289@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

On 5/3/26 9:50 PM, Eric Biggers wrote:
> With AF_ALG being on its way out due to its frequent vulnerabilities,
> iwd will need to be fixed to follow the standard practice of using
> userspace crypto code (for example, libcrypto) instead.  In the mean
> time, AF_ALG is at least going to need to be hardened by removing
> unnecessary functionality, for example unnecessary algorithms.
>
> Based on the iwd and libell source code, it appears iwd is relying on
> the following algorithm names from AF_ALG.  Please confirm that this
> list is correct and that these are the ones we need to keep for iwd:
>
>      cmac(aes)
>      hmac(md5)
>      hmac(sha1)
>      hmac(sha224)
>      hmac(sha256)
>      hmac(sha384)
>      hmac(sha512)
>      md4
>      md5
>      sha1
>      sha224
>      sha256
>      sha384
>      sha512
>      ecb(aes)
>      cbc(aes)
>      ctr(aes)
>      ecb(des)
>      cbc(des)
>      cbc(des3_ede)

This looks correct from IWD's standpoint, but ELL does support 
additional checksums:

- sha3-224
- sha3-256
- sha3-384
- sha3-512
- hmac(sha3-224)
- hmac(sha3-256)
- hmac(sha3-384)
- hmac(sha3-512)

Marcel may be able to comment on what projects are using these, if any.

>
> Also, does iwd always hold CAP_NET_ADMIN?  We're also considering adding
> a privilege check to AF_ALG.  (It's TBD whether it would be
> unconditional or controlled by a sysctl.)

Yes we require CAP_NET_ADMIN:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/iwd.service.in#n15


Thanks,

James

>
> - Eric
