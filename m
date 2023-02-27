Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC5746B
	for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 16:24:34 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-172afa7bee2so7923871fac.6
        for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p052AgGxJ3DHKADjp4eT1QyYxUjhODx0ZyYcEl6V/g8=;
        b=ekwx9BMIfjrf/gJYCg7sTBfYuXFC921o+Q2utHq4YV6JMCG+C5uG+aMndWuvX1HyJb
         8jVHgTnP7jYraZ+kzMOs1vtqz3s8YyAl9/YatOp2Rl6DuawvsbDqS4PjngBKR9scv8V4
         nvBbkMnDeY3S9ieYxzHt4xW6IcaT3xJsJymH0/ZLlnx0tQBMUUlEx2rIGngR7mJqJ5pz
         VfCKNgURLSJjoGZJKd0qO4CEayLEFK4xBUMeJf6xFF7b+n2TSysucW54AQ1/+qvS420Y
         9f9oVuiRZTVPZMc8s9LXM5+Cvb4/Rzowi0a0VyGlREBXac04B94k/Q3FoEkr/6tyq3OL
         0Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p052AgGxJ3DHKADjp4eT1QyYxUjhODx0ZyYcEl6V/g8=;
        b=13aZwUk584qb5aAd7heYsglLkABgH7Thvd9jVTYadVjAHZupG4gkc6B5Wd4VzujSbs
         zuZ3lvuLJ0ILoTTn7L75cBicn2rT6SSJtjdJF6+b6CYaOZIWPQ7+elylw8WES+PVzV5a
         FbMYx2AMLXfohH4FesyXRLXceTFDlQZ83zoXdcaU8h3GHel7JazL2RYlQ0Wxu+OYND+2
         d4r4GGCggcRCqmRGwZKNSuRkpMcYuztAfbcc45VHEM6zfrjK47pU+4RhiSh00v8xuibG
         TuR7Id9Odu21fl8llAmmNWctD3tqfZ+VavJHOq7CWHQN2nH2eLFZpQIDEQVbaVbM4UgU
         X2Bg==
X-Gm-Message-State: AO0yUKVitmDiNecR8SKWmQvys7yWAll/+1lkCAM3KHyWbIdP7ZVti4Bw
	KjYH+0dvWeAgUj61JeNRyZcvxaSTvbE=
X-Google-Smtp-Source: AK7set+hbtBaciLoRWivmSIymHxxXfKDuLx+ttuAPG6IACLpbef+UNt7g+R0vEPbqI0AGkU+gejrzQ==
X-Received: by 2002:a05:6870:a454:b0:172:4d65:c883 with SMTP id n20-20020a056870a45400b001724d65c883mr5158281oal.28.1677515073772;
        Mon, 27 Feb 2023 08:24:33 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v19-20020a056870365300b001723f29f6e2sm2417867oak.37.2023.02.27.08.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:24:32 -0800 (PST)
Message-ID: <283af45d-c764-f405-d993-469731d5c499@gmail.com>
Date: Mon, 27 Feb 2023 10:24:31 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] knownnetworks: fix potential out of bounds write
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, iwd@lists.linux.dev
References: <20230226062526.3115588-1-c@jia.je>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230226062526.3115588-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jiajie,

On 2/26/23 00:25, Jiajie Chen wrote:
> If a very long ssid was used (e.g. CJK characters in SSID), it might do
> out of bounds write to static variable for lack of checking the position
> before the last snprintf() call.
> ---
>   src/knownnetworks.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Nice catch.  Applied, thanks.

Regards,
-Denis

