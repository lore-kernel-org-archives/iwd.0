Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C926AA0
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 17:46:55 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id p132so11758094oif.9
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=FTgUsK0eL2CpBS2KEn8K3q6tscRUnyN74LtpbFu6mpA=;
        b=S5zrI2r0V+rr1COfH3s29axtGZj7N3en4uKRuUwuS/6MwEkW6QotdhodrWJDkecN0V
         Tr3JYnGIpoDh4qQyOPflObgVhkXeOBwt9CHAPwB8zI7fr7WSxhusyz+KVgio4KrnRXS1
         a3Pig6ZEZguRKtbJ9Biz+7PiBw40gSO23QDcPIwPng9/Rd2uhmRK6iFNVMrjVi65+uL0
         bgesm20KZQN8tloQ1W6ZVUYSStwYjMxqqtBrRrqzi1N/AgC6gOs/FUPftZPpCCKCkJqW
         Sw5aRscMZalnJU7/7TPtl0Gc0QBfLj6TBEue+v85oDN2I6T8cinOT66uu3YuEp911KP7
         BUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FTgUsK0eL2CpBS2KEn8K3q6tscRUnyN74LtpbFu6mpA=;
        b=TviinTqxSD7umgjq1SwpQeO8tGMgQTexHnDSWurnBQYBGIU4CYp2dvc6Z6DgYZsOBQ
         2z2+MqIz4bKCG95ZhK+RnYen3DI2lAoJHuBI7UdhNDmDJ2PzXoWUrKN8S+WFzB1ix4wR
         imEGOKFB+kpEEY13liISDgLbPK4R5gKzk+1ULq5yqcsjtOAClSqN7FmXxKN+2U1TS4YK
         VL9e1sZexOczlaJWzHDGQ9AuCkhUl7HY3d/z1kZS8gOYT8MYG8GbGselx3HZLoCvq5aU
         CjMA5Qg2IG+TSRi5snM/qvhQDa24rjkI7hI/+u5FJ5DU54pjy5kljTW8MF6HtXGo5DUZ
         F88A==
X-Gm-Message-State: AJIora81RFbWPn5m3rqRN48b0n0DrrJ5XNrTH9+Z1DU+C7q8ZHoxHCn2
	epfUPvqHGJGT/bOT6xPH5u0e5EmQCoI=
X-Google-Smtp-Source: AGRyM1vqedFXdrfigsoyQ7A1b+2UpU195qvv5/1+DP3AHxSpanx+11IqCHcPjSeHhTio30OwrzqgZA==
X-Received: by 2002:a05:6808:aa7:b0:33a:5f1e:21ad with SMTP id r7-20020a0568080aa700b0033a5f1e21admr2846074oij.262.1658339214964;
        Wed, 20 Jul 2022 10:46:54 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id c11-20020a056870478b00b0010c8b6e70ffsm9332989oaq.37.2022.07.20.10.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:46:54 -0700 (PDT)
Message-ID: <7e1dd0a7-7bbd-1a33-af0a-45c1aeca9828@gmail.com>
Date: Wed, 20 Jul 2022 12:35:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] doc: Mention "wep" network type
Content-Language: en-US
To: Jesse Lentz <jesse@twosheds.org>, iwd@lists.linux.dev
References: <20220720161108.250369-1-jesse@twosheds.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220720161108.250369-1-jesse@twosheds.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jesse,

On 7/20/22 11:11, Jesse Lentz wrote:
> Document "wep" as a possible Network Type. Mention that connections to WEP
> networks are unsupported.
> ---
>   doc/network-api.txt | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

