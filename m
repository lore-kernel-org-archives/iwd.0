Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01314D44E
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133282; cv=none; b=bZDzKMiF9fKpsvFFMyxrIdHNoyzayH+a004XO0X/s428Xbpllzq98QyH7m5PCFFlRhUrawhyN02d6dklCJsxg79NftfjqdgP+TbLjs8PbNu8uIXDF3FrFThz8oq2NFp0ssfEhE01B98JP1cOHpSNG/tJrkEX/MI/qjnopMz2lGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133282; c=relaxed/simple;
	bh=LNOKYapMwQzE00IsH7jsI9H8yzZKEJtCavcGfqaXgR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBCWr4SU6gjMlrs1oNRaKjOBhxlVPILIuw5hwAIgg6BSIroYJpy9X5cFGNDCNpBvCdBFzWCxuFIqOSuSLrSzzGgtZRj2f0Gd07p57Y6TkSyvkyfDOHQL38+VvCb64BXszESmCpUKgI3YN+6SamzlwX9VvAniX/hZ5b2xbEB7dmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA7eVa+H; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA7eVa+H"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21ea1aae402so2858794fac.1
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 07:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709133279; x=1709738079; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sljosZpa8dCS77/ZhqB47qtCzWpct8iz3J4FU/Pz5P8=;
        b=FA7eVa+Hj6hdGPMWpIwO/AAnSrgCcvV3Lc7xdLSp6PgrNKMdFYiOAEgkmggWcoghIq
         JQ9FOEbU+o9kIgph6JmybLAm5okg3kLOsfHaN4s9adWP7PDI8psfdxk5IasCBg+tV+uf
         MCv80QEoDiHLSFh6aoI6baxP5Q97MdYUrB6YD3PKw4R1bkgf/YG/OVR9PKdHquL5Dgza
         sacpDPm7lQWT7CoI/NAChyfj5yp+kGHzxyMhz2uwoJ1ZGGXUp1aLUh4NukVhS9ieF5kq
         Clj2lbDvrzFwxmtwRaN+OiqUUvO4GyVcBaSdEEWDVOAA7MpF14b3eKElYj7JekM+QDv8
         uESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133279; x=1709738079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sljosZpa8dCS77/ZhqB47qtCzWpct8iz3J4FU/Pz5P8=;
        b=Bzn42IznjjiwAl7y2FZmUMXPgKAg14MxRXCU5aVvz6I6fnGCajuNFmqw8EpPDLddeb
         MhGQHqCRIpe3S8yrUcdOcuGdqcbuZEKUXQb33bPF2L9tB9+ekBCnlTlvRQhQXrNuWYFT
         0qSE2ky/k2jOWP6gxMLdg5zqBOimoXs9jVySPHZ+DgpXmVTbFatOyi0iXklaFn25JmwG
         YWg+F5u7PqYYOWBX6t61hR27JLqocaAr+zDLak+lTQ4aJP4PiBpSDBD3bHD7+LLs3GI+
         fl0dfThoO4EIpdGc3aiwmR2VyP3nb4gyOdYYps6psvk1Zu2EAGr56DwEJgRPbltZhYFe
         41Pw==
X-Gm-Message-State: AOJu0YwvlWE5HMgxJr5LtiwQFbOB4C30K0JpJjEm8AT1vFYNYc5f1ylf
	YXx7QE238wvG/fM+AwVCGzN93qQU7p3bHziwytURldxYgjUBHHat
X-Google-Smtp-Source: AGHT+IHH5SH1LhgOw3FMydkFuDsSED1bk5wEPmwHNL508bm8oxogzw6W/s01FDJ9BBrbiJiCuxzbOw==
X-Received: by 2002:a05:6870:514f:b0:21e:aadb:e037 with SMTP id z15-20020a056870514f00b0021eaadbe037mr16454674oak.41.1709133279678;
        Wed, 28 Feb 2024 07:14:39 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h20-20020a9d6a54000000b006e4901f1a3csm1855553otn.22.2024.02.28.07.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:14:39 -0800 (PST)
Message-ID: <0ed91cc2-b88c-4bef-8405-35bb14b161d0@gmail.com>
Date: Wed, 28 Feb 2024 09:14:38 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eap-wsc: Silence static analysis
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: iwd@lists.linux.dev
References: <20240227212521.1510693-1-denkenz@gmail.com>
 <259df0b0-4961-4818-8342-e87117074048@molgen.mpg.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <259df0b0-4961-4818-8342-e87117074048@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,

> 
> Too bad. Out of curiosity. What static analyzer is this?

In this particular case: coverity.  It is very easily availabile for open source 
projects and does a pretty good job.

> 
> For the commit message summary, I would be more specific. Maybe:
> 
> Zero authenticator bytes to fix static analysis warning

Great suggestion!  Done.

> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks for the review.  Added your Reviewed-by to the commit and pushed out.

Regards,
-Denis

