Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A867EF
	for <iwd@lists.linux.dev>; Mon,  1 Jan 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAPpDuXT"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbd6e3795eso2527488b6e.2
        for <iwd@lists.linux.dev>; Sun, 31 Dec 2023 18:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704076554; x=1704681354; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BStz8wzVsGoezKS7DkZQ3BoyzXJe5RtUc17KGfo0yzU=;
        b=PAPpDuXTN1OWuPh/GM2WuU3AQjS2+E0eI0kPysgEIto/NnQFVuVGmm2dflGgN67krM
         Pz6V7F9jzVnSuLOfHTZEt6gkuAwl9X9+lcKRZ7geA3Ft3o4PbOxKM6Xs+83tLMWYG1NH
         DiN36Jmg2KDnT3G4zqAPnVyjZzDk52Pu1H1cEQ6D2LpgLpqYNYTO3OoXHlHwrNIDl7s+
         mdLJDliCPj7JQDj5MnvsVjROreTBWA7axWbzHupttv8gq+lYie5RHmITFKS6/N1JCBBo
         LlNNKYJKEbnPzeT5zQmI19sd7g2It8nSwK8knsTDWZPfA0fNUIxbxOCDDtw9qPKk1xzK
         Mbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704076554; x=1704681354;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BStz8wzVsGoezKS7DkZQ3BoyzXJe5RtUc17KGfo0yzU=;
        b=bstgvYsczYBrmmY2w8l2HQOxJdU6mWwxKluJoj04rME6K0B9PKfifAHsYzyHa8XbwH
         8KQYLEIQeTXST0FV9AjDt67Wi1OOMtMpCTAdgmt/flVA1wJ505XJDMR7srXCkq1g/JCx
         GTLgFnVwQXpE/nQaS9uc5cT17qC6IoNFPKC4fn282L9+xRWK513oCBK5vUkxRrtbjzj3
         67nx13ymQAD+8jQeaP1xKsNHTj3BN9FL0cbelKXdvR5UjzjAAf4ttJH7t2KdAoYGiCuY
         sW8kfCFO1l7vcTFK6CfKyOMFZA/ws/fRXtkN7dvtgk1lP1EOOXEUvB/1zbAOZCXUnRay
         GCSw==
X-Gm-Message-State: AOJu0Yw4TeI43TScOlyHeh0Fiu+TKA5bcGCaKiPls5t4P2ri9lqgZHhV
	RHXWzknVEVW2ZX0yLo3exRo=
X-Google-Smtp-Source: AGHT+IFenfcLM1Knt2NnvuNntE9koPFrnt0hfxOaC58whQaPIHJRSq4g/h8fFjETZ2zXmVDvPcoHiQ==
X-Received: by 2002:a05:6808:38cf:b0:3bb:c981:2877 with SMTP id el15-20020a05680838cf00b003bbc9812877mr10059257oib.18.1704076554290;
        Sun, 31 Dec 2023 18:35:54 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id h123-20020a4a5e81000000b00595086848a8sm1392387oob.16.2023.12.31.18.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 18:35:53 -0800 (PST)
Message-ID: <aea77220-eeaf-4890-bb0c-315b5bd938a4@gmail.com>
Date: Sun, 31 Dec 2023 20:35:52 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure.ac: fix bashism
Content-Language: en-US
To: Sam James <sam@gentoo.org>, iwd@lists.linux.dev
References: <20231229003840.4152342-1-sam@gentoo.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231229003840.4152342-1-sam@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sam,

On 12/28/23 18:38, Sam James wrote:
> configure scripts need to be runnable with a POSIX-compliant /bin/sh.
> 
> On many (but not all!) systems, /bin/sh is provided by Bash, so errors
> like this aren't spotted. Notably Debian defaults to /bin/sh provided
> by dash which doesn't tolerate such bashisms as '+='.
> 
> This retains compatibility with bash. Just copy the expanded append like
> we do on the line above.
> 
> Fixes warnings like:
> ```
> ./configure: 13352: CFLAGS+= -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2: not found
> ```
> ---
>   configure.ac | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

