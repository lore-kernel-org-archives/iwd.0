Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A14A02
	for <iwd@lists.linux.dev>; Fri,  9 Sep 2022 14:13:26 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so1118567otd.12
        for <iwd@lists.linux.dev>; Fri, 09 Sep 2022 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TAi+hOoiTpx/IJRRWF/dfQrL3irZrF6CMykC7nNEU5Q=;
        b=jrvsMkvcFR1aOMynCvsxTxLCyDC+bClGsVSG28d3DbUO3eY5YF+l/Uhu8ijK+TZw3C
         6BFuqcJVpHW9sO8xkIzjE85aPG2LLLkz5CM5k4/uUJXdRJkOOue5RamiCiUUyfcDegUV
         ErhdusN/6oWqDO+ktTwEVgQWzExPeBdDXJ7b9xfMkRakXcr186tB2wzVKKSWTVLWRCNJ
         DhLTilYXTUpy8YnqcdMJoLFziBkhO5fEdZhtRSom3DPcLNk1uRjiumAjuf4NSpF4oa8J
         aqeJOjZktCamkeHUFLqynjOt6LpVMTdvIeEKdqY2elX8VSeFZpQy5CZC/KTUFWsiHg6I
         2FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TAi+hOoiTpx/IJRRWF/dfQrL3irZrF6CMykC7nNEU5Q=;
        b=54veZR6xWhlMdHlPaKgHh9WZQ8z9FmyFjnUZYQstyG+A8AaRhZN33VMWzj6hI2hrOH
         N2/A9RhqvLt/UU2bhYWcZ4ZLBYlyU4HMMFMt9E+rb9QCZg9Jxs7RyrdPBKkJuoeocIXh
         4L2vlFPgdmpYByjqbcCynil7LzPqex/eATbQMMfUr/J157fbmIgz5fm9hx6BXX+3IQWu
         si6Cy8AXKh8aU8qveDXhKcDulQiYuDZjBf8BxrLNm8qiWk4MayZOeJLfsqa+xzRZa35G
         Qc6eWfAYeEViURrU6jxArtcB4vMjKxObCuNa22/s8B45o5unRspKnuUVBRWhieCcRXl/
         yPoA==
X-Gm-Message-State: ACgBeo1b0BXE5ejRa7htGXWqC+ZbOuqeknleR4myvAUY3HiK/MRymeJ0
	u0va+2NSAUC1dVcLe2akM+E=
X-Google-Smtp-Source: AA6agR6vh8CFqlQi5pVphyi80mmdjJX+jfGOXt/T495ioZxpod2etciwwR0zswTswxS16uxJSaLUow==
X-Received: by 2002:a9d:7f91:0:b0:637:26ca:280e with SMTP id t17-20020a9d7f91000000b0063726ca280emr5482666otp.246.1662732805312;
        Fri, 09 Sep 2022 07:13:25 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t15-20020a056871020f00b0012b2137fb3dsm353546oad.40.2022.09.09.07.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:13:25 -0700 (PDT)
Message-ID: <deb04bbb-3ae7-50e1-f196-6e938fb82ab6@gmail.com>
Date: Fri, 9 Sep 2022 09:12:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] auto-t: add more checks to testRRM
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220908223308.439085-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220908223308.439085-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/8/22 17:33, James Prestwood wrote:
> The hostapd events for RRM come regardless of success
> so they need to be checked as such. In addition one more
> RRM request was added to scan on a frequency which is
> disabled (operating class 82, channel 14).
> ---
>   autotests/testRRM/connection_test.py | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

