Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF2160644
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239007; cv=none; b=Ldsg+RdL1LFtYCfa98ePUkM8EJE9SA9dxBBa8d9b2BCLp5sjjyffE6+LuC265sAomGEKmjo8p6//glPJs6JlB3Kl3JVcFqJQLViiQKUHi7+szmkE6IxIaplzy+PNvdcS27EuzSxAKnWPG0faxabJgH3OXwKrlp4ybit4vlm4Rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239007; c=relaxed/simple;
	bh=Ffq/hrKMA2NkaUfg7U9RHLR37ZUZ8tytKae+aEJdYXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gR3t2K3P6UXo5F4JfXxW4u6um2xOFUeEBo/iFzDfla/5V0/7KEkzI/UqNsVgoAzBrMWekrwQmeNVNEP0BGjrlV5lQA7lYn6eqwO3T9EAVHGklkXWXN3B+bjzTqegAFYkRDugn/ASGILyzmlCTc8FRY6rtqjtm/zd7zoFIjU6GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE2tBUCg; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE2tBUCg"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a0d96012d0so705983eaf.3
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709239004; x=1709843804; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6vpM1lHnmZ9BwHzAi27ZmgPL8IZY17coPQRhKnw+k0=;
        b=SE2tBUCgRctVf3UzW7NLggEF+h/SBFfilIpNmlrzIV8joY5Wlb4JL73c1kDVv14HG1
         9vbHMKdj6HV3cF2lh7PhB/UWIWyOsFJJSsc+mP9HfIrgZZknARvIt8R5k2y9P8adKC8h
         1DDB13OC9DvrTJxvP954HTpKbAtr8BwJw17iYX/Na/06pAhZz9QrA33ZSniGF2fv0u9Q
         yF+CuqocNE/tPge2vdVY/+83qaBzU3uG4pgw8OGMyMQMs/aqhvcjgqtrZHTFJzb20xjc
         VnCKYH7iNRzXUFpHy0g/182Lu8pfEcytITuupnee2IiBAFN/nxRC0pOfpPN/6X8IqFlj
         VNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709239004; x=1709843804;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6vpM1lHnmZ9BwHzAi27ZmgPL8IZY17coPQRhKnw+k0=;
        b=wKe1s9ubWpkXUyEmmqEkKqghT+UbaRErA6CH3Ksp9s1cQZ4Hz5CKvIkSiHtLN8gSK5
         aEqG8pos9roGE4iIN2H0PhCI02euWyY/bX2uUcNJUJ4CIEkin33iDth6GhWdH7uteZtG
         UwlSas8yd6FIzVbwSkUgJ1AX5hC7kshOeGMByhg2bqDnl36H1Wht3yB+wTwh5VAqCFet
         tCTGf9taRrMwRLqV6iU/5SnEVnTJRzjeYpyA/Et55Z/m30JeKjefTLu+2md1ZtDvjkfp
         0/bhsuYk8GWRGG854UF7C5Sd9XG5lhuZqXT8G2KStRNgXLR/dDxaLZ9AAqqPzPj9o0dM
         WSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUcNFV9QzTQOB7G29vvFTeMma5eNNNSE2zZYXVm9z//VqP+Urdu6hYJh/jPk7ihs2724yfDD/I8MCNmjcWE1vQDKuxe
X-Gm-Message-State: AOJu0Ywrw8945oMFj0UFLhp73LBOdRXA7GHjdQSDn1OwM5csZc8Dp/yZ
	dfKSOodQ+pQkEGIu+2coTLRmvPsLvXPwYWrtPZ7OJqa37YfM6Jbc
X-Google-Smtp-Source: AGHT+IHaW+f9oF2+hK62DfhfCaF5Vz4NmVmLhWh9SED338Tn99ByJyXsGe6chzlG5slhgyFJNi78yg==
X-Received: by 2002:a4a:ea1c:0:b0:5a0:f725:654d with SMTP id x28-20020a4aea1c000000b005a0f725654dmr1099381ood.2.1709239004552;
        Thu, 29 Feb 2024 12:36:44 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v18-20020a4a2552000000b005a0c9264b9asm428186ooe.39.2024.02.29.12.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:36:44 -0800 (PST)
Message-ID: <3d6b96bb-d111-415c-8203-0dfba01d6a60@gmail.com>
Date: Thu, 29 Feb 2024 14:36:43 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] auto-t: end process_io on HUP signal, detect process
 crash
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240229170734.1498918-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240229170734.1498918-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/29/24 11:07, James Prestwood wrote:
> When HUP is received the IO read callback was never completing which
> caused it to block indefinitely until waited for. This didn't matter
> for most transient processes but for IWD, hostapd, wpa_supplicant
> it would cause test-runner to hang if the process crashed.
> 
> Detecting a crash is somewhat hacky because we have no process
> management like systemd and the return code isn't reliable as some
> processes return non-zero under normal circumstances. So to detect
> a crash the process output is being checked for the string:
> "++++++++ backtrace ++++++++". This isn't 100% reliable obviously
> since its dependent on how the binary is compiled, but even if the
> crash itself isn't detected any test should still fail if written
> correctly.
> 
> Doing this allows auto-tests to handle IWD crashes gracefully by
> failing the test, printing the exception (event without debugging)
> and continue with other tests.
> ---
>   tools/utils.py | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

