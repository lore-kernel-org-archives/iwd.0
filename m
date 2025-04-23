Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47C27F4F5
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419399; cv=none; b=YAkVcnIjGvdq7aECbCyhrHm5DB96emnH3bTc3FVWGg7oSaBEr7uFGp0bDu/MttxfwO8Ougz+vER07SaYfAb5Fcyr6/wt8xoqcy/yD1/MvLVGzUmoKvbbDufuz2QcflB8SukZ3hbytQOT4vlr3HCNy+WDEFiKpJ+/DxhIESFn0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419399; c=relaxed/simple;
	bh=5HRpZTcXdUawmqxs7u2PkIZmpaT1BXDwU3oOUddKRQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fFWsWSEY7b1e5I72BP/9JXXKwdC76QdOJcihraBuxGhbyRDF/nUXpMZzIw9ZBB/WxsHsQDhdm9GfPOUmVsBoqO7LAcw03/+epUAhgzoCwsp8onoskybs953G+Wp4Y1AOledzXcMILmp/MbvfCCDJaYtOKKsn39X44JbJcnadFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSoO5lmc; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSoO5lmc"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72c40235c34so1980507a34.3
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419396; x=1746024196; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekrYiTLie0+drcp/u07OHsMKj35FZvDSwy7cAQftQ3M=;
        b=NSoO5lmcds8zIeXwMjvzZ4sIiNcHUfUMbPXaDcm1DHXI5c6VxoKZ0iFMCdheyOCBox
         AnJ9PlP4YddTfZDz4ZuSYLRooVQTqIDG/475/5E9msFe8TCHGmFuPHnxIdZalu0IlHGY
         B7hZXl92pLR/LKN0MYpnNiqR9GfL2RxzhEBoc+Av80Ok4/rzH939+Vff+mImZM4+xtKF
         Q2Dkal8T72DdLRDsyfNSLFGyGv5bmXjvuLcgglss6ulilQsggj7AjBByJHwOAElWIEZs
         u7uDWvkZy0H6dWszIQNFlulxofwrohMEDGejVqZkmVoASoxYC21GeMpNMNEYEkUN1QgE
         CcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419396; x=1746024196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekrYiTLie0+drcp/u07OHsMKj35FZvDSwy7cAQftQ3M=;
        b=AibncSx5hlMVTq8nrhfmukeIztUB+WfXQ0PMmYGt3zysnRYdX7pegLMQYuiWhcwdUG
         h4rqGX1lwqyirqH6iRYVgjzjZMmFrS4ZHR4R3l/z6fAfS66iBGgr9ZSF/mmJA4VkzojK
         NF1yZ3BSDzxgYxZNmM7ylHeJzVVfEihf4/HBwQ2xqY27WrW1U2bTAIO6t2gmbJXjN3nF
         pcr0IBTuKiyFoLDQQccJM02ZVbstV1BvfhmpDrpEw80M//pvNGGzgxZsdt9bNwSqCqWt
         40aT5kk5PIPFLNz++EKXXVM3b4G3tRFWsFMvDdncVSMaPj/nMWL3VjVoAvVb4Ak4YuB9
         vOYw==
X-Forwarded-Encrypted: i=1; AJvYcCUUZ+yudZNMxsgiWAuCFM3eJZ7nD7PCRBKjkl1TfIps1Yzmc2X6v5L6eTtaILSgMUujsj0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzeN4yxUO4Z+wv5muwWhgAg62Ezd3EcUufZt5bsbpBnt8+FCpVU
	Wl/VT+orEaZheZ1vBrGeDec0bhiVmjYOYCY++nzphHPosGALlmYIxqA1Ow==
X-Gm-Gg: ASbGnctbpThPbz2qAxDCDQQmnSjOdwG3w+/IQBBluGYdsS2sByreQv6cwMhN4R5jrPC
	Xo0+Dy1xefHR5Mj6GfUI9VzSp9uGys0yTeBX9jf93qbXWT64y3sjkcH5Sjzj0n1iFl4kHEk31EN
	Z5ULznZD68/VWWiHul8A5cBh0a3tyxpas3vs3hRjiZw1FIGJcwxXsTk5Uufg9fLt/AOlYOhnpck
	/EWW5JT0UC34oESohfAXmQCjAbq3mvgGcfFtQjLLRPMMvX62wrwhqKgY14UBRda/31JzpJzEkSR
	4fBIK076eZseN8Gg7nDnBWyzT1gVrcJn9uPjv/CKDg9njrPn3KABb//xgjKy+V0xAP0ez8Hzok+
	LmZ1jZQ==
X-Google-Smtp-Source: AGHT+IHLZmI7Bxo8RZIsM3pRXbkn9ARUu3BC/SVNnorbhva2xaptSvu9JSP9RAWJbaq+HzXlg9oLZw==
X-Received: by 2002:a05:6830:d84:b0:72a:4804:77ff with SMTP id 46e09a7af769-7300635b891mr13877040a34.25.1745419396088;
        Wed, 23 Apr 2025 07:43:16 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-730047af85bsm2520763a34.19.2025.04.23.07.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:43:15 -0700 (PDT)
Message-ID: <15229ae4-8069-4fbf-9880-11be9793a35c@gmail.com>
Date: Wed, 23 Apr 2025 09:43:15 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: fix setting an empty affinities list
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250417161601.249876-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250417161601.249876-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/17/25 11:16 AM, James Prestwood wrote:
> A prior patch broke this by checking the return of
> l_dbus_message_iter_next_entry. This was really subtle but the logic
> actually relied on _not_ checking that return in order to handle
> empty lists.
> 
> Instead of reverting the logic was adapted/commented to make it more
> clear what the API expects from DBus. If list contains at least one
> value the first element path will get set, if it contains zero
> values "new_path" will be set to NULL which will then cause the
> list to be cleared later on.
> 
> This both fixes the regression, and makes it clear that a zero
> element list is supported and handled.
> ---
>   src/station.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
