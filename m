Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4316F824
	for <iwd@lists.linux.dev>; Mon, 26 Aug 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673818; cv=none; b=M/mPtkM5gsFKKLiI/V3SzXt+czlEEl6gqu+p1hLM6me0bBNoj7zO9nNGkxESllcHDcOU0GY21bnjhBCk1B2584vEIV8t4WdBj3CXJlUGzpVqaXAIT+Ilej6JBfZnyK2pSIQN4MPykYF6FOQvFbgVHUZGYMGgMzWK9DAzLzEZop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673818; c=relaxed/simple;
	bh=IXv4ut+++6U8jozpa3MSUzzvxL38lKxPUIoAK/jVI+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IDjzUBIv6YVcEaNJRjIe2Hjo6otCGu1ABwDxUrNIY6tsWw2+1NMHTulUkWQ3cDhZ/dstoE4eOVBpJ0sQpn2St1sknEuw1zZg4LMsnM6YM3cm8jhU/xTvb/i/5issWFzLf0ilvbxiacpQ39h+LdftA6erYcHH8Npixxt9JS/nzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THrGsWwz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THrGsWwz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3c098792bso3347487a91.1
        for <iwd@lists.linux.dev>; Mon, 26 Aug 2024 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724673817; x=1725278617; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28t78CUY0f/cOs2VUmYqLqvyFQpQ6FLwIo1wX+wAhxE=;
        b=THrGsWwzgjhdS4BccIOPjaq9tSg61wf+VX+YZYXG46wafXxKozmuFYWW7EOAXpxpBh
         Ftx1cewevqBf7hxifY89yR221t7Esfugl+wAfHKjLiMgk95Gjep7l5TlbwIsP8O1p1Cc
         5+k0yhA91iub/NCcZ6+6PEof5lyKqLi3BftVRqk1MAbyBmCd4DgKvYDSbIgJ2CrqhwHk
         BMCuJwNJHrXMCYPrCGxs3HjU1n19UfpnHMp1NJ0A/lp8cPUdWYN7SXkKdWzLzrKjUDxa
         uCoUnQLZ4SgNWO6vDRm5prTFoKSGze+P2jY4aaKbYHUIgKArOZTqkH6e31djK8stXmIT
         k1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673817; x=1725278617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28t78CUY0f/cOs2VUmYqLqvyFQpQ6FLwIo1wX+wAhxE=;
        b=o6/cldY/DKffBGTWVuWuWQx+rP27+uJgf3k7SzuTQYMaIMpMUrFjx88j2LCfq8gwfz
         nRAM7vTk+QoKZDRvBlinRM0FE76p7jchF6Ie2kAMuxeXsAlnla3QO/CvDYex6BG3HEjP
         rEJ8QNvf67RjDD1vvxvn5hNH/uzQzmnyDJlB4USCREg1Zj2EN+osyXF77VQmDW6oImFs
         ODJRaFg2Bs5qlGYuriOwQAYp3NUIqbRYJPtGBPSp9BOT44uCXwKspoHgxbJObqiiD3XQ
         UTPvXipud8t0faPiIByqJLO0WJoTPM+xpfheVjAhqX59l24LYq52l/Np5TPRJiQ5/yH1
         XIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIpuBGrl+046KXDxxdYNEHRzxrkgf0TXOfYNIsVwjZfjYCJ2nIuVI5+43S871LpeC414o=@lists.linux.dev
X-Gm-Message-State: AOJu0YyXq+Vz5WhVhdisAPZIGD9+hyIDosCbqeGxvQLIUswfJz2Iw0Jz
	uiWdPymoJ3nDb7ZjmseUVpzjVVvsYw3swPITAnMWSrVa0kzU2nlYKgSYDA==
X-Google-Smtp-Source: AGHT+IEF1blmyZgNulfeXInWuSlmx1lke3EZCgjyvtevej7stANfAUah+h36AXKZ9IpVIXt9CBbbtQ==
X-Received: by 2002:a17:90b:3ec6:b0:2c8:6bfa:bbf1 with SMTP id 98e67ed59e1d1-2d646c44f02mr10542037a91.23.1724673816509;
        Mon, 26 Aug 2024 05:03:36 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61968ecc7sm9313446a91.54.2024.08.26.05.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 05:03:36 -0700 (PDT)
Message-ID: <93c46e3b-7063-4469-88aa-67578d3c4989@gmail.com>
Date: Mon, 26 Aug 2024 05:03:35 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/2] netdev: external auth support
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240823174220.498594-1-denkenz@gmail.com>
 <20240823174220.498594-2-denkenz@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240823174220.498594-2-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

<snip>
> +
> +	if (action == NL80211_EXTERNAL_AUTH_ABORT) {
> +		iwd_notice(IWD_NOTICE_CONNECT_INFO, "External Auth Aborted");

I know this is just an RFC, and maybe you just used iwd_notice() as a 
debugging mechanism but the intent was to only use the notice prints 
with comma separated key/value pairs to easily be parsed by tooling. For 
these connect failures we already have IWD_NOTICE_CONNECT_FAILED:

iwd_notice(IWD_NOTICE_CONNECT_FAILED, "reason: ext-auth-aborted");

> +		goto error;
> +	}
> +
> +	iwd_notice(IWD_NOTICE_CONNECT_INFO,
> +			"External Auth to SSID: %s, bssid: "MAC,
> +			util_ssid_to_utf8(ssid.iov_len, ssid.iov_base),
> +			MAC_STR(bssid));
This one does fit into the connect info category, but we already print 
this info in __station_connect_network(), granted no info about external 
auth but I don't think that is really important for the context of 
iwd_notice().
> +
> +	if (hs->ssid_len != ssid.iov_len ||
> +			memcmp(hs->ssid, ssid.iov_base, hs->ssid_len)) {
> +		iwd_notice(IWD_NOTICE_CONNECT_INFO, "Target SSID mismatch");
> +		goto error;
> +	}
> +
> +	if (memcmp(hs->aa, bssid, ETH_ALEN)) {
> +		iwd_notice(IWD_NOTICE_CONNECT_INFO, "Target BSSID mismatch");
> +		goto error;
> +	}

iwd_notice(IWD_NOTICE_CONNECT_FAILED, "reason: ssid-mismatch");

iwd_notice(IWD_NOTICE_CONNECT_FAILED, "reason: bssid-mismatch");

> +		/* Case 3 */
> +		iwd_notice(IWD_NOTICE_CONNECT_INFO,
> +			"FullMAC driver: %s using SAE.  Expect EXTERNAL_AUTH",
>   			wiphy->driver_str);

This could be useful, but probably as a separate event and maybe during 
wiphy dumping?

iwd_notice(IWD_NOTICE_DRIVER_INFO, "name: brcmfmac, type: fullmac, sae: 
ext-auth");

Thanks,

James

