Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178137162
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqBv0TK2"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6cd09f51fe0so1457617a34.1
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 12:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252027; x=1700856827; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mi+YRg4tut1Xy/poEXQKpRCNyY++McucYAR0Rn7Styo=;
        b=KqBv0TK2JKVoD6Ai7gKeo6Hdra/nSEPCWlynryjXxZkuswVpiDjkFHwrEn4hu9+hyb
         +GpmaLh642dOg/4u+2Rc1z08ks/Xb53acjvqJdeAAAJ7R62j0C7sbInVxoWGcB3FkzVe
         2shpwjC9jBzbxzCAVzazwBZ9TzSt1LgAgfl4RLM3egc9ALz9OHwHM0/6VB/CppSCwBak
         ga4pN7WMfPzHCRQPOTXcsgt7dJ16gQb6WcxxsA8mI4ZZiHX85cet/mrWPg5IPxzGHJ2o
         tr32eSOd5zXQbrgRjUZb99nTfBGST6F1xFy05EVAv3JYHrnwyREozeu52vQbblZRxrP8
         5qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252027; x=1700856827;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mi+YRg4tut1Xy/poEXQKpRCNyY++McucYAR0Rn7Styo=;
        b=Ce5xZ0GD1jtTQZI8XlYiJzgwSGN5DKIFJzFHkGPG1IoOCLqcl5KW2l9w3yecz0ZOdn
         o/vaeFGlfe1GJ3l6IAodUhE/zcasrCuOrLYbKQAgPBA1JaSjSLIB9JSHsY7eZj0wLLGo
         N5Sg97j4xoZ8cHJCshrgzvM12Bvkm3v63HlRCtCmrkPlq4sxx1f+OGfj8rRMXM5PKB5c
         IlqZEbZNKfhHmqphioWZQEmUYgSFnH6YvFwMMEdKNDjo4X5ns+utp7OickiCBsyPT52S
         0BM+I9WlTcKjdS7Z96VedzYjVBVkWODl0BisPzkbU44/EhsRMOUv5fY82yE8Bu5kv+Am
         8xAA==
X-Gm-Message-State: AOJu0YwnGUV+t2ZyBEZtsRsxqi/4TPizgq19h69bk1axxqs6JQ63vJ2J
	F40Q6FkT8A02g/KXMmdfn+4vJZmfMhc=
X-Google-Smtp-Source: AGHT+IEJE2K7C6u2/pX1hffkBqjp12fZhnj8sewHE+GqX5cjU4dqMPtCO3tVVXpUj3uxzx968DZOCA==
X-Received: by 2002:a9d:6f14:0:b0:6bc:de95:a639 with SMTP id n20-20020a9d6f14000000b006bcde95a639mr299565otq.16.1700252026896;
        Fri, 17 Nov 2023 12:13:46 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n8-20020a056830320800b006ce325bc75csm353570ott.6.2023.11.17.12.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 12:13:46 -0800 (PST)
Message-ID: <d0f40a51-771e-438f-9fd2-27225f777aaa@gmail.com>
Date: Fri, 17 Nov 2023 14:13:45 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dbus: add SharedCodeAgent interface to iwd-dbus.conf
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231117194750.90786-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231117194750.90786-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/17/23 13:47, James Prestwood wrote:
> ---
>   src/iwd-dbus.conf | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

