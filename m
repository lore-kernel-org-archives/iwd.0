Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535F46B7
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:26:14 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-101ab23ff3fso5792953fac.1
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=+7ZTqc69mqPfT1beQb8mD7YNoD4JX6AqXE+rl16aplM=;
        b=qYonmm6SY2FSO+OxiJsIq3rbE3KPXRF0b7QJPUP6DDxAXB3MBwGlYsnZaiJAFw5lWV
         kkNEW8TAqAHfmvIXNzi75XcqwDzf1DtkDTPf4QRUQTLn4hyiSfrOLdjU9jojxr5cDXu+
         lVFrC5CBUWNAFwwUcOrMvXLBxs3id8bHaNn0UHIUYKqInrK9qTdLOhg0Ze+7u+UNCgHl
         hWlCFo8/Fg3XAmY+hRzeXm6Wheq2zj9AA9ABwGDa1ThKlsxdElwQHGqc58ApNJSS4WZi
         jcOU9Txptw3FlwU6MI1RG6SEsAc0ZPEIIiC8v76WgBD4EaKK8QHrjDrs3s8D19FAN7/x
         U5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+7ZTqc69mqPfT1beQb8mD7YNoD4JX6AqXE+rl16aplM=;
        b=Z1/Zfpg5dA6VOhaWhy4+K+bBkEskclfVModRybejz6V4qwdnatlwDSgUI13tXnXNcB
         ad1I9OydFMHg4AIvAd1ZT5P2DtchPcUOetI9MIhpwMPGHnyK4hDEglxbXuIHPPsnyYVn
         iaLwuL3nPlkyFOzYspubB1/2wpsmwzEt4E8NhhqP7ArtzPlaxfaRAuvQgM6IljxhnDUR
         IN9njVR9p9eAicfGbrB6zkxhgpxaPNM8UkrUMpBIOkAiec5L1Tw1sLKktYmkTf7kVSFs
         C8UQFyz/vryRM+wb/bp4mj+OtfKdEfFzyo6bh9WtUm3s0vWyHG4FFuTH8UC2CHBISxcG
         mGRA==
X-Gm-Message-State: AJIora/6QaLtVoy43SfVuRAfrk4u1NC4eRqtaRUSQnm+JOoy31NSiRLq
	3cvOJ1FA71bfP5+Rtswj3Ls=
X-Google-Smtp-Source: AGRyM1upOd/6jvfiWT/BO16HpjhfmwIiql/P0OP7jnhBE5vpw+HLGw2b5smR49jm8esoERHzNT0c+Q==
X-Received: by 2002:a05:6870:9711:b0:101:ae38:6c85 with SMTP id n17-20020a056870971100b00101ae386c85mr3674539oaq.50.1656113173652;
        Fri, 24 Jun 2022 16:26:13 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n39-20020a056870972700b000f333ac991fsm2804116oaq.27.2022.06.24.16.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 16:26:13 -0700 (PDT)
Message-ID: <864ef05f-2cba-9cb4-4be6-bc3805b732c5@gmail.com>
Date: Fri, 24 Jun 2022 18:13:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/8] test-runner: remove reference to missing class member
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220624230741.1957863-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220624230741.1957863-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/24/22 18:07, James Prestwood wrote:
> The print statement was referencing self.name, which doesn't exist. Use
> self.args[0] instead.
> ---
>   tools/utils.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

