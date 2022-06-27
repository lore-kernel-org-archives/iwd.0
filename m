Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD573D98
	for <iwd@lists.linux.dev>; Mon, 27 Jun 2022 18:25:45 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id w83so13999517oiw.1
        for <iwd@lists.linux.dev>; Mon, 27 Jun 2022 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Reak5uwY1aD1lKUZcJdnjJ7wG5rEkTUl298dgt8C/wg=;
        b=bRZ5lxFulCZA8pVpPlEiiLYG6jvn7i8SN8WhZ4c8cW5M7RPh9wL4cI2h197pCi/BG8
         XeNXnOGrkHyKJKdN9WWXI7pTJQ5bwGHbjnwPcg2RAeOaLGQGxzJkgA3sa601XDPtR6w6
         MAhcy6aU2M7HrSjR3TfVpcRC7Drcr/ERLR5KgHtXcO69zcLTbNpX9gg0p7AU04Bmhw0g
         vKW7LArr3/sTv9D3odshAqL+TqdohmDjEkVogX7rYM6K+syEw1EpN7OumLvG6Bh4Poqi
         4g2BGniRUyuCR52LU5gueQ5PONIlD08bqpS29amjIB+iCgxc+HAwDdnWa3mDdPDd99r+
         RXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Reak5uwY1aD1lKUZcJdnjJ7wG5rEkTUl298dgt8C/wg=;
        b=TQCq1eKIha40IrearljWo5ZYHqaqhPb9FsLIObnNdLk2NQc1Hieh6Lzh+TZ0ZBbXJi
         KU/rgx4GLLKL9jTrzKTaGNAKIzJCZUWz3VuSxC99A0T3kusWmYmYxkkgfuRE6z9Q1m3+
         0SBcFWq4cgdSZH0yf2b9GAmbqONPbnLP/gOas3+6AiDhE7gQe1E0SAepYmIzJspNTAMk
         hhaumQyjJfoZapp2hPtYkjBWIDFQI2jvIYHXObgyt+aSKhp0mjSzhL6r+ba4FlMOYJTZ
         79sH3FccDVo9BmSZ2B+424ggBz/ROlDvld0BCHcALp5PIUhXfypBh3qAb0G9+21053vr
         odzA==
X-Gm-Message-State: AJIora85TxsGwZNbSqZ4m3axVLxb+54sO3wxvOMsUOSO7RvSc6p5b00e
	GAET6dP0ph08IFegLOb0F20=
X-Google-Smtp-Source: AGRyM1sOOJf+1QEy31Q/v6CRAtdMw740GLSB3Q8CZEAiaLQEZWIAwdZWlKJH0aIt80zoYjzTwRAkGQ==
X-Received: by 2002:a05:6808:1889:b0:32f:65e3:be98 with SMTP id bi9-20020a056808188900b0032f65e3be98mr11454435oib.160.1656354344951;
        Mon, 27 Jun 2022 11:25:44 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bl29-20020a056808309d00b0032ed2343100sm5839007oib.14.2022.06.27.11.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 11:25:44 -0700 (PDT)
Message-ID: <192a1d31-7476-c60c-cee2-1f213a0a9a2d@gmail.com>
Date: Mon, 27 Jun 2022 13:12:05 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 15/15] autotests: In testNetconfig verify routes from RIOs
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-15-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-15-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/15/22 19:02, Andrew Zaborowski wrote:
> Verify that IWD with NetworkConfigurationEnabled creates the off-link
> routes for Route Information Options in the Router Advertisements.
> Sending this last because these options are not supported by current
> netconfig code and the test should fail without the l_netconfig patch.
> ---
>   autotests/testNetconfig/connection_test.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

I went ahead and applied this patch with a slight amendment of the commit 
description.

Regards,
-Denis

