Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C438DD1
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778580; cv=none; b=kOR28Cofmbbgh0RMpgmErFSJEQFLWNuocON/loipclxlYneCnox3924wXRV/UCYNveHYfm5JqOlUrGwyVTz/ChXWOwU/J+PUcot0uCbzM7IMpVyqR4yLlhX0+jWAS6ay9GHYs8BMy70DCC5W/erVXXE+XrqSkHX/zmDEfU3AhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778580; c=relaxed/simple;
	bh=kMeW2v9kDlVjh1smBjTGR0nliA10Mr6JLi7kzakMQto=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TxxR89OFlP9ukV25qdaDlGmpTMXujCurKH9qvEdfeUjrp/zw+WJbqTqgxC4GVzsRfgJC+798aiKkN2+wvs4QoX+rMF4wNpQnDBLBzWzSnsHiC7KbgirUaYLGxnfuFXNl5BKn/g+xTf2DlIQdKkVnKWy0qBXRVXhKv3nA6OxXRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E46rPC8c; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E46rPC8c"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e5ffbc6acbso578080b6e.3
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729778578; x=1730383378; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=euc3yPybViaBUQclyf/NIg1CM91wfXmx373eK+bUN0E=;
        b=E46rPC8cFZ2uWU9u3Qjfod2Gn9T0mkR9OwhT7bVamhsYGKJvOE7LT8co6wlaYNKXF2
         Z0L7Vhec3H5yh2fHWLetqMbcYrWmOe7Ptike3mmpVaOBHDZIO+7YrDKfTbrGeh39TCVm
         stIvoXPHtWSdWPx0sK6ggbG7NtSO9neEoG+kxRyvzCqvhYx54krcMERKn5plAnftyEs7
         bESEYJWjnvATkpCyz2cMv6g90OBRmpGzXqFCafgmG3XkgIUDuJLhv7/3Km7t32zCSbGl
         b6GXzbGiIukvWZe0Qoj1O6JGbReVafotHe4y+loZfaLCXNVlELveVxS8R5Rd9Q5Liu7c
         3tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778578; x=1730383378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euc3yPybViaBUQclyf/NIg1CM91wfXmx373eK+bUN0E=;
        b=cbErFGZDTVW0LByVZgiRX6M5EF8tAkZKSZtDRho+E3kC5gETKDhVRBLF0bHTfGtEuL
         JB3AtJwzd8m3E3d6uY37OvuyMpzb/1J4BmzesVwRe1mSRr8FdIYCYuNniuxMcyaPywxU
         JRHWSYIYcGieuadRlAhUTWZjF+ehqz2aU+dXg3d6T2qL0mVm5jgA1A/hglowy6FWGsBT
         dqCx6Twut/IFsj+ng3ijLuaSXS8R+x1cmEP+gVwUMNI23n1uJSzG7xKHO1kZuJrfXjMN
         4lsaorWY/FG9ybEPVDE0TzGV1SeFpceAAamyt5+RiO7FjE2NmAoVq86UvobKtDzpi/YO
         mJwg==
X-Forwarded-Encrypted: i=1; AJvYcCVooDuLgwOzZdgE0vTX323XzIpGIoemmKMjUFGBuwAMROhSQUvv2H3/13hrzcBoYyRvWVI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8y3yJ7jS9LxYt1+PuUryS54k6nCTeT7Vtnr2VbMIwucKcex6y
	Bnhm7pkOOq6MouaOkg8cGVKWCf3j2hjHvbCSCPq0TQ0yHmfycQf9
X-Google-Smtp-Source: AGHT+IHJWvg1P2SSi8QFr7z404D3jl/K4Smwx4b2lX29LFYe3Iz7yctLUylnOuVEk3nI8194YP/RCA==
X-Received: by 2002:a05:6808:1143:b0:3e5:edfe:c677 with SMTP id 5614622812f47-3e624500a14mr6410897b6e.10.1729778577750;
        Thu, 24 Oct 2024 07:02:57 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e6102e3b81sm2236413b6e.23.2024.10.24.07.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:02:56 -0700 (PDT)
Message-ID: <f10961fd-0839-4f65-a772-c7c850f00844@gmail.com>
Date: Thu, 24 Oct 2024 09:02:55 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] network: don't allow connection to OWE AKM if
 disabled
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241023182912.128388-1-prestwoj@gmail.com>
 <20241023182912.128388-2-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241023182912.128388-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/23/24 1:29 PM, James Prestwood wrote:
> ---
>   src/network.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/src/network.c b/src/network.c
> index 20d9a3dd..5a856fb4 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -911,6 +911,9 @@ int network_can_connect_bss(struct network *network, const struct scan_bss *bss)
>   		return ret;
>   	}
>   
> +	if (IE_AKM_IS_OWE(rsn.akm_suites) && wiphy_owe_disabled(wiphy))
> +		return -EPERM;
> +

Hmm, why do we need this if we already check wiphy_owe_disabled in 
wiphy_select_akm in patch 1?

...

Ah, I guess this function doesn't perform the special case check like 
station_build_handshake_rsn() does.  That's probably why we have the problem 
with reconnects

>   	if (!config || !config->have_transition_disable) {
>   		if (band == BAND_FREQ_6_GHZ)
>   			goto mfp_no_tkip;

Regards,
-Denis
