Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190806A32B
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618119; cv=none; b=sx0t4XYoh8LMsBElZLNLnnOxANzooZUNEOW+IG9ApQCTLS/P2kUIDoA6qQMbrCNOg+UljhRxN/ySo+oG1/tsYZ9Q99rqKeDe+UUBqqe0EsIWqYgkYrmvTPdk31mt0P/Yn3fdg1WX/qkv5Mviif3PO4eVJhbk3JH/Rt9r6aqjR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618119; c=relaxed/simple;
	bh=vuW1A8GdUZ6If0FmuMhq0rDAoJBTJ5RT48+th1u/xUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d2GDn5k7Wi60WyN5YnYd9jL2MDSWa2oTNrhx4PuyoqRfhhiBL4xuQq2/2gnKMWy5SAbwu8XKJQIm9GawhzGELe47ZwrW3/hP26ZeLrRx1PQoEHvYEYXHzT7kcdemp3Bj9f5D7WtBovx6B56GNTb6iPX9R5nSRlenf/J1NCpl+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPMsM2RW; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPMsM2RW"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be6360a7b2so818728b6e.0
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706618117; x=1707222917; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3k1Vf7T+VfENOTKC9B57LviFwCR9sMU/dEQgDIvzlM=;
        b=lPMsM2RWCAuR7nA0Ml+ayQ3KlHjCiSF/lDE+Wpmsq6avo1JXNCeY3GqqkDmZ93pOKM
         +Pk1tmT8ujKhcctTIxhHX1LPwfGqk7Fzl5PBa4i4auaKNl1N/unJsddNqm5NdVbhoNG4
         OIgelQ2TKj/n2HFjkJowhQgoONYonq+7r/IBT8EI3ugqTC3BhtNW5EAQCZIVdbiH+6IV
         lrI0yGdfcSyBg5ZEhwOmTbEkFf7ZjJMpInyyQRDqK9Gk/Ct68wqy01JZDzYtg7IkLyp3
         yXXVQ90IZuVpfCbWaUG9a6WSOPn3oY/Z/nVJV/PgCWtRMdJhoht6myyo9SB7qr7iAaPG
         9rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618117; x=1707222917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3k1Vf7T+VfENOTKC9B57LviFwCR9sMU/dEQgDIvzlM=;
        b=BdJAemqAHvRnqXIoFIT0JPyMmkpzZkQG7cqhfJVXvNSGJOGPMtcvksXkRijtANvrfG
         0KXAUrM/Sr1m4XczV3IrdU847gm4dZZuOyruohzBewwrVcX5fWV3FGZihS+St4J5lxUY
         jy9Hvlkjr+mgehsNNaxNKAqisJVeVzRx/BWBVoOuAB/G9JgjAMCzB48om6pLX+RAHjZv
         rOzoV6X4fjQFAZOtZ0ua0SfH0NJSxCDzBykyr4VQXHxhomOi6Z3jvbHg5RIKVJc5NFpC
         IZdfoG5OnCv77kDPVCxGQ/QYBLbv+g97bbh3hlrW/sftJIoMjrJO+axIXLdlnkDU5flW
         q7Wg==
X-Gm-Message-State: AOJu0YwmRkBEVLAKNoncYTRlY2C2LKSxJ+R5kHpjPFNsy6n9XDL4V0WF
	0xc60ceuhSSiOTtfZfOpkTkbK8gNTTj+vA2zGLNqUjD3kp7Vr8OH
X-Google-Smtp-Source: AGHT+IFRoPrRciCIs9YI8waXY99Lul9PZLaM2ujX7jgkPz6HYYK8f3gbw7tXEtHt4CcLemiIWiIfRw==
X-Received: by 2002:a05:6808:3993:b0:3be:3647:3f8b with SMTP id gq19-20020a056808399300b003be36473f8bmr7756942oib.20.1706618117028;
        Tue, 30 Jan 2024 04:35:17 -0800 (PST)
Received: from [192.168.254.83] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id i8-20020a056a00004800b006ddc40fd1easm7966911pfk.173.2024.01.30.04.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:35:16 -0800 (PST)
Message-ID: <d6b782f1-2e72-470e-9423-a4be993cdf43@gmail.com>
Date: Tue, 30 Jan 2024 04:35:16 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TLS session key?
Content-Language: en-US
To: Rhys Perry <rhysperry111@gmail.com>, iwd@lists.linux.dev
References: <CAGTBY+uz6kxvM7OEVQUVCyHNnz6APuPgvmQkHBemN1wFkQpiGg@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAGTBY+uz6kxvM7OEVQUVCyHNnz6APuPgvmQkHBemN1wFkQpiGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rhys,

On 1/30/24 2:48 AM, Rhys Perry wrote:
> Hi,
>
> Just wondering whether it's possible to get IWD to dump the TLS
> session key it uses for EAP on an enterprise network? I'm trying to
> debug some odd behavior that some network users are experiencing and
> think that there might be some clues in the encrypted messages.

No, IWD doesn't dump any keys in the debug log, so it would probably 
require a source code change for debugging. You can use l_util_hexdump() 
to make this easier.

Thanks,

James

>
> Kind regards,
> Rhys
>
