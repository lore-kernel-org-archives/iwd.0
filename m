Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094E1A6839
	for <iwd@lists.linux.dev>; Mon,  4 May 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777874263; cv=none; b=PAQWBiA1L9371CUXWaN38zX1dkG4iJlr+g1ODJbMOPIlI7g6sXxwkYLKCLwqMdf6xYhjQouuN0WtcMFySHd5o908ZRFE5VziAWIbF0hfh3iGTe5zecurF62xXko52FMLT7dheHSBN/YEZd/GIl5qB1zwhTILdUUt5uu7Wojb/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777874263; c=relaxed/simple;
	bh=HARrkfo1sxplwp5eJQlUaa+3YZ/JypcF2BY7zxd3Nk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaSRxaOM9WhBK16RN7E5Rn1HXhbSqvAdvvaxqiLitc+bDt+lGEuiOCW+PI23GJSS6bwtUGi3HSUydrC5leu0ZDwmDtxNDkB0NrSgquOhfBJ99kTdfuV+cq0wxcJ/H2OYytwN7jAFomGrgc2yqQnyG8oKMgMMOUKEVGhv5F/rW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd5yPoPX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd5yPoPX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ba840146so30610535e9.1
        for <iwd@lists.linux.dev>; Sun, 03 May 2026 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777874260; x=1778479060; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OMGqfti9ozqkswlDM2tiOauit1bHew2WxyC+HxqjqoA=;
        b=Xd5yPoPXkFhzmpIzJMdI+Kux/I9y8ny9qIIXhqC7L/1skaMvwaNE7NXlS0cxJEM2Gz
         sugw6pDw7AllRVJf1OSn0fp0lpnByWKLHGpql3FktHgx7dbyFt5KSfzTxEfYuek2KEwu
         mqXnU4DSjDVKVwp7dS2QuAuWQvCyw6NgHVPqhky8S7dacJHJT+8AeufnhWbe1O4C6DSF
         vugwuBxx3vub68eBzGARc5nxVlTnZkRlJxXgOA7VRqZoQkxOTsEr+Z7sQ6bpGhMUkrnR
         penGBGVppfzrO8ynBKmsbNMYW/kyBDZZkV4pg29Rj8QBaTm1thl1O8+ga6Ss/lhtSaVk
         GSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777874260; x=1778479060;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMGqfti9ozqkswlDM2tiOauit1bHew2WxyC+HxqjqoA=;
        b=mb3/2fLjj9SHLxdqDJULs9aaYCKseoTTXeE6ygTUZSonY5VbXkmWXr16lg5+QNVy8r
         6Eod3TAb7Q+XA3XBY1+M1lTSObJsUw26ERY/4UgOpvzZ9TQnzw5QC59fud4hIgVmtRX0
         Yu9Npgq/7+SkWk2EWjIP0a6IwR87r6oIh/tuPim41FfdF/p0QfDHHK9q9zKzyeipweJ4
         UjJuuFyBepgH7M9XlEP3X9u83n+a8rstAzlNB3npFx7q/+mI57ETIAvfqShQJZayVpzf
         yjpIrg7J0R+8ULMlDAtbyzNbWRDAt+ISEeL3bcX96zUQx4GTR1sW5sARMG1Pp7cGb56K
         i4RQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EvPR+pVEijhl4awyKmEd4I6C88ZU/ACPk/tHQwmUAR+AlD0nAdgueIJc/kx/xarI0W8w=@lists.linux.dev
X-Gm-Message-State: AOJu0YxAonIYK5I4pbbRQSylWV6MN36awsAb2FsLgj6GWPl74UYkTPgj
	fXwvaT3CGLJ90Ook8UrT3N8+6fyMBnKz0NjXnMNuiYSN8BJfJER+66LP
