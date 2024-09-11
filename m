Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC11CF92
	for <iwd@lists.linux.dev>; Wed, 11 Sep 2024 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015366; cv=none; b=nrJ2x20Fqdj2DUnlrgdTW5yT1TIFlGcWqct3ziz60aPjwisKjYVoNSrrSxGIe14vFwQSygOe8Cf9WWF4v0l7jtvRej3LCj1FjvjT4S7WnYZ3PXT5B0c6Z/8AQ4mv39jeKBOqIpAi3sAMp9stUEXDCiW6TXsIwrmXAQDSnJL1qg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015366; c=relaxed/simple;
	bh=cOYttNyzk2yP5Jx8wpBiSU2U4QU0ml5fhmIPcYgVdPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XxOTLTbYqYPk8WxYJTPIG8Lolr89Zn+l03z78u4JXVVP0tfA6SO2SQq8nEhFOEmRQd+l6MCz2EtcDjAo76PIF32jWfb4A+GhXswEVWrxIE1OIyokiNbVsw8lJDBVq/Z1A28/VWTQF2J4GdcveP7fPBZ9a+r25ZX2A5/RahocS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfy27ebe; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfy27ebe"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5daa93677e1so3664031eaf.3
        for <iwd@lists.linux.dev>; Tue, 10 Sep 2024 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726015364; x=1726620164; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ToZRvH9MeiGhnYUk+0GT9GEThpLcA1BteIGHUYdcoIg=;
        b=hfy27ebefW3Ba9aD/LvVxqfqe2xwQWUo0QMKEU6txBspAIo/Wdk9Zlul2QGmyNvSDB
         aXXvIurTfz2Qmsz1IRzeSMvRtMpAX30woiELjWp8T9WHB9stJLgATulMbJrwXsnoGXgY
         ZW8W0GBzhJXj0XCjM0sL5o2vylwMShf9ii2UZjp7A01qJ7nUBy3bkNQRn5fmdQ1fpqXk
         S1V8k0f1xmt/eN4ff9CbmNpfiAIsVj8FbIVCSarxV8DdU+RezDjie/010b/sFf8mK7jj
         nZ/5vCpppW07z08Oww2vXqv/i55nf0KH3ROxAgkDa6wyP8fCXQoOkOyCoMeOInqoILy1
         RnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726015364; x=1726620164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToZRvH9MeiGhnYUk+0GT9GEThpLcA1BteIGHUYdcoIg=;
        b=AZp+T8bgRX/ns5+BteIftV8Xy67CbUH0wai9SOdZCpJjr6oWZDPtF1Q6DCA4eOAG7c
         soMLY6X9zggAIu4xX0hFHK4DX4uam2o4UdI0k1199yc2MVi3mr9y07a36PCkEq2mGc2C
         2yWW0O9oaPNgpoIAn7SEVzpBcnEnfbnGZ/7VO7sdeKDvn7aNn5H1IitVtE0UTO72Ji8H
         N8xu0//50kraVce25sX8exqZWZbx7/KIFAKi/rIeYsdrbB/HtJF3z4soXL460/Hryuir
         rj+TfddznAlelFP7H9HMsGB2I364n2nt418haupi0TW9eBYsYrpieisX3BGGvb0oOcXA
         h0HA==
X-Forwarded-Encrypted: i=1; AJvYcCVvbU4msM5urU37DmvdtIV05rnc9+kwQHC9jcUKP4mnIbxRFjEggd+pjOB51JsHAQqtZMI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzqVOO2nSBo9/ixDvcuogk3DE1uqJa8H54crAewXxKk1Bkmv+w1
	wjJrv2lCKwpv6jtDFasWF27Q1In7g14ta9ixcw8/n4N8rI/kgPM1
X-Google-Smtp-Source: AGHT+IEfMVDyLWmvg/bN6YqsT0SndX6yJReLdAki14lOreNLyj4jbdkx+250vmipvIgKFG/soaDnLg==
X-Received: by 2002:a05:6820:38f:b0:5e1:bc6e:52e8 with SMTP id 006d021491bc7-5e1bc6e5543mr4728996eaf.1.1726015364446;
        Tue, 10 Sep 2024 17:42:44 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5e1bf12561dsm1906208eaf.16.2024.09.10.17.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 17:42:43 -0700 (PDT)
Message-ID: <bb75914f-b8d0-453b-8c88-8143b61f7678@gmail.com>
Date: Tue, 10 Sep 2024 19:42:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: emit property changed for connected AP on
 roaming
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240910190334.128166-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240910190334.128166-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/24 2:03 PM, James Prestwood wrote:
> This was only done for connecting states, but needs to also be done
> for roaming.
> ---
>   src/station.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

