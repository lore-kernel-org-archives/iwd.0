Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B57E9
	for <iwd@lists.linux.dev>; Thu,  6 Jul 2023 03:04:22 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-785d738d3feso4704339f.0
        for <iwd@lists.linux.dev>; Wed, 05 Jul 2023 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688612661; x=1691204661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rhx+kBn73679eNXjwBHv9KBpYE4RH3q4KDT2ozY3+8U=;
        b=BCPzoo3jyZruYYd5wZj4jz0b66KiAiU6oZryF6CXZGEwY8NID0aDfyX+qnfGZRSWdI
         OYMBJNQWklY8LkMOUBT/b5aEdpnHZns7aQQgZIkIIIqJf4A8wJHNxljyWK/SQ3x3BxL/
         YL43eCTg7XdryP5YnXPZrPPGqIYkHCBt+qt0LBI3jHFWu7vVVPH+ifWJCnRor1OcDbck
         0HH4hP13yB46pJXNvo4P7pB+CBBaYj8rZa2FzsGp7GHk59h9UYZfooZgcNR3teAShZyG
         X6yTylKtjQLGivZ/p+vtreg5UQSslWsTOhAPwWjeuQ/Z68Rw2bQCTT4Xb9Rix2gKUS7k
         kgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688612661; x=1691204661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhx+kBn73679eNXjwBHv9KBpYE4RH3q4KDT2ozY3+8U=;
        b=RnA/mpSSNTsosL7qDsjSeqHYd7KKrhfj5kNVrGM23OgwCORPUb5rwmv2iHEcr58LXu
         DvXMYe0obv4+G+1/lKlQKkPcQbr7CELRLXHA9JJfPo4bgTiVYkkNSSPXD8n/MvNtEVtJ
         Cdara4WyVx0v19KEo/7AJSXjKgsjL7Yrrh+xPr6gaLdLqoPUKpfMX+N4kU1n8VjY7Yzt
         R3udDUDxMfkwYhxntWvkNKC8+gygTLu+l6aBFvgEjHE1lmq7hHziNoQhzqUCwvqsa046
         xWYP7hX7hWml3akn8/95OHuvWyz25fxYPNZqWUZlt6kWZi9Z3LjaCbAWhwQ1QJAalkZZ
         jGUg==
X-Gm-Message-State: ABy/qLZPoK42vqShYaV4vDKQpo9p+ip5gmbAUEvhbxIlNLIQEgsa+32J
	JK0XqcTEbYXrcSxXyeEHe/A=
X-Google-Smtp-Source: APBJJlFVoVe8a1hswMfVtXbGmGFZCFsL5R90UW3iIgoxfxe/1ZadplVdYVM9O+S4vsH5YNCx1zi0pQ==
X-Received: by 2002:a6b:6d13:0:b0:785:d098:b2d5 with SMTP id a19-20020a6b6d13000000b00785d098b2d5mr741035iod.5.1688612661301;
        Wed, 05 Jul 2023 20:04:21 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id l7-20020a6b7f07000000b007836b48d268sm141600ioq.51.2023.07.05.20.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 20:04:20 -0700 (PDT)
Message-ID: <c79ad910-3375-75cd-2d57-8f85035d9f24@gmail.com>
Date: Wed, 5 Jul 2023 22:04:19 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] Handle DEL/ADD_MAC_ADDR events
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230628202033.2320994-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230628202033.2320994-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/28/23 15:20, James Prestwood wrote:
> So this did work all along, I was just looking at it the wrong way.
>   - Scan randomization now works with hwsim
>   - Radios can be moved to another namespace and still work correctly
>     with hwsim
> 
> James Prestwood (3):
>    hwsim: add ADD/DEL_MAC_ADDR events
>    hwsim: move frame processing into a separate function
>    hwsim: handle ADD/DEL_MAC_ADDR events
> 
>   tools/hwsim.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 158 insertions(+), 6 deletions(-)
> 

Patch 1 & 2 applied, thanks.

Regards,
-Denis