X-Gm-Gg: AeBDietjEY+I8puoMh4qRLLAiR2ls4HHJ8VjaAexB2qCPcBk8Qfu1fDAaBU8NchmfLM
	1uvYa89BqAtiNX+hH5/GMtskklYdhpV3TbXlH2vC8xynkzSJ+cdvf+Wbb8tewgqh904cJPv9mVU
	omeM1fboQUQUCWcmOjRWxORQLkQPhVS8zAPPI/OST0Xu0QQ12kuwzTjult8eaFa8bEe0dUkh+Wh
	uBYMPtsiGi8ESlz22VH9PJfRLzDxO5r1MEiDegKdv2vredN1PT6wxWnTj5UKE+5mZyNXRzvWHnC
	J3UqjsHc4Q3bdruam+1rr45zyaeoMIe3EmCZdx3eiTclZUtpOEgy8OSAs8aW2Wpd46YiQzqFsyz
	EyTWbDuDcvgvFPJKXr5EBeUl7fz0f8SVdDz1RVbu4Eg0y6UpuD1EbB7rPMtOeze7Cmixt5oAB8C
	x+luhNOrQ/JYz1soitYW0m2bf5EXXHEL5s9WDX5PstcSgiFVLowi6oBoBlhHc=
X-Received: by 2002:a05:600c:a111:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-48a9863cee3mr91471755e9.11.1777874260106;
        Sun, 03 May 2026 22:57:40 -0700 (PDT)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fe8sm249856385e9.8.2026.05.03.22.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 22:57:39 -0700 (PDT)
Message-ID: <021503ca-8a9b-4f9d-8b8e-81661572a018@gmail.com>
Date: Mon, 4 May 2026 07:57:38 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [oss-security] CVE-2026-31431: CopyFail: linux local privilege
 scalation
To: oss-security@lists.openwall.com,
 Demi Marie Obenour <demiobenour@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Jan Schaumann <jschauma@netmeister.org>, iwd@lists.linux.dev
References: <afJorKIje4O6dXbH@netmeister.org>
 <d6111caa-db61-498a-92cb-ea7a0aa0a5e2@ehuk.net> <87se8dgicq.fsf@gentoo.org>
 <afL-QhLfEKqHZqka@eldamar.lan> <20260430071917.GB54208@sol>
 <177abb5d-8ba9-4bb9-8b23-9fbc868ed3cd@gmail.com> <20260501180028.GA2260@sol>
 <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/1/26 9:24 PM, Demi Marie Obenour wrote:
> Cryptsetup needs CAP_SYS_ADMIN, but iwd definitely does not, and
> presumably BlueZ should not use have it either.

In cryptsetup, AF_ALG is used exactly in places where it does
NOT need CAP_SYS_ADMIN.

While I agree that AF_ALG is misdesigned (specifically, indirect
loading of kernel modules just on non-privileged user request),
it is used in real scenarios.

I can write a long story why it is used in cryptsetup, but long
story short:

- It is used for benchmarking, where we actually need kernel crypto.

As it will be used in real dm-crypt mapping later, benchmarking
userspace lib just does not make sense.
(Requiring CAP_SYS_ADMIN here is not such a big issue, and it is
a very rough test - but useful for relative comparison, not for the
real numbers.)

- It is used in TrueCrypt/VeraCrypt compatibility (at least).

This format needs to decrypt the header (first sector) with
the same algorithms as it is later mapped through dm-crypt.
Not everything is available in userspace (we support all historic
versions) and using AF_ALG was very convenient here.

By removing AF_ALG, you will completely break this format support.
including some distros (I think Tails uses that :).

We are using userspace libraries, but removing AF_ALG would be a pain.
It can be done, but it requires time.

> Cryptsetup is a special case because there are times when it may not
> be safe to allocate memory: if I/O to the swap partition is suspended,
> and the kernel tries to page data out to it, the system may deadlock.
> So calling into arbitrary third-party libraries might not be the best
> idea.  Thankfully, Nettle should meet all of cryptsetup's requirements.

The cause with the swap is not such a big deal in reality.

Nettle is NO WAY for cryptsetup (we have support for it as an alternative
backend, but it cannot be the default). You do not see the whole picture.

Thanks,
Milan

