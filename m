Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C017C217
	for <iwd@lists.linux.dev>; Thu, 30 May 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080225; cv=none; b=Sw88MjScXCQ805y5hiWVmijB6Ed6m5TJdqNZKHyJ4Y+F7RGttxCY3IuI/5SKtyDgD1v4HvDJj225E5aOKx+RajXpQuxXa3jE26b1T+3oPH4KAr4JD0cc0Eq394ls5HzW+jdAsiBuroHPSwDeQdE6ga/v/U4WSzNBqR1rRRwtcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080225; c=relaxed/simple;
	bh=VyTbLkLCzRAw6aj72aA7NNyRMH2yUeR7u911pKEJgYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CEsrLQROOPjOckLiRjP/keNu6EO8v9CURShMIaAGF6isHQFK+ThO4MQvPWlsKJYnVl8VkiLKMX0rUAlB9Rxcnu5i0da+RHDpovBVZ+b88wOKg4H5s8a31TnlS8yYbVHQwf+Av1DrpJugpIlUmX3iIdSjzFRlXzjVRYrqENcZDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPizzdL8; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPizzdL8"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c9f892aeaso526174fac.2
        for <iwd@lists.linux.dev>; Thu, 30 May 2024 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717080223; x=1717685023; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RdP8PybrIHPcxZJIGNgJgGywZWGKfBbHdF2E7IYnyrk=;
        b=OPizzdL8rI182NS7Al45uWWSwCaq1+I180vshr8xBfUm93Ie7Vd/Pj5fpOdyXhDIOj
         cD27ny5JjIOPif8pmKgoDTu5gzBjXIr314lUX+q213dQ309Y0yhVH3TXgMVbNIsdF+xY
         HnrC11ULHIk0t18OZpUVlXM427l3vQBfEXJ5kawXnxTkdxxNsMQ0X0W1uJSnbcSIpp7F
         MY3xD9GXySbOT7SSfgpZHPZfU5/2GVRzkyfhOLQZHbOUQUZn4XniSRGVAlEuuQwCZTKi
         IDVZagFMpMgXEGY+WDYbpg9Qw9Co8/jyOTclDnki2iQPcFTuOwkDGIduD8WVd9BZYQYC
         7YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717080223; x=1717685023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdP8PybrIHPcxZJIGNgJgGywZWGKfBbHdF2E7IYnyrk=;
        b=mbI+WkBvs4+RXpkyF9YkMeVyaJBHCgPKb01Un14fAhnLuLAhlEEF21knhWHX76/dYG
         ueva/iemT45EW3/JpO8z+LiSkZPg2O4orMsY0D1BLKZxSxJe0bC33b9zRY4ZUcngS0E3
         PXeb5c0tlxjYTu/XnUnQwlo3QpMJeBcJdKcUGoWu+//TYkphFJmlo97Y+3USF5vzLBSG
         uprZoDxy+0kVuF4/jUvyld0L83/cjeuPQ834BP6tIDPb7fN16sVs/QIAKoM61sbRHzHV
         pbTfZ2m1byOTwlP+qei465UPuYNDew4hBat7Ha0dh0E2vsA6dIh5TY9Yy2tx/2jJdeEE
         nl+A==
X-Gm-Message-State: AOJu0YwsKfS8KFGg1oWMSG6mk0WhgHhMSoNRYJWuneeGLwH+skZEB0Hw
	fAHGODl/pyylZ0z0fdbi6IFebN5v7mBMzu+aYYwqp+zxRvtGglxxeuGKfQ==
X-Google-Smtp-Source: AGHT+IEaHxRew2/H3tZuNhbN37HV138UF1PqyIUDp4KInq5lRAGZmec0LVVYeQY7yZkTeoSF4Wd/7g==
X-Received: by 2002:a05:6870:63a5:b0:22e:de2d:8c00 with SMTP id 586e51a60fabf-25060bda50amr3352160fac.24.1717080222706;
        Thu, 30 May 2024 07:43:42 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-24ca1f7b5f3sm3629384fac.2.2024.05.30.07.43.41
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:43:42 -0700 (PDT)
Message-ID: <c4cd1c4d-5361-499b-8614-e4cb01e7e5a4@gmail.com>
Date: Thu, 30 May 2024 09:43:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchlist: Remove unused APIs
To: iwd@lists.linux.dev
References: <20240529225243.261672-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240529225243.261672-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 5:52 PM, Denis Kenzior wrote:
> watchlist_new and watchlist_free were never used.  Get rid of them.
> ---
>   src/watchlist.c | 17 -----------------
>   src/watchlist.h |  2 --
>   2 files changed, 19 deletions(-)
> 

Applied.

