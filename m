Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98764192D68
	for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220458; cv=none; b=CS8LljU5SIYRBBxDVrWd4Jhf9xvcnqMsG9n//E08DETTLfQ6KvB4qspDGRRQuAtMpt5hBapd9hI7so/YF0hhT3ljsit4UFu3mDDg9HXUr/MZ06mKFKDCzDhimbcEa2Xfb9D97Yy3+HdpvBVl3CQodpsW+2SRFJ9SrMdZrjj0uf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220458; c=relaxed/simple;
	bh=uID1TAXthSssWEE9b9bPGGJUYvPcaDwUZzEU/H9DTdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=msHGnphsq7gECYoGKP0kqAIsfkxrZkyRBdih2CtrQcmSuaRMf/EQxYYzLk4InQI9cRbwX0AKzk08nwMb0Erm5wjOVSyf0jcO06gid/5p/GJwVWEjrx3vMfXAikfYbFRFyHaDg1q9ImvOdQTd4gM25zi9E6jfHP/1FOuwj79r5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMA/tp++; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMA/tp++"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61dc69c033aso1407678eaf.0
        for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756220456; x=1756825256; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8f7y7b89suoxUpIM38c4oxaOkxHMpT9DkdZc7wss+0=;
        b=ZMA/tp++R2BkePkOlRkZobmbItsENrb+a17OkSCpjVr59GyHaOaJ6dsFUj/kiHaCDj
         AMNwSSVPHOTVpheGr0mubs33fzp2CB+rB2V+7llPrT+wMqTnV+ZBWMCU20vHF2ssoAW+
         xxYjA4f+X+8NgVLzUWt4/L9O9LM5D0Ff874l8evR+N6CzauUvookTmgo6sBR4SMx2Q4C
         T+E0eg4B8WvLItvDh6KvC4Lhh6wG3a5rWuYoKfvFN44SDfyr4lJxll2iE+s32h+RD+Wz
         aa38VcW6zd6TTJLySiP+bluEivBubi94Nd6BvCg0YtFr2ZIoM9MZ7cgFtPwZB59rQ3JB
         IZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220456; x=1756825256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8f7y7b89suoxUpIM38c4oxaOkxHMpT9DkdZc7wss+0=;
        b=KHJBZ2LZYLIafi4hP/v1nmYtZxAccL3+LrydBJ/J17HAFy6QKjVsvC5m2iVoAKYSas
         DPwAuFtgRwc7qjzoDPkgpAVcl1/s9yPmy/D1EmgYFUf0CuG42RIkaCvNPMzvoo6m9UW4
         KaWojcIEoqGsKWNmlN5YKqU94/lrizBhybF7nw0Q5dg/alvH8KgXzavdqxbPTaxQteni
         /PwC+vhleEzcPoYSd1YHj05yy7K2eU4XJHatY/3pZPTOBnQpOpH6G/B5Z8vpEUiM2aR+
         OmoQAaJ2rSNhIW+n8mV3UHYg3Pi7qZAlnXNAAyZ14gS/Ax6vJXudYsKGDGIltAHxJC8y
         58EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf/xlcqTtBM6WOzvox6K9NSM12i65uLikQZtYzmOtXqEtjSC6g1qU6axBZN+XwvjWqkdA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVD4cotkS5I+BdPMZhB+BUp1kebpBaQD2TViVDa7o3VdOTnTgI
	zkd3ovE0wbIddO3z50u/uQ3oklc4O3lNfxbKaEkuA5cn7xC0uydxrNoM
X-Gm-Gg: ASbGnctqfJfGbBg+Gxj0LJgk23C3/FuDF4dAADyVy4DEhZznvlt5GaYe5damLn7BwMe
	GOrsL7kPnd2TxbHBv/ODyUn7My4n5tG8Noh1xbWWO+apUEubsz1MMpTtTeW71sRWPfmC1d70QDr
	A/0nFMgb9qcdByoShnCnMQfZT1z68Cfomqjl2KMRMaoQoPN/lcB5tJvC76ybBOGyqYgexMs5yV0
	I8Lq2BB9puegYWeDX6ipCfzWOzBmEcOzN8QXVrnnLw54mitHOQuSAgAvDks9uo6pD4KZBMyN6T/
	1dJ2fzz28v5N5j/1FTJh6KyzzS+ftY3MScbcdd1qyZCTiEJ1YODJ8qVbxmFEMU8OdbtLMPu9tfe
	UMs+dCbb1JPz50y+NvnDiN4PFPpwjv5Nm2Y6sy27Sf/bH22OWbXTNMVopsYj9LoGDjkaoa62o2i
	7zx8iP8kFb3w==
X-Google-Smtp-Source: AGHT+IFqLopEc5W5TRYcSTHHMd3hc/ddvA6dkLd/1ONtsGGKbL/3I69CCnn/Sn66q6VJuoEjl649Pg==
X-Received: by 2002:a05:6871:2316:b0:30b:9e5a:13d4 with SMTP id 586e51a60fabf-314dcb55ddbmr6806198fac.13.1756220455137;
        Tue, 26 Aug 2025 08:00:55 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-314f7d98e29sm2485966fac.31.2025.08.26.08.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:00:54 -0700 (PDT)
Message-ID: <2b1c8292-b3d7-402b-b862-0b969587fac6@gmail.com>
Date: Tue, 26 Aug 2025 10:00:53 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] station: clear roam_freqs on delayed roam
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-14-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250822195118.271122-14-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 2:51 PM, James Prestwood wrote:
> If there were no BSS candidates found after trying to roam make
> sure the old roam_freqs list gets cleared so IWD doesn't end up
> scanning potentially old frequencies on the next retry.
> ---
>   src/station.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 

Applied, thanks.

Regards,
-Denis
