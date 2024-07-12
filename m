Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19E1DFE3
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800569; cv=none; b=dP+1i9XWX3jAUAkKmW8fflZwvyKYat3bqtw3y/IbpdEBWk89/seuC4q9wDJrbJhUBdLH8IYlhvwLmdWO6wOhuyT3tZ9rO5y8VxVw3caV0qMxXUKJRRrXD4sALIP1arNg89vXjK4QVCt1Hm454lb4xbemHMr+s77pgiXtD/f3Uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800569; c=relaxed/simple;
	bh=hZtdih5Azfu89MCDuZiR+bpEuWfB2LE4Y4p4fc2G5c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oGVRnLtQYO9dyTETH7871bBNJ6J9WIj4ohLlN9yR99GiR70SfCr9mAthlCRPFSkPf/NfZcO5Q1TLo59oOKpIB065J3wQU4DQmW469HEJl+Tt0rjGDF0CntnI/bgTmD9GsyIDetEdoH4DWaLRFP+O2QT/IU1aJ9/dJS7BwXtM9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKhxh79l; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKhxh79l"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-80a2939265cso26945139f.3
        for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720800567; x=1721405367; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mTYD1eRapuRJsUoXP9FNCv4jA2/oJAVrMoqHdPtvY8Q=;
        b=KKhxh79lYS0Sj7kBn1C7X8upjyM2E3WPn095gtL3sFK7+Y8Gl1HCqiTKP4lZW5WfBK
         oJ+qHdq+e4asODxCcwkDHY1CC+NP3bSqEXv0qAUAQTGN917ILBKjTd+hxbFzVnuMxtHp
         /Is2uAMZKh2OJ9CsLFb7YKtXtsHp6ZZ6dcIhPxcobEm1LStkskw14o5QAyKr6BrAkz+r
         EK7sJXMuvZMP9RBfbYEJ2l9s1t5a+spsziphHI5M2bO0tzVAi2/5U0HGidsg+rnzCXtg
         UdOYAlK9TVsvk2oeSATfnjrAcEsiArT3RMTTs5Q4MoNGR1ZONjQKzCIHMh+CQdiBv/3W
         pb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800567; x=1721405367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTYD1eRapuRJsUoXP9FNCv4jA2/oJAVrMoqHdPtvY8Q=;
        b=rl9lCvXObWlgQQB1QfBArNdWUcLyAmQza1T0LSnQb4zY6YJjHWaQBHxTlT17+CNVih
         Rppm1vgSAbrNAKdtV0lIMvHMswgcJNEPf/3j8Lw+cnnrJYdTS9PUiljiJxRlMZqmTkFk
         xqoTSb08afWu10LQ6XjR23ibnQeFK3oCfAVBsE8DlLMSLuDvPhjoPMItK1xWdkti6DOO
         XoVcdRflDA2NnCMnPmD+Zdlx5rlu0FreGpV+36etPf6RtokGEnJQdVaov+5BwCtYacaW
         5znth2VT0f/szrcPHfCtfnSrEXKhlmNHHNM8Qn14Ao4kNf/05cGVP2QGD0bMTgmZ43Fj
         Gn5g==
X-Forwarded-Encrypted: i=1; AJvYcCUDMkkFFRm0bDxPMh0nlIs3atVWEad5/z+4mqcjDXEWZJVdbeVdotPM2XZeOKUsdNA3/xoRhQOKrP2zRC4N9BqsVGet
X-Gm-Message-State: AOJu0YwwvICKajB5MEMUDmzwydicwLL2K3kWfOuoKo2t13PHbjyLSpst
	uoZsDHTuEHq8EwvrfJh/x9/xOnIfpl+qr2dz9kp6ysQTvGVw2cq9yGGN9Q==
X-Google-Smtp-Source: AGHT+IGqxIK4opRun18r4RfI/6LiG7WF3Z8NDjwFa6COXP4H3CzymxMyUABnROgiVi3RKBuhcT4X/g==
X-Received: by 2002:a5e:d809:0:b0:7fa:cd1e:963d with SMTP id ca18e2360f4ac-80003ca8f80mr1288207339f.15.1720800566867;
        Fri, 12 Jul 2024 09:09:26 -0700 (PDT)
Received: from ?IPV6:2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3? ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf8284sm2508520173.98.2024.07.12.09.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 09:09:26 -0700 (PDT)
Message-ID: <59f20eb3-7f41-47fe-9010-9ac4f9a48fd6@gmail.com>
Date: Fri, 12 Jul 2024 11:09:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] main: remove static from const strlen
To: "dangling ." <kasperkantz@outlook.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <DM4PR14MB4880D5598D181E5FE126C54BA7A62@DM4PR14MB4880.namprd14.prod.outlook.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <DM4PR14MB4880D5598D181E5FE126C54BA7A62@DM4PR14MB4880.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/11/24 7:33 PM, dangling . wrote:
>  From bc0f427f81b5b25f1c706c66e455dc9ea5686266 Mon Sep 17 00:00:00 2001
> From: kasper <kasperkantz@outlook.com>

I need a full name in order to accept this patch.

> Date: Fri, 12 Jul 2024 00:23:56 +0000
> Subject: [PATCH] main: remove static from const strlen To fix this error:
>   src/p2putil.c: In function 'p2p_get_random_string':   src/p2putil.c:2641:37:
>   error: initializer element is not constant    2641 |         static const int
>   set_size = strlen(CHARSET);         |
>   ^~~~~~
> 
> ---
>   src/p2putil.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Why did you send 3 of the same one?

> diff --git a/src/p2putil.c b/src/p2putil.c
> index d1f114d0..ef0f988c 100644
> --- a/src/p2putil.c
> +++ b/src/p2putil.c
> @@ -2638,7 +2638,7 @@ void p2p_get_random_string(char *buf, size_t len)
>   {
>   #define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz" \
>                  "0123456789"
> -       static const int set_size = strlen(CHARSET);
> +       const int set_size = strlen(CHARSET);
> 
>          l_getrandom(buf, len);
> 
> --
> 2.45.2

Regards,
-Denis
