Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4019CCFC
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544588; cv=none; b=hosJXwhvouAgKa9arb6xfvDe8NoxI6pNPEdXakbGqU4SYhIWoXU9HW/l6HvRxpUkqR55yXuH9vIhgJgeYQ0MHZUrfoyPOPpDL9o4w3fG8qO8FJp8Dtbc/oW12GDnNsr4v3z1luV8Va+8IWfp6UA1ET35EXb1/nFezhojE8qS7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544588; c=relaxed/simple;
	bh=NceeuCoZfo6l2nFmGxjL1FWZKi3NCeFJmXpNBuSUzQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+NcCrFJvXfQmV+qYEFwS2r8RrMg62kSncdOGDfDeQ9NOtrbEywQCBMGd70Sta+9p+1/mJ2g0FQ4UHTZF9gLayifabAdFQL670Bvwwsxn92bYBLkn37svLFnNj9dwmIdHHeupNbgZU09ozRstVfI7TTCa1wTXbtbVAyRYGAQGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0UOxucC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0UOxucC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20536dcc6e9so6022565ad.2
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725544586; x=1726149386; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qz2HF6wOYftNENHsph9UDNmc6CxVKlvO7McPcN6Kr6U=;
        b=X0UOxucCTrK0Vq5HdrNnA2VnOxGMd74lS5IitaqPs6/V++RsIsSuwvdHw1PNBWaeuf
         xaxWi3tdB+8bHHNcpgzaNphlT5QF3Cwk3dv1V5XiDWyJiXgqR14WP2BILDHX33a8zYP6
         k3OIm8KU/vPbbJUlRbhckWPAAIHheO5mwSUokE2+b+cowHq/OeM26WBKaC0KmZg3eatS
         Z4sF3eatnB4ROcIko4Z8y+Qe6dvDC96FGwNMvTeftdEhFOkKhEJPso9N0QZbUARn+zkd
         zSGD3yRQLuKbozB0jeAwesjM+/bZGvnZEWrqcOGVr6Fj0+Ob0FGXfdLhv1IYuGpFHgHb
         JTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725544586; x=1726149386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz2HF6wOYftNENHsph9UDNmc6CxVKlvO7McPcN6Kr6U=;
        b=gb1OddheQYhO0j4//oYqojyDJFVUD+KnVsmFVSyyeMuoHcHy023oEqpqHwJDnAtC+Q
         Us8SrBxyoDAQ2VOUk7QqKSPoRPRNeAIZNXh13hdFEw+v9dBqWLaFe7Djyk/gtedZeBbG
         UpPI0p6begjok/sLNbg7sDnk4keliDwxlnKLj0arQSw4uswFYpC+nukwEBIMRHIQpMRa
         gF11zw32qgSFC+WpHvRrJkwShzpfrqhxbQq+pcWZcfWwloT7Ah6/bMk8ihZat420psDt
         pTDz5SSZ/Wwk59SZZKkf7VtURtGgsfP8q8RGaxrxDoMIjMYDM9gPHTldya0eRpKwn7FR
         G8tw==
X-Gm-Message-State: AOJu0YxpjpsTfoh9Y7rF+027TLorYOp/h7b8bUsII1lap4pnFauTUUkh
	f/Lm6ZwZ8eh18IIXJ3YmqCe0rEMmxx9Jz9+7cntxzHdJYstoqsSPvOxGPw==
X-Google-Smtp-Source: AGHT+IESZs5MGJ9jvOI/V5DSfCPHUcrAr4x5VXShqndsT3+deUk8GlBeyIbMZKsINMu1tzXUjNDohg==
X-Received: by 2002:a17:903:18e:b0:205:5427:2231 with SMTP id d9443c01a7336-20554272500mr143136115ad.47.1725544585958;
        Thu, 05 Sep 2024 06:56:25 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea55816sm29049105ad.190.2024.09.05.06.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 06:56:25 -0700 (PDT)
Message-ID: <f11971b9-f1dd-4055-953f-9fbb76691031@gmail.com>
Date: Thu, 5 Sep 2024 06:56:24 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: check scan request in get_survey_done before
 deref
To: iwd@lists.linux.dev
Cc: Daniel Bond <danielbondno@gmail.com>
References: <20240905134315.374800-1-prestwoj@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240905134315.374800-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Daniel,

On 9/5/24 6:43 AM, James Prestwood wrote:
> Due to the possibility of external scans the scan request pointer
> could be NULL. Prior to surveys IWD would still get the results in
> order for periodic scans to utilize them. This behavior can be
> retained by checking both if we don't have a request or if the
> request was canceled. This check is identical to the one in
> get_scan_done.
>
> This fixes a crash when checking if the NULL scan request has been
> canceled:
>
> 0x00005ffa6a0376de in get_survey_done (user_data=0x5ffa783a3f90) at src/scan.c:2059
> 0x0000749646a29bbd in ?? () from /usr/lib/libell.so.0
> 0x0000749646a243cb in ?? () from /usr/lib/libell.so.0
> 0x0000749646a24655 in l_main_iterate () from /usr/lib/libell.so.0
> 0x0000749646a24ace in l_main_run () from /usr/lib/libell.so.0
> 0x0000749646a263a4 in l_main_run_with_signal () from /usr/lib/libell.so.0
> 0x00005ffa6a00d642 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:614
>
> Reported-by: Daniel Bond <danielbondno@gmail.com>
> ---
>   src/scan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/scan.c b/src/scan.c
> index debdeb1f..205365cd 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -2056,7 +2056,7 @@ static void get_survey_done(void *user_data)
>   
>   	sc->get_survey_cmd_id = 0;
>   
> -	if (!results->sr->canceled)
> +	if (!results->sr || !results->sr->canceled)
>   		get_results(results);
>   	else
>   		get_scan_done(user_data);

Feel free to re-submit under your name as this is nearly the same as 
your patch, but the difference in logic change is important.

I also forgot about Co-authored-by, which maybe is more fitting for this 
case. I can send that in v2, or maybe it could be added before merging.

Thanks,

James

