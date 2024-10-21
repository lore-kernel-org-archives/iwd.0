Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845A1CBEB6
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533336; cv=none; b=I4/GZ9PZv40C53jwynykpCth2zLICcX6BKhwIe8f6BaB8Wdbd5fUx6gwdcWE0Arxm4Lwz+KLrc4oCtn5RjvCeTLhIpxDtlx2sFBX+IL2lMjpWcIZXfA+Ie/liFs3pxSsBvtXrsXMU0xqg9tSiH+CO53ZYsEDeEO7GRALo78L0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533336; c=relaxed/simple;
	bh=z1RMbWkYylHh508f4J0xq3HXZooL0LIOR0G0F+TgCj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MrAYqpRPa7c87mAivjyIFNrjFwTSQEDtj4W1uf6wykvAwCCmEEUwOQJnQn791qBUPzoUWWsRHLjjN+HWL+CIzmvaXdDyJjYDF4l5TDxYWBnie/l4VRK2UylNP8tP1IycS5hOojfsJvMfK3kXg0GLctvwIsCXdr2rB4tTfP5f1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctpKNLi7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctpKNLi7"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b158542592so273905985a.2
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729533333; x=1730138133; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uhp+BNe9LVvWezfY12f6YVDBNTuMUYRSwldHH0ODHxU=;
        b=ctpKNLi7PFTCKnmqLZQTs+VHKfQ4tZNXrwA7xF6Ey9Rm0o0Oe6G2T9P+O/a/p5fVjZ
         khmbz232LaFtRLotyerJrS8M2UDZseAPB48H1KcalxUokKcSeX03gyL5hS6/EhPQ1hKX
         /UMhCHszd6FUk56BeBObnkxQiBOx82FwYJXIaS7xHD7gqAshQ+LjwNOzBUlrwWp+O3B9
         LT+Qk86o0WNUhbu9I4k0GtGdBJSAFB37esjWw5XgMg/Y9MXwMzYU8/1Q5lh7IKsJIhZz
         haGAhQXbmjbRvFfmYFJe3pICO1mhlbtGXXb18PuMCKSv6kRu1vdXEcuy76T8dLXGVWmn
         lQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729533333; x=1730138133;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhp+BNe9LVvWezfY12f6YVDBNTuMUYRSwldHH0ODHxU=;
        b=dhLZXKq6R8bPrQggBTgT+f9MwqrvPPbBrXqIT3ANjd7h9Ws7lB2VDcMCtCeHFolH3P
         Z6NjFLGZyEOz5E1z1hzLXmLiTd655f+Uk+UzwyiKlnoaKv1bbOKIwQ4unaRoouZ6Qhm2
         njgHOjkM5NOW+Gjg8s8MxfiMnzHImYv/QlZc8VzRtsiI5scSYKuFC2qKPoh6T3fmmGRd
         cduhReyDPfEQpI4cJA20BHsNgvwkY5kWhVm8JCmeLWf3P6EkCZ+z9KVm/FsqPkKvHKa2
         LqLVzc0bOUbq5TkObp8sqQ3xCarqDNKpFlDDRaFm8irBXVOP0UsgANOozkHDWL2/5Jmr
         vY8A==
X-Gm-Message-State: AOJu0Yyq9kj1KSIsPV0vCJBx9YRPJe7ELH988NY3Zh9BOMKjm6EUxm/H
	esXbCu1RGoADDEloA1Gq1EgXBkyM4lGpPz/mslVauExfiTCvXpp86X+iLA==
X-Google-Smtp-Source: AGHT+IH4tqtXoLILvsOPC66WT34TCp6HzX89y0B8xbbB8xvnHd1KHK8n27xv3+8Jhx2+h9C/fi8xxw==
X-Received: by 2002:a05:620a:1916:b0:7b1:4ff4:6a05 with SMTP id af79cd13be357-7b157bebf63mr1700806485a.54.1729533333139;
        Mon, 21 Oct 2024 10:55:33 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a89d54sm194034485a.129.2024.10.21.10.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:55:32 -0700 (PDT)
Message-ID: <1b41f5d1-39e2-439a-8bd6-c270c18a3335@gmail.com>
Date: Mon, 21 Oct 2024 10:55:30 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wiphy: parse TX/RX frame types, and API to check auth
 frame support
To: iwd@lists.linux.dev
References: <20241011145503.51330-1-prestwoj@gmail.com>
Content-Language: en-US
Cc: Dierk.Modrow@sew-eurodrive.de
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20241011145503.51330-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dierk,

On 10/11/24 7:55 AM, James Prestwood wrote:
> Drivers have been identified that do not support authentication via
> CMD_FRAME. This prevents FT from succeeding but since there is no
> way to check this in IWD station cannot handle it gracefully.
>
> Now IWD can parse the TX/RX frame types and check if authentication
> is supported and plan the type of roam according to what protocol
> will work correctly.
> ---
>   src/wiphy.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/wiphy.h |  1 +
>   2 files changed, 55 insertions(+)

Were you able to try these patches yet? I can't test them on the 
hardware you are using, so if possible we'd like a confirmation the fix 
worked as expected before they are merged upstream.

Thanks,

James

